Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20080304232608.GD4416@sequoia.sous-sol.org>
References: <1204667623-16224-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080304232608.GD4416@sequoia.sous-sol.org>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 18:07:06 -0500
Message-Id: <1204672026.14520.133.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-04 at 15:26 -0800, Chris Wright wrote:
> * David P. Quigley (dpquigl@tycho.nsa.gov) wrote:
> > +/* Flags for setcontext */
> > +#define LSM_SETCORE	1
> > +#define LSM_SETDISK	2
> > +
> >  #ifdef CONFIG_SECURITY
> >  
> >  /**
> > @@ -1395,6 +1399,9 @@ struct security_operations {
> >  	int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
> >  	void (*release_secctx)(char *secdata, u32 seclen);
> >  
> > +	int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int flags);
> > +	int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> 
> Is this meant to address Casey's argument about the mac label hook name?
> Also, why have you made the distinction of in-core vs. on disk in the
> interface?  As I mentioned, I think just needs a little better
> description of why.
> 
> thanks,
> -chris

The reason for the differentiation is that NFS inodes don't need their
on-disk representation set. Normally this would be taken care of with an
inode_getsecurity call but as you noted Casey objected to a hook to get
the suffix name. Also he did have a point in that the context may have
several components to it that could have multiple suffixes. So I need a
hook that allows us to set possibly multiple internal security values
based on a security context and without using an xattr name.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
