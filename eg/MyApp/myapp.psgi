use lib qw(../../lib);
use MyApp::Web;
use Plack::Builder;

my $app = MyApp::Web->app;
builder {
    enable "Plack::Middleware::Static",
        path => qr{^/static},
            root => 'root';
    $app;
};

