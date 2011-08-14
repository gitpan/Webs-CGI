#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'Webs::CGI' ) || print "Bail out!\n";
    use_ok( 'Webs::CGI::Session' ) || print "Bail out!\n";
}

diag( "Testing Webs::CGI $Webs::CGI::VERSION, Perl $], $^X" );
