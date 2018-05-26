Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIiQ64004301
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:44:26 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 995E15606A2
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:51 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:12 +0200
Message-Id: <20180526184213.4896-7-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 6/7] checkpolicy: destroy the class datum if it
 fails to initialize
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

require_class() allocate memory for its variable "class_datum_t *datum"
and calls symtab_init(&datum->permissions, PERM_SYMTAB_SIZE). If this
second call fails, datum is not freed.

Fix this memory leak.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/module_compiler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 155702f2731b..ada7cb2ae9c7 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -802,6 +802,7 @@ int require_class(int pass)
 	if ((datum = calloc(1, sizeof(*datum))) == NULL ||
 	    symtab_init(&datum->permissions, PERM_SYMTAB_SIZE)) {
 		yyerror("Out of memory!");
+		class_datum_destroy(datum);
 		return -1;
 	}
 	ret =
-- 
2.17.0
