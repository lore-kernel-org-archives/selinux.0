Subject: [patch] libselinux:  fix type mismatch in string_to_security_class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Content-Type: text/plain
Date: Mon, 23 Jul 2007 10:21:57 -0400
Message-Id: <1185200517.1998.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix type mismatch in string_to_security_class, produces seg fault on x86_64.
For https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249038

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 stringrep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: src/stringrep.c
===================================================================
--- src/stringrep.c	(revision 2496)
+++ src/stringrep.c	(working copy)
@@ -236,7 +236,7 @@
 
 	dentry = readdir(dir);
 	while (dentry != NULL) {
-		size_t value;
+		unsigned int value;
 		struct stat m;
 
 		snprintf(path, sizeof path, "%s/class/%s/perms/%s", selinux_mnt,s,dentry->d_name);
@@ -258,7 +258,7 @@
 		if (ret < 0)
 			goto err4;
 
-		if (sscanf(buf, "%u", (unsigned int *)&value) != 1)
+		if (sscanf(buf, "%u", &value) != 1)
 			goto err4;
 
 		node->perms[value-1] = strdup(dentry->d_name);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
