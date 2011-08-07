package MetaCPANDancingExplorer::Author;
use Dancer ':syntax';
use Capture::Tiny 'capture';

prefix '/author';

get '/' => sub {
    template 'authors';
};

get '/:file' => sub {
    my $file    = params->{'file'};
    my $content = vars->{'gist'}->file($file);
    $content =~ s/\n//g;
    $content .= <<'__END';
use Data::Dump 'dd';
dd $author;
__END

    return capture { eval $content } || 'error';

};

true;

