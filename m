Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwipI005432
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:46 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 90064564780
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:39 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/8] policycoreutils/semodule: hide -Wwrite-strings warnings
Date: Sun,  5 Feb 2017 16:58:15 +0100
Message-Id: <20170205155820.29157-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building with "clang -Wwrite-strings", the compiler complains about
initializing a char* array (variable genhomedirconargv) with literal
strings (which are in read-only memory).

However the programs needs to use a non-const char* array in order to
fake arguments of getopt_long() (called by parse_command_line()). Silent
the compiler warnings by introducing casts to char*.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/semodule/semodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ce048bc061b9..36686d0230a8 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -341,7 +341,7 @@ int main(int argc, char *argv[])
 	int i, commit = 0;
 	int result;
 	int status = EXIT_FAILURE;
-	char *genhomedirconargv[] = { "genhomedircon", "-B", "-n" };
+	char *genhomedirconargv[] = { (char *)"genhomedircon", (char *)"-B", (char *)"-n" };
 	create_signal_handlers();
 	if (strcmp(basename(argv[0]), "genhomedircon") == 0) {
 		argc = 3;
-- 
2.11.0
