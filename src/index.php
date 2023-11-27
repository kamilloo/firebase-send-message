<?php
declare(strict_types=1);

require_once "vendor/autoload.php";

$client_api = new \GuzzleHttp\Client();

//read variable for environment
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
$device_token = $_ENV['DEVICE_TOKEN'];
$access_token = $_ENV['ACCESS_TOKEN'];

$payload = [
     "message" => [
         "token" => $device_token,
         "notification" => [
             "title" => "Sample Message",
             "body" => "This is an sample Message",
         ],
     ],
 ];


try {
    $response = $client_api->post('https://fcm.googleapis.com/v1/projects/wholesome-yum-prod/messages:send', [
        'json' => $payload,
        'headers' => [
            'Authorization' => 'Bearer ' . $access_token,
            'Content-Type' => 'application/json',
        ],
    ]);

    print_r($response->getBody()->getContents());

}catch (Throwable|\GuzzleHttp\Exception\GuzzleException $throwable){
    print_r($throwable->getMessage());
}
die();
