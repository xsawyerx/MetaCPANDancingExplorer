package MetaCPANDancingExplorer;
use Dancer ':syntax';
use Capture::Tiny 'capture';
use WWW::GitHub::Gist;

our $VERSION = '0.1';

# basic variables
my $gist  = WWW::GitHub::Gist->new( id => 1119648 );
my @pages = qw/author/;

# setting up routes for all pages
foreach my $page (@pages) {
    get "/$page" => sub {
        template "${page}s";
    };

    get "/$page/:file" => sub {
        my $file    = params->{'file'};
        my $content = $gist->file($file);
        $content =~ s/\n//g;
        $content .= <<"____END";
use Data::Dump 'dd';
dd \$$page;
____END

        return capture { eval $content } || 'error';
    };
}

# setting up variables for all templates
before_template sub {
    my $tokens = shift;

    $tokens->{'gistp'} = 'https://gist.github.com/1119648.js?file=';
};

# main route
get '/' => sub {
    template 'index';
};

true;

