Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27623tm020585
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 01:02:03 -0500
Received: from mxout2.cac.washington.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2760UVk003691
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 06:00:30 GMT
Received: from smtp.washington.edu (smtp.washington.edu [140.142.32.139])
	by mxout2.cac.washington.edu (8.13.5+UW05.10/8.13.5+UW05.09) with ESMTP id k27621UO007942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 22:02:01 -0800
Message-ID: <440D21C1.30401@u.washington.edu>
Date: Mon, 06 Mar 2006 22:01:37 -0800
From: Brad Willson <bwil150n@u.washington.edu>
Reply-To: bradw@genetests.org
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SEL+RHEL4+Amanda, targeted policy 18, enforcing
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Red Hat Enterprise Linux AS release 4 (Nahant Update 2)
selinux-policy-targeted-1.17.30-2.110
selinux-policy-targeted-sources-1.17.30-2.110
libselinux-1.19.1-7
amanda-2.4.4p3-1
amanda-client-2.4.4p3-1
kernel-smp-2.6.9-5.0.5.EL

The output from sestatus:
SELinux status: enabled
SELinuxfs mount: /selinux
Current mode: enforcing
Mode from config file: enforcing
Policy version: 18
Policy from config file:targeted

Policy booleans:
allow_ypbind active
dhcpd_disable_trans inactive
httpd_builtin_scripting active
httpd_disable_trans inactive
httpd_enable_cgi active
httpd_enable_homedirs active
httpd_ssi_exec active
httpd_tty_comm inactive
httpd_unified active
mysqld_disable_trans inactive
named_disable_trans inactive
named_write_master_zonesinactive
nscd_disable_trans inactive
ntpd_disable_trans inactive
pegasus_disable_trans inactive
portmap_disable_trans inactive
postgresql_disable_transinactive
snmpd_disable_trans inactive
squid_disable_trans inactive
syslogd_disable_trans inactive
use_nfs_home_dirs inactive
use_samba_home_dirs inactive
use_syslogng inactive
winbind_disable_trans inactive
ypbind_disable_trans inactive

Running SELinux enforcing mode does not allow amanda to connect and do
backups.

I'm a newbie at SELinux in dire need of some straightforward answers.

Following the logic that named.fc needs a companion named.te, the first
thing I have noticed is the lack of an amanda.te file in this particular
distribution.  What I find odd is there are several diffs on this list
specifically for amanda.te.  I have located what appears to be a
complete amanda.te file from another distribution, but when I try to
recompile the policy, it spews errors then fails, e.g.

Building file_contexts ...
/usr/bin/checkpolicy -o policy.18 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
domains/program/amanda.te:143:ERROR 'syntax error' at token
'can_network_server' on line 4181:

can_network_server(amanda_t);
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.18] Error 1

 From the head of amanda.te
...
# X-Debian-Packages: amanda-common amanda-server
# Depends: inetd.te
# Author     :  Carsten Grohmann <carstengrohmann@gmx.de>
#
# License    :  GPL
#
# last change:  27. August 2002
#
# state      :  complete and tested
...

Log files follow...

sendbackup: debug 1 pid 27890 ruid 33 euid 33: start at Fri Mar  3
01:17:19 2006
/usr/lib/amanda/sendbackup: version 2.4.4p3
  parsed request as: program `GNUTAR'
                     disk `/home'
                     device `/home'
                     level 0
                     since 1970:1:1:0:0:0
                     options
`|;bsd-auth;compress-fast;index;exclude-list=/usr/lib/amanda/exclude.gtar;'
sendbackup: try_socksize: send buffer size is 65536
sendbackup: time 0.000: stream_server: waiting for connection: 0.0.0.0.42857
sendbackup: time 0.000: stream_server: waiting for connection: 0.0.0.0.42858
sendbackup: time 0.000: stream_server: waiting for connection: 0.0.0.0.42859
sendbackup: time 0.000: waiting for connect on 42857, then 42858, then 42859
sendbackup: time 29.995: stream_accept: timeout after 30 seconds
sendbackup: time 29.995: timeout on data port 42857
sendbackup: time 59.990: stream_accept: timeout after 30 seconds
sendbackup: time 59.990: timeout on mesg port 42858
sendbackup: time 89.986: stream_accept: timeout after 30 seconds
sendbackup: time 89.986: timeout on index port 42859
sendbackup: time 89.986: pid 27890 finish time Fri Mar  3 01:18:49 2006

The preceding is typical of all the directories to be backed up.

 From /var/log/secure...

Feb 28 00:45:01 ajax xinetd[12722]: START: amanda pid=27017
from=xxx.xxx.xxx.xxx
Feb 28 00:45:01 ajax xinetd[12722]: START: amanda pid=27018
from=xxx.xxx.xxx.xxx
Feb 28 01:17:18 ajax xinetd[12722]: START: amanda pid=30144
from=xxx.xxx.xxx.xxx
Feb 28 01:17:48 ajax xinetd[12722]: START: amanda pid=30169
from=xxx.xxx.xxx.xxx
Feb 28 01:18:40 ajax xinetd[12722]: START: amanda pid=30211
from=xxx.xxx.xxx.xxx
Feb 28 01:19:22 ajax xinetd[12722]: START: amanda pid=30241
from=xxx.xxx.xxx.xxx
Feb 28 01:20:09 ajax xinetd[12722]: START: amanda pid=30269
from=xxx.xxx.xxx.xxx
Feb 28 01:20:24 ajax xinetd[12722]: START: amanda pid=30293
from=xxx.xxx.xxx.xxx

And finally from the amanda server...

Little of value on the amanda server (running on a Debian Sarge box on 
another network)  I know the firewall rules are good because the backups 
on other machines work.

Since the first send bounced back, I also tried strict/enforcing and 
found myself in even deeper trouble, but still without a successful 
backup.  My next test is to relax targeted policy to permissive so I can 
audit the errors for clues.

Thanks in advance!

-- 
Brad Willson
Sr. Computer Specialist
UW GeneTests, http://www.genetests.org
EM: bwil150n@u.washington.edu
W: 206.221.4674, C: 425.891.2732




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
