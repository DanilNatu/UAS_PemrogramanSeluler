<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: PUT, GET, POST, OPTIONS");
    header("Content-Type: application/json; charset=UTF-8");
    
    $con = new mysqli('127.0.0.1:3307', 'root', '', 'db_listbarang');

    $query = mysqli_query($con, "select * from tb_barang");
    $data = mysqli_fetch_all($query, MYSQLI_ASSOC);

    echo json_encode($data);
?>