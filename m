Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5NHtlHL019552
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 13:55:47 -0400
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
In-Reply-To: <20090620013216.GA4435@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 13:55:51 -0400
Message-Id: <1245779751.27538.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-06-19 at 20:32 -0500, Serge E. Hallyn wrote:
> diff --git a/ipc/checkpoint_msg.c b/ipc/checkpoint_msg.c
> index 51385b0..ca55339 100644
> --- a/ipc/checkpoint_msg.c
> +++ b/ipc/checkpoint_msg.c
<snip>
> @@ -175,11 +183,26 @@ static int load_ipc_msg_hdr(struct ckpt_ctx *ctx,
>  			    struct msg_queue *msq)
>  {
>  	int ret = 0;
> +	int secid = 0;
>  
>  	ret = restore_load_ipc_perms(&h->perms, &msq->q_perm);
>  	if (ret < 0)
>  		return ret;
>  
> +	if (h->perms.secref) {
> +		struct sec_store *s;
> +		s = ckpt_obj_fetch(ctx, h->perms.secref, CKPT_OBJ_SECURITY);
> +		if (IS_ERR(s))
> +			return PTR_ERR(s);
> +		secid = s->secid;
> +	}
> +	ret = security_msg_queue_alloc(msq);
> +	if (ret)
> +		return ret;
> +	ret = security_msg_queue_restore(msq, secid);
> +	if (ret < 0)
> +		return ret;

I don't think you want to call security_msg_queue_alloc() here, as that
both allocates the security struct and performs the create check.  So I
would just call the _restore() function, and let it internally call
ipc_alloc_security() to allocate the struct but then apply its own
distinct restore check.  Likewise for the rest of them.

Also, where do we get to veto attempts to checkpoint the task in the
first place?  If ptrace, I think we'd want it treated as a
PTRACE_MODE_ATTACH (also used for /proc/pid/mem) rather than just
PTRACE_MODE_READ (reading other /proc/pid info).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
