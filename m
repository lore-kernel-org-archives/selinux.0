Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QENCOf024768
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 10:23:12 -0400
Received: by mail-qk0-f175.google.com with SMTP id g67so104600259qkd.0
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 07:23:02 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov, jdanis@google.com
Cc: Janis Danisevskis <jdanis@android.com>
Subject: [PATCH 3/3] libselinux: sefcontext_compile invert semantics of "-r"
 flag
Date: Mon, 26 Sep 2016 15:22:36 +0100
Message-Id: <1474899756-93610-3-git-send-email-jdanis@android.com>
In-Reply-To: <1474899756-93610-1-git-send-email-jdanis@android.com>
References: <1474899756-93610-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The "-r" flag of sefcontext_compile now causes it to omit the
precompiled regular expressions from the output.

Signed-off-by: Janis Danisevskis <jdanis@android.com>
---
 libselinux/utils/sefcontext_compile.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 8c48d32..b2746c7 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -276,10 +276,12 @@ static void usage(const char *progname)
 	    "         will be fc_file with the .bin suffix appended.\n\t"
 	    "-p       Optional binary policy file that will be used to\n\t"
 	    "         validate contexts defined in the fc_file.\n\t"
-	    "-r       Include precompiled regular expressions in the output.\n\t"
+	    "-r       Omit precompiled regular expressions from the output.\n\t"
 	    "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
-	    "         not portable across architectures. When linked against\n\t"
-	    "         PCRE this flag is ignored)\n\t"
+	    "         not portable across architectures. Use this flag\n\t"
+	    "         if you know that you build for an incompatible\n\t"
+	    "         architecture to save space. When linked against\n\t"
+	    "         PCRE1 this flag is ignored.)\n\t"
 	    "-i       Print regular expression info end exit. That is, back\n\t"
 	    "         end version and architecture identifier.\n\t"
 	    "         Arch identifier format (PCRE2):\n\t"
@@ -294,7 +296,7 @@ int main(int argc, char *argv[])
 {
 	const char *path = NULL;
 	const char *out_file = NULL;
-	int do_write_precompregex = 0;
+	int do_write_precompregex = 1;
 	char stack_path[PATH_MAX + 1];
 	char *tmp = NULL;
 	int fd, rc, opt;
@@ -315,7 +317,7 @@ int main(int argc, char *argv[])
 			policy_file = optarg;
 			break;
 		case 'r':
-			do_write_precompregex = 1;
+			do_write_precompregex = 0;
 			break;
 		case 'i':
 			printf("%s (%s)\n", regex_version(),
-- 
2.8.0.rc3.226.g39d4020
