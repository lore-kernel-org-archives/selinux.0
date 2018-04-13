Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3DL2Vxf008162
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 17:02:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 40N9Fw2np9z14wTY
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 21:02:28 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 40N9Fw29qvz14wTV
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6DBBD564946
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 23:01:15 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Fri, 13 Apr 2018 22:34:24 +0200
Message-Id: <20180413203424.20542-5-nicolas.iooss@m4x.org>
In-Reply-To: <20180413203424.20542-1-nicolas.iooss@m4x.org>
References: <20180413203424.20542-1-nicolas.iooss@m4x.org>
Subject: [PATCH 5/5] libselinux: remove unused variable usercon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In getconlist.c, main() does not use usercon. Remove this variable.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/getconlist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index abfe2c742bfb..5ac0ca85075c 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -19,7 +19,7 @@ static __attribute__ ((__noreturn__)) void usage(const char *name, const char *d
 
 int main(int argc, char **argv)
 {
-	char **list, *usercon = NULL, *cur_context = NULL;
+	char **list, *cur_context = NULL;
 	char *user = NULL, *level = NULL;
 	int ret, i, opt;
 
@@ -69,7 +69,6 @@ int main(int argc, char **argv)
 		freeconary(list);
 	}
 
-	free(usercon);
 	free(level);
 
 	return 0;
-- 
2.17.0
