package MyApp::Web::Root;

sub index {
    my ( $self, $c ) = @_;
    my $entries = $c->model('API')->get_entries;
    return [ 'index.tt2',
        { message => 'noblesse oblige', entries => $entries } ];
}

sub post {
    my ( $self, $c ) = @_;
    my $body = $c->req->param('body');
    my $id   = $c->model('API')->create_entry($body);
    return [ 301, [ Location => $c->req->base ], [] ];
}

1;
