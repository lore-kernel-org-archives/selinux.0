Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGKCA7P019316
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:12:10 -0500
Subject: [PATCH 11/13] NFSD: Server implementation of MAC Labeling
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:12:09 -0500
Message-Id: <1195243929.20981.26.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch implements the encoding of a MAC label on the server side to be
sent across the wire to the NFSv4 client. At this time there is no method of
receiving a label from the client to be set on the server.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfsd/nfs4xdr.c          |   91 +++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/vfs.c              |    7 +++
 2 files changed, 97 insertions(+), 1 deletions(-)
 create mode 100644 fs/nfs/doimap.c
 create mode 100644 include/linux/nfs_doimap.h

diff --git a/fs/nfs/doimap.c b/fs/nfs/doimap.c
new file mode 100644
index 0000000..e69de29
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5733394..9972b14 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -50,6 +50,7 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/clnt.h>
+#include <linux/nfs_fs.h>
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/state.h>
 #include <linux/nfsd/xdr4.h>
@@ -58,6 +59,8 @@
 #include <linux/nfs4_acl.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/security.h>
+#include <linux/xattr.h>
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
@@ -411,6 +414,22 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval, struct iattr *ia
 			goto xdr_error;
 		}
 	}
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	if (bmval[1] & FATTR4_WORD1_SECURITY_LABEL) {
+		READ_BUF(4);
+		len += 4;
+		READ32(dummy32);
+		READ_BUF(dummy32);
+		len += (XDR_QUADLEN(dummy32) << 2);
+		READMEM(buf, dummy32);
+		iattr->ia_label_len = dummy32;
+		iattr->ia_label = kmalloc(dummy32 + 1, GFP_ATOMIC);
+		memcpy(iattr->ia_label, buf, dummy32);
+		((char *)iattr->ia_label)[dummy32 + 1] = '\0';
+		iattr->ia_valid |= ATTR_SECURITY_LABEL;
+		defer_free(argp, kfree, iattr->ia_label);
+	}
+#endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
 	if (len != expected_len)
 		goto xdr_error;
 
@@ -1418,6 +1437,44 @@ nfsd4_encode_aclname(struct svc_rqst *rqstp, int whotype, uid_t id, int group,
 	return nfsd4_encode_name(rqstp, whotype, id, group, p, buflen);
 }
 
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+static inline __be32
+nfsd4_encode_security_label(struct svc_rqst *rqstp,
+			    struct dentry *dentry,
+			    __be32 **p, int *buflen)
+{
+	void *context;
+	int err = 0, len;
+
+	const char *suffix = security_inode_xattr_getname()
+				+ XATTR_SECURITY_PREFIX_LEN;
+
+	len = security_inode_getsecurity(dentry->d_inode, suffix, &context, true);
+	if (len < 0) {
+		err = nfserrno(len);
+		goto out;
+	}
+
+	if (len > NFS_MAXLABELLEN) {
+		err = nfserrno(len);
+		goto out_err;
+	}
+	if (*buflen < ((XDR_QUADLEN(len) << 2) + 4)) {
+		err =  nfserr_resource;
+		goto out_err;
+	}
+
+	*p = xdr_encode_opaque(*p, context, len);
+	*buflen -= (XDR_QUADLEN(len) << 2) + 4;
+	BUG_ON(*buflen < 0);
+
+out_err:
+	security_release_secctx(context, len);
+out:
+	return err;
+}
+#endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
+
 #define WORD0_ABSENT_FS_ATTRS (FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_FSID | \
 			      FATTR4_WORD0_RDATTR_ERROR)
 #define WORD1_ABSENT_FS_ATTRS FATTR4_WORD1_MOUNTED_ON_FILEID
@@ -1513,6 +1570,16 @@ nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
 			bmval0 &= ~FATTR4_WORD0_FS_LOCATIONS;
 		}
 	}
+
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	if (bmval1 & FATTR4_WORD1_SECURITY_LABEL) {
+		if (/* XXX !selinux_enabled */0)
+			bmval1 &= ~FATTR4_WORD1_SECURITY_LABEL;
+	}
+#else
+	bmval1 &= ~FATTR4_WORD1_SECURITY_LABEL;
+#endif
+
 	if ((buflen -= 16) < 0)
 		goto out_resource;
 
@@ -1523,15 +1590,26 @@ nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
 
 	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		u32 word0 = NFSD_SUPPORTED_ATTRS_WORD0;
+		u32 word1 = NFSD_SUPPORTED_ATTRS_WORD1;
 		if ((buflen -= 12) < 0)
 			goto out_resource;
 		if (!aclsupport)
 			word0 &= ~FATTR4_WORD0_ACL;
 		if (!exp->ex_fslocs.locations)
 			word0 &= ~FATTR4_WORD0_FS_LOCATIONS;
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+		/* XXX: turn this on unconditionally for now ...*/
+		if (1 || exp->ex_flags & NFSEXP_SECURITY_LABEL)
+			word1 |= FATTR4_WORD1_SECURITY_LABEL;
+		else
+			word1 &= ~FATTR4_WORD1_SECURITY_LABEL;
+#else
+		word1 &= ~FATTR4_WORD1_SECURITY_LABEL;
+#endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
+
 		WRITE32(2);
 		WRITE32(word0);
-		WRITE32(NFSD_SUPPORTED_ATTRS_WORD1);
+		WRITE32(word1);
 	}
 	if (bmval0 & FATTR4_WORD0_TYPE) {
 		if ((buflen -= 4) < 0)
@@ -1836,6 +1914,17 @@ out_acl:
 		}
 		WRITE64(stat.ino);
 	}
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+	if (bmval1 & FATTR4_WORD1_SECURITY_LABEL) {
+		status = nfsd4_encode_security_label(rqstp, dentry,
+				&p, &buflen);
+		if (status == nfserr_resource)
+			goto out_resource;
+		if (status)
+			goto out;
+	}
+#endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
+
 	*attrlenp = htonl((char *)p - (char *)attrlenp - 4);
 	*countp = p - buffer;
 	status = nfs_ok;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d019918..0cf1884 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1528,6 +1528,13 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!host_err) {
 		if (EX_ISSYNC(fhp->fh_export))
 			host_err = nfsd_sync_dir(dentry);
+#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
+		if (iap && (iap->ia_valid & ATTR_SECURITY_LABEL)) {
+			char *key = (char *)security_inode_xattr_getname();
+			vfs_setxattr_locked(dnew, key,
+					iap->ia_label, iap->ia_label_len, 0);
+		}
+#endif
 	}
 	err = nfserrno(host_err);
 	fh_unlock(fhp);
diff --git a/include/linux/nfs_doimap.h b/include/linux/nfs_doimap.h
new file mode 100644
index 0000000..e69de29
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
