From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 sds@tycho.nsa.gov
Subject: [PATCH v4 3/7] ebitmap: detect invalid bitmap
Date: Tue, 16 Aug 2016 10:28:33 -0700
Message-Id: <1471368517-20552-4-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
References: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

When count is 0 and the highbit is not zero, the ebitmap is not
valid and the internal node is not allocated. This causes issues
when routines, like mls_context_isvalid() attempt to use the
ebitmap_for_each_bit() and ebitmap_node_get_bit() as they assume
a highbit > 0 will have a node allocated.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/ebitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
index 58f2fc4..fe8beb8 100644
--- a/libsepol/src/ebitmap.c
+++ b/libsepol/src/ebitmap.c
@@ -394,6 +394,10 @@ int ebitmap_read(ebitmap_t * e, void *fp)
 		     e->highbit, MAPSIZE);
 		goto bad;
 	}
+
+	if (e->highbit && !count)
+		goto bad;
+
 	l = NULL;
 	for (i = 0; i < count; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t));
-- 
1.9.1
