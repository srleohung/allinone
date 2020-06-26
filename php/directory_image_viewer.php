<html>
    <head>
        <title>Directory Image Viewer</title>
    </head>
    <body>
    <form action="/directory_image_viewer.php">
        <input type="text" id="search" name="search" value="">
        <input type="submit" value="Search">
    </form> 
    <?php
        $directory = './';
        $search = $_POST['search'];
        function search($_search)
        {
            global $search;
            $search = $_search;
        }
        if (isset($_GET['search'])) {
            search($_GET['search']);
        }
        if ($handle = opendir($directory)) {
            while (false !== ($fileName = readdir($handle))) {
                if (strpos($fileName, $search) !== false) {
                    if ($fileName != '.' && $fileName != '..') {
                        echo $fileName.'<br />';
                        echo '<img src="'.$directory.$fileName.'"><br />';
                    }
                }
            }
            closedir($handle);
        }
    ?>
    </body>
</html>