Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SASj7e030021
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 06:28:45 -0400
Received: by mail-wm0-f52.google.com with SMTP id b130so63288340wmc.0
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 03:28:44 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov, jdanis@google.com
Cc: Janis Danisevskis <jdanis@android.com>
Subject: [PATCH 2/3] libselinux: sefcontext_compile: Add "-i" flag
Date: Wed, 28 Sep 2016 11:28:31 +0100
Message-Id: <1475058512-76102-2-git-send-email-jdanis@android.com>
In-Reply-To: <1475058512-76102-1-git-send-email-jdanis@android.com>
References: <1475058512-76102-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Adds the "-i" flag, which prints the version and
architecture identifier of the regular expression back end.

Signed-off-by: Janis Danisevskis <jdanis@android.com>
---
 libselinux/utils/sefcontext_compile.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index d91db9a..8c48d32 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -280,6 +280,11 @@ static void usage(const char *progname)
 	    "         (PCRE2 only. Compiled PCRE2 regular expressions are\n\t"
 	    "         not portable across architectures. When linked against\n\t"
 	    "         PCRE this flag is ignored)\n\t"
+	    "-i       Print regular expression info end exit. That is, back\n\t"
+	    "         end version and architecture identifier.\n\t"
+	    "         Arch identifier format (PCRE2):\n\t"
+	    "         <pointer width>-<size type width>-<endianness>, e.g.,\n\t"
+	    "         \"8-8-el\" for x86_64.\n\t"
 	    "fc_file  The text based file contexts file to be processed.\n",
 	    progname);
 		exit(EXIT_FAILURE);
@@ -301,7 +306,7 @@ int main(int argc, char *argv[])
 	if (argc < 2)
 		usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "o:p:r")) > 0) {
+	while ((opt = getopt(argc, argv, "io:p:r")) > 0) {
 		switch (opt) {
 		case 'o':
 			out_file = optarg;
@@ -312,6 +317,10 @@ int main(int argc, char *argv[])
 		case 'r':
 			do_write_precompregex = 1;
 			break;
+		case 'i':
+			printf("%s (%s)\n", regex_version(),
+					regex_arch_string());
+			return 0;
 		default:
 			usage(argv[0]);
 		}
-- 
2.8.0.rc3.226.g39d4020
