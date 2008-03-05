Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Chris Wright <chrisw@sous-sol.org>, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <515206.47792.qm@web36604.mail.mud.yahoo.com>
References: <515206.47792.qm@web36604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 08:41:20 -0500
Message-Id: <1204724480.14520.163.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-04 at 17:08 -0800, Casey Schaufler wrote:
> ----- Original Message ----
> > From: Dave Quigley <dpquigl@tycho.nsa.gov>
> > To: Chris Wright <chrisw@sous-sol.org>
> > Cc: sds@tycho.nsa.gov; jmorris@namei.org; casey@schaufler-ca.com; linux-security-module@vger.kernel.org; selinux@tycho.nsa.gov
> > Sent: Tuesday, March 4, 2008 3:07:06 PM
> > Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM security context information.
> > 
> > 
> > On Tue, 2008-03-04 at 15:26 -0800, Chris Wright wrote:
> > > * David P. Quigley (dpquigl@tycho.nsa.gov) wrote:
> > > > +/* Flags for setcontext */
> > > > +#define LSM_SETCORE 1
> > > > +#define LSM_SETDISK 2
> > > > +
> > > > #ifdef CONFIG_SECURITY
> > > > 
> > > > /**
> > > > @@ -1395,6 +1399,9 @@ struct security_operations {
> > > > int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
> > > > void (*release_secctx)(char *secdata, u32 seclen);
> > > > 
> > > > + int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int 
> > flags);
> > > > + int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> > > 
> > > Is this meant to address Casey's argument about the mac label hook name?
> > > Also, why have you made the distinction of in-core vs. on disk in the
> > > interface? As I mentioned, I think just needs a little better
> > > description of why.
> > > 
> > > thanks,
> > > -chris
> > 
> > The reason for the differentiation is that NFS inodes don't need their
> > on-disk representation set. Normally this would be taken care of with an
> > inode_getsecurity call but as you noted Casey objected to a hook to get
> > the suffix name.
> 
> No, I objected to a hook that is specific to MAC LSMs that
> store a single label as an xattr. I objected to it because it
> was being used to support one file system on one LSM and
> suggested that for that reason it should be an interface
> private to either the specific LSM or the specific filesystem.
> 
> > Also he did have a point in that the context may have
> > several components to it that could have multiple suffixes. So I need a
> > hook that allows us to set possibly multiple internal security values
> > based on a security context and without using an xattr name.
> 
> You could use Ahmed's hook to get the secid of a file and then
> use secid_to_secctx to get the context. That's what audit has to
> do.
> 

Historically though audit was using inode_getsecurity with the suffix.
The reason for the switch to secids was that they didn't want to
overhead of retrieving and storing the context unless they needed it.
With the NFS case we always want to context so we are going to be going
through double calls here all the time which is silly. A robust set of
interfaces should have the ability to get/set contexts get/set secids
and convert between them. As of right now the context half of that is
missing.

Dave



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
