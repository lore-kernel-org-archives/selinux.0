Subject: [PATCH] selinux: inherit /proc/self/attr/keycreate across fork
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: sds@tycho.nsa.gov, James Morris <jmorris@namei.org>, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 21 Jun 2006 17:20:13 -0400
Message-Id: <1150924813.3432.14.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This resubmission includes a more detailed explanation that
I hope is suitable for upstream inclusion.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

This patch updates SELinux to cause the keycreate process attribute held in
/proc/self/attr/keycreate to be inherited across a fork and reset upon execve.
This is consistent with the handling of the other process attributes provided
by SELinux and also makes it simpler to adapt logon programs to properly
handle the keycreate attribute.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 security/selinux/hooks.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc6-mm2.dh.keycreate.paris/security/selinux/hooks.c	2006-06-21 16:19:10.000000000 -0400
+++ linux-2.6.17-rc6-mm2.dh.keycreate.paris.inherit/security/selinux/hooks.c	2006-06-21 16:26:03.000000000 -0400
@@ -1532,8 +1532,9 @@ static int selinux_bprm_set_security(str
 	/* Default to the current task SID. */
 	bsec->sid = tsec->sid;
 
-	/* Reset create and sockcreate SID on execve. */
+	/* Reset fs, key, and sock SIDs on execve. */
 	tsec->create_sid = 0;
+	tsec->keycreate_sid = 0;
 	tsec->sockcreate_sid = 0;
 
 	if (tsec->exec_sid) {
@@ -2586,9 +2587,10 @@ static int selinux_task_alloc_security(s
 	tsec2->osid = tsec1->osid;
 	tsec2->sid = tsec1->sid;
 
-	/* Retain the exec, create, and sock SIDs across fork */
+	/* Retain the exec, fs, key, and sock SIDs across fork */
 	tsec2->exec_sid = tsec1->exec_sid;
 	tsec2->create_sid = tsec1->create_sid;
+	tsec2->keycreate_sid = tsec1->keycreate_sid;
 	tsec2->sockcreate_sid = tsec1->sockcreate_sid;
 
 	/* Retain ptracer SID across fork, if any.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
