<?php

$basepath = "/app";

chmod($basepath ."/divio/run-locally.sh", 0755);
chmod($basepath ."/divio/ensure-env.sh", 0755);
chmod($basepath ."/bin/console", 0755);
chmod($basepath ."/bin/phpunit", 0755);

$directories = [
    "var/storage/",
    "var/cache/",
    "var/logs/",
];

foreach($directories as $directory) {
    if(!is_dir($basepath ."/". $directory)) {
        mkdir($basepath ."/". $directory, 0777, true);
    }
}

system("cd $basepath && composer install");
system("cd $basepath && bin/console doctrine:migrations:migrate --no-interaction");
