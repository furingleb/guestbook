<?php
    include ('../lib/util.php');
    $db_conn = db_open();
    $response = '';

    if (isset($_POST['request']))
        $request = $_POST['request'];

    $request = clear_text($request,$db_conn);

    $sql = 'SELECT * FROM mytable WHERE ((username LIKE "{request}%") or (email LIKE "{request}%") or (tags LIKE "%{request}%") or (sdate LIKE "%{request}%")) ORDER BY id DESC ';
    $sql = str_replace("{request}",$request,$sql);

    $db_res = $db_conn->query($sql);

   while ($r = $db_res->fetch_assoc()) {
      unset($r['id']);
      $response[] = $r;
   }

    echo json_encode($response);?>