Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BLkUKk001912
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 17:46:31 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id ED4105647D8
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:46:29 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/6] libselinux: getsebool: always free names
Date: Tue, 11 Apr 2017 23:46:01 +0200
Message-Id: <20170411214603.28040-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170411214603.28040-1-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When getsebool's main() fails to allocate memory for the boolean names,
it returns without freeing variables first, even though other errors do
this (with label "out").

This silences a warning reported by clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/getsebool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libselinux/utils/getsebool.c b/libselinux/utils/getsebool.c
index 3c6eba55b7a8..369945363535 100644
--- a/libselinux/utils/getsebool.c
+++ b/libselinux/utils/getsebool.c
@@ -15,7 +15,7 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 int main(int argc, char **argv)
 {
 	int i, get_all = 0, rc = 0, active, pending, len = 0, opt;
-	char **names;
+	char **names = NULL;
 
 	while ((opt = getopt(argc, argv, "a")) > 0) {
 		switch (opt) {
@@ -55,7 +55,7 @@ int main(int argc, char **argv)
 		if (argc < 2)
 			usage(argv[0]);
 		len = argc - 1;
-		names = malloc(sizeof(char *) * len);
+		names = calloc(len, sizeof(char *));
 		if (!names) {
 			fprintf(stderr, "%s:  out of memory\n", argv[0]);
 			return 2;
@@ -65,7 +65,8 @@ int main(int argc, char **argv)
 			if (!names[i]) {
 				fprintf(stderr, "%s:  out of memory\n",
 					argv[0]);
-				return 2;
+				rc = 2;
+				goto out;
 			}
 		}
 	}
-- 
2.12.0
