<?php
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    
    $con = new mysqli('127.0.0.1:3307', 'root', '', 'db_listbarang');
    $id = $_POST['id'];
    $jenis_barang = $_POST['jenis_barang'];
    $jumlah_barang = $_POST['jumlah_barang'];
    $harga_barang = $_POST['harga_barang'];

    $data = mysqli_query($con, "update tb_barang set 
    jenis_barang='$jenis_barang', jumlah_barang='$jumlah_barang', harga_barang='$harga_barang' where id = '$id'");
    
    if($data) {
        echo json_encode ([
            'pesan' => 'Sukses Update'
        ]);
    } else {
        echo json_encode ([
            'pesan' => 'Gagal Update'
        ]);
    }
?>