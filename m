Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IEmES8005438
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 10:48:14 -0400
Received: from QMTA07.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IEmAlK024454
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 14:48:10 GMT
Received: from ccase by shiva.hsd1.md.comcast.net. with local (Exim 4.69)
	(envelope-from <ccase@tresys.com>)
	id 1JbcqS-0003pv-CG
	for selinux@tycho.nsa.gov; Tue, 18 Mar 2008 10:31:16 -0400
Subject: policycoreutils semanage --proto --protocol inconsistent flags
To: <selinux@tycho.nsa.gov>
Message-Id: <E1JbcqS-0003pv-CG@shiva.hsd1.md.comcast.net.>
From: Caleb Case <ccase@tresys.com>
Date: Tue, 18 Mar 2008 10:31:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

semanage --help indicates two conflicting ways of using the port protocol flag:

# semanage --help | grep proto
semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range
	-p, --proto      Port protocol (tcp or udp)

That is --protocol and --proto.

The code paths are similarly conflicted with --protocol as the 'valid_option', but --proto as the flag actually used in getopt. This results in --protocol not being recognized:

# semanage port -t ftp_port_t -a --protocol tcp 12345
/usr/sbin/semanage: Options Error option --protocol not recognized 

The port is not added in this case.

Using --proto instead results in a 'not valid for port objects' error, but the error is ignored and the port added:

# semanage port -t ftp_port_t -a --proto tcp 12345
--proto not valid for port objects

# semanage port -l | grep 12345
ftp_port_t                     tcp      12345, 21

The man pages for semanage are also inconsistent.

This patch resolves the inconsistency to use --proto.

---
 semanage/semanage   |    4 ++--
 semanage/semanage.8 |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: policycoreutils/semanage/semanage
===================================================================
--- policycoreutils.orig/semanage/semanage
+++ policycoreutils/semanage/semanage
@@ -47,7 +47,7 @@ if __name__ == '__main__':
 semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] \n\
 semanage login -{a|d|m} [-sr] login_name\n\
 semanage user -{a|d|m} [-LrRP] selinux_name\n\
-semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
+semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range\n\
 semanage interface -{a|d|m} [-tr] interface_spec\n\
 semanage fcontext -{a|d|m} [-frst] file_spec\n\
 semanage translation -{a|d|m} [-T] level\n\n\
@@ -103,7 +103,7 @@ Object-specific Options (see above):\n\
 		valid_option["user"] = []
 		valid_option["user"] += valid_everyone + [ '-L', '--level', '-r', '--range', '-R', '--roles', '-P', '--prefix' ] 
 		valid_option["port"] = []
-		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 
+		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--proto' ]
 		valid_option["interface"] = []
 		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
 		valid_option["fcontext"] = []
Index: policycoreutils/semanage/semanage.8
===================================================================
--- policycoreutils.orig/semanage/semanage.8
+++ policycoreutils/semanage/semanage.8
@@ -9,7 +9,7 @@ semanage \- SELinux Policy Management to
 .br
 .B semanage user \-{a|d|m} [\-LrRP] selinux_name
 .br
-.B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
+.B semanage port \-{a|d|m} [\-tr] [\-p proto] port | port_range
 .br
 .B semanage interface \-{a|d|m} [\-tr] interface_spec
 .br

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
