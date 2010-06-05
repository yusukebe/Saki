package Saki;
use strict;
use warnings;
use Plack::Request;
use Router::Simple;
use UNIVERSAL::require;
use Template;
use Carp;
use Saki::Container;

our $VERSION = '0.01';

my $_router = Router::Simple->new;
my ( $_class, $_template, $_model );

$_template = Template->new( { INCLUDE_PATH => 'tmpl/' } );

sub app {
    sub {
        my $env = shift;
        my $p   = $_router->match($env);
        return handle_404() unless $p;
        my $controller = $_class . "::$p->{controller}";
        eval { $controller->use };
        return handle_500($@) if $@;
        my $req = Plack::Request->new($env);
        my ( $action, $code ) = ( $p->{action} );
        my $c = Saki::Container->new( req => $req, model => $_model );
        eval { $code = $controller->$action( $c, $p ) };
        return handle_500($@) if $@;
        return handle_404() unless $code;

        if (   ref $code eq 'ARRAY'
            && defined $code->[1]
            && ref $code->[1] eq 'HASH' )
        {
            my $html;
            $code->[1]->{base} = $req->base;
            $_template->process( $code->[0], $code->[1], \$html )
              or return handle_500( $_template->error );
            my $types = [ 'Content-Length' => length $html ];
            $types = $code->[2] if defined $code->[2] && $code->[2];
            return [ 200, $types, [$html] ];
        }
        else {
            return $code;
        }
    };
}

sub handle_500 {
    my $message = shift;
    $message = 'Internal Server Error' unless $message;
    return [ 500, [], [$message] ];
}

sub handle_404 {
    my $message = shift;
    $message = 'Not Found' unless $message;
    return [ 404, [], [$message] ];
}

sub get {
    my ( $path, $args ) = @_;
    $args->{method} = 'GET';
    $_router->connect( $path, $args );
}

sub post {
    my ( $path, $args ) = @_;
    $args->{method} = 'POST';
    $_router->connect( $path, $args );
}

sub model {
    my ( $name, $model ) = @_;
    $_model->{$name} = $model;
}

sub import {
    strict->import;
    warnings->import;
    no strict 'refs';
    $_class    = caller;
    my $functions = [qw/get post app model/];
    for my $function (@$functions) {
        *{"${_class}\::$function"} = \&$function;
    }
}

1;

__END__

=head1 NAME

Saki - glue for web applications.

=head1 SYNOPSIS

  use Saki;

=head1 DESCRIPTION

Saki is glue for web applications using Plack::Request, Router::Simple, Template-Toolkit.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke at kamawada.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
