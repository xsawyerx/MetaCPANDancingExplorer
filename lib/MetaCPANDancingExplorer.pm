package MetaCPANDancingExplorer;
use Dancer ':syntax';
use Capture::Tiny 'capture';
use WWW::GitHub::Gist;

our $VERSION = '0.1';

my $gist  = WWW::GitHub::Gist->new( id => 1119648 );
my $gistp = 'https://gist.github.com/1119648.js?file=';

get '/' => sub {
    template 'index';
};


get '/author' => sub {
    template authors => { gistp => $gistp };
};

get '/author/:file' => sub {
    my $file    = params->{'file'};
    my $content = $gist->file($file);
    $content =~ s/\n//g;
    $content .= <<'__END';
use Data::Dump 'dd';
dd $author;
__END

    return to_json { content => ( capture { eval $content } || '' ) };

};

true;

