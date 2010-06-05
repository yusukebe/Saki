package MyApp::API;
use Mouse;
use MyApp::DB;
use Data::UUID;

has 'db' => (
    is      => 'ro',
    isa     => 'MyApp::DB',
    default => sub {
        return MyApp::DB->new;
    }
);

has 'uuid' =>
  ( is => 'ro', isa => 'Data::UUID', default => sub { Data::UUID->new } );

sub BUILD {
    my $self = shift;
    $self->db->do(q{CREATE TABLE entry ( id varchar, body text )});
}

sub get_entries {
    my $self    = shift;
    my @entries = $self->db->search('entry');
    if (wantarray) {
        return @entries;
    }
    else {
        return \@entries;
    }
}

sub get_entry {
    my ( $self, $id ) = @_;
    my $entry = $self->db->single( 'entry', { id => $id } );
    return $entry;
}

sub create_entry {
    my ( $self, $body ) = @_;
    my $uuid = $self->uuid->create_str();
    $self->db->insert( 'entry', { id => $uuid, body => $body } );
    return $uuid;
}

__PACKAGE__->meta->make_immutable();
1;
