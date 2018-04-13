Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3DL21r8008038
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 17:02:01 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0B4DC56494C
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 23:01:15 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Fri, 13 Apr 2018 22:34:23 +0200
Message-Id: <20180413203424.20542-4-nicolas.iooss@m4x.org>
In-Reply-To: <20180413203424.20542-1-nicolas.iooss@m4x.org>
References: <20180413203424.20542-1-nicolas.iooss@m4x.org>
Subject: [PATCH 4/5] libselinux: fix memory leak in getconlist
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In getconlist.c's main(), "level" is duplicated from an optional
argument without being ever freed. clang's static analyzer warns about
this memory leak.

Free the allocated memory properly in order to remove a warning reported
by clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/getconlist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index adec1781658b..abfe2c742bfb 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -40,6 +40,7 @@ int main(int argc, char **argv)
 	if (!is_selinux_enabled()) {
 		fprintf(stderr,
 			"getconlist may be used only on a SELinux kernel.\n");
+		free(level);
 		return 1;
 	}
 
@@ -49,6 +50,7 @@ int main(int argc, char **argv)
 	if (((argc - optind) < 2)) {
 		if (getcon(&cur_context) < 0) {
 			fprintf(stderr, "Couldn't get current context.\n");
+			free(level);
 			return 2;
 		}
 	} else
@@ -68,6 +70,7 @@ int main(int argc, char **argv)
 	}
 
 	free(usercon);
+	free(level);
 
 	return 0;
 }
-- 
2.17.0
