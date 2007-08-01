From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 7/7] NFSv4: Server implementation of MAC Labeling
Date: Wed,  1 Aug 2007 16:02:12 -0400
Message-Id: <11859985331897-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

This patch implements the encoding of a MAC label on the server side to be sent
across the wire to the NFSv4 client. At this time there is no method of
receiving a label from the client to be set on the server.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/nfsd/nfs4xdr.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8ef0964..593a0b9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -58,6 +58,7 @@
 #include <linux/nfs4_acl.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/security.h>
 
 #define NFSDDBG_FACILITY		NFSDDBG_XDR
 
@@ -408,6 +409,20 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval, struct iattr *ia
 			goto xdr_error;
 		}
 	}
+#ifdef CONFIG_NFSD_V4_MAC
+	if (bmval[1] & FATTR4_WORD1_MAC_LABEL) {
+		READ_BUF(4);
+		len += 4;
+		READ32(dummy32);
+		READ_BUF(dummy32);
+		len += (XDR_QUADLEN(dummy32) << 2);
+		READMEM(buf, dummy32);
+		if (security_secctx_to_secid(&iattr->ia_sid,
+						(char *)buf, dummy32) != 0)
+			goto out_nfserr;
+		iattr->ia_valid |= ATTR_MAC_LABEL;
+	}
+#endif /* CONFIG_NFSD_V4_MAC */
 	if (len != expected_len)
 		goto xdr_error;
 
@@ -1414,6 +1429,34 @@ nfsd4_encode_aclname(struct svc_rqst *rqstp, int whotype, uid_t id, int group,
 	return nfsd4_encode_name(rqstp, whotype, id, group, p, buflen);
 }
 
+#ifdef CONFIG_NFSD_V4_MAC
+static inline __be32
+nfsd4_encode_mac_label(struct svc_rqst *rqstp,
+			struct dentry *dentry,
+			__be32 **p, int *buflen)
+{
+	char *context;
+	unsigned len = 0;
+	u32 secid;
+
+	security_inode_getsecid(dentry->d_inode, &secid);
+	security_secid_to_secctx(secid, &context, &len);
+	if (len < 0)
+		return nfserrno(len);
+	if (*buflen < ((XDR_QUADLEN(len) << 2) + 4)) {
+		kfree(context);
+		return nfserr_resource;
+	}
+
+	*p = xdr_encode_opaque(*p, context, len);
+	*buflen -= (XDR_QUADLEN(len) << 2) + 4;
+	BUG_ON(*buflen < 0);
+
+	kfree(context);
+	return 0;
+}
+#endif /* CONFIG_NFSD_V4_MAC */
+
 #define WORD0_ABSENT_FS_ATTRS (FATTR4_WORD0_FS_LOCATIONS | FATTR4_WORD0_FSID | \
 			      FATTR4_WORD0_RDATTR_ERROR)
 #define WORD1_ABSENT_FS_ATTRS FATTR4_WORD1_MOUNTED_ON_FILEID
@@ -1508,6 +1551,17 @@ nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
 			bmval0 &= ~FATTR4_WORD0_FS_LOCATIONS;
 		}
 	}
+#ifdef CONFIG_NFSD_V4_MAC
+	/**
+	 * This really isn't a good way to do this. We need the framework to detect a
+	 * mac implementation and handle this if it doesn't find one.
+	 *
+	 if (bmval1 & FATTR4_WORD1_MAC_LABEL) {
+	 if(!selinux_enabled)
+	 bmval1 &= ~FATTR_WORD1_MAC_LABEL;
+	 }
+	 */
+#endif /* CONFIG_NFSD_V4_MAC */
 	if ((buflen -= 16) < 0)
 		goto out_resource;
 
@@ -1518,15 +1572,25 @@ nfsd4_encode_fattr(struct svc_fh *fhp, struct svc_export *exp,
 
 	if (bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
 		u32 word0 = NFSD_SUPPORTED_ATTRS_WORD0;
+		u32 word1 = NFSD_SUPPORTED_ATTRS_WORD1;
 		if ((buflen -= 12) < 0)
 			goto out_resource;
 		if (!aclsupport)
 			word0 &= ~FATTR4_WORD0_ACL;
 		if (!exp->ex_fslocs.locations)
 			word0 &= ~FATTR4_WORD0_FS_LOCATIONS;
+		#ifdef CONFIG_NFSD_V4_MAC
+			/* XXX: should also be turned into a check to the framework */
+			/* XXX: turn this on unconditionally for now ...*/
+				if (1 || exp->ex_flags & NFSEXP_MAC_LABEL)
+					word1 |= FATTR4_WORD1_MAC_LABEL;
+				else
+					word1 &= ~FATTR4_WORD1_MAC_LABEL;
+		#endif /* CONFIG_NFSD_V4_MAC */
+		
 		WRITE32(2);
 		WRITE32(word0);
-		WRITE32(NFSD_SUPPORTED_ATTRS_WORD1);
+		WRITE32(word1);
 	}
 	if (bmval0 & FATTR4_WORD0_TYPE) {
 		if ((buflen -= 4) < 0)
@@ -1832,6 +1896,17 @@ out_acl:
 		} else
                 	WRITE64((u64) stat.ino);
 	}
+#ifdef CONFIG_NFSD_V4_MAC
+	if (bmval1 & FATTR4_WORD1_MAC_LABEL) {
+		status = nfsd4_encode_mac_label(rqstp, dentry,
+				&p, &buflen);
+		if (status == nfserr_resource)
+			goto out_resource;
+		if (status)
+			goto out;
+	}
+#endif /* CONFIG_NFSD_V4_MAC */
+	
 	*attrlenp = htonl((char *)p - (char *)attrlenp - 4);
 	*countp = p - buffer;
 	status = nfs_ok;
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
