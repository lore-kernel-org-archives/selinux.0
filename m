Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w53GSQix021029
 for <selinux@tycho.nsa.gov>; Sun, 3 Jun 2018 12:28:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 40zNm82MMvz3GD9w
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:28:24 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 40zNm80WqXz3GD9p
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D2B3D56470D
 for <selinux@tycho.nsa.gov>; Sun,  3 Jun 2018 18:26:22 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Jun 2018 18:25:40 +0200
Message-Id: <20180603162541.28136-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180603162541.28136-1-nicolas.iooss@m4x.org>
References: <20180603162541.28136-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/4] policycoreutils/secon: free scon_trans before returning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

disp_con() leaks scon_trans if it returns early.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/secon/secon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 6078139422ab..477057a6896b 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -646,6 +646,7 @@ static void disp_con(security_context_t scon_raw)
 			disp__con_val("clearance", NULL, &color);
 		if (opts->disp_mlsr)
 			disp__con_val("mls-range", NULL, &color);
+		freecon(scon_trans);
 		return;
 	}
 
-- 
2.17.1
