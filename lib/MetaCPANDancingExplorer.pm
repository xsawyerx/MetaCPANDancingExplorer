package MetaCPANDancingExplorer;
use Dancer ':syntax';

our $VERSION = '0.1';

my $gistp = 'https://gist.github.com/1119648.js?file=';

get '/' => sub {
    template 'index';
};

before_template sub {
    my $tokens = shift;

    $tokens->{'gistp'} = $gistp;
};

load 'MetaCPANDancingExplorer/Author.pm';

true;

