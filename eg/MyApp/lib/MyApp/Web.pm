package MyApp::Web;
use Saki;

get '/' => { controller => 'Root', action => 'index' };

1;
