Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8J5HlNs014754
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 01:17:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8J5Dud6024925
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 05:13:58 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CD7D261B01
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 15:13:53 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22174-01 for <selinux@tycho.nsa.gov>;
	Mon, 19 Sep 2005 15:13:53 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 340DD61B00
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 15:13:53 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 2FEB838
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 15:13:52 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: policy patches
Date: Mon, 19 Sep 2005 15:13:46 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PkkLDMfn28pqH//"
Message-Id: <200509191513.51923.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_PkkLDMfn28pqH//
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

app.diff changes the application_domain() macro to work on the targeted 
policy.  This is needed for running the Postfix "postmap" program on the 
targeted policy among other things.

games.diff adds correct labelling for FreeCiv on Red Hat, adds an ifdef to 
reduce redundant rules, and removes an unnecessary lib64 reference.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_PkkLDMfn28pqH//
Content-Type: text/x-diff;
  charset="us-ascii";
  name="app.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="app.diff"

--- macros/global_macros.te.orig	2005-09-19 14:24:32.000000000 +1000
+++ macros/global_macros.te	2005-09-19 14:25:03.000000000 +1000
@@ -518,6 +518,9 @@
 type $1_t, domain, privlog $2;
 type $1_exec_t, file_type, sysadmfile, exec_type;
 role sysadm_r types $1_t;
+ifdef(`targeted_policy', `
+role system_r types $1_t;
+')
 domain_auto_trans(sysadm_t, $1_exec_t, $1_t)
 uses_shlib($1_t)
 ')

--Boundary-00=_PkkLDMfn28pqH//
Content-Type: text/x-diff;
  charset="us-ascii";
  name="games.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="games.diff"

--- file_contexts/program/games.fc.orig	2005-09-17 01:59:39.000000000 +1000
+++ file_contexts/program/games.fc	2005-09-19 15:04:30.000000000 +1000
@@ -1,8 +1,10 @@
 #  games
-/usr/lib(64)?/games/.* 	--	system_u:object_r:games_exec_t:s0
-/var/games(/.*)?		system_u:object_r:games_data_t:s0
-/usr/games/.*		--	system_u:object_r:games_exec_t:s0
+/usr/lib/games/.* 	--	system_u:object_r:games_exec_t:s0
 /var/lib/games(/.*)? 		system_u:object_r:games_data_t:s0
+ifdef(`distro_debian', `
+/usr/games/.*		--	system_u:object_r:games_exec_t:s0
+/var/games(/.*)?		system_u:object_r:games_data_t:s0
+', `
 /usr/bin/micq		--	system_u:object_r:games_exec_t:s0
 /usr/bin/blackjack	--	system_u:object_r:games_exec_t:s0
 /usr/bin/gataxx		--	system_u:object_r:games_exec_t:s0
@@ -53,4 +55,6 @@
 /usr/bin/lskat		--	system_u:object_r:games_exec_t:s0
 /usr/bin/lskatproc	--	system_u:object_r:games_exec_t:s0
 /usr/bin/Maelstrom	--	system_u:object_r:games_exec_t:s0
-
+/usr/bin/civclient.*	--	system_u:object_r:games_exec_t:s0
+/usr/bin/civserver.*	--	system_u:object_r:games_exec_t:s0
+')dnl end non-Debian section

--Boundary-00=_PkkLDMfn28pqH//--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
