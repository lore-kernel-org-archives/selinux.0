Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s75KCseL016675
 for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2014 16:12:54 -0400
Subject: [PATCH] netlabel: fix the netlbl_catmap_setlong() dummy function
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 05 Aug 2014 16:12:52 -0400
Message-ID: <20140805201252.14969.17811.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When I added the netlbl_catmap_setlong() function I mistakenly forgot
to mark the associated dummy function as an inline.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 include/net/netlabel.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index a4fc39b..7b5a300 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -524,10 +524,10 @@ static inline int netlbl_catmap_setrng(struct netlbl_lsm_catmap **catmap,
 {
 	return 0;
 }
-static int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
-				 u32 offset,
-				 unsigned long bitmap,
-				 gfp_t flags)
+static inline int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
+					u32 offset,
+					unsigned long bitmap,
+					gfp_t flags)
 {
 	return 0;
 }
