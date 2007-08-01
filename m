Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71LIjvt031440
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 17:18:45 -0400
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l71LIhdm013958
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 21:18:43 GMT
Date: Wed, 1 Aug 2007 14:18:43 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 5/7] NFSv4: Add secid recommended attribute and NFSv4 flags
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985333464-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <301656.30194.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:

> From: David P. Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch adds a new recommended attribute named secid into the NFSv4 file
> attribute structure. In addition it also adds several new flags to allow the
> NFS client and server to determine if this attribute is supported and if it
> is
> being sent over the wire.

Sorry to keep repeating myself, I expect the message has come through
by now, but this is assumes a u32 label, which is fine for SELinux
but not for a general framework. 

> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> ---
>  fs/nfs/nfs4proc.c           |    1 +
>  include/linux/nfs4.h        |    1 +
>  include/linux/nfs_xdr.h     |    3 +++
>  include/linux/nfsd/export.h |    5 +++--
>  include/linux/nfsd/nfsd.h   |    8 +++++---
>  5 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 6ca2795..9caddc9 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -98,6 +98,7 @@ const u32 nfs4_fattr_bitmap[2] = {
>  	| FATTR4_WORD1_TIME_ACCESS
>  	| FATTR4_WORD1_TIME_METADATA
>  	| FATTR4_WORD1_TIME_MODIFY
> +	| FATTR4_WORD1_MAC_LABEL

If you're sticking with a u32 label make this FATTR4_WORD1_SELINUX_LABEL

>  };
>  
>  const u32 nfs4_statfs_bitmap[2] = {
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 8726491..e978031 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -348,6 +348,7 @@ enum lock_type4 {
>  #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
>  #define FATTR4_WORD1_TIME_MODIFY_SET    (1UL << 22)
>  #define FATTR4_WORD1_MOUNTED_ON_FILEID  (1UL << 23)
> +#define FATTR4_WORD1_MAC_LABEL		(1UL << 31)

If you're sticking with a u32 label make this FATTR4_WORD1_SELINUX_LABEL

>  
>  #define NFSPROC4_NULL 0
>  #define NFSPROC4_COMPOUND 1
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index cf74a4d..f6100e7 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -56,6 +56,9 @@ struct nfs_fattr {
>  	__u64			change_attr;	/* NFSv4 change attribute */
>  	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
>  	unsigned long		time_start;
> +#ifdef CONFIG_NFS_V4_MAC
> +	__u32			secid;
> +#endif
>  };

Make this field accomodating of other label formats, please.

>  
>  #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
> diff --git a/include/linux/nfsd/export.h b/include/linux/nfsd/export.h
> index 5cd1924..76652ad 100644
> --- a/include/linux/nfsd/export.h
> +++ b/include/linux/nfsd/export.h
> @@ -32,7 +32,8 @@
>  #define NFSEXP_ALLSQUASH	0x0008
>  #define NFSEXP_ASYNC		0x0010
>  #define NFSEXP_GATHERED_WRITES	0x0020
> -/* 40 80 100 currently unused */
> +#define NFSEXP_MAC_LABEL	0x0040 /* Support Mac label fattr4 */

If you're sticking with a u32 label make this NFSEXP_SELINUX_LABEL

> +/* 80 100 currently unused */
>  #define NFSEXP_NOHIDE		0x0200
>  #define NFSEXP_NOSUBTREECHECK	0x0400
>  #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just
> trust */
> @@ -40,7 +41,7 @@
>  #define NFSEXP_FSID		0x2000
>  #define	NFSEXP_CROSSMOUNT	0x4000
>  #define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use */
> -#define NFSEXP_ALLFLAGS		0xFE3F
> +#define NFSEXP_ALLFLAGS		0xFE7F
>  
>  /* The flags that may vary depending on security flavor: */
>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
> diff --git a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
> index e452256..f381441 100644
> --- a/include/linux/nfsd/nfsd.h
> +++ b/include/linux/nfsd/nfsd.h
> @@ -309,8 +309,9 @@ extern struct timeval	nfssvc_boot;
>   | FATTR4_WORD1_OWNER	        | FATTR4_WORD1_OWNER_GROUP  |
> FATTR4_WORD1_RAWDEV           \
>   | FATTR4_WORD1_SPACE_AVAIL     | FATTR4_WORD1_SPACE_FREE   |
> FATTR4_WORD1_SPACE_TOTAL      \
>   | FATTR4_WORD1_SPACE_USED      | FATTR4_WORD1_TIME_ACCESS  |
> FATTR4_WORD1_TIME_ACCESS_SET  \
> - | FATTR4_WORD1_TIME_DELTA   | FATTR4_WORD1_TIME_METADATA    \
> - | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET |
> FATTR4_WORD1_MOUNTED_ON_FILEID)
> + | FATTR4_WORD1_TIME_DELTA   	| FATTR4_WORD1_TIME_METADATA    			    \
> + | FATTR4_WORD1_TIME_MODIFY     | FATTR4_WORD1_TIME_MODIFY_SET 				    \
> + | FATTR4_WORD1_MOUNTED_ON_FILEID | FATTR4_WORD1_MAC_LABEL)
>  
>  /* These will return ERR_INVAL if specified in GETATTR or READDIR. */
>  #define NFSD_WRITEONLY_ATTRS_WORD1							    \
> @@ -321,7 +322,8 @@ extern struct timeval	nfssvc_boot;
>  (FATTR4_WORD0_SIZE              | FATTR4_WORD0_ACL                          
>               )
>  #define NFSD_WRITEABLE_ATTRS_WORD1                                          
>                \
>  (FATTR4_WORD1_MODE              | FATTR4_WORD1_OWNER         |
> FATTR4_WORD1_OWNER_GROUP     \
> - | FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_METADATA |
> FATTR4_WORD1_TIME_MODIFY_SET)
> + | FATTR4_WORD1_TIME_ACCESS_SET | FATTR4_WORD1_TIME_METADATA 				    \
> + | FATTR4_WORD1_TIME_MODIFY_SET | FATTR4_WORD1_MAC_LABEL)
>  
>  #endif /* CONFIG_NFSD_V4 */
>  
> -- 
> 1.5.2.2
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
