From: Brian Fegler <fegler@bigfoot.com>
Reply-To: fegler@bigfoot.com
To: SELinux@tycho.nsa.gov
Subject: Re: rule analyzer
Date: Fri, 18 Oct 2002 12:20:25 -0600
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1AW64CC8TQQ36KEORNH3"
Message-Id: <200210181220.25789.fegler@bigfoot.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_1AW64CC8TQQ36KEORNH3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ha! I suppose I ought to include the program, I've attached it in this em=
ail.

I've included it as an attachment and in the email body.=20

############################################
#!/usr/bin/perl=20
use strict;

#   Author: Brian Fegler (brianfegler@bigfoot.com)
#   Copyright (C) 2002 Brian Fegler
#
#   This program is free software; you can redistribute it and/or modify =
it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2, or (at your option) any
#   later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.


$| =3D 1;


#####################################################
######## Global Values ##############################
#####################################################
my $version =3D ".1";

my $pfile =3D "/usr/src/selinux/policy/policy.conf";

#May not use this, keeping in here for now.
#my @keep;
#my @toss;

#List of source and destinations the user is
#interested in
my (@src,@dst,@class,@perm);

#set to one if the user wants to only match exact names
#given when doing list compares
my $full_name =3D 0;

#if set to one there will be a short printout
my $short_print_out =3D 0;

#if set to one the permissions will be alligned when applicable
my $align =3D 0;
my ($wsrc,$wdst,$wclass) =3D (0,0,0);

#this sets the width of a tab (useful for changing width of tabs when use=
d)
#changed with --tab=3DINTEGER
my $tab =3D "    ";

#determines how many levels deep to print the rule set
my %l =3D ( 1=3D>1, 2=3D>1, 3=3D>1, 4=3D>1, );

#Make sure all exits call this incase I ever want the=20
#program to exit in a certain way all the time.
sub killme {exit;}
$SIG{INT} =3D \&killme;
#####################################################
######## End Global Values ##########################
#####################################################



#####################################################
#####Reading in user values #########################
#####################################################
#turn options like -df into -d -f
for(my $i=3D0; $i<=3D$#ARGV; $i++){
    if($ARGV[$i] =3D~ /^-\w{2,}$/){
        my @temp =3D split("",$ARGV[$i]);  =20
        shift @temp;                      #get rid of leading -
        $_ =3D "-$_" foreach(@temp);        #slap a - on each element
        splice(@ARGV,$i,1,@temp);         #put switches back in
        $i+=3D$#temp;                       #don't read what you just put=
 in
    }
}

foreach(@ARGV) {
    if(/^--help$/){
        &help; killme();
    }elsif(/^-h$/){=20
        &short_help; killme();
    }
   =20
    elsif(/^--todo$/){=20
        &todo; killme();
    }elsif(/^--version$/){=20
        print "$version\n";
        killme();
    }
    elsif(/^--src=3D/){
        push @src, split(",",$');
    }elsif(/^--dst=3D/){
        push @dst, split(",",$');
    }elsif(/^--class=3D/){
        push @class, split(",",$');
    }elsif(/^--perm=3D/){
        push @perm, split(",",$');
    }
   =20
    elsif(/^-f$/ || /^--full-name$/){
        $full_name =3D 1;
    }
   =20
   =20
    elsif(/^--pfile=3D/){
        $pfile =3D $';
    }


    #print options
    elsif(/^-s$/ || /^--short$/){
        $short_print_out =3D 1;
    }elsif(/^-a$/ || /^--alignt$/){
        $align =3D 1;
    }elsif(/^--tab=3D(\d{1,2})$/){
        $tab =3D " " x $1;
    }
   =20
    elsif(/^--l=3D(1|2|3|4)$/){
        my $start =3D $1;
        if($start!=3D4){ $start++;}
        else{ next;}
        for($start .. 4){
            $l{$_} =3D 0;
        }
    }
    #don't know if i'll use these
    #i don't thing they benefit speed in any way
    #elsif(/^-keep=3D/){
    #    push @keep, split(",",$');
    #}elsif(/^-toss=3D/){
    #    push @toss, split(",",$');
    #}
   =20
    #used for general purpose debugging
    #current program may or maynot use this
    elsif(/^-edebug=3D/){
        foreach(split("",$')){
            $ENV{"_d$_"}=3D1;
        }
    }
   =20
    else{
        print "$_ is an unrecognized option\n";
        killme();
    }

}#end - foreach(@ARGV)
#####################################################
#####Done reading in user values ####################
#####################################################



#####################################################
### validating input ################################
#####################################################
if(!-r $pfile){
    print STDERR "can't read policy file: $pfile\n";
    killme();
}
#####################################################
### done validating input ###########################
#####################################################



#what gets defined
# using "type .*(,.*);
#as mentioned below, not sure what I'll use this for
my %defined;

#{source}{dest}{class} =3D LIST
#example: {user_xserver_t}{user_home_t}{dir} =3D read getattr remove_name=
 ...
#example: {user_xserver_t}{user_home_t}{file}=3D read getattr unlink ...
my %rules;


my %transitions;



open(FILE, "<$pfile") or die "couldn't open $pfile: $!\n";
LINE: while(my $line=3D<FILE>){
    chomp $line;
    if($line =3D~ /^type /){
        #not sure what'll I'll be using this for
        #just though I'd keep my options open
        my @temp =3D split(/ /, $line);
        @temp =3D split(/,|, /, $temp[1]);
        $defined{$temp[0]}=3D1;
    }
   =20
    elsif($line =3D~ /^allow /){

        #TODO
        #try this at different locations in the program
        #to see where the most speed is gained
        #if(@keep and !doesExpMatchList($line,\@keep)){
        #    next LINE;
        #}elsif(@toss and doesExpMatchList($line,\@toss)){
        #    next LINE;
        #}

   =20
        #used for debugging
        #if($line !~ /kde_t/){next LINE;}
        #if($line !~ /user_gpg/){next LINE;}
       =20
   =20
        #i've left the print "$line\n"; in there for future debugging

        #i should try doing a single level hash, this might make
        #   the code a little bit shorter, (cleaner?)
        #this could be tested with out deleting code, i suppose
        #test for speed
   =20
        if($line =3D~ /^allow\s*((\w*)|{(.*)})\s*((\w*)|{(.*)})(\s*:\s*)(=
(\w*)|{(.*)})\s*((\w*)|{(.*)})\s*;/){
            #print "1=3D($1) 2=3D($2) 3=3D($3) 4=3D($4) 5=3D($5) 6=3D($6)=
 7=3D($7) 8=3D($8) 9=3D($9) 10=3D($10) 11=3D($11) 12=3D($12) 13=3D($13)\n=
";
            my $one   =3D $1||$2||$3;
            my $two   =3D $4||$5||$6;
            #: is 7
            my $three =3D $8||$9||$10;
            my $four  =3D $11||$12||$13;
           =20
            foreach my $src ( getAtoms($one) ){
                foreach my $dst ( getAtoms($two) ){
                    foreach my $class ( getAtoms($three) ){
                        #push @{$rules{$src}{$dst}{$class}}, getAtoms($fo=
ur);
                        addRule($src,$dst,$class,getAtoms($four));
                    }
                }
            }
       =20
        }elsif($line =3D~ /^allow (\w*)\s*(\w*):(\w*) (\*|\~.*);$/){
            #allow * *:* \*
            #allow * *:* ~*
            #push @{$rules{$1}{$2}{$3}}, "*";
            addRule($1,$2,$3,getAtoms($4));
        }elsif($line =3D~ /^allow \w* \w*;$/){
            #should i do anything with these?
        }elsif($line =3D~ /^allow /){
            #should i toggle this on or off with a switch?
            #print print "ignoring: $line\n";
            next LINE;
        }

    }#end - elsif($line =3D~ /^allow /)

    #not sure how I'll implement this.   =20
    #    elsif($line =3D~ /^type_trans/){
    #         if($line =3D~ /^type_transition\s*((\w*)|{(.*)})\s*((\w*)|{=
(.*)})(\s*:\s*)((\w*)|{(.*)})\s*((\w*)|{(.*)})\s*;/){
    #             #print "1=3D($1) 2=3D($2) 3=3D($3) 4=3D($4) 5=3D($5) 6=3D=
($6) 7=3D($7) 8=3D($8) 9=3D($9) 10=3D($10) 11=3D($11) 12=3D($12) 13=3D($1=
3)\n";
    #             my $one   =3D $1||$2||$3;
    #             my $two   =3D $4||$5||$6;
    #             #: is 7
    #             my $three =3D $8||$9||$10;
    #             my $four  =3D $11||$12||$13;
    #            =20
    #         }else{   =20
    #             print "ignoring: $line\n";
    #         }
    #     }
   =20
    #     elsif($line =3D~ /^role /){
    #    =20
    #     }elsif($line =3D~ /^dontaudit /){
    #    =20
    #     }elsif($line =3D~ /^auditallow /){
    #    =20
    #     }elsif($line =3D~ /^type_change /){
    #    =20
    #     }elsif($line =3D~ /^\s*neverallow /){
    #    =20
    #     }elsif($line =3D~ /^user /){
    #    =20
    #     }elsif($line =3D~ /^attribute /){
    #    =20
    #     }
   =20
    #     else {
    #         if($line !~ /^#|^$/){
    #             print "$line\n";
    #         }
    #     }

}#end - while(my $line=3D<FILE>)
close(FILE);



#keeping only unique permissions
foreach my $src (keys %rules){
    foreach my $dst (sort keys %{$rules{$src}}){
        foreach my $class (sort keys %{$rules{$src}{$dst}}){
            my %perms;
            PERM: foreach my $perm (@{$rules{$src}{$dst}{$class}}){
                $perms{$perm}=3D1;
            }
            @{$rules{$src}{$dst}{$class}} =3D keys %perms;
        }#end - class loop
    }#end - dst loop
}#end - src loop


################################################################
#from here on out are all the different printing options #######
################################################################
if($align){
    my %lists;
    #need to widest width of src, dest and class
   =20
    #1. collect all of the uniq src, dst and class
    #2. determin the widest src, dst and class
   =20
    SRC: foreach my $src (sort keys %rules){
        $lists{src}{$src}=3D1;
        DST: foreach my $dst (sort keys %{$rules{$src}}){
            $lists{dst}{$dst}=3D1;
            foreach my $class (sort keys %{$rules{$src}{$dst}}) {
                $lists{class}{$class}=3D1;
            }
        }
    }#end - SRC:=20

    #these are global values   =20
    ($wsrc,$wdst,$wclass) =3D (longest("src"), longest("dst"), longest("c=
lass"));
   =20
   =20
    sub longest {
        #used only with in the scope of this block of code
        my ($item) =3D @_;
        my $longest =3D 0;
       =20
        for my $atom (keys %{$lists{$item}}){
            my $length =3D length $atom;
            if($length > $longest){
                $longest =3D $length;
            }
        }
        return $longest
    }#end - sbu longest
}#end - if($align)



if($short_print_out){
    #because this print out puts a ":" after the dst
    #i am incrementing $wdst, I don't know if future print outs
    #will need this, so I'm just doing it here
    $wdst++;

    #print join("-",sort keys %rules) . "\n";

    SRC: foreach my $src (sort keys %rules){
       =20
        if($l{2}=3D=3D0){=20
            printf "%-${wsrc}s ", $src;
            print "\n";=20
            next SRC;=20
        }

        DST: foreach my $dst (sort keys %{$rules{$src}}){

            if($l{3}=3D=3D0){=20
                printf "%-${wsrc}s ", $src;
                printf "%-${wdst}s ", "$dst:";
                print "\n";=20
                next SRC;=20
            }

            CLASS: foreach my $class (sort keys %{$rules{$src}{$dst}}) {
       =20
                if($l{4}=3D=3D1){print "allow ";}
                printf "%-${wsrc}s ", $src;
                printf "%-${wdst}s ", "$dst:";
                printf "%-${wclass}s ", $class;                   =20
                if($l{4}=3D=3D0){=20
                    print "\n";=20
                    next SRC;=20
                }

                print "{ @{$rules{$src}{$dst}{$class}} };\n";
            }
        }
    }#end - SRC:=20
    killme();
}#end - if($short_print_out)


#printing out the rules
SRC: foreach my $src (sort keys %rules){

    print "$src\n";
    DST: foreach my $dst (sort keys %{$rules{$src}}){
   =20
        print "$tab$dst\n";
        CLASS: foreach my $class (sort keys %{$rules{$src}{$dst}}) {
            print "$tab$tab";
            printf "%-12s ", $class;
            if($l{4}=3D=3D0){=20
                print "\n";
                next CLASS;
            }
            print "{ @{$rules{$src}{$dst}{$class}} }\n";
        }
    }#end - DST:=20

    #only print out a new line if you are displaying
    #   at least two levels deep
    #if you aren't displaying at least two levels deep=20
    #   you are just displaying the src, so need for a double \n
    print "\n" unless($l{2}=3D=3D0);

}#end - SRC:=20




killme();
#
# end of program
#

sub addRule {=20
    #INPUT
    #   $scalar: source
    #   $scalar: destination
    #   $scalar: class
    #   $array:  list of permission
    #RETURN
    #   undef
    #DESCRIPTION
    #   determines if this rule should be added to the rule set
    #   if at anyone time it determines that it shouldn't it=20
    #       returns with out adding it
    #   if the rule should be added, it'll be done, and the program
    #       will return

    my($src,$dst,$class,@these_perms) =3D @_;


    if(@src   and !doesExpMatchList($src,\@src)){     return; }
    if(@dst   and !doesExpMatchList($dst,\@dst)){     return; }
    if(@class and !doesExpMatchList($class,\@class)){ return; }


    if(@perm){
        #if no permissions were selected don't bother with this
        my @keep_these_perm;
        PERM: foreach my $perm (@these_perms){
            if(doesExpMatchList($perm,\@perm)){
                push @keep_these_perm, $perm;
            }
        }
        if(!@keep_these_perm){
            return;
        }
        @these_perms =3D @keep_these_perm;
    }


    if($l{4}){
        push @{$rules{$src}{$dst}{$class}}, @these_perms;
    }elsif($l{3}){
        @{$rules{$src}{$dst}{$class}} =3D ();
    }elsif($l{2}){
        $rules{$src}{$dst} =3D undef;
    }elsif($l{1}){
        $rules{$src} =3D undef;
    }
   =20
    return;
}#end - sub addRule


sub getAtoms {
    #INPUT
    #   $scalar: a string coming from inside {}'s=20
    #       It doesn't matter if there are embedded {}'s
    #RETURN
    #   @array: the list of strings (not including {}'s) found
    #       within the top {}'s  =20
    my $list =3D shift;
    $list =3D~ s/{|}//g;
    return split(" ", $list);
}#end - sub getAtoms



sub doesExpMatchList {
    #INPUT
    #   $scalar: the string you want to look for in the list
    #   @array: list of reg exps you want to compare the scalar to
    #       the list will be used as is, (as in it will not be
    #       converted from a user reg exp to a perl reg expt
    #RETURN
    #   1 if a match occurred
    #   0 if no match found
    #DESCRIPTION
    #   give it a string and a list of regular expressions
    #   if the string matches any one reg exp return 1
    #       other wise return 0
    #   this is CASE INSENSITIVE
    #MISC
    #   Uses the global variable "$full_name" to determine if
    #   exact matches are required.
   =20
    my ($string,$l) =3D @_;
   =20
    foreach my $try(@{$l}){
        if(!$full_name && $string =3D~ /$try/i){  return 1; }
        if( $full_name && $string =3D~ /^$try$/){ return 1; }
    }
    return 0;
}#end - sub doesExpMatchList


sub intersection {
    #INPUT:
    #   two references to arrays
    #RETURN
    #   1 if any one element in the first array
    #   matches any one element in the second array, using
    #   the list compare that the rest of the program uses
   =20
    my ($first, $second) =3D @_;
   =20
    for my $f (@{$first}){
        if(doesExpMatchList($f, \@{$second})){
            return 1;
        }
    }
}#end - sub intersection


sub todo {=20
print "
TODO (someday)(in no particular order)   =20

    1. List type_transitions.

    2. Create multiple, user selectable print functions for the rulesets.
        Example: html, condensed, ...?

    3. Possibly use a conf file to alter certain parts of any one print f=
unction.
        Examples
            A. Never use line breaks, except at the end of a source line.
            B. Group certain dst's, with no line breaks within a group.
            C. Condense groups of permissions down to one permission.
               file {ioctl read getattr access lock poll write setattr ap=
pend}
               file { rw_file_perms }
               These could be hardcoded, or user defined.
       Don't know if i want to turn this into a \"two file\" script, thou=
gh.=20
   =20
    4. Once kde rules are finished (unrelated to this program) I'd like=20
       to use this code (which hopefully will be refined by then), to
       create a GUI based version of this program. The GUI would most lik=
ely
       read everything into memory and then display, and clear, the resul=
ts
       for each query.=20

    5. Force user input to be POSIX compliant, and give dst, pfile, and
       src single letter aliases.=20

";
}#end - sub todo


sub short_help {=20
print "
    Displays SELinux rules.
   =20
    --src=3DLIST                List of sources to display.
    --dst=3DLIST                List of destinations to select from.
    --class=3DLIST              List of classes to select from.
    --perm=3DLIST               List of permissions to select from.

    -f,--full-name            Match complete names only.=20
    --pfile=3DFILE              Specify a policy file.


    -s, --short               Condense the print out.
    -a, --align               Aligns colums when applicable.
    --tab=3DINTEGER             Sets width of tabs.
    --l=3D(1|2|3|4)             Level of info you want to see.
   =20
    --todo                    Show the TODO list.
    -h                        Displays this screen.
    --help                    Displays full version of help.
    --version                 Prints version and exits.

";
}#end - sub short_help


sub help {=20
print "
NAME
    cando - displays what cando what in a given policy.conf file.

DESCRIPTION
    The given input file has to be a finished SELinux rule set. No
    macros will be translated.

    Each LIST is made up of one or more comma separated strings. By
    default the compares of lists are case insensative and any match of=20
    any element is successful. \"-f\" or \"--full-name\" requires
    exact matches.
   =20
    This help file's nomenclature:
        allow source destination:class permissions
        abbreviated:
        allow src dst:class permissions
   =20
    As of this version ($version), backwards compatability is completely=20
    disregared, and not thought of for each subsequent release.=20

OPTIONS
    -a, --align
        Aligns colums when applicable.

    --dst=3DLIST
        Will keep only rules that interact with any destination in the
        supplied list.

    --class=3DLIST
        Will keep only rules that interact with any class in the
        supplied list.

    -f, --full-name
        When comparing a string to a list the full string will have
        match, including case.

    -h
        Display short help.
       =20
    --help=20
        Displays this help screen.

    --l=3D(1|2|3|4)
        How much info you want to see. src=3D=3D1, dst=3D=3D2, class=3D3,=
 Perm=3D4.
        This is useful if all you want to see is the sources that can
        exececute bin_t files.=20
        Example: \"cando  --dst=3Dbin_t --perm=3Dexecute -s --l=3D1\"
   =20
    --perm=3DLIST
        List of permissions you'd like to see.

    --pfile=3DFILE
        Use a supplied file name instead of the default.
        Default: $pfile
   =20
    -s, --short
        Condense the print out.
       =20
    --scr=3DLIST
        Will keep all rules who's source in in LIST.=20

    --tab=3DINTEGER
        Sets width of tabs.
   =20
    --todo
        Display the TODO list for this program.=20

    --version
        Prints version and exits.=20

EXAMPLES
    The following examples are from the default policy.

    cando --src=3Drpm_t
        Shows all rules for rpm_tmpfs_t and rpm_t.
       =20
    cando --src=3Drpm_t -f
        Shows all the rules for rpm_t.
       =20
    cando --src=3Drpm_t --dst=3Dtmpfs_t=20
        Shows:=20
            what rpm_tmpfs_t can do to tmpfs_t=20
            what rpm_t       can do to tmpfs_t and rpm_tmpfs_t
       =20
    cando --src=3Drpm_t --dst=3Dtmpfs_t -f
        Shows what rpm_t can do to tmpfs_t.
       =20
    cando  --dst=3Duser_gpg_secret_t
        Shows all sources that can do anything to a destination that
        mathes \"user_gpg_secret_t\".
       =20
    cando --dst=3Duser_gpg_t
        Shows all sources that can do anything with the user_gpg_t type.

    cando --dst=3Dgpg --perm=3Dexecute -sa
        Shows every domain that can execute any \"gpg\" type.
        The output is shortened (-s), and aligned (-a).
   =20
    cando  --src=3Dhttpd --dst=3D^user
        Shows what any httpd domain can do to any domain that starts with=
 user

AUTHOR
    Brian Fegler <brianfegler\@bigfoot.com>

";
}

#############################################


--------------Boundary-00=_1AW64CC8TQQ36KEORNH3
Content-Type: application/x-gzip;
  name="cando.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cando.gz"

H4sICODxrT0AA2NhbmRvAMRceXPbRrL/n59iTHJj0oYoUXYuMUqs2LLDKlt2SXKyqVWiAsEhiRUI
MBjQNB/FfPbXv54BMDgoX7vv0WUeg+6enp4+51Dr3v5SxfsjP9xfyDgQjaWSQiWx7yWDRqMlhDhZ
JrMoPhI/x74biudyGshYdEb4NeEfT0b+dBJFSc+L5l1GeRot1rE/nSWi87QrDg8ODgvYjRZDXc58
JRZxNI3duaCvk1hS19EkWbmxHIh1tBQe4cRy7IOh0TKRwk+EG473o1jMo7E/WVMD01qGY+IqmUmR
yHiuRDThHy/O3ooXMpSxG4g3y1Hge+Kl78mQxuhS32hRMzkWozXAmdJzcHFhuBDPI6LsJn4UDoT0
CSYW72Ss6Lc4dASx0XETcBqLaAGoLrG3ZjqBm+TAvR1Dzkc2Fn7ILM+iBQ1iRmRprCs/CMRICpqU
yTJwmAZBi9+Gl7+8fnspTs5+F7+dnJ+fnF3+PiBomil6Kt9JTcufLwKfSNNQYjdM1iQWJvHq9Pzp
L4Rz8vPw5fDyd4zj+fDy7PTiQjx/fS5OxJuT88vh07cvT87Fm7fnb15fnPaEuJAyk9Idgp3w5JDs
xjJx/UD1Go1G+1Yciz4pVKP1Oa8MS7wIohF1+asbLKUSH4n1aX3N16KdzvGxaPb6TeIbjYuJH0g0
scWo2NtXMvDD5fv9RUQCWJsPMoNwApzWK3ctwijB7JHgfOWIGykXfjjFXJMqaVmF0YrUgzp4gqcD
/TWJlAKJl6QgUGZFKuZJ6D6JVSV+yDqpeJaJfEzK1Gj5IakcPWVlAsudJ8Sl82SsEueJF7hKOU/I
yOddUFYyEUkkopDUZJLTWZGeKP0gWIu5m3gzId+7XiJCdy6pk6kP7VrN6G0cYSwBWCTTX5C9KBYU
qWpwDXAS1gH6og6s7hIeeqrarlDkXhKyCmKftJcpcNM1N11Do3fRERiOrxTLIqMYBP40hNqDSXdB
NuC5o0AyZRfPND0IqL2ChNoriKi9Yhl16WnnwKF/LCdMHHrVsl7542SGCXFF4o5ERxsmz6M3c8Mp
BJLBEITSTBDYmFwjg4AxMlSxt0fPj4dnl6cvTs+ZN1Ak9SLzEqw/ZEAYXkiaPotWNBnhWgRk3AE5
DlIVyIFFxJzFS1JO4hOU/hFgDKJ//GPfEYf8/ojfH/N7VyvnDcEvY5YXTbFPI/TwlQfsh55LWjuE
L9FKwZ00Wqnzor6BA012hSdjMnXSClJ4TYJmx5/LXkMtR+KG5oV0YQP4wbbRvhi+2NCwt8Tj1Vf6
4eBL/cIpGcbH+obP7OvLnNe5dMfG8tnO3n2Ay8/tK1nGoYlFikyT5nhvPBEwLfoi9iYNUtUOlM0/
PhjQ+w/H7dbJ+Ytf8f3hw+6mAe3zJ502Gv/V9v8Qx3+L/T/3rlabQ2fb3jcQeLGfkvMFzaMiG0s6
zaaToXUHBJGBqpk/STT0QNS+WlMy7Ngfw24CI6u9DL99DcPYa183YWrS9WYdJtbNqLVU4C5IFffI
NQgACBnIuQyTnAf4Adl5Ag6dtu/0nRIJ0VqQq1FknN6MpmbkejfwoxkP/kOS1R1DEK1xFN6nURD7
ZPY6MRD/XpJ7BGFDatvYNhrZIMBMV2RSJ0HvzWSwKMj5K7QMjBl1yHiZDHkBjTADcC7qr7TvrMXh
d37LsPeSaByVKKBpd397JjgWkbQjaqaR8ypsDrJndVzk5MgBH9vDXSzVTHDgStXKIb26X+WDfHYN
Ijz5BxDZzdeg6hD5AWREnBpcNNej1gh90t4Xt7cwqz3Eyj3EysKUF0Jov0KoJEFOTAo8ZblK+36K
3ODPlp4n4yCKdFTOFetQkaNqSO6XZePmBDjMliikobeCx4GwczXe9J3DbbeIlMbEpngv2lVJ5DSC
407/9vD20e3jbtlLtVXixuA4JYAXfBy33zt+TIqsvz98ONhmEERbbkQo3ydWI9ynodfricdWR8xu
sGlfb3V6kbZtLZ6Nh7ihnA9Zl3+fgqXODqWSGsIXGobCMLlAerCmnCaUE4q1aiF1nYBEgGKtRshE
gPQx04JWrppor1XNVj4FyDfrcNG+AzefhBbSG86BpqYkWCzjRaRQAoyWUyRFGs5bxjG55KwCmlO+
gGrBXdtpcnFiJdMoaHfqPfOoc79bnojTs183zesxRYztcb9+MtJ+pGXLxotdozij2nMZxtKLpqH/
PzRAbTR3erbGtiUpE9kTRQf/JYnDM6S68cdnD/8P2Q3Y8VElM4eIdR+D9Rl9kUbc24uNdzMzrqfs
4vLZ6fm5aHpuFoF1NSYAemRQsrnL5237BcMeY2o+ZexfMDecT0xRhozJF1B1Q2X4UqHXZrJeSNF7
0HF6D2hALVcJ5D2kqljYkEG0crgK5VyfyQxzt4NllyjmmsHQRW2w0eXmdoNac7vhuAiv9nJ4cdlo
UTk4X0CoG+ji9Xt6o6h/TYD8exbNJX6M/Rg4PBfEuJskMf2YR++kDmy9Xu+jaWHytiVay5CK7xsm
A/ZR/6Bk5h9J7IbK5xiHpka0kGHn+fDlqSOaP2hdaHbhesa+JKWJlsEYegMwoyqkMvdYXV4Oz06P
SG7UxnkzdSqPfwCtH40GesTlQj8YZOkzfunUmafHdl+twmxgLnhCeJlH+3wzKxkC55BY25nOCHbM
ywgIbGmeD753p+X7Yt/R7HVzz1UCcW4dhkLrv/p/WIBtoxcb/ezgj8yfVsKwNWiqAinEYdT5KC5f
P3ud/0ritR4pKeTYn0wkR4Yg8szKhlkOM6HCwouoyoXosIgAiHmkstCoxNRl48jAiS0OgLx0cm8c
SXX6fvEKyxpYWtEsO1cMYscQDoEI/QLzn0sjDZkcGPVyzC6SgPg4ko1ckNyQhdNi+EzHo8V8j8R8
MybrICHnVLc7INmapovpDuASA/79d5KqsElipkAHRRCDSZipMctXk2WyjO1Ib5HB0g6ZlsBc68Ui
V0DFA6nXMcTMVTNHq8Gc14vn7o0sSAwMeNEY60SkqAlhjpAJIRmVsSM6HhWLlHP81LU0BOTYpmFT
iV4Q4yUX5K1jqgvZW4OqI4jH5QK5ioVPGDw0VqqiaGq0/Eo96HSuVg+6t5sOeeBtt9LQoZYj+t/9
ABw1DPZLiYxJ2Jv940673xWH9HHYFY/o41FXPKaPx13xNX183RXf0Mc3XfEtfXzbFd/Rx3dd8T19
fN8V/QPgH9AXJkSU+iDVJ1p9EOs/6hYSG7zg7RDhBGfOt7ftQ/r/qAqTrCIN85ief03/vynCtI5g
mN9W8WZYaie87wjne/rfP6gSn2BtnRkAB32w0C/xUPhhEi+d9see6CBenCTRXHUwmK4oybeMQ+Vj
AYcGV4tTxuMYWcTE8Hbi6rnlHHvT5ti1Ab/bDTigdx1zt45FEKLoDnZSc8fjc6LTafOKJi9o6oK2
RGEHiW2ltdhSchbctMPts1JDu/F5xO/U9uD26m9kKO2KimusB+LB0QNx9WD3s79Lz0ri65PYDun/
I4it+aCkzZl4+k770Gk/ssTy2JbJrkHRKPC/hn3j5FC4oTLThRv7Gy7rfvog6d0Uk2gKZ8keLQqR
sESTiabtmpWqn+rchXEaVG9H9G16JDLnXYCuiUYmGKV1zE6OzXJClspggZrTGOw58cIbc93LFIbD
X4UckqNrztYKxSe/dkFyXvff8bp555Yw/y99b5GBuzxwFXKXHy4NyvLGNTR2+eQq6B2euQhcatrq
dZXqA7w+oLgWFeu3vRTBDRU1i6Mgz8FbZa6qdkmVXeIux5RpfAISIxQt+iOwWK/1xtCnoJHWhtib
+eT+eP3gU0aVpHvvu5Fq5C/FTnNGPvpn6/bPdr3VldPNOyc+W3CpL9AaXkCpHVd+XS4EW+kOLG9v
LkP/r2VhE7FRyR9u5FqZ6tKwW0kXFPYvNVwhlm+ra1Z2rrALTacA21JQQFkLRlXRhb85PX91VKAO
ING5M6uoyUkYjaDxUVgxy2Wevu4kTQ5BD6nEazpPeuxBFC0KcQZy5Ma0AbLnhs9clyqsukziaK43
3BFEqQhwzbYnqou8+GTNY+UwdfUXLdvYHED3efnbSJ73aKlYNAJqhaheqbJd+VhxyXeQeReEm1Bq
suwsW+v3qIgJAuklPBhz5gVKbRAreK3Dnkh3ldP9bFDfAc5vF+dPj6pptaW8tm2wKvHINlo58G6r
07OLy6PPsyCLtNY4vJc19TPMTNQYg+5Gq3Sq2ruNYltQZZaXSY84AWRtm+rNabNwm8p25/mDIKJ4
oJJOkx43u47IfhNg4TejNNMENn/DxrsBsgaolxbY93ESabRAeTh0xPpDucEoiLwb/EKFbC8rddp+
Iufg78n1wH7QTnsqbHzYvo+hXEq3U4e6MTJmknXOrh3IcEosHgvzhdGLU8AhRT/9MWOizrnl/Bn4
u6cSr1jyVnqKWphiNVqmws0cVm7iiDO8u1TcMUuD3Uh6brb4arbjlrxFrCipbx41hTtJzGG2sem4
5QscGAu9mFNr+CitM2IoiltKZjkmo2vsns/GaC/DB5FURNn6XG9O65UZynXgIRmcaT98OCjsGf6b
wDrNvaZTMX3RE02O1J/nL4qLK5vD7fHxgb21jBezMBHNf+y1NzCZrRJNh0kPqnCamyIBLnWINat5
my9VfbpXqurh5lEd45/CfAUWDophm2DoqLkDvG68O8ZcGjdeT1+eXFwcfaHnrPStRfKYRNLvbgyX
OldtDqpLDf9tCaXg2pNr4vy99ijHHYOpnd+sm10TgdeOycCrNCEWuc0Hkq3toFLT3x2W0GJtflm+
q+ytkHjlCdEyP2SmGh9t4Q1rKADKmP28LKBRkg4OBwCzIIP/iDqXO6H/zRpHw2rVP7T1qcYv7NQb
S2fqbZfHclcq/rFqUuiiqBc8FcbRc2KQhySXuFgJrtkosuAwEzKZsa8WgbvONvXpv5vgzBb2qFaR
fULRxK4MF4EqR9+JlpeSaZ86TuWYnLTwCaFIRzWkGC5FsuWICv2r0FY8Gjv2CqVSeXQZ5IWjSdfo
ldsFDmvjKeVA6f5Tq8FnGc0qojCz2RqevXl7mbHbVp4buPGROa5bbbfO7lYfWmk6mnFme30k9Pla
cJJVqRrm/PTy7flZBo8T8BP969npxdPz4ZvL4ev8sXWW1Dd5nj4xOks3SmhouggpnCZN8QnJRXmw
5pO3/pyP4ltE0xPrmh4mmn4USnedUKl8J4Y61ImH3UneeZExh+DMLim23R2uVMobhGlXnO3o/hqm
3qouiz/h5Pya69Q0p9XQ2N+DSxO7Ng1B6gog3e7GGtvAmBbw4dB24oOLK4Dsxtc+awe+HsCVBgKN
HD8fAZ/0tlJ/Em4YFQ9MoyJWEgWkHJs8chTxJQezfG0O42gR6pNE17nYcpeycxXClnHRvRKL1YHx
KborzXpNHp+fZ7K4cHRnH87ocXqkjFzqxMixBtkeCZSlVhSW+NnvV04J3r3VY/dROCPHyaVF7EMr
MKVDm+z27AK9gkw47D/KaP1daCWEPDynEsxKpdxpNrQLTfdd0gXCHS7U5VtIvE87xwev4fih8sfk
fbf3VdG5DBPeiIcGz90E5ZP2JbGuvuV8JNm9AbPWfT4x7hYuJfW4mgHKHLDLQcVXsGSHBRpdUnYS
QMnrYOtHH36PFppJIxW9LskFKB+F1mIzTX8Ltb+53e7vTweWCNNDd5xbALBbFGoqxoYRa9mYPiBe
jqBawAiy+oR/hCW3Gw6mZiDouCKjVD6xnAr5fqEKFMxNELOugM6otSCnTMTW7aYx7mOhMO24fPQj
vfsEyY9kAd2LwncyhsdilXD1iTjDCzhwBd9kMy1J7XT3OaCZ+y2RxwcT89k8ENpZ6sfWTNdFVlyI
4XtpqTzhtF1bSEsIgViJpVlkTlFNvDN43JtUfLpTH/rTQzL60C9IIXXTSqbPD7Ln+gaHEk9PLk7F
8Ozi9OxieDn89VQDvBpePM1A3yqpL7Zk61Oxj7sylPdmR5CbEGoW6onpDFtfDMr4jsHLX0ufRNnL
PQIvHOkhOu3AXj3iNztoJPEaC9eB7XXgta3j0F99JQwx3p4Ayr6PKJpKaVD0+GI37p9A5lPsZdyt
bYcHRbsr25kxP757pSiS4tqYbXpH+bRQlhtLXmv2JN+xYnuq90daQY0mmKsMqVFO/BhLtUDO4MvK
U0IhziKoJXAcfc7MUhdZuMSlczlOxKTWYSvPgrWp0uQyPyjXuZO6GdYbhrwrwcClCa4mAhNHXBGw
prgt5wLZfJVrmsJM2VNiZgk3G5C7m9KggSNpKAzncuyuux0SFlIkN058j402iscy7vJIuIN+T7Bv
LW1G444jHh/2xFPS5kSK+TJI/EUgHe2ddJLFhqW7nixDT+8xQDpZaS0T1cvGdJqejZwl88CB3xvj
giWlwr1e7yfd46OeeBORVxlhNwtLzQCb8KFXVrAAoTC9noWB8dXYVEmKvFR6VgWhn/TEGd8GQz9c
FI5orDfks+V7Ty4SYZTGFE5uemcRoL0CpZ974kUcLRcZY5SC3Cc6nHTSBFjE06DqiikwinSekriN
UPRjVayTqJqMVmF6XTBvL1KBhkJcGz/ykqB4xtT1yFKxXeXd4DxxIFaxn3BhpB8vFjTaynKWJifi
1TW+mZyxAnXJewPZObWZG4+x4D7ma8WsNebkZcbus+LlgSzksjGYa3sc/66a8DV84rlJQTj2F4lj
zo/2rD2Cxz3xmlyRuBkb9WMXTn3qS9EdnH7HNWZTFeZXl7t8CpVvl6W8EUS2qM3n9TqrmU9uHdeZ
4YHXWbSP9ajMneuw66T5Ab08bT2uePF2KEYu8oL0Km66O2FY6EF+DLZiCfIpUHAUrFNiPJPQWHMk
h4Uzl/MoXqfVY5guKjhm50u6sZO6PjLhzAJgpRym/loSvZ5xB1/3xPMIOq6v4PLxb+qDBvnm9cXw
n+xQA59mSZPnTIFX7fmIMTemHaDezI5GcgLrEib5WvTVLIYgeDHj0PLLXrZbY2XRA1Pi4vQlLinr
Gbbisr55hSPdJcUUxUvHHKmMmHoGE1ev7sIs3lGOjP/jhC0loS9hVYmkJPi53IXNt7BqOHhZWSyp
UtAkJo51+comwVFITx3lPPraM2+Z9VK56ftWOFRQ7PxiIT38TQLXvnvQMzXhHjk4c7GqxHPmw/LD
ttEyMSN1gaVvThVfJ2iDrQXLuSpfdU7FZN0wLnKKiwSFe8ophnWNqihYPq8b4SrpJCok/ErKglZx
jK15XeCIGIbIQRcJh+lzVgeNV6bC+g42OQcZpnyyyt+Fg7m1nQcQUuS0ufx6A+GrDAs2yxejexUT
zO3OGGLZBM9OXul82yMqEU44pIzxFQzdyl91dONb9dYfEEh1p1xxwOtpYO1uONbMXGX8jpu7b9vu
EbEofGs/O3e9OMqvy3Maw27emMYp/BzbFo5lu+TLKVSTBBFE07/tQOYxpwgvKaXgAGFK5Z74Wbtf
Cl0u+U9zfFv/bQC+2otNXw4zfL+c6nnSfPIT7/TfNkBiYmqyidYntGS5LCnBkiMyTW6PotzehOIb
sUTfclumJlOFmJtkdpFiaSr/LQ6eNsiQavWQ0kAq8l1soB5l0VpvWplcxvJrR3qFzj47lKGMKHl5
50MwFTrk5rFRVY/Mbycqi3WpInbSa7UULHEteUW5gtJyJdv1Az9ZC19lPouCrZ4EX1ENScIe6/iD
YlpnAewjs5hG+qtIYhAxBXxJE4Og85qV7qLshrIBfcABlSJFhvYb1I5vZPBug8479Oox8nXMlT7f
ShNvidsUMhkZnNrnv22iHUklqHxWf3pWPqanCeSRqVzeGaSg9d3cdtDlJmdlXGNx/QbXZJ6wFc7c
d9ZBC2iqY603wVLSfmcZmHF05q9n5N4t0yPjI8sIxpvys9SlVn1/hvUL/vDE0pvV+33o8/Fxn88O
HR8fOlqCx48c8QYB+nHO0qVZkzB/MAPFLQ28RA8AXK2miYdxlRkV+V560sNhxJEfXmvvp3r5GLOS
6aqpPazRQA1t0gYQAYk9xWPuXzXt8JVlFhnRupyCGE8z4DQEVpKDjMBbLswyPWKXzVkHub8ESaop
sY3TzIX2TDek1xctNvNkIgO+K42wxkdz/r+VXMFqwzAMvecrRk7NoT8wxqCHQA8dG2yDHQIhsJb2
kDXMgf3+9GTJlu2E0mMSWVIkS3p2Yq0FCDzi4+PvfKWEKEnvwsGHMYp709YlymgNVBhcUMzeBA/I
WtiCfJUn+S+MX63UNKL92r28Hdr3UC9PV+RehJIcN5SFDrYPjd21/Fa2bjNI/p3GPhoaQMYZY0Fr
phink+v9P3R8ndm+4Ih2HCXTsBkQGd9mxLNcFUiZPqYfnhlzWHXRY4vYYYmXj0/p5UZJH17YX9+n
bGEDI7AQtWgIYahH3Hp3pLQ2LzosTyzJkQ1O0rbkgMqmZeyvdXUhp6tX/JNodbc6eoLkIbLgfads
fkIIPSyT25AJ5JUwSRiHy0+UqPQof11NjAg+eSk6GhFEiYRbmDg5eYf1+2brGo8rBum3tNkOjQn5
4B24/jzP07eoy/+gL3kdSnhCUTNOAIYDRnduwSAfk5ldtfv82L/6bJS0qnsyreo626vu2aP66h/L
FiKrA08AAA==

--------------Boundary-00=_1AW64CC8TQQ36KEORNH3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
