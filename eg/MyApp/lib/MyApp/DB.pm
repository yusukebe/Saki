package MyApp::DB;
use DBIx::Skinny setup => +{
    dsn      => 'dbi:SQLite:',
    username => '',
    password => '',
};
1;
