Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4DGm8gA004460
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 12:48:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4DGit6j021869
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 16:45:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 27EB961AF1
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 17:20:35 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21315-08 for <selinux@tycho.nsa.gov>;
	Fri, 13 May 2005 17:20:34 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B24C761ADD
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 17:20:34 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: setfiles and relabeling
Date: Sat, 14 May 2005 02:44:26 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wlNhC9dDBmuoQpj"
Message-Id: <200505140244.32358.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_wlNhC9dDBmuoQpj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As fixfiles calls setfiles we need the attached patch so that setfiles runs in 
the correct domain for a autorelabel on boot.  Things still work otherwise 
(the machine will be in permissive mode), but it gives more AVC messages 
which hide things that may be worth seeing.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_wlNhC9dDBmuoQpj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/setfiles.te.orig	2005-05-14 02:39:14.000000000 +1000
+++ domains/program/setfiles.te	2005-05-14 02:39:47.000000000 +1000
@@ -26,6 +26,9 @@
 
 domain_auto_trans(secadmin, setfiles_exec_t, setfiles_t)
 allow setfiles_t { userdomain privfd initrc_t init_t }:fd use;
+ifdef(`distro_redhat', `
+domain_auto_trans(initrc_t, setfiles_exec_t, setfiles_t)
+')
 
 uses_shlib(setfiles_t)
 allow setfiles_t self:capability { dac_override dac_read_search fowner };

--Boundary-00=_wlNhC9dDBmuoQpj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
