From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] selinux-testsuite: fix nnp test for RHEL7
Date: Thu, 16 Feb 2017 13:50:05 -0500
Message-Id: <1487271005-3728-3-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1487271005-3728-1-git-send-email-sds@tycho.nsa.gov>
References: <1487271005-3728-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

RHEL7.3 backported the support for bounded transitions under
NO_NEW_PRIVS.  Since the kernel version comparison is against
the upstream kernel version that first included this support,
the test was failing on RHEL7.  Adjust the logic so that we do
not treat it as an error if earlier kernels correctly return
success (i.e. they contain the back-ported patch).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/nnp/execnnp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
index 8421df4..d8f1986 100644
--- a/tests/nnp/execnnp.c
+++ b/tests/nnp/execnnp.c
@@ -48,9 +48,7 @@ int main(int argc, char **argv)
 
 	pid = wait(&status);
 	if (WIFEXITED(status)) {
-		if (nobounded) {
-			if (!WEXITSTATUS(status))
-				exit(-1);
+		if (WEXITSTATUS(status) && nobounded) {
 			printf("%s:  Kernels < v3.18 do not support bounded transitions under NNP.\n",
 			       argv[0]);
 			/* pass the test */
-- 
2.7.4
