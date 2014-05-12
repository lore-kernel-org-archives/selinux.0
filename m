From: Dan Walsh <dwalsh@redhat.com>
To: SELinux@tycho.nsa.gov
Subject: [PATCH 4/4] seunshare: Try to use setcurrent before setexec
Date: Mon, 12 May 2014 13:19:21 -0400
Message-Id: <1399915161-31072-4-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1399915161-31072-1-git-send-email-dwalsh@redhat.com>
References: <1399915161-31072-1-git-send-email-dwalsh@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Andy Lutomirski <luto@amacapital.net>

If seunshare uses PR_SET_NO_NEW_PRIVS, which certain versions of
libcap-ng set, setexeccon will cause execve to fail.  This also
makes setting selinux context the very last action taken by
seunshare prior to exec, as it may otherwise cause things to fail.

Note that this won't work without adjusting the system policy to
allow this use of setcurrent.  This rule appears to work:

    allow unconfined_t sandbox_t:process dyntransition;

although a better rule would probably relax the unconfined_t
restriction.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 policycoreutils/sandbox/seunshare.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index a221920..c92e394 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -826,17 +826,25 @@ int main(int argc, char **argv) {
 			goto childerr;
 		}
 
-		/* selinux context */
-		if (execcon && setexeccon(execcon) != 0) {
-			fprintf(stderr, _("Could not set exec context to %s. %s\n"), execcon, strerror(errno));
-			goto childerr;
-		}
-
 		if (chdir(pwd->pw_dir)) {
 			perror(_("Failed to change dir to homedir"));
 			goto childerr;
 		}
 		setsid();
+
+		/* selinux context */
+		if (execcon) {
+			/* try dyntransition, since no_new_privs can interfere
+			 * with setexeccon */
+			if (setcon(execcon) != 0) {
+				/* failed; fall back to setexeccon */
+				if (setexeccon(execcon) != 0) {
+					fprintf(stderr, _("Could not set exec context to %s. %s\n"), execcon, strerror(errno));
+					goto childerr;
+				}
+			}
+		}
+
 		execv(argv[optind], argv + optind);
 		fprintf(stderr, _("Failed to execute command %s: %s\n"), argv[optind], strerror(errno));
 childerr:
-- 
1.9.0
