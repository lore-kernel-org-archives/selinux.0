Date: Wed, 1 Aug 2007 20:17:20 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: Re: [PATCH 1/7] Security: Add inode_{get,set}secid LSM hooks and
 security helper functions
In-Reply-To: <1185998532157-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Pine.LNX.4.64.0708012012580.29184@us.intercode.com.au>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
 <1185998532157-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Aug 2007, David P. Quigley wrote:

> + * @inode_getsecid:
> + * 	Returns secid from @inode;

Probably best to specify that this happens via *secid.

> + * @inode_setsecid:
> + * 	Set the security structure value of @inode with @sid.
> + * 	Returns 0 on success.

Except when it returns void :-)

> +	void (*inode_getsecid)(struct inode *inode, u32 *secid);
> +	void (*inode_setsecid)(struct inode *inode, u32 secid);

> +static inline void security_inode_setsecid(struct inode *inode, u32 sid)
> +{
> +	if (unlikely (IS_PRIVATE (inode)))

Please remove the extra spaces.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
