#!/usr/bin/env perl
use Modern::Perl '2014';
use autodie;
use Data::Dumper;

use Spreadsheet::ParseExcel::Simple;

binmode STDOUT, ':utf8';
my $counter=0;
my (%salary_min, %salary_max, %stipend);
my (%pay_masters, %company_skills, %skills);
my @h_pay_masters;

  my $xls = Spreadsheet::ParseExcel::Simple->read('/home/at/Downloads/Company_list.xls');
  foreach my $sheet ($xls->sheets) {
     while ($sheet->has_data 
         ##&& $counter <=2
            ) { 
         $counter++;
         #next if ( $counter <= 59 or $counter <=62); 
         next if ( $counter == 1); 
         my ($company, $location, $salary, $skills) = ($sheet->next_row)[0,1,4,5];
         $location = uc $location;
         $skills = uc $skills;
         #printf "%s %s %s\n\n",$data[1],$data[4],$data[5];
         #printf "%s %s %s\n\n",$location, $salary, $skills;
         $salary =~ tr/,//d;
         $salary =~ tr/0-9 / /c;
         $salary =~ tr/0-9 \.//cd;
         #my @split_sal=split (" ",$salary);
         my ($salary_min, $salary_max)=(split (" ",$salary))[0,-1];
         $salary_min =~ tr/0-9\.//cd if ( defined $salary_min);
         $salary_max =~ tr/0-9\.//cd if ( defined $salary_max);
         $salary_min{$salary_min}++ if ( defined $salary_min);
         $salary_max{$salary_max}++ if (defined $salary_max && $salary_max > 0 && $salary_max > $salary_min);
         my $stipend = $salary_max if (defined $salary_max && $salary_max > 0 && $salary_max < $salary_min);
        $stipend{$stipend}++ if (defined $stipend);
        my $sal_range= (defined $salary_max) ? $salary_min." : ".$salary_max : $salary_min." : ".$salary_min;
        if ( defined ($salary_max) && $salary_max > 600000) {
                push @{ $pay_masters{"H"}}, $location." : ".$sal_range." : ".$company;
                $pay_masters{$company}=$location." : ".$sal_range;
                push @h_pay_masters, $company;
            }
        if ( defined ($salary_min) && $salary_min > 600000) {
                push @{ $pay_masters{"H"}}, $location." : ".$sal_range." : ".$company; 
                $pay_masters{$company}=$location." : ".$sal_range;
                push @h_pay_masters, $company;
            }

        $skills =~ tr/\/,\./ /d;
        $company_skills{$company}=$skills;
        my @skills= split (" ", $skills);
        foreach (@skills){
            $skills{$_}++;
            }
     }
  }
print Dumper (\%pay_masters);
foreach (@h_pay_masters){
    printf "%s %s %s\n",$_, $pay_masters{$_}, $company_skills{$_};
}
my @unique = sort ({$skills{$b} <=> $skills{$a}  } keys %skills);
foreach (@unique){
    printf "%s %s\n",$_, $skills{$_};
}
exit 0;
  foreach (sort keys %salary_min)
    {printf "%s %s \n",$_, $salary_min{$_};}
    print "\n\nStipend\n";
  foreach (sort keys %stipend)
    {printf "%s %s \n",$_, $stipend{$_};}
