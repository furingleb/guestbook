<?php
    require_once('../lib/util.php');
    $db_conn = db_open();
    $response = '';

    if (isset($_POST['username'])) {
        foreach ($_POST as $k => $v) {
            $response[$k] = $v;
        }
    }

    $response['browser'] = $_SERVER['HTTP_USER_AGENT'];
    $response['ipad'] = $_SERVER['REMOTE_ADDR'];
    $response['sdate'] = date('c');

    // foreach ($response as $k){
    //   $response[$k] = '1';
    //  }

    $forsql = $response;


    extract($forsql);

    $sql = "
            INSERT INTO mytable(username,Email,Homepage,Text,tags,ipad,browser,sdate)
              VALUES ('$username','$email','$homepage','$text','$tags','$ipad','$browser','$sdate')
            ";
    $sql = clear_text($sql, $db_conn);


    $db_res = $db_conn->query($sql);
    echo json_encode($response);
?>