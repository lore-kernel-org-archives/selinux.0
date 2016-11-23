Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANMDbNk025594
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:13:42 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1554B564A0D
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 23:07:37 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] libsepol: ebitmap: reject loading bitmaps with incorrect
 high bit
Date: Wed, 23 Nov 2016 23:06:44 +0100
Message-Id: <20161123220646.23504-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161123220646.23504-1-nicolas.iooss@m4x.org>
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently ebitmap_load() accepts loading a bitmap with highbit=192 and
one node {startbit=0, map=0x2}. When iterating over the bitmap,
ebitmap_for_each_bit() is expected to only yield "1" but it gives the
following bits: 1, 65, 129.

This is due to two facts in ebitmap_for_each_bit() implementation:
* ebitmap_next() stays on the first (and only) node of the bitmap
  instead of stopping the iteration.
* the end condition of the for loop consists in comparing the bit with
  ebitmap_length() (ie. the bitmap highbit), which is above the limit of
  the last node here.

These are not bugs when the bitmap highbit is equals to
l->startbit+MAPSIZE, where l is the last node (this is how
ebitmap_set_bit() sets it). So a simple fix consists in making
ebitmap_load() reject bitmaps which are loaded with an invalid highbit
value.

This issue has been found while fuzzing semodule_package with the
American Fuzzy Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/ebitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index fe8beb879a18..218adc293aae 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -453,6 +453,12 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 
 		l = n;
 	}
+	if (count && l->startbit + MAPSIZE != e->highbit) {
+		printf
+		    ("security: ebitmap: hight bit %u has not the expected value %zu\n",
+		     e->highbit, l->startbit + MAPSIZE);
+		goto bad;
+	}
 
       ok:
 	rc = 0;
-- 
2.10.2
