Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2518jYH006114
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 20:08:45 -0500
Received: from web36604.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2518h79022238
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 01:08:43 GMT
Date: Tue, 4 Mar 2008 17:08:43 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM security context information.
To: Dave Quigley <dpquigl@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>
Cc: sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <515206.47792.qm@web36604.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


----- Original Message ----
> From: Dave Quigley <dpquigl@tycho.nsa.gov>
> To: Chris Wright <chrisw@sous-sol.org>
> Cc: sds@tycho.nsa.gov; jmorris@namei.org; casey@schaufler-ca.com; linux-security-module@vger.kernel.org; selinux@tycho.nsa.gov
> Sent: Tuesday, March 4, 2008 3:07:06 PM
> Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM security context information.
> 
> 
> On Tue, 2008-03-04 at 15:26 -0800, Chris Wright wrote:
> > * David P. Quigley (dpquigl@tycho.nsa.gov) wrote:
> > > +/* Flags for setcontext */
> > > +#define LSM_SETCORE 1
> > > +#define LSM_SETDISK 2
> > > +
> > > #ifdef CONFIG_SECURITY
> > > 
> > > /**
> > > @@ -1395,6 +1399,9 @@ struct security_operations {
> > > int (*secctx_to_secid)(char *secdata, u32 seclen, u32 *secid);
> > > void (*release_secctx)(char *secdata, u32 seclen);
> > > 
> > > + int (*setcontext)(struct dentry *dentry, void *ctx, u32 ctxlen, int 
> flags);
> > > + int (*getcontext)(struct dentry *dentry, void **ctx, u32 *ctxlen);
> > 
> > Is this meant to address Casey's argument about the mac label hook name?
> > Also, why have you made the distinction of in-core vs. on disk in the
> > interface? As I mentioned, I think just needs a little better
> > description of why.
> > 
> > thanks,
> > -chris
> 
> The reason for the differentiation is that NFS inodes don't need their
> on-disk representation set. Normally this would be taken care of with an
> inode_getsecurity call but as you noted Casey objected to a hook to get
> the suffix name.

No, I objected to a hook that is specific to MAC LSMs that
store a single label as an xattr. I objected to it because it
was being used to support one file system on one LSM and
suggested that for that reason it should be an interface
private to either the specific LSM or the specific filesystem.

> Also he did have a point in that the context may have
> several components to it that could have multiple suffixes. So I need a
> hook that allows us to set possibly multiple internal security values
> based on a security context and without using an xattr name.

You could use Ahmed's hook to get the secid of a file and then
use secid_to_secctx to get the context. That's what audit has to
do.


Casey Schaufler
casey@schaufler-ca.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
