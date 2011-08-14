package Webs::CGI::Session;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw( %_SESSION );

=head1 NAME

Webs::CGI::Session - Plugin module for Webs::CGI to handle basic session management

head1 VERSION

Version 0.1

=cut

our $VERSION = '0.1';

=head1 SYNOPSIS

Webs::CGI::Session is a basic module to accomodate Webs::CGI. It offers basic 
session management using DB_File to store its data.

    use Webs::CGI;
    use Webs::CGI::Session;

    my $s = Webs::CGI::Session->new;

    if (exists $_SESSION{user}) {
        ...
    }

    $_SESSION{user} = 'test1234';
=cut

use DB_File;

our %_SESSION = ();

sub new {
    use Digest::MD5 qw( md5_hex );
    my ($class, $path) = @_;
    my $self = { 'path' => ($path||'/tmp'), 'id' => undef };
    if (! defined $ENV{'HTTP_COOKIE'}) {
        my $ssid = md5_hex(localtime() . rand(99));
        my $sid = 'SOYID=' . $ssid;
        $self->{'id'} = $sid;
        print "Set-Cookie: $sid\n";
        tie %_SESSION, "DB_File", $self->{'path'} . '/' . $sid;
    }
    else {
        my $cookies = $ENV{'HTTP_COOKIE'};
        if ($cookies =~ /SOYID=([0-9a-f]{32})/i) {
            $self->{'id'} = $1;
            tie %_SESSION, "DB_File", $self->{'path'} . '/SOYID=' . $1;
        }
        else {
            my $ssid = md5_hex(localtime() . rand(99));
            my $sid = 'SOYID=' . $ssid;
            $self->{'id'} = $sid;
            print "Set-Cookie: $sid\n";
            tie %_SESSION, "DB_File", $self->{'path'} . '/' . $sid;
        }
    }
    bless $self, $class;
    return $self;
}

=head2 Webs::CGI::Session->session_id

Returns a session id of the cookie

    my $s = Webs::CGI::Session->new;
    print "Session ID: " . $s->session_id;
=cut

sub session_id {
    my $self = shift;
    if (defined $self->{'id'}) { return $self->{'id'}; }
    else { return undef; }
}

=head2 Webs::CGI::Session->session_flush

Closes the session properly

    $session->session_flush;
=cut

sub session_flush {
    use vars qw( %_SESSION );
    my $self = shift;
    untie %_SESSION;
}
1;
