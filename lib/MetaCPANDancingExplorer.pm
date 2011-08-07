package MetaCPANDancingExplorer;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

load 'MetaCPANDancingExplorer/Author.pm';

true;

