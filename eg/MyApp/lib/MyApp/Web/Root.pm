package MyApp::Web::Root;
use base 'Saki::Controller';

sub root {
    my ( $self, $c ) = @_;
    $c->stash->{message} = 'noblesse oblige';
}

1;
