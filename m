Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5DEF3ne027899
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 10:15:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB1A964D18
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 14:15:00 +0000 (UTC)
Subject: [PATCH] selinux: import NetLabel category bitmaps correctly
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 13 Jun 2016 10:14:59 -0400
Message-ID: <146582729948.14945.7155589043038782897.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The existing ebitmap_netlbl_import() code didn't correctly handle the
case where the ebitmap_node was not aligned/sized to a power of two,
this patch fixes this (on x86_64 ebitmap_node contains six bitmaps
making a range of 0..383).

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/ebitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 57644b1..894b6cd 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -165,7 +165,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 			e_iter = kzalloc(sizeof(*e_iter), GFP_ATOMIC);
 			if (e_iter == NULL)
 				goto netlbl_import_failure;
-			e_iter->startbit = offset & ~(EBITMAP_SIZE - 1);
+			e_iter->startbit = offset - (offset % EBITMAP_SIZE);
 			if (e_prev == NULL)
 				ebmap->node = e_iter;
 			else
