package MyApp::Web;
use Saki;
use MyApp::API;

my $api = MyApp::API->new();
model 'API' => $api;

get '/' => { controller => 'Root', action => 'index' };
post '/post' => { controller => 'Root', action => 'post' };

1;
