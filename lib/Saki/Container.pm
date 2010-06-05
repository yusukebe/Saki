package Saki::Container;
use strict;
use warnings;

sub new {
    my ( $class, %args ) = @_;
    my $self = bless {
        req   => $args{req},
        model => $args{model} || {},
    }, $class;
    $self;
}

sub req {
    my $self = shift;
    return $self->{req};
}

sub model {
    my ($self, $name) = @_;
    return $self->{model}->{$name};
}

1;
