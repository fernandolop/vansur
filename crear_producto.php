<?php

$input_file = "productos.csv";

if (($handle = fopen($input_file, "r")) !== FALSE) {
    $header = fgetcsv($handle, 0, ",");
    while (($data = fgetcsv($handle, 0, ",")) !== FALSE) {
        $product = array_combine($header, $data);
        $nombre = escapeshellarg($product['Nombre']);
        $descripcion = escapeshellarg($product['Descripción corta']);
        $precio = escapeshellarg($product['Precio normal']);
        $stock = intval($product['Inventario']);

        $imagenes_array = array_map(function($url) {
            return array('src' => trim($url));
        }, explode(',', $product['Imágenes']));
        $imagenes_json = escapeshellarg(json_encode($imagenes_array));

        $command = "sudo wp wc product create --name=$nombre --description=$descripcion --regular_price=$precio --stock_quantity=$stock --images=$imagenes_json --user=8 --porcelain";
        $product_id = shell_exec($command);

        echo "Producto creado con ID: $product_id" . PHP_EOL;
        echo "Nombre del producto: " . $product['Nombre'] . PHP_EOL;
        echo "Descripción del producto: " . $product['Descripción corta'] . PHP_EOL;
        echo "-----------------------------" . PHP_EOL;
    }
    fclose($handle);
}

?>
