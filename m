Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: sds@tycho.nsa.gov, chrisw@sous-sol.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.64.0803051045330.22374@us.intercode.com.au>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <Xine.LNX.4.64.0803051045330.22374@us.intercode.com.au>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 18:26:02 -0500
Message-Id: <1204673162.14520.135.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That sounds like a reasonable request.

Dave

On Wed, 2008-03-05 at 10:48 +1100, James Morris wrote:
> On Tue, 4 Mar 2008, David P. Quigley wrote:
> 
> >  	void (*release_secctx)(char *secdata, u32 seclen);
> >  
> > +	int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int flags);
> > +	int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> 
> To remain consistent with the rest of the API, how about getsecctx and 
> setsecctx ?
> 
> 
> - James


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
