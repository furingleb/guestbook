<?php
    require_once ('../lib/util.php');
    $db_conn= db_open();
    $response='';

    if ((isset($_POST['commentsoffset'])))
        $offset = $_POST['commentsoffset'] * 5;

    if (isset($_POST['cad']))
        $offset += $_POST['cad'];

    $offset = clear_text($offset,$db_conn);

    $sql = "SELECT * FROM mytable ORDER BY id DESC LIMIT ".$offset.",5";

    $db_res = $db_conn->query($sql);

    while ($r = $db_res->fetch_assoc()) {
        unset($r['id']);
        $response[] = $r;
    }

    echo json_encode($response);?>