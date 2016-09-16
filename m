Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GD8p1n022898
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 09:08:54 -0400
Received: by mail-wm0-f45.google.com with SMTP id k186so40693059wmd.0
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 06:08:53 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Cc: Janis Danisevskis <jdanis@android.com>
Subject: [PATCH] Change semantic of -r in sefcontext_compile
Date: Fri, 16 Sep 2016 14:08:48 +0100
Message-Id: <1474031328-29743-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch reestablishes the default behavior of sefcontext_compile
to include precompiled regular expressions in the output. If linked
against PCRE2 the flag "-r" now causes the precompiled regular
expressions to be omitted from the output.
---
 libselinux/utils/sefcontext_compile.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 770ec4c..c1284d5 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -263,12 +263,10 @@ static void usage(const char *progname)
 	    "         will be fc_file with the .bin suffix appended.\n\t"
 	    "-p       Optional binary policy file that will be used to\n\t"
 	    "         validate contexts defined in the fc_file.\n\t"
-	    "-r       Include precompiled regular expressions in the output.\n\t"
+	    "-r       Omit precompiled regular expressions in the output.\n\t"
 	    "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
 	    "         not portable across architectures. When linked against\n\t"
 	    "         PCRE this flag is ignored)\n\t"
-	    "         Omit precompiled regular expressions (only meaningful\n\t"
-	    "         when using PCRE2 regular expression back-end).\n\t"
 	    "fc_file  The text based file contexts file to be processed.\n",
 	    progname);
 		exit(EXIT_FAILURE);
@@ -278,7 +276,7 @@ int main(int argc, char *argv[])
 {
 	const char *path = NULL;
 	const char *out_file = NULL;
-	int do_write_precompregex = 0;
+	int do_write_precompregex = 1;
 	char stack_path[PATH_MAX + 1];
 	char *tmp = NULL;
 	int fd, rc, opt;
@@ -299,7 +297,7 @@ int main(int argc, char *argv[])
 			policy_file = optarg;
 			break;
 		case 'r':
-			do_write_precompregex = 1;
+			do_write_precompregex = 0;
 			break;
 		default:
 			usage(argv[0]);
-- 
2.8.0.rc3.226.g39d4020
