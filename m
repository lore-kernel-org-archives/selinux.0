From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 6/7] NFSv4: Client implementation of MAC Labeling
Date: Wed,  1 Aug 2007 16:02:11 -0400
Message-Id: <11859985332803-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

There are several places where recommended attributes are implemented in the
NFSv4 client code. This patch adds two functions to encode and decode the secid
recommended attribute which makes use of the LSM hooks added earlier. It also
adds code to grab the label from the file attribute structures and encode the
label to be sent back to the server. Even though the code is there to encode a
label to be sent back to the server there does not appear to be an interface to
use it yet.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/nfs/inode.c   |   16 ++++++++++++++
 fs/nfs/nfs4xdr.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/super.c   |   10 ++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bca6cdc..1bc0951 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -37,6 +37,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/nfs_xdr.h>
+#include <linux/security.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -287,6 +288,14 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode->i_nlink = fattr->nlink;
 		inode->i_uid = fattr->uid;
 		inode->i_gid = fattr->gid;
+		
+#ifdef CONFIG_NFS_V4_MAC
+		if ((fattr->valid & NFS_ATTR_FATTR_V4) &&
+				(fattr->bitmap[1] & FATTR4_WORD1_MAC_LABEL)) {
+			security_inode_setsecid(inode, fattr->secid);
+		}
+#endif /* CONFIG_NFS_V4_MAC  */
+
 		if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 			/*
 			 * report the blocks in 512byte units
@@ -1038,6 +1047,13 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	inode->i_uid = fattr->uid;
 	inode->i_gid = fattr->gid;
 
+#ifdef CONFIG_NFS_V4_MAC
+	if ((fattr->valid & NFS_ATTR_FATTR_V4) &&
+	    (fattr->bitmap[1] & FATTR4_WORD1_MAC_LABEL)) {
+		security_inode_setsecid(inode, fattr->secid);
+	}
+#endif /* CONFIG_NFS_V4_MAC */
+
 	if (fattr->valid & (NFS_ATTR_FATTR_V3 | NFS_ATTR_FATTR_V4)) {
 		/*
 		 * report the blocks in 512byte units
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index badd73b..4dc8943 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -51,6 +51,7 @@
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_idmap.h>
+#include <linux/security.h>
 #include "nfs4_fs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
@@ -610,6 +611,10 @@ static int encode_attrs(struct xdr_stream *xdr, const struct iattr *iap, const s
 	uint32_t bmval0 = 0;
 	uint32_t bmval1 = 0;
 	int status;
+#ifdef CONFIG_NFS_V4_MAC
+	char *label = NULL;
+	u32 label_len = 0;
+#endif
 
 	/*
 	 * We reserve enough space to write the entire attribute buffer at once.
@@ -648,6 +653,18 @@ static int encode_attrs(struct xdr_stream *xdr, const struct iattr *iap, const s
 		}
 		len += 4 + (XDR_QUADLEN(owner_grouplen) << 2);
 	}
+#ifdef CONFIG_NFS_V4_MAC
+	if (iap->ia_valid & ATTR_MAC_LABEL) {
+		security_secid_to_secctx(iap->ia_sid, &label, &label_len);
+		if (label_len < 0) {
+			printk(KERN_WARNING
+					"nfs4: couldn't resolve sid %d to string\n",
+					iap->ia_sid);
+			/* XXX: Should we be going to an error label? */
+		}
+		len += 4 + (XDR_QUADLEN(label_len) << 2);
+	}
+#endif
 	if (iap->ia_valid & ATTR_ATIME_SET)
 		len += 16;
 	else if (iap->ia_valid & ATTR_ATIME)
@@ -706,6 +723,14 @@ static int encode_attrs(struct xdr_stream *xdr, const struct iattr *iap, const s
 		bmval1 |= FATTR4_WORD1_TIME_MODIFY_SET;
 		WRITE32(NFS4_SET_TO_SERVER_TIME);
 	}
+#ifdef CONFIG_NFS_V4_MAC
+	if (iap->ia_valid & ATTR_MAC_LABEL) {
+		bmval1 |= FATTR4_WORD1_MAC_LABEL;
+		WRITE32(label_len);
+		WRITEMEM(label, label_len);
+		security_release_secctx(label, label_len);
+	}
+#endif /* CONFIG_NFS_V4_MAC */
 	
 	/*
 	 * Now we backfill the bitmap and the attribute buffer length.
@@ -2944,6 +2969,37 @@ static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, str
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_MAC
+static int decode_attr_mac_label(struct xdr_stream *xdr, uint32_t *bitmap,
+					struct nfs_client *clp, u32 *sid)
+{
+	uint32_t len;
+	__be32 *p;
+	int rc = 0;
+	if (unlikely(bitmap[1] & (FATTR4_WORD1_MAC_LABEL - 1U))) {
+		rc = -EIO;
+		goto out;
+	}
+	if (likely(bitmap[1] & FATTR4_WORD1_MAC_LABEL)) {
+		READ_BUF(4);
+		READ32(len);
+		READ_BUF(len);
+		if (len < XDR_MAX_NETOBJ) {
+			if (security_secctx_to_secid(sid, (char *)p, len) != 0)
+				dprintk("%s: security_decode_secid failed!\n",
+								__FUNCTION__);
+		} else {
+			printk(KERN_WARNING "%s: label too long (%u)!\n",
+					__FUNCTION__, len);
+		}
+		bitmap[1] &= ~FATTR4_WORD1_MAC_LABEL;
+	}
+	dprintk("%s: sid=%d\n", __FUNCTION__, (u32)*sid);
+out:
+	return rc;
+}
+#endif /* CONFIG_NFS_V4_MAC */
+
 static int verify_attr_len(struct xdr_stream *xdr, __be32 *savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -3175,6 +3231,11 @@ static int decode_getfattr(struct xdr_stream *xdr, struct nfs_fattr *fattr, cons
 		goto xdr_error;
 	if ((status = decode_attr_mounted_on_fileid(xdr, bitmap, &fileid)) != 0)
 		goto xdr_error;
+#ifdef CONFIG_NFS_V4_MAC
+	if ((status = decode_attr_mac_label(xdr, bitmap, server->nfs_client,
+					&fattr->secid)) != 0)
+		goto xdr_error;
+#endif /* CONFIG_NFS_V4_MAC */
 	if (fattr->fileid == 0 && fileid != 0)
 		fattr->fileid = fileid;
 	if ((status = verify_attr_len(xdr, savep, attrlen)) == 0)
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index b2a851c..fec4cfb 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -495,6 +495,12 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",timeo=%lu", 10U * clp->retrans_timeo / HZ);
 	seq_printf(m, ",retrans=%u", clp->retrans_count);
 	seq_printf(m, ",sec=%s", nfs_pseudoflavour_to_name(nfss->client->cl_auth->au_flavor));
+
+#ifdef CONFIG_NFS_V4_MAC
+	if ((nfss->nfs_client->cl_nfsversion == 4) &&
+	    (nfss->attr_bitmask[1] & FATTR4_WORD1_MAC_LABEL))
+		seq_printf(m, ",mac_label");
+#endif /* CONFIG_NFS_V4_MAC */
 }
 
 /*
@@ -549,6 +555,10 @@ static int nfs_show_stats(struct seq_file *m, struct vfsmount *mnt)
 		seq_printf(m, "bm0=0x%x", nfss->attr_bitmask[0]);
 		seq_printf(m, ",bm1=0x%x", nfss->attr_bitmask[1]);
 		seq_printf(m, ",acl=0x%x", nfss->acl_bitmask);
+#ifdef CONFIG_NFS_V4_MAC
+		if (nfss->attr_bitmask[1] & FATTR4_WORD1_MAC_LABEL)
+			seq_printf(m, ",mac_label");
+#endif /* CONFIG_NFS_V4_MAC */
 	}
 #endif
 
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
