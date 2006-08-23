Subject: [patch] libselinux:  do not set compat_net upon policy load
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:13:09 -0400
Message-Id: <1156360389.8506.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Revert the change to automatically set /selinux/compat_net at policy
load time based on the policy, as this prevents compat_net from being
effectively used with refpolicy-based policies that include the packet
class definition.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 src/load_policy.c |   46 +++++++++++++++-------------------------------
 1 files changed, 15 insertions(+), 31 deletions(-)

Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.17
diff -u -p -r1.17 load_policy.c
--- libselinux/src/load_policy.c	29 Jun 2006 18:21:04 -0000	1.17
+++ libselinux/src/load_policy.c	23 Aug 2006 18:48:46 -0000
@@ -49,7 +49,7 @@ int selinux_mkload_policy(int preservebo
 	struct stat sb;
 	size_t size;
 	void *map, *data;
-	int fd, rc = -1, *values, len, i, prot, compat_net;
+	int fd, rc = -1, *values, len, i, prot;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
 
@@ -79,23 +79,20 @@ int selinux_mkload_policy(int preservebo
 	if (map == MAP_FAILED)
 		goto close;
 
-	if (sepol_policy_file_create(&pf))
-		goto unmap;
-	if (sepol_policydb_create(&policydb)) {
-		sepol_policy_file_free(pf);
-		goto unmap;
-	}
-	sepol_policy_file_set_mem(pf, data, size);
-	if (sepol_policydb_read(policydb, pf)) {
-		sepol_policy_file_free(pf);
-		sepol_policydb_free(policydb);
-		goto unmap;
-	}
-
-	compat_net = sepol_policydb_compat_net(policydb);
-
 	if (vers > kernvers) {
 		/* Need to downgrade to kernel-supported version. */
+		if (sepol_policy_file_create(&pf))
+			goto unmap;
+		if (sepol_policydb_create(&policydb)) {
+			sepol_policy_file_free(pf);
+			goto unmap;
+		}
+		sepol_policy_file_set_mem(pf, data, size);
+		if (sepol_policydb_read(policydb, pf)) {
+			sepol_policy_file_free(pf);
+			sepol_policydb_free(policydb);
+			goto unmap;
+		}
 		if (sepol_policydb_set_vers(policydb, kernvers) ||
 		    sepol_policydb_to_image(NULL, policydb, &data, &size)) {
 			/* Downgrade failed, keep searching. */
@@ -106,11 +103,10 @@ int selinux_mkload_policy(int preservebo
 			vers--;
 			goto search;
 		}
+		sepol_policy_file_free(pf);
+		sepol_policydb_free(policydb);
 	}
 
-	sepol_policy_file_free(pf);
-	sepol_policydb_free(policydb);
-
 	if (load_setlocaldefs) {
 		void *olddata = data;
 		size_t oldsize = size;
@@ -150,18 +146,6 @@ int selinux_mkload_policy(int preservebo
 
 	rc = security_load_policy(data, size);
 
-	if (!rc && selinux_mnt) {
-		int fd2;
-		char buf[2];
-		snprintf(path, sizeof path, "%s/compat_net", selinux_mnt);
-		fd2 = open(path, O_RDWR);
-		if (fd2 < 0)
-			goto unmap;
-		buf[0] = compat_net ? '1' : '0';
-		buf[1] = '\0';
-		(void)write(fd2, buf, 2);
-		close(fd2);
-	}
       unmap:
 	if (data != map)
 		free(data);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
