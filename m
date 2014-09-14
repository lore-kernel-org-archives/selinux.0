Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sG009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:12 -0400
Received: by mail-we0-f171.google.com with SMTP id p10so3067976wes.16
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:18 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.17
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:17 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 05/20] policycoreutils/semodule_package: fix debug build
Date: Sun, 14 Sep 2014 23:41:36 +0200
Message-Id: <1410730911-14512-6-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Building from the root directory with "make DEBUG=1" enables -Wshadow
option.  This makes the compilation fail with the following error:

  semodule_unpackage.c: In function 'usage':
  semodule_unpackage.c:17:25: error: declaration of 'progname' shadows a global declaration [-Werror=shadow]
   static void usage(char *progname)
                         ^
  semodule_unpackage.c:14:7: error: shadowed declaration is here [-Werror=shadow]
   char *progname = NULL;
         ^

Fix this error by no longer passing a global variable as a parameter to
usage function.
---
 policycoreutils/semodule_package/semodule_unpackage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semodule_package/semodule_unpackage.c b/policycoreutils/semodule_package/semodule_unpackage.c
index 0120ee433339..07893f146258 100644
--- a/policycoreutils/semodule_package/semodule_unpackage.c
+++ b/policycoreutils/semodule_package/semodule_unpackage.c
@@ -14,7 +14,7 @@
 char *progname = NULL;
 extern char *optarg;
 
-static void usage(char *progname)
+static void usage(void)
 {
 	printf("usage: %s ppfile modfile [fcfile]\n", progname);
 	exit(1);
@@ -49,7 +49,7 @@ int main(int argc, char **argv)
 	progname = argv[0];
 
 	if (argc < 3) {
-		usage(progname);
+		usage();
 		exit(1);
 	}
 
-- 
2.1.0
