package MyApp::Web::Root;
use strict;
use warnings;

sub index {
    my ( $self, $c ) = @_;
    my $entries = $c->model('API')->get_entries;
    return [ 'index.tt2',
        { message => 'noblesse oblige', entries => $entries } ];
}

sub entry {
    my ( $self, $c, $args ) = @_;
    my $id    = $args->{id};
    my $entry = $c->model('API')->get_entry($id);
    return [ 'entry.tt2', { entry => $entry } ];
}

sub post {
    my ( $self, $c ) = @_;
    my $body = $c->req->param('body');
    my $id   = $c->model('API')->create_entry($body);
    return [ 302, [ Location => $c->req->base ], [] ];
}

sub rss {
    my ( $self, $c ) = @_;
    my $entries = $c->model('API')->get_entries();
    return [
        'rss.tt2',
        { entries        => $entries, view => 'TT' },
        [ 'Content-Type' => 'application/rss+xml' ]
    ];
}

1;
