Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9CMggwQ008899
	for <selinux@tycho.nsa.gov>; Fri, 12 Oct 2007 18:42:42 -0400
Message-ID: <470FF79D.7000003@tycho.nsa.gov>
Date: Fri, 12 Oct 2007 18:39:25 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [PATCH] refpolicy: gdm file context
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like gdm has moved to /usr/sbin, at least on my rawhide box.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 xserver.fc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Index: policy/modules/services/xserver.fc
===================================================================
--- policy/modules/services/xserver.fc	(revision 2451)
+++ policy/modules/services/xserver.fc	(working copy)
@@ -63,7 +63,7 @@
 #
 
 /usr/(s)?bin/gdm-binary	--	gen_context(system_u:object_r:xdm_exec_t,s0)
-/usr/bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
+/usr/(s)?bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
 /usr/bin/gpe-dm		--	gen_context(system_u:object_r:xdm_exec_t,s0)
 /usr/bin/iceauth		--	gen_context(system_u:object_r:iceauth_exec_t,s0)
 /usr/bin/Xair		--	gen_context(system_u:object_r:xserver_exec_t,s0)

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
