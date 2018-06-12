From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:09:01 +0200
Message-ID: <20180612080912.7827-3-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 02/13] selinux: Cleanup printk logging in ebitmap
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/ebitmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 5ae8c61b75bf..8f624f80055b 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -362,7 +362,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	count = le32_to_cpu(buf[2]);
 
 	if (mapunit != BITS_PER_U64) {
-		printk(KERN_ERR "SELinux: ebitmap: map size %u does not "
+		pr_err("SELinux: ebitmap: map size %u does not "
 		       "match my size %zd (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
@@ -383,19 +383,19 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	for (i = 0; i < count; i++) {
 		rc = next_entry(&startbit, fp, sizeof(u32));
 		if (rc < 0) {
-			printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
+			pr_err("SELinux: ebitmap: truncated map\n");
 			goto bad;
 		}
 		startbit = le32_to_cpu(startbit);
 
 		if (startbit & (mapunit - 1)) {
-			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
+			pr_err("SELinux: ebitmap start bit (%d) is "
 			       "not a multiple of the map unit size (%u)\n",
 			       startbit, mapunit);
 			goto bad;
 		}
 		if (startbit > e->highbit - mapunit) {
-			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
+			pr_err("SELinux: ebitmap start bit (%d) is "
 			       "beyond the end of the bitmap (%u)\n",
 			       startbit, (e->highbit - mapunit));
 			goto bad;
@@ -405,8 +405,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			struct ebitmap_node *tmp;
 			tmp = kmem_cache_zalloc(ebitmap_node_cachep, GFP_KERNEL);
 			if (!tmp) {
-				printk(KERN_ERR
-				       "SELinux: ebitmap: out of memory\n");
+				pr_err("SELinux: ebitmap: out of memory\n");
 				rc = -ENOMEM;
 				goto bad;
 			}
@@ -418,7 +417,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 				e->node = tmp;
 			n = tmp;
 		} else if (startbit <= n->startbit) {
-			printk(KERN_ERR "SELinux: ebitmap: start bit %d"
+			pr_err("SELinux: ebitmap: start bit %d"
 			       " comes after start bit %d\n",
 			       startbit, n->startbit);
 			goto bad;
@@ -426,7 +425,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 		rc = next_entry(&map, fp, sizeof(u64));
 		if (rc < 0) {
-			printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
+			pr_err("SELinux: ebitmap: truncated map\n");
 			goto bad;
 		}
 		map = le64_to_cpu(map);
-- 
2.15.1
