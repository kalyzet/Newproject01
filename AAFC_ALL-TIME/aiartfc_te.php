<?php
// Koneksi ke database
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'football_aiartfc';
$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Ambil filter dari GET
$filter_negara = $_GET['negara'] ?? '';
$filter_posisi = $_GET['posisi'] ?? '';

// Query utama
$sql = "
    SELECT p.id_pemain, p.nama, p.negara, GROUP_CONCAT(DISTINCT po.kode ORDER BY po.kode SEPARATOR ', ') AS posisi
    FROM pemain p
    LEFT JOIN posisi_pemain pp ON p.id_pemain = pp.id_pemain
    LEFT JOIN posisi po ON pp.id_posisi = po.id_posisi
    WHERE 1=1
";

if ($filter_negara != '') {
    $sql .= " AND p.negara = '" . $conn->real_escape_string($filter_negara) . "'";
}
if ($filter_posisi != '') {
    $sql .= " AND po.kode = '" . $conn->real_escape_string($filter_posisi) . "'";
}

$sql .= " GROUP BY p.id_pemain, p.nama, p.negara ORDER BY p.nama ASC";
$result = $conn->query($sql);

// Ambil semua negara & posisi untuk dropdown filter
$negara_res = $conn->query("SELECT DISTINCT negara FROM pemain ORDER BY negara");
$posisi_res = $conn->query("SELECT kode FROM posisi ORDER BY kode");
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Daftar Pemain Sepak Bola</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4 bg-light">
    <div class="container">
        <h2 class="mb-4">Daftar Pemain Sepak Bola Klub AI ART FC</h2>
        <!-- Ringkasan Total -->
<div class="row mb-4">
    <div class="col-md-6">
        <h5>Total Pemain dalam Negara</h5>
        <ul class="list-group">
            <?php
            $q1 = $conn->query("SELECT negara, COUNT(*) AS total FROM pemain GROUP BY negara ORDER BY total DESC");
            while ($row = $q1->fetch_assoc()):
            ?>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <?= htmlspecialchars($row['negara']) ?>
                    <span class="badge bg-primary rounded-pill"><?= $row['total'] ?></span>
                </li>
            <?php endwhile; ?>
        </ul>
    </div>
    <div class="col-md-6">
        <h5>Total Pemain dalam Posisi</h5>
        <ul class="list-group">
            <?php
            $q2 = $conn->query("
                SELECT po.kode AS posisi, COUNT(DISTINCT pp.id_pemain) AS total
                FROM posisi_pemain pp
                JOIN posisi po ON pp.id_posisi = po.id_posisi
                GROUP BY po.kode
                ORDER BY total DESC
            ");
            while ($row = $q2->fetch_assoc()):
            ?>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <?= htmlspecialchars($row['posisi']) ?>
                    <span class="badge bg-success rounded-pill"><?= $row['total'] ?></span>
                </li>
            <?php endwhile; ?>
        </ul>
    </div>
</div>
        <!-- Filter -->
        <form method="GET" class="row g-3 mb-4">
            <div class="col-md-4">
                <label class="form-label">Filter Negara</label>
                <select name="negara" class="form-select">
                    <option value="">Semua Negara</option>
                    <?php while($n = $negara_res->fetch_assoc()): ?>
                        <option value="<?= $n['negara'] ?>" <?= $filter_negara == $n['negara'] ? 'selected' : '' ?>>
                            <?= $n['negara'] ?>
                        </option>
                    <?php endwhile; ?>
                </select>
            </div>
            <div class="col-md-4">
                <label class="form-label">Filter Posisi</label>
                <select name="posisi" class="form-select">
                    <option value="">Semua Posisi</option>
                    <?php while($p = $posisi_res->fetch_assoc()): ?>
                        <option value="<?= $p['kode'] ?>" <?= $filter_posisi == $p['kode'] ? 'selected' : '' ?>>
                            <?= $p['kode'] ?>
                        </option>
                    <?php endwhile; ?>
                </select>
            </div>
            <div class="col-md-4 align-self-end">
                <button class="btn btn-primary" type="submit">Terapkan Filter</button>
                <a href="aiartfc_te.php" class="btn btn-secondary">Reset</a>
            </div>
        </form>

        <!-- Tabel Data -->
        <div class="card">
            <div class="card-body">
                <p><strong>Total Pemain:</strong> <?= $result->num_rows ?></p>
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Nama</th>
                            <th>Negara</th>
                            <th>Posisi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($result->num_rows > 0): $i = 1; ?>
                            <?php while($row = $result->fetch_assoc()): ?>
                                <tr>
                                    <td><?= $i++ ?></td>
                                    <td><?= htmlspecialchars($row['nama']) ?></td>
                                    <td><?= htmlspecialchars($row['negara']) ?></td>
                                    <td><?= htmlspecialchars($row['posisi']) ?></td>
                                </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr><td colspan="4" class="text-center">Tidak ada data ditemukan.</td></tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
