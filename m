From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>, Daniel Jurgens
 <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
Message-ID: <2c4582c9-efc1-4b8c-1095-84e00062c7de@users.sourceforge.net>
Date: Sun, 13 Aug 2017 16:46:53 +0200
MIME-Version: 1.0
In-Reply-To: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 2/4] selinux: Adjust jump targets in ebitmap_read()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 13 Aug 2017 15:21:43 +0200

Adjust jump targets so that the function implementation becomes smaller.

* Move an error message so that it is present only once here.

* Avoid another check for the local variable "rc" at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/ebitmap.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ccf372db689c..03581d7ef817 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -350,21 +350,20 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	__le32 buf[3];
 	int rc, i;
 
-	ebitmap_init(e);
-
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
 		goto out;
 
-	mapunit = le32_to_cpu(buf[0]);
+	ebitmap_init(e);
 	e->highbit = le32_to_cpu(buf[1]);
 	count = le32_to_cpu(buf[2]);
+	mapunit = le32_to_cpu(buf[0]);
 
 	if (mapunit != BITS_PER_U64) {
 		printk(KERN_ERR "SELinux: ebitmap: map size %u does not "
 		       "match my size %zd (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
-		goto bad;
+		goto destroy_bitmap;
 	}
 
 	/* round up e->highbit */
@@ -377,27 +376,26 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	}
 
 	if (e->highbit && !count)
-		goto bad;
+		goto destroy_bitmap;
 
 	for (i = 0; i < count; i++) {
 		rc = next_entry(&startbit, fp, sizeof(u32));
-		if (rc < 0) {
-			printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
-			goto bad;
-		}
+		if (rc)
+			goto report_truncated_map;
+
 		startbit = le32_to_cpu(startbit);
 
 		if (startbit & (mapunit - 1)) {
 			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
 			       "not a multiple of the map unit size (%u)\n",
 			       startbit, mapunit);
-			goto bad;
+			goto destroy_bitmap;
 		}
 		if (startbit > e->highbit - mapunit) {
 			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
 			       "beyond the end of the bitmap (%u)\n",
 			       startbit, (e->highbit - mapunit));
-			goto bad;
+			goto destroy_bitmap;
 		}
 
 		if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
@@ -407,7 +405,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 				printk(KERN_ERR
 				       "SELinux: ebitmap: out of memory\n");
 				rc = -ENOMEM;
-				goto bad;
+				goto destroy_bitmap;
 			}
 			/* round down */
 			tmp->startbit = startbit - (startbit % EBITMAP_SIZE);
@@ -420,14 +418,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 			printk(KERN_ERR "SELinux: ebitmap: start bit %d"
 			       " comes after start bit %d\n",
 			       startbit, n->startbit);
-			goto bad;
+			goto destroy_bitmap;
 		}
 
 		rc = next_entry(&map, fp, sizeof(u64));
-		if (rc < 0) {
-			printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
-			goto bad;
-		}
+		if (rc)
+			goto report_truncated_map;
+
 		map = le64_to_cpu(map);
 
 		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
@@ -438,9 +435,10 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 	}
 out:
 	return rc;
-bad:
-	if (!rc)
-		rc = -EINVAL;
+report_truncated_map:
+	printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
+	rc = -EINVAL;
+destroy_bitmap:
 	ebitmap_destroy(e);
 	goto out;
 }
-- 
2.14.0
