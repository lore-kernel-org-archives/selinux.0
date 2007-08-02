Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JwT8p021344
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:58:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JwSOD028687
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:58:28 GMT
Date: Thu, 2 Aug 2007 15:58:25 -0400
Message-Id: <200708021958.l72JwPPn029497@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: apps_games changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Path changes for game

--- nsaserefpolicy/policy/modules/apps/games.fc	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/apps/games.fc	2007-08-02 11:02:02.000000000 -0400
@@ -1,22 +1,16 @@
 #
 # /usr
 #
-/usr/games/powermanga	--	gen_context(system_u:object_r:games_exec_t,s0)
-/usr/games/nethack-3.4.3/nethack -- gen_context(system_u:object_r:games_exec_t,s0)
-/usr/games/vulturesclaw/vulturesclaw -- gen_context(system_u:object_r:games_exec_t,s0)
-/usr/games/vultureseye/vultureseye -- gen_context(system_u:object_r:games_exec_t,s0)
-
 /usr/lib/games(/.*)? 		gen_context(system_u:object_r:games_exec_t,s0)
+/usr/games/.*		--	gen_context(system_u:object_r:games_exec_t,s0)
 
 #
 # /var
 #
 /var/lib/games(/.*)? 		gen_context(system_u:object_r:games_data_t,s0)
-
-ifdef(`distro_debian', `
-/usr/games/.*		--	gen_context(system_u:object_r:games_exec_t,s0)
 /var/games(/.*)?		gen_context(system_u:object_r:games_data_t,s0)
-', `
+
+ifdef(`distro_debian', `', `
 /usr/bin/micq		--	gen_context(system_u:object_r:games_exec_t,s0)
 /usr/bin/blackjack	--	gen_context(system_u:object_r:games_exec_t,s0)
 /usr/bin/gataxx		--	gen_context(system_u:object_r:games_exec_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
