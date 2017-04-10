#!/usr/bin/perl
use Net::DNS;
use Data::Dumper;


sub reply_string {
        my $self = shift;

        my $header = $self->header;
        my $update = $header->opcode eq 'UPDATE';
        my $server = $self->{answerfrom};
        my $length = $self->{answersize};
        my $string = $server ? ";; Answer received from $server ($length bytes)\n" : "";
        $string = '';

        my $answer = $update ? 'PREREQUISITE' : 'ANSWER';
        my @answer  = map $_->string, $self->answer;
        my $ancount = scalar @answer;
        my $ans     = $ancount != 1 ? 's' : '';
        $string .= join "\n", @answer;
        return "$string\n\n";
}


my @domain_list=("google.com","servernet.se");
$resolver = new Net::DNS::Resolver();
$resolver->usevc(1);            #use TCP
$resolver->persistent_tcp(1);   #use persistent connections
print 'usevc flag: ', $resolver->usevc, "\n";
print 'Persistent TCP flag: ', $resolver->persistent_tcp, "\n";

@nameservers = $resolver->nameservers();
print @nameservers;

print " : Records :\n";
foreach my $domain (@domain_list){
        foreach my $type ('A', 'AAAA','MX','TXT'){
                $reply = $resolver->send( $domain, $type, 'IN' );
                if ($resolver->errorstring eq 'NOERROR') {
                        $string = reply_string($reply);
                        print $string;
                } else {
                        print "error in $domain, $type, $resolver->errorstring";
                }
        }
}
print  "\n";
