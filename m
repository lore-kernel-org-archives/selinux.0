Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01648
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 13:27:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA05860
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 18:26:29 GMT
Received: from jsmith.org (pool-141-158-43-243.phil.east.verizon.net [141.158.43.243])
	by jazzband.ncsc.mil  with ESMTP id SAA05856
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 18:26:26 GMT
Subject: Revised perl script
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 04 Dec 2001 13:24:35 -0500
Message-Id: <1007490275.3468.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Here's the revised perl script that uses the new one-line format for
denied-messages:
#---------------------cut here---------------------------------
#!/usr/bin/perl
open ERRFILE, "< messages";
open NEWRULES, "> newrules";

my %rules = ();

# format: $rules{ "$scontext|$tcontext|$tclass"}
#          = { '$accesstype' => 1}; 

while ($inline = <ERRFILE>)
  {
    next unless ($inline =~ /avc:\s*denied\s*\{((\w|\s)*)\}/);
    my $accesstype = $1;
    my $nextline = $';
    $nextline =~ /scontext=\w+:\w+:(\w+)\s*/;
    my $scontext = $1;
    $nextline = $';
    $nextline =~ /tcontext=\w+:\w+:(\w+)\s*/;
    my $tcontext = $1;
    $nextline = $';
    $nextline =~ /tclass=(\w+)\s*\Z/;
    my $tclass = $1;
    my @atypes = split / /,$accesstype;
    foreach $atype (@atypes)
      {
	$atype =~ /\s*(\w+)\s*/;
	my $trim = $1;
	$rules{"$scontext|$tcontext|$tclass"}{$trim}=1;
      }
  }

# done  with the input file
# now generate the rules

foreach $k (sort keys %rules)
  {
    my ($scontext,$tcontext,$tclass) = split /\|/, $k;
    print NEWRULES "allow $scontext $tcontext:$tclass { ";
    my $access_types = $rules{$k};
    foreach $t (sort keys %$access_types)
      {
	print NEWRULES "$t ";
      }
    print NEWRULES "};\n";
  }
#------------------------------------------------------------------


2. Here's the result of running it on the new ipchains domain:
# File contexts for the ipchains programs:
#-------------------------cut here------------
/usr/sbin/ipchains		system_u:object_r:ipchains_exec_t
/sbin/ipchains			system_u:object_r:ipchains_exec_t
/sbin/ipchains-restore		system_u:object_r:ipchains_exec_t
/sbin/ipchains-save		system_u:object_r:ipchains_exec_t
#--------------------------------------------------------------------

Description of the ipchains domain:
#---------------------cut here------------------------
#
# Rules for the ipchains_t domain.
#
type ipchains_t, domain, privlog;
type ipchains_exec_t, file_type, sysadmfile, exec_type;
type ipchains_file_t, file_type, syadmfile;
type ipchains_var_run_t, file_type, sysadmfile, pidfile;

domain_auto_trans(ipchains_t, insmod_exec_t, insmod_t)

domain_auto_trans(ipchains_t, ifconfig_exec_t, ifconfig_t)
file_type_auto_trans(ipchains_t, var_run_t, ipchains_var_run_t)

# Inherit and use descriptors from init.
allow ipchains_t init_t:fd inherit_fd_perms;
#--------suto-generated:
allow ipchains_t bin_t:file { execute execute_no_trans file };
allow ipchains_t ipchains_exec_t:file { execute_no_trans file };
allow ipchains_t ipchains_t:capability { capability net_admin net_raw };
allow ipchains_t ipchains_t:rawip_socket { create rawip_socket setopt };
#----------------------------end------------------------



-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
