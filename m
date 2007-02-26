Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJiYRQ018705
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:44:34 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QJjtW2027211
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:45:55 GMT
Message-ID: <45E338DD.5010302@redhat.com>
Date: Mon, 26 Feb 2007 14:45:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Additional Games file context
Content-Type: multipart/mixed;
 boundary="------------040103000209010102020900"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040103000209010102020900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040103000209010102020900
Content-Type: text/plain;
 name="nsaserefpolicy_policy_modules_apps_games.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_apps_games.fc"

--- nsaserefpolicy/policy/modules/apps/games.fc	2006-11-16 17:15:07.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/apps/games.fc	2007-02-26 11:04:22.000000000 -0500
@@ -2,6 +2,10 @@
 # /usr
 #
 /usr/lib/games(/.*)? 		gen_context(system_u:object_r:games_exec_t,s0)
+/usr/games/vulturesclaw/vulturesclaw -- gen_context(system_u:object_r:games_exec_t,s0)
+/usr/games/powermanga -- gen_context(system_u:object_r:games_exec_t,s0)
+/usr/games/nethack-3.4.3/nethack --      gen_context(system_u:object_r:games_exec_t,s0)
+
 
 #
 # /var

--------------040103000209010102020900--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
