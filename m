Date: Wed, 1 Aug 2007 20:37:11 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 6/7] NFSv4: Client implementation of MAC Labeling
In-Reply-To: <11859985332803-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Pine.LNX.4.64.0708012032360.29184@us.intercode.com.au>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
 <11859985332803-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Aug 2007, David P. Quigley wrote:

> +#ifdef CONFIG_NFS_V4_MAC
> +		if ((fattr->valid & NFS_ATTR_FATTR_V4) &&
> +				(fattr->bitmap[1] & FATTR4_WORD1_MAC_LABEL)) {
> +			security_inode_setsecid(inode, fattr->secid);
> +		}
> +#endif /* CONFIG_NFS_V4_MAC  */

Turn this into a static inline & reuse it, then it can be compiled away 
cleanly for !CONFIG_NFS_V4_MAC.

> +			if (security_secctx_to_secid(sid, (char *)p, len) != 0)
> +				dprintk("%s: security_decode_secid failed!\n",
> +								__FUNCTION__);

Standard form is:

	err = foo();
	if (err)
		bar();


And then you can print the error code, too.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
