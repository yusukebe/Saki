package MyApp::Web;
use Saki;
use MyApp::API;

my $api = MyApp::API->new();
model 'API'    => $api;
view 'WRAPPER' => 'layout.tt2';

get '/' => { controller => 'Root', action => 'index' };
get '/entry/:id' => { controller => 'Root', action => 'entry' };
post '/post' => { controller => 'Root', action => 'post' };

1;
