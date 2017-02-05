Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwipE005432
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:45 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5403B564780
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:40 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/8] policycoreutils/hll/pp: fix -Wwrite-strings warnings
Date: Sun,  5 Feb 2017 16:58:16 +0100
Message-Id: <20170205155820.29157-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In main(), variable ifile can be made const char*. While at it, make
ofile const char* too.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/hll/pp/pp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 7f9afb01dc23..e4fa4c4b467c 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -69,8 +69,8 @@ int main(int argc, char **argv)
 		{ NULL, 0, NULL, 0 }
 	};
 	struct sepol_module_package *mod_pkg = NULL;
-	char *ifile = NULL;
-	char *ofile = NULL;
+	const char *ifile = NULL;
+	const char *ofile = NULL;
 	FILE *in = NULL;
 	FILE *out = NULL;
 	int outfd = -1;
-- 
2.11.0
