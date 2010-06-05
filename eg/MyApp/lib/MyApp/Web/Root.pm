package MyApp::Web::Root;

sub index {
    my ( $self, $c ) = @_;
    return [ 'index.tt2', { message => 'noblesse oblige' } ];
}

1;
