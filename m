Date: Tue, 4 Mar 2008 15:26:08 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
        casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
Message-ID: <20080304232608.GD4416@sequoia.sous-sol.org>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* David P. Quigley (dpquigl@tycho.nsa.gov) wrote:
> +/* Flags for setcontext */
> +#define LSM_SETCORE	1
> +#define LSM_SETDISK	2
> +
>  #ifdef CONFIG_SECURITY
>  
>  /**
> @@ -1395,6 +1399,9 @@ struct security_operations {
>  	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
>  	void (*release_secctx)(char *secdata, u32 seclen);
>  
> +	int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int flags);
> +	int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);

Is this meant to address Casey's argument about the mac label hook name?
Also, why have you made the distinction of in-core vs. on disk in the
interface?  As I mentioned, I think just needs a little better
description of why.

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
