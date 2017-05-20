Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4KACAcp029614
 for <selinux@tycho.nsa.gov>; Sat, 20 May 2017 06:12:11 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3AB61561352
 for <selinux@tycho.nsa.gov>; Sat, 20 May 2017 12:12:09 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsepol: use the number of elements in calloc first
 argument
Date: Sat, 20 May 2017 12:11:41 +0200
Message-Id: <20170520101141.6207-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170520101141.6207-1-nicolas.iooss@m4x.org>
References: <20170520101141.6207-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When allocating an array with calloc(), the first argument usually is
the number of items and the second one the size of an item. Doing so
silences a warning reported by clang's static analyzer:

    kernel_to_cil.c:2050:14: warning: Call to 'calloc' has an allocation
    size of 0 bytes.
            cond_data = calloc(sizeof(struct cond_data), num);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/kernel_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 3a1c0be76f45..498e2947f6cb 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -2043,7 +2043,7 @@ static int write_cond_nodes_to_cil(FILE *out, struct policydb *pdb)
 		num++;
 	}
 
-	cond_data = calloc(sizeof(struct cond_data), num);
+	cond_data = calloc(num, sizeof(struct cond_data));
 	if (!cond_data) {
 		rc = -1;
 		goto exit;
-- 
2.12.2
