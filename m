From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 1/3] selinux: detect invalid ebitmap
Date: Tue, 23 Aug 2016 13:49:23 -0700
Message-Id: <1471985365-1197-1-git-send-email-william.c.roberts@intel.com>
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
---
 security/selinux/ss/ebitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 894b6cd..7d10e5d 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -374,6 +374,9 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 		goto ok;
 	}
 
+	if (e->highbit && !count)
+		goto bad;
+
 	for (i = 0; i < count; i++) {
 		rc = next_entry(&startbit, fp, sizeof(u32));
 		if (rc < 0) {
-- 
1.9.1
