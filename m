Date: Wed, 5 Mar 2008 10:48:39 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: sds@tycho.nsa.gov, chrisw@sous-sol.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
 security context information.
In-Reply-To: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Xine.LNX.4.64.0803051045330.22374@us.intercode.com.au>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Mar 2008, David P. Quigley wrote:

>  	void (*release_secctx)(char *secdata, u32 seclen);
>  
> +	int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int flags);
> +	int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);

To remain consistent with the rest of the API, how about getsecctx and 
setsecctx ?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
