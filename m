Date: Wed, 22 Aug 2007 06:44:34 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
Subject: Re: [patch] Tuning avtab to reduce memory usage
In-Reply-To: <20070822115145.E7D3.YNAKAM@hitachisoft.jp>
Message-ID: <Xine.LNX.4.64.0708220642110.21844@us.intercode.com.au>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
 <Xine.LNX.4.64.0708210645130.16813@us.intercode.com.au>
 <20070822115145.E7D3.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Aug 2007, Yuichi Nakamura wrote:


Just a couple more nits...

> +#define AVTAB_HASH(keyp, mask) \
>  ((keyp->target_class + \
>   (keyp->target_type << 2) + \
>   (keyp->source_type << 9)) & \
> - AVTAB_HASH_MASK)
> + mask)

Can you make this a static inline ?

> +	if (rc) {
> +		goto err;
> +	}

Don't need these braces.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
