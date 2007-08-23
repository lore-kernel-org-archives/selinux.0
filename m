Date: Thu, 23 Aug 2007 07:46:52 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com
Subject: Re: [patch] Tuning avtab to reduce memory usage
In-Reply-To: <20070823094904.1AB9.YNAKAM@hitachisoft.jp>
Message-ID: <Xine.LNX.4.64.0708230745220.27506@us.intercode.com.au>
References: <20070822115145.E7D3.YNAKAM@hitachisoft.jp>
 <Xine.LNX.4.64.0708220642110.21844@us.intercode.com.au>
 <20070823094904.1AB9.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Aug 2007, Yuichi Nakamura wrote:

> +static inline int avtab_hash(struct avtab_key *keyp, u16 mask)
> +{
> +	return ((keyp->target_class + (keyp->target_type << 2) + \
> +		 (keyp->source_type << 9)) & mask);
> +}

As you'll need to resubmit the patch, please remove the \ (I had fixed it 
up in my local tree).

Please also provide a short description of the patch (one paragraph at the 
most), to go in the git log.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
