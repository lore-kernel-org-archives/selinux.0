Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U4eZgA019256
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 00:40:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U4cwBs024559
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 04:38:59 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C388561B03
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 14:39:35 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21070-05 for <selinux@tycho.nsa.gov>;
	Thu, 30 Jun 2005 14:39:35 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 54F5D61B02
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 14:39:35 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 5696C44
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 14:39:30 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: crontab policy
Date: Thu, 30 Jun 2005 14:39:27 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Be3wCJNkPXMChje"
Message-Id: <200506301439.29861.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Be3wCJNkPXMChje
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow the "crontab -u" checks to operate 
correctly.  Without this the check always returns 0 and crontab will allow 
root to create crontabs for anyone regardless of SE Linux context.

Note that it may be necessary to go further.  I am operating under the 
assumption that if you want to grant a particular crontab domain the access 
to create crontab files for other users then you will grant extra access to 
the crontab domain as well as the "passwd crontab" access to the parent 
domain in the policy.  Maybe we should allow all $1_crontab_t domains to 
perform the security checks?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Be3wCJNkPXMChje
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/program/crontab_macros.te.orig	2005-06-30 14:30:43.000000000 +1000
+++ macros/program/crontab_macros.te	2005-06-30 14:35:37.000000000 +1000
@@ -41,8 +41,6 @@
 # Use capabilities dac_override is to create the file in the directory
 # under /tmp
 allow $1_crontab_t $1_crontab_t:capability { setuid setgid chown dac_override };
-dontaudit $1_crontab_t proc_t:dir search;
-dontaudit $1_crontab_t selinux_config_t:dir search;
 
 # Type for temporary files.
 file_type_auto_trans($1_crontab_t, tmp_t, $1_tmp_t, { dir file })
@@ -65,6 +63,11 @@
 
 # for the checks used by crontab -u
 dontaudit $1_crontab_t security_t:dir search;
+allow $1_crontab_t proc_t:dir search;
+allow $1_crontab_t proc_t:{ file lnk_file } { getattr read };
+allow $1_crontab_t selinux_config_t:dir search;
+allow $1_crontab_t selinux_config_t:file { getattr read };
+dontaudit $1_crontab_t self:dir search;
 
 # crontab signals crond by updating the mtime on the spooldir
 allow $1_crontab_t cron_spool_t:dir setattr;

--Boundary-00=_Be3wCJNkPXMChje--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
