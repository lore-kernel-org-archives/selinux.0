From: Dan Walsh <dwalsh@redhat.com>
To: SELinux@tycho.nsa.gov
Subject: [PATCH 2/4] Update XDG_RUNTIME_DIR directory
Date: Mon, 12 May 2014 13:19:19 -0400
Message-Id: <1399915161-31072-2-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1399915161-31072-1-git-send-email-dwalsh@redhat.com>
References: <1399915161-31072-1-git-send-email-dwalsh@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/sandbox/seunshare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index 97f3920..596a43e 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -964,6 +964,7 @@ int main(int argc, char **argv) {
 	if (child == 0) {
 		char *display = NULL;
 		char *LANG = NULL;
+		char *RUNTIME_DIR = NULL;
 		int rc = -1;
 		char *resolved_path = NULL;
 
@@ -1014,6 +1015,13 @@ int main(int argc, char **argv) {
 			}
 		}
 
+		if ((RUNTIME_DIR = getenv("XDG_RUNTIME_DIR")) != NULL) {
+			if ((RUNTIME_DIR = strdup(RUNTIME_DIR)) == NULL) {
+				perror(_("Out of memory"));
+				goto childerr;
+			}
+		}
+
 		if ((rc = clearenv()) != 0) {
 			perror(_("Failed to clear environment"));
 			goto childerr;
@@ -1022,6 +1030,8 @@ int main(int argc, char **argv) {
 			rc |= setenv("DISPLAY", display, 1);
 		if (LANG)
 			rc |= setenv("LANG", LANG, 1);
+		if (RUNTIME_DIR)
+			rc |= setenv("XDG_RUNTIME_DIR", RUNTIME_DIR, 1);
 		rc |= setenv("HOME", pwd->pw_dir, 1);
 		rc |= setenv("SHELL", pwd->pw_shell, 1);
 		rc |= setenv("USER", pwd->pw_name, 1);
@@ -1049,6 +1059,7 @@ childerr:
 		free(resolved_path);
 		free(display);
 		free(LANG);
+		free(RUNTIME_DIR);
 		exit(-1);
 	}
 
-- 
1.9.0
