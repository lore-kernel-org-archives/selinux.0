Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w53GRPH1020894
 for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2018 12:27:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40zNl01tZpz25sRt
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:27:24 +0000 (UTC)
Received: from UPBD19PA03.eemsg.mil (unknown [192.168.18.4])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40zNkz5ydJz25sS4
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F110C56470D
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 18:26:21 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Jun 2018 18:25:39 +0200
Message-Id: <20180603162541.28136-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180603162541.28136-1-nicolas.iooss@m4x.org>
References: <20180603162541.28136-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/4] policycoreutils/secon: fix typo in comment
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/secon/secon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index c29d9fb67fa5..6078139422ab 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -309,7 +309,7 @@ static void cmd_line(int argc, char *argv[])
 		}
 	}
 
-	if (!done) {		/* defualt, if nothing specified */
+	if (!done) {		/* default, if nothing specified */
 		opts->disp_user = TRUE;
 		opts->disp_role = TRUE;
 		opts->disp_type = TRUE;
-- 
2.17.1
