<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS");
    header("Content-Type: application/json; charset=UTF-8");

    $con = new mysqli('127.0.0.1:3307', 'root', '', 'db_listbarang');

    // Mendapatkan data dari body request
    parse_str(file_get_contents("php://input"), $data);

    $id = $data['id'] ?? null;
    $jenis_barang = $data['jenis_barang'] ?? null;
    $jumlah_barang = $data['jumlah_barang'] ?? null;
    $harga_barang = $data['harga_barang'] ?? null;

    if ($id && $jenis_barang && $jumlah_barang && $harga_barang) {
        $query = "UPDATE tb_barang SET jenis_barang='$jenis_barang', jumlah_barang='$jumlah_barang', harga_barang='$harga_barang' WHERE id='$id'";
        $result = mysqli_query($con, $query);

        if ($result) {
            echo json_encode(['pesan' => 'Sukses Update']);
        } else {
            echo json_encode(['pesan' => 'Gagal Update']);
        }
    } else {
        echo json_encode(['pesan' => 'Data tidak lengkap']);
    }
?>
