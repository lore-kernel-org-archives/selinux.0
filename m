Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OGqkeA010402
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 11:54:38 -0500
Received: from sw.stl.gtri.gatech.edu (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OGqaGA008307
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 16:52:36 GMT
From: Joshua Roys <joshua.roys@gtri.gatech.edu>
To: selinux@tycho.nsa.gov
Cc: Joshua Roys <joshua.roys@gtri.gatech.edu>
Subject: [PATCH] netlabel: fix export of SELinux categories > 127
Date: Wed, 24 Feb 2010 16:52:37 +0000
Message-Id: <1267030357-26366-1-git-send-email-joshua.roys@gtri.gatech.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This fixes corrupted CIPSO packets when SELinux categories greater
than 127 are used.  The bug occured on the second (and later) loops
through the while; the inner for loop through the ebitmap->maps array
used the same index as the NetLabel catmap->bitmap array, even though
the NetLabel bitmap is twice as long as the SELinux bitmap.

Signed-off-by: Joshua Roys <joshua.roys@gtri.gatech.edu>
---
 security/selinux/ss/ebitmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 68c7348..04b6145 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -128,7 +128,7 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 			cmap_idx = delta / NETLBL_CATMAP_MAPSIZE;
 			cmap_sft = delta % NETLBL_CATMAP_MAPSIZE;
 			c_iter->bitmap[cmap_idx]
-				|= e_iter->maps[cmap_idx] << cmap_sft;
+				|= e_iter->maps[i] << cmap_sft;
 		}
 		e_iter = e_iter->next;
 	}
-- 
1.6.5.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
