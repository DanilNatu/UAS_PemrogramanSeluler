<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS");
    header("Content-Type: application/json; charset=UTF-8");
    
    $con = new mysqli('127.0.0.1:3307', 'root', '', 'db_listbarang');
    $id = $_GET['id'];

    $data = mysqli_query($con, "delete from tb_barang where id = '$id'");
    
    if($data) {
        echo json_encode ([
            'pesan' => 'Sukses Delete'
        ]);
    } else {
        echo json_encode ([
            'pesan' => 'Gagal Delete'
        ]);
    }
?>