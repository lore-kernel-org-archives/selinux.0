From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: fix audit2why error handling if SELinux is
 disabled.
Date: Fri, 13 Feb 2015 10:43:39 -0500
Message-Id: <1423842219-16327-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If SELinux is disabled, then selinux_current_policy_path() returns NULL.
At present, if you run audit2allow on a SELinux-disabled host without
the -p option, you get:
unable to open (null):  Bad address

We haven't seen this because most people running audit2allow are doing
it on SELinux-enabled hosts and using the host policy.  But for Android,
the build host OS often has SELinux disabled and we need to pass audit2allow
the path to the Android policy.  Handle this case and provide a hint to
the user.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/audit2why.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index c91b65e..12745b3 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -209,11 +209,19 @@ static int __policy_init(const char *init_path)
 			return 1;
 		}
 	} else {
-		fp = fopen(selinux_current_policy_path(), "r");
+		const char *curpolicy = selinux_current_policy_path();
+		if (!curpolicy) {
+			/* SELinux disabled, must use -p option. */
+			snprintf(errormsg, sizeof(errormsg),
+				 "You must specify the -p option with the path to the policy file.\n");
+			PyErr_SetString( PyExc_ValueError, errormsg);
+			return 1;
+		}
+		fp = fopen(curpolicy, "r");
 		if (!fp) {
 			snprintf(errormsg, sizeof(errormsg), 
 				 "unable to open %s:  %s\n",
-				 selinux_current_policy_path(),
+				 curpolicy,
 				 strerror(errno));
 			PyErr_SetString( PyExc_ValueError, errormsg);
 			return 1;
-- 
1.9.3
