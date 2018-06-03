Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w53GQPEe020850
 for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2018 12:26:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC09.oob.disa.mil (Postfix) with SMTP id 40zNjs36Bhz2NhLb
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:26:25 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC09.oob.disa.mil (Postfix) with ESMTP id 40zNjr3ydcz2NhLJ
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A71D256470D
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 18:26:23 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Jun 2018 18:25:41 +0200
Message-Id: <20180603162541.28136-4-nicolas.iooss@m4x.org>
In-Reply-To: <20180603162541.28136-1-nicolas.iooss@m4x.org>
References: <20180603162541.28136-1-nicolas.iooss@m4x.org>
Subject: [PATCH 4/4] policycoreutils/hll/pp: remove unused variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

pp's main() never set outfd to anything else than -1 so there is no
point in closing it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/hll/pp/pp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index b97a9b34816a..98969eb2f5f3 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -73,7 +73,6 @@ int main(int argc, char **argv)
 	const char *ofile = NULL;
 	FILE *in = NULL;
 	FILE *out = NULL;
-	int outfd = -1;
 
 	// ignore sigpipe so we can check the return code of write, and potentially
 	// return a more helpful error message
@@ -159,12 +158,6 @@ exit:
 	if (out != NULL) {
 		fclose(out);
 	}
-	if (outfd != -1) {
-		close(outfd);
-		if (rc != 0) {
-			unlink(argv[2]);
-		}
-	}
 	sepol_module_package_free(mod_pkg);
 
 	return rc;
-- 
2.17.1
