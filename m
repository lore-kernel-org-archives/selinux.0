Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1QDWMa8027306
 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2015 08:32:22 -0500
Message-ID: <54EF2047.2010002@tycho.nsa.gov>
Date: Thu, 26 Feb 2015 08:31:51 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Fwd: [PATCH] fgets function warnings fix
References: <CA+2y1146jZMaJUCwsoKJjZSNx3NUOe69CiNoDBnX+BdHdbZGdw@mail.gmail.com>
In-Reply-To: <CA+2y1146jZMaJUCwsoKJjZSNx3NUOe69CiNoDBnX+BdHdbZGdw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------020103010808030904060007"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------020103010808030904060007
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit




-------- Forwarded Message --------
Subject: 	[PATCH] fgets function warnings fix
Date: 	Thu, 26 Feb 2015 11:06:58 +0200
From: 	Emre Can Kucukoglu <eckucukoglu@gmail.com>
To: 	Stephen Smalley <sds@tycho.nsa.gov>



2015-02-25 20:25 GMT+02:00 Stephen Smalley <sds@tycho.nsa.gov
<mailto:sds@tycho.nsa.gov>>:

    On 02/25/2015 10:42 AM, Emre Can Kucukoglu wrote:
    > Hello,
    >
    > I want to use SELinux for my experimental vanilla kernel
    distribution in
    > Pandaboard ES. To achieve that I have configured my kernel for SELinux
    > support. Then, I have recently cloned selinux userspace repository to
    > cross-compile it for arm architecture. I use arm-linux-gnueabi
    toolchain
    > in Ubuntu 14.04 workstation.
    >
    > $ export ARCH=arm
    > $ export CROSS_COMPILE=arm-linux-gnueabi-
    >
    > As mentioned in readme instruction,
    >
    > $ make DESTDIR=~/obj install install-pywrap
    >
    > command is used, however due to -Werror flags in various Makefile's,
    > error is thrown:
    >
    > dispol.c: In function âmainâ:
    > dispol.c:452:8: error: ignoring return value of âfgetsâ,
    declared with
    > attribute warn_unused_result [-Werror=unused-result]
    >Â  Â  fgets(ans, sizeof(ans), stdin);
    >Â  Â  Â  Â  Â ^
    > dispol.c:479:9: error: ignoring return value of âfgetsâ,
    declared with
    > attribute warn_unused_result [-Werror=unused-result]
    >Â  Â  Â fgets(ans, sizeof(ans), stdin);
    >Â  Â  Â  Â  Â  ^
    > dispol.c:490:9: error: ignoring return value of âfgetsâ,
    declared with
    > attribute warn_unused_result [-Werror=unused-result]
    >Â  Â  Â fgets(ans, sizeof(ans), stdin);
    >Â  Â  Â  Â  Â  ^
    > dispol.c:517:9: error: ignoring return value of âfgetsâ,
    declared with
    > attribute warn_unused_result [-Werror=unused-result]
    >Â  Â  Â fgets(OutfileName, sizeof(OutfileName), stdin);
    >Â  Â  Â  Â  Â  ^
    > cc1: all warnings being treated as errors
    > make[2]: *** [dispol.o] Error 1
    >
    > I did this modification to get over this error which is caused by
    > -Werror flag:
    >
    > char *fgetsret; /* error is given, because return value is not
    captured */
    > fgetsret = fgets(...);
    > if (!fgetsret) { /* if fgetsret is not used, another error comes from
    > warning */
    > // some exit message
    > exit(1);
    > }
    >
    > Did I miss something about SELinux cross-compilation for an arm
    > architecture, since constantly I'm taking errors.

    Hmm...that's interesting.Â  Builds just fine on Fedora 20.Â  I do
    however
    get the same error building on Ubuntu 14.04 (which is not something we
    typically test on; most SELinux developers work on Fedora).

    Willing to accept patches to fix it, but it is merely a test/debugging
    program that you can even exclude from your build if you like.

checkpolicy/test/dismod.c and
checkpolicy/test/dispol.c both have same warnings.

Signed-off-by: Emre Can Kucukoglu <eckucukoglu@gmail.com
<mailto:eckucukoglu@gmail.com>>
---
Â checkpolicy/test/dismod.c | 20 +++++++++++++++++---
Â checkpolicy/test/dispol.c | 24 ++++++++++++++++++++----
Â 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index db9ae55..c55f726 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -755,7 +755,12 @@ static void link_module(policydb_t * base, FILE *
out_fp)
Â return;
Â }
Â printf("\nModule filename: ");
-fgets(module_name, sizeof(module_name), stdin);
+if (fgets(module_name, sizeof(module_name), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+exit(1);
+}
+
Â module_name[strlen(module_name) - 1] = '\0';/* remove LF */
Â if (module_name[0] == '\0') {
Â return;
@@ -884,7 +889,12 @@ int main(int argc, char **argv)
Â menu();
Â for (;;) {
Â printf("\nCommand (\'m\' for menu): Â ");
-fgets(ans, sizeof(ans), stdin);
+if (fgets(ans, sizeof(ans), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+continue;
+}
+
Â switch (ans[0]) {

Â case '1':
@@ -951,7 +961,11 @@ int main(int argc, char **argv)
Â case 'f':
Â printf
Â Â  Â ("\nFilename for output (<CR> for screen output): ");
-fgets(OutfileName, sizeof(OutfileName), stdin);
+if (fgets(OutfileName, sizeof(OutfileName), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+break;
+}
Â OutfileName[strlen(OutfileName) - 1] = '\0';/* fix_string (remove LF) */
Â if (strlen(OutfileName) == 0)
Â out_fp = stdout;
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 9d66358..0333bcc 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -449,7 +449,11 @@ int main(int argc, char **argv)
Â menu();
Â for (;;) {
Â printf("\nCommand (\'m\' for menu): Â ");
-fgets(ans, sizeof(ans), stdin);
+if (fgets(ans, sizeof(ans), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+continue;
+}
Â switch (ans[0]) {

Â case '1':
@@ -476,7 +480,11 @@ int main(int argc, char **argv)
Â break;
Â case '7':
Â printf("name? ");
-fgets(ans, sizeof(ans), stdin);
+if (fgets(ans, sizeof(ans), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+break;
+}
Â ans[strlen(ans) - 1] = 0;

Â name = malloc((strlen(ans) + 1) * sizeof(char));
@@ -487,7 +495,11 @@ int main(int argc, char **argv)
Â strcpy(name, ans);

Â printf("state? ");
-fgets(ans, sizeof(ans), stdin);
+if (fgets(ans, sizeof(ans), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+break;
+}
Â ans[strlen(ans) - 1] = 0;

Â if (atoi(ans))
@@ -514,7 +526,11 @@ int main(int argc, char **argv)
Â case 'f':
Â printf
Â Â  Â ("\nFilename for output (<CR> for screen output): ");
-fgets(OutfileName, sizeof(OutfileName), stdin);
+if (fgets(OutfileName, sizeof(OutfileName), stdin) == NULL) {
+fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+strerror(errno));
+break;
+}
Â OutfileName[strlen(OutfileName) - 1] = '\0';/* fix_string (remove LF) */
Â if (strlen(OutfileName) == 0)
Â out_fp = stdout;
--
1.9.1



-- 
Emre Can Kucukoglu



--------------020103010808030904060007
Content-Type: text/x-patch;
 name="fgets-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fgets-warnings.patch"

>From dc27dab37d82823095971789fef105eea77aa38a Mon Sep 17 00:00:00 2001
From: Emre Can Kucukoglu <eckucukoglu@gmail.com>
Date: Thu, 26 Feb 2015 10:22:48 +0200
Subject: [PATCH] fgets function warnings fix

---
 checkpolicy/test/dismod.c | 20 +++++++++++++++++---
 checkpolicy/test/dispol.c | 24 ++++++++++++++++++++----
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index db9ae55..c55f726 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -755,7 +755,12 @@ static void link_module(policydb_t * base, FILE * out_fp)
 		return;
 	}
 	printf("\nModule filename: ");
-	fgets(module_name, sizeof(module_name), stdin);
+	if (fgets(module_name, sizeof(module_name), stdin) == NULL) {
+		fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+				strerror(errno));
+		exit(1);
+	}
+
 	module_name[strlen(module_name) - 1] = '\0';	/* remove LF */
 	if (module_name[0] == '\0') {
 		return;
@@ -884,7 +889,12 @@ int main(int argc, char **argv)
 	menu();
 	for (;;) {
 		printf("\nCommand (\'m\' for menu):  ");
-		fgets(ans, sizeof(ans), stdin);
+		if (fgets(ans, sizeof(ans), stdin) == NULL) {
+			fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+					strerror(errno));
+			continue;
+		}
+
 		switch (ans[0]) {

 		case '1':
@@ -951,7 +961,11 @@ int main(int argc, char **argv)
 		case 'f':
 			printf
 			    ("\nFilename for output (<CR> for screen output): ");
-			fgets(OutfileName, sizeof(OutfileName), stdin);
+			if (fgets(OutfileName, sizeof(OutfileName), stdin) == NULL) {
+				fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+						strerror(errno));
+				break;
+			}
 			OutfileName[strlen(OutfileName) - 1] = '\0';	/* fix_string (remove LF) */
 			if (strlen(OutfileName) == 0)
 				out_fp = stdout;
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 9d66358..0333bcc 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -449,7 +449,11 @@ int main(int argc, char **argv)
 	menu();
 	for (;;) {
 		printf("\nCommand (\'m\' for menu):  ");
-		fgets(ans, sizeof(ans), stdin);
+		if (fgets(ans, sizeof(ans), stdin) == NULL) {
+			fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+					strerror(errno));
+			continue;
+		}
 		switch (ans[0]) {

 		case '1':
@@ -476,7 +480,11 @@ int main(int argc, char **argv)
 			break;
 		case '7':
 			printf("name? ");
-			fgets(ans, sizeof(ans), stdin);
+			if (fgets(ans, sizeof(ans), stdin) == NULL) {
+				fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+						strerror(errno));
+				break;
+			}
 			ans[strlen(ans) - 1] = 0;

 			name = malloc((strlen(ans) + 1) * sizeof(char));
@@ -487,7 +495,11 @@ int main(int argc, char **argv)
 			strcpy(name, ans);

 			printf("state? ");
-			fgets(ans, sizeof(ans), stdin);
+			if (fgets(ans, sizeof(ans), stdin) == NULL) {
+				fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+						strerror(errno));
+				break;
+			}
 			ans[strlen(ans) - 1] = 0;

 			if (atoi(ans))
@@ -514,7 +526,11 @@ int main(int argc, char **argv)
 		case 'f':
 			printf
 			    ("\nFilename for output (<CR> for screen output): ");
-			fgets(OutfileName, sizeof(OutfileName), stdin);
+			if (fgets(OutfileName, sizeof(OutfileName), stdin) == NULL) {
+				fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
+						strerror(errno));
+				break;
+			}
 			OutfileName[strlen(OutfileName) - 1] = '\0';	/* fix_string (remove LF) */
 			if (strlen(OutfileName) == 0)
 				out_fp = stdout;
--
1.9.1

--------------020103010808030904060007--
