Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85CjwrT017412
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 08:45:58 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85Cj5ia004896
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 12:45:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6E1D761AFD
	for <selinux@tycho.nsa.gov>; Sun,  5 Sep 2004 22:45:56 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 24743-03 for <selinux@tycho.nsa.gov>;
	Sun, 5 Sep 2004 22:45:56 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 22E9961AFC
	for <selinux@tycho.nsa.gov>; Sun,  5 Sep 2004 22:45:56 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 806F9B58F1
	for <selinux@tycho.nsa.gov>; Sun,  5 Sep 2004 22:45:54 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: crontab -u
Date: Sun, 5 Sep 2004 22:45:53 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409052245.53741.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- macros/admin_macros.te      2004-09-03 05:14:42.000000000 +1000
+++ /root/admin_macros.te       2004-09-05 21:28:38.504868911 +1000
@@ -67,7 +67,7 @@

 # Manipulate other user crontab.
 allow $1_t self:passwd crontab;
-
+can_getsecurity(sysadm_crontab_t)

 # Change system parameters.
 can_sysctl($1_t)


The above patch is needed to have crontab -u work as administrator.  The below 
patch is needed to have rpm run crontab -u (IE installing mailman).


--- /root/rpm.te        2004-09-05 21:37:55.677133067 +1000
+++ domains/program/rpm.te      2004-09-05 21:39:08.658793880 +1000
@@ -161,6 +161,7 @@
 ')
 ifdef(`crond.te', `
 allow crond_t rpm_t:fifo_file r_file_perms;
+allow rpm_script_t self:passwd crontab;
 ')

 allow rpm_script_t proc_t:dir { search getattr };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
