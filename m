From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, richard_c_haines@btinternet.com, jason@perfinion.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: selinux_restorecon: fix realpath logic
Date: Wed,  5 Oct 2016 10:52:41 -0400
Message-Id: <1475679161-24493-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The realpath logic in selinux_restorecon() was taken from the
Android libselinux fork.  However, bionic dirname() and basename()
do not modify their argument and therefore are safe to call on a
const string.  POSIX dirname() and basename() can modify their argument.
There is a GNU basename() that does not modify its argument, but not
for dirname().
For portability, create copies of the original pathname for each call
and keep them around until finished using the result.

Fixes "restorecon -r goes up the tree?" bug reported by Jason Zaman.

Reported-by: Jason Zaman <jason@perfinion.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/selinux_restorecon.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 0945138..a3f7d83 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -797,25 +797,38 @@ int selinux_restorecon(const char *pathname_orig,
 	 * realpath of containing dir, then appending last component name.
 	 */
 	if (flags.userealpath) {
-		pathbname = basename((char *)pathname_orig);
+		char *basename_cpy = strdup(pathname_orig);
+		if (!basename_cpy)
+			return -1;
+		pathbname = basename(basename_cpy);
 		if (!strcmp(pathbname, "/") || !strcmp(pathbname, ".") ||
 					    !strcmp(pathbname, "..")) {
 			pathname = realpath(pathname_orig, NULL);
-			if (!pathname)
+			if (!pathname) {
+				free(basename_cpy);
 				goto realpatherr;
+			}
 		} else {
-			pathdname = dirname((char *)pathname_orig);
+			char *dirname_cpy = strdup(pathname_orig);
+			pathdname = dirname(dirname_cpy);
 			pathdnamer = realpath(pathdname, NULL);
-			if (!pathdnamer)
+			if (!pathdnamer) {
+				free(basename_cpy);
+				free(dirname_cpy);
 				goto realpatherr;
+			}
 			if (!strcmp(pathdnamer, "/"))
 				error = asprintf(&pathname, "/%s", pathbname);
 			else
 				error = asprintf(&pathname, "%s/%s",
 						    pathdnamer, pathbname);
-			if (error < 0)
+			free(dirname_cpy);
+			if (error < 0) {
+				free(basename_cpy);
 				goto oom;
+			}
 		}
+		free(basename_cpy);
 	} else {
 		pathname = strdup(pathname_orig);
 		if (!pathname)
-- 
2.7.4
