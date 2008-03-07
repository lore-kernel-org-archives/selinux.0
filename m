Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27JwcMK010801
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 14:58:38 -0500
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m27JwaCe029447
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 19:58:36 GMT
Date: Fri, 7 Mar 2008 09:11:55 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be called from the SELinux hook for inode_setsecctx.
To: Dave Quigley <dpquigl@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>
Cc: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1204906208.14520.270.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <624405.64789.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:

> Yea, I didn't get to read the rest of the emails before I responded to
> this. In the lastest version it is two hooks. inode_notifysecctx and
> inode_setsecctx which set incore and both respectivly.

So what is the desired behavior of these two calls in the case
where on-disk and inode secctx are in lockstep? Does "notify"
imply "set" in this case?

What about the case where there is no "disk", as is the case
for virtual filesystems? Would "set" imply "notify" in this case?

I think that if the answer to these questions is "it will never
come up because it's only for NFS" what you have is an NFS
specific interface in the LSM. That may be OK, but it ain't pretty.
On the other hand, NFS is sufficiently important that a little
ugly may be a price worth paying.
 
> Dave
> 
> 
> On Fri, 2008-03-07 at 11:05 +0100, Christoph Hellwig wrote:
> > On Thu, Mar 06, 2008 at 11:47:06AM -0500, Dave Quigley wrote:
> > > Will do. I have to release a new patch set with the hook changed to take
> > > a bool instead of a flag so you should see this updated sometime later
> > > today.
> > 
> > I think it really should be a separate hook for the two different
> > use-cases as suggested by Stephen.
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
