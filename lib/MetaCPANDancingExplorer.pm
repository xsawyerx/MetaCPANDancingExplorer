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
    my @examples = ();
    my @files    = ( 'author-pauseid.pl', 'author-search-twitterprofile.pl' );

    foreach my $file (@files) {
        my $content = $gist->file($file);
        $content =~ s/\n//g;
        $content .= <<'__END';
use Data::Dump 'dd';
dd $author;
__END

        push @examples, capture { eval $content };
    }

    template authors => { examples => \@examples, gistp => $gistp };
};

true;

