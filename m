Subject: [patch] libselinux: don't warn about failed selinuxfs mount if
	selinux disabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>
Content-Type: text/plain
Date: Wed, 19 Mar 2008 09:12:20 -0400
Message-Id: <1205932340.6466.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do not warn about a failed mount of selinuxfs if selinux was disabled
in the kernel (either at compile-time or at boot via selinux=0).
Based on a diff in the Debian libselinux package, reformatted for coding style.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/load_policy.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2852)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -369,8 +369,11 @@
 			 * commandline enforcing setting.
 			 */
 			*enforce = 0;
+		} else {
+			/* Only emit this error if selinux was not disabled */
+			fprintf(stderr, "Mount failed for selinuxfs on %s:  %s\n", SELINUXMNT, strerror(errno));
 		}
-		fprintf(stderr, "Mount failed for selinuxfs on %s:  %s\n", SELINUXMNT, strerror(errno));
+                
 		goto noload;
 	}
 	set_selinuxmnt(SELINUXMNT);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
