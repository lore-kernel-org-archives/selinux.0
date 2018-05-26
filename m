Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIhiaL004239
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:43:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 40tX7Z3TJ5z1pJ8x
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:22 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 40tX7Y5BKSz1pJ8t
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 592CF56069F
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:50 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:10 +0200
Message-Id: <20180526184213.4896-5-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 4/7] libsepol: do not call malloc with 0 byte
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang's static analyzer reports that ebitmap_to_names() can call
malloc(0) when the bitmap is empty. If malloc() returns NULL, this
triggers a misleading "Out of memory" error.

Work around this by treating empty bitmaps as appropriate.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 310cf1a7b1c1..56887366707a 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1009,6 +1009,12 @@ static int ebitmap_to_names(struct ebitmap *map, char **vals_to_names, char ***n
 		}
 	}
 
+	if (!num) {
+		*names = NULL;
+		*num_names = 0;
+		goto exit;
+	}
+
 	name_arr = malloc(sizeof(*name_arr) * num);
 	if (name_arr == NULL) {
 		log_err("Out of memory");
-- 
2.17.0
