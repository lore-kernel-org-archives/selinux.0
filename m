Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK9vWt018951
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:09:57 -0500
Subject: [PATCH 07/13] NFSv4: Add label recommended attribute and NFSv4
	flags
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:09:56 -0500
Message-Id: <1195243796.20981.17.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a new recommended attribute named label into the NFSv4 file
attribute structure. In addition it also adds several new flags to allow the
NFS client and server to determine if this attribute is supported and if it is
being sent over the wire.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfs/nfs4proc.c           |    3 +++
 include/linux/nfs4.h        |    2 ++
 include/linux/nfs_fs_sb.h   |    2 +-
 include/linux/nfs_xdr.h     |    4 ++++
 include/linux/nfsd/export.h |    5 +++--
 include/linux/nfsd/nfsd.h   |    5 +++--
 6 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f03d9d5..dfa6179 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -96,6 +96,9 @@ const u32 nfs4_fattr_bitmap[2] = {
 	| FATTR4_WORD1_TIME_ACCESS
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	| FATTR4_WORD1_SECURITY_LABEL
+#endif
 };
 
 const u32 nfs4_statfs_bitmap[2] = {
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8726491..af90403 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -21,6 +21,7 @@
 #define NFS4_FHSIZE		128
 #define NFS4_MAXPATHLEN		PATH_MAX
 #define NFS4_MAXNAMLEN		NAME_MAX
+#define NFS4_MAXLABELLEN	255
 
 #define NFS4_ACCESS_READ        0x0001
 #define NFS4_ACCESS_LOOKUP      0x0002
@@ -348,6 +349,7 @@ enum lock_type4 {
 #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
 #define FATTR4_WORD1_TIME_MODIFY_SET    (1UL << 22)
 #define FATTR4_WORD1_MOUNTED_ON_FILEID  (1UL << 23)
+#define FATTR4_WORD1_SECURITY_LABEL	(1UL << 31)
 
 #define NFSPROC4_NULL 0
 #define NFSPROC4_COMPOUND 1
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 0cac49b..6f190c2 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -118,5 +118,5 @@ struct nfs_server {
 #define NFS_CAP_SYMLINKS	(1U << 2)
 #define NFS_CAP_ACLS		(1U << 3)
 #define NFS_CAP_ATOMIC_OPEN	(1U << 4)
-
+#define NFS_CAP_SECURITY_LABEL  (1U << 5)
 #endif
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index daab252..9393572 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -56,6 +56,10 @@ struct nfs_fattr {
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
 	unsigned long		time_start;
+#ifdef CONFIG_SECURITY
+	void			*label;
+	__u32			 label_len;
+#endif
 };
 
 #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
diff --git a/include/linux/nfsd/export.h b/include/linux/nfsd/export.h
index bcb7aba..fba3d6e 100644
--- a/include/linux/nfsd/export.h
+++ b/include/linux/nfsd/export.h
@@ -32,7 +32,8 @@
 #define NFSEXP_ALLSQUASH	0x0008
 #define NFSEXP_ASYNC		0x0010
 #define NFSEXP_GATHERED_WRITES	0x0020
-/* 40 80 100 currently unused */
+#define NFSEXP_SECURITY_LABEL	0x0040  /* Support security label fattr4 */
+/* 80 100 currently unused */
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -40,7 +41,7 @@
 #define NFSEXP_FSID		0x2000
 #define	NFSEXP_CROSSMOUNT	0x4000
 #define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use */
-#define NFSEXP_ALLFLAGS		0xFE3F
+#define NFSEXP_ALLFLAGS		0xFE7F
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
index 604a0d7..6c4b122 100644
--- a/include/linux/nfsd/nfsd.h
+++ b/include/linux/nfsd/nfsd.h
@@ -311,7 +311,7 @@ extern struct timeval	nfssvc_boot;
  | FATTR4_WORD1_OWNER	        | FATTR4_WORD1_OWNER_GROUP  | FATTR4_WORD1_RAWDEV           \
  | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   | FATTR4_WORD1_SPACE_TOTAL      \
  | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  | FATTR4_WORD1_TIME_ACCESS_SET  \
- | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
+ | FATTR4_WORD1_TIME_DELTA   	| FATTR4_WORD1_TIME_METADATA    			    \
  | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MOUNTED_ON_FILEID)
 
 /* These will return ERR_INVAL if specified in GETATTR or READDIR. */
@@ -323,7 +323,8 @@ extern struct timeval	nfssvc_boot;
 (FATTR4_WORD0_SIZE              | FATTR4_WORD0_ACL                                         )
 #define NFSD_WRITEABLE_ATTRS_WORD1                                                          \
 (FATTR4_WORD1_MODE              | FATTR4_WORD1_OWNER         | FATTR4_WORD1_OWNER_GROUP     \
- | FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_METADATA | FATTR4_WORD1_TIME_MODIFY_SET)
+ | FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_METADATA 				    \
+ | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_SECURITY_LABEL)
 
 #endif /* CONFIG_NFSD_V4 */
 
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
