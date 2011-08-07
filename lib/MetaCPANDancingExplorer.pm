package MetaCPANDancingExplorer;
use Dancer ':syntax';
use WWW::GitHub::Gist;

our $VERSION = '0.1';

var gist => WWW::GitHub::Gist->new( id => 1119648 );

before_template sub {
    my $tokens = shift;

    $tokens->{'gistp'} = 'https://gist.github.com/1119648.js?file=';
};

get '/' => sub {
    template 'index';
};

load 'MetaCPANDancingExplorer/Author.pm';

true;

