package MetaCPANDancingExplorer::Author;
use Dancer ':syntax';
use Capture::Tiny 'capture';
use WWW::GitHub::Gist;

my $gist  = WWW::GitHub::Gist->new( id => 1119648 );

prefix '/author';

get '/' => sub {
    template 'authors';
};

get '/:file' => sub {
    my $file    = params->{'file'};
    my $content = $gist->file($file);
    $content =~ s/\n//g;
    $content .= <<'__END';
use Data::Dump 'dd';
dd $author;
__END

    return capture { eval $content } || 'error';

};

true;

