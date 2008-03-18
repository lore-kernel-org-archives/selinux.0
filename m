Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2IFSQVA010599
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:28:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2IFSPFc029949
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 15:28:26 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2IFSPYv001049
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:28:25 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2IFSP2o025862
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:28:25 -0400
Received: from dhcp-10-12-34-132.boston.devel.redhat.com (vpn-248-104.boston.redhat.com [10.13.248.104])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m2IFSOkB027857
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2008 11:28:24 -0400
Message-ID: <47DFDF9E.4010008@redhat.com>
Date: Tue, 18 Mar 2008 11:28:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: semanage patch from Caleb with man page fix
Content-Type: multipart/mixed;
 boundary="------------050608080904030003070606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050608080904030003070606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------050608080904030003070606
Content-Type: text/plain;
 name="semanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="semanage.patch"

--- nsapolicycoreutils/semanage/semanage	2008-01-28 16:52:22.000000000 -0500
+++ policycoreutils-2.0.44/semanage/semanage	2008-03-18 11:23:20.000000000 -0400
@@ -47,7 +47,7 @@
 semanage {boolean|login|user|port|interface|fcontext|translation} -{l|D} [-n] \n\
 semanage login -{a|d|m} [-sr] login_name\n\
 semanage user -{a|d|m} [-LrRP] selinux_name\n\
-semanage port -{a|d|m} [-tr] [ -p protocol ] port | port_range\n\
+semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range\n\
 semanage interface -{a|d|m} [-tr] interface_spec\n\
 semanage fcontext -{a|d|m} [-frst] file_spec\n\
 semanage translation -{a|d|m} [-T] level\n\n\
@@ -103,7 +103,7 @@
 		valid_option["user"] = []
 		valid_option["user"] += valid_everyone + [ '-L', '--level', '-r', '--range', '-R', '--roles', '-P', '--prefix' ] 
 		valid_option["port"] = []
-		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--protocol' ] 
+		valid_option["port"] += valid_everyone + [ '-t', '--type', '-r', '--range', '-p', '--proto' ] 
 		valid_option["interface"] = []
 		valid_option["interface"] += valid_everyone + [ '-t', '--type', '-r', '--range'] 
 		valid_option["fcontext"] = []
--- nsapolicycoreutils/semanage/semanage.8	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.44/semanage/semanage.8	2008-03-18 11:23:24.000000000 -0400
@@ -9,7 +9,7 @@
 .br
 .B semanage user \-{a|d|m} [\-LrRP] selinux_name
 .br
-.B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
+.B semanage port \-{a|d|m} [\-tr] [\-p proto] port | port_range
 .br
 .B semanage interface \-{a|d|m} [\-tr] interface_spec
 .br

--------------050608080904030003070606
Content-Type: application/octet-stream;
 name="semanage.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="semanage.patch.sig"

iEYEABECAAYFAkff354ACgkQrlYvE4MpobMEugCgy/atUm5LD4KCcigvpOUu54ckgb4AnAjS
4SWOKsnzQ60ApdMJtAGrf9KC
--------------050608080904030003070606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
