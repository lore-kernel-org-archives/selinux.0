Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P4W5rT002990
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 00:32:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P4VHLV018957
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 04:31:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 90F7A61AFB
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:32:02 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26791-06 for <selinux@tycho.nsa.gov>;
	Wed, 25 Aug 2004 14:32:02 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 229EE61AFA
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:32:02 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id BA8A9B5889
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:32:00 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: initrc.te
Date: Wed, 25 Aug 2004 14:32:00 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AZBLBJWp8HrGLot"
Message-Id: <200408251432.00287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_AZBLBJWp8HrGLot
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch (against the latest CVS version) simplifies the initrc_t 
domain declaration.  The current version is difficult to read and leads to 
bugs (such as putting the unrestricted on only one of two lines where it was 
needed).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_AZBLBJWp8HrGLot
Content-Type: text/x-diff;
  charset="us-ascii";
  name="initrc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="initrc.diff"

--- /usr/src/se/policy/domains/program/initrc.te	2004-08-25 13:21:21.000000000 +1000
+++ ./domains/program/initrc.te	2004-08-25 14:14:34.000000000 +1000
@@ -11,14 +11,13 @@
 # initrc_t is the domain of the init rc scripts.
 # initrc_exec_t is the type of the init program.
 #
-ifdef(`sendmail.te', `
 # do not use privmail for sendmail as it creates a type transition conflict
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer;
+type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, auth_write, unrestricted, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer, ifdef(`sendmail.te', `', `privmail');
+ifdef(`sendmail.te', `
 allow system_mail_t initrc_t:fd use;
 allow system_mail_t initrc_t:fifo_file write;
-', `
-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem,auth_write, ') domain, privlog, privowner, privmodule, sysctl_kernel_writer, privmail;
 ')
+
 role system_r types initrc_t;
 uses_shlib(initrc_t);
 can_ypbind(initrc_t)

--Boundary-00=_AZBLBJWp8HrGLot--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
