Date: Fri, 5 Dec 2008 20:39:13 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, "Matthew N. Dodd" <matthew.dodd@sparta.com>,
        trond.myklebust@fys.uio.no, bfields@fieldses.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 12/14] NFS: Client implementation of Labeled-NFS
In-Reply-To: <1227733394-1114-13-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.1.10.0812052022320.14142@tundra.namei.org>
References: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov> <1227733394-1114-13-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Nov 2008, David P. Quigley wrote:

> +#ifdef CONFIG_NFS_V4_SECURITY_LABEL
> +	if (((nd->flags & LOOKUP_CREATE) != 0) &&
> +	      nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL)) {
> +		status = security_dentry_init_security(dentry,
> +				sattr->ia_mode, &l.label, &l.len);
> +		/* XXX: should this be more fatal? */
> +		if (status == 0)
> +			label = &l;
> +	}
> +#endif

Per the comment, it seems this function should fail and propagate an error 
if status != 0.

> +	memset(&fattr, 0, sizeof(struct nfs_fattr));
> +	nfs_fattr_alloc(&fattr, GFP_KERNEL);

Need to check the return value.

> +	nfs_fattr_alloc(&fattr, GFP_KERNEL);

Ditto.

> +static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap, void **ctx, __u32 *ctxlen)
> +{
> +	__u32 len;
> +	__be32 *p;
> +	int rc = 0;
> +
> +	if (unlikely(bitmap[1] & (FATTR4_WORD1_SECURITY_LABEL - 1U)))
> +		return -EIO;
> +	if (likely(bitmap[1] & FATTR4_WORD1_SECURITY_LABEL)) {
> +		READ_BUF(4);
> +		READ32(len);
> +		READ_BUF(len);
> +		if (len < XDR_MAX_NETOBJ) {
> +			if (*ctx != NULL) {
> +				if (*ctxlen < len) {
> +					printk(KERN_ERR
> +						"%s(): ctxlen %d < len %d\n",
> +						__func__, *ctxlen, len);
> +					/* rc = -ENOMEM; */
> +					*ctx = NULL;	/* leak */

Shouldn't the function stop processing and return an error?

> +				} else {
> +					memcpy(*ctx, p, len);
> +				}
> +			}
> +			*ctxlen = len;
> +		} else
> +			printk(KERN_WARNING "%s: label too long (%u)!\n",
> +					__FUNCTION__, len);
> +		bitmap[1] &= ~FATTR4_WORD1_SECURITY_LABEL;
> +	}
> +	return rc;
> +}
> +



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
