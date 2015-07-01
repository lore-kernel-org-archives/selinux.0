Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t612TUJH031057
 for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2015 22:29:30 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 33D52388802
 for <selinux@tycho.nsa.gov>; Wed,  1 Jul 2015 02:29:25 +0000 (UTC)
Subject: [PATCH] selinux: don't waste ebitmap space when importing NetLabel
 categories
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 30 Jun 2015 22:29:24 -0400
Message-ID: <20150701022924.7788.80821.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

At present we don't create efficient ebitmaps when importing NetLabel
category bitmaps.  This can present a problem when comparing ebitmaps
since ebitmap_cmp() is very strict about these things and considers
these wasteful ebitmaps not equal when compared to their more
efficient counterparts, even if their values are the same.  This isn't
likely to cause problems on 64-bit systems due to a bit of luck on
how NetLabel/CIPSO works and the default ebitmap size, but it can be
a problem on 32-bit systems.

This patch fixes this problem by being a bit more intelligent when
importing NetLabel category bitmaps by skipping over empty sections
which should result in a nice, efficient ebitmap.

Cc: stable@vger.kernel.org # 3.17
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/ss/ebitmap.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index afe6a26..57644b1 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -153,6 +153,12 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 		if (offset == (u32)-1)
 			return 0;
 
+		/* don't waste ebitmap space if the netlabel bitmap is empty */
+		if (bitmap == 0) {
+			offset += EBITMAP_UNIT_SIZE;
+			continue;
+		}
+
 		if (e_iter == NULL ||
 		    offset >= e_iter->startbit + EBITMAP_SIZE) {
 			e_prev = e_iter;
