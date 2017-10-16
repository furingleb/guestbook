<?php
    $res['one'] = 'one';
    $res['two'] = 'two';

    foreach ($res as $k)
        $res[$k] = $res[$k] . 'changed';

    print_r($res);

?>