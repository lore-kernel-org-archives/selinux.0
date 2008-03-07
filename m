Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Christoph Hellwig <hch@lst.de>, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <624405.64789.qm@web36607.mail.mud.yahoo.com>
References: <624405.64789.qm@web36607.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 12:37:30 -0500
Message-Id: <1204911451.14520.292.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For some odd reason I can't quite parse the first two parts of your
email but to answer your question about it being an NFS only hook. As of
right now the only user is going to be NFS however any remote filesystem
(labeled CIFS anyone?) will potentially have this problem. Also even
though we don't have one today if there ever were an LSM that used
multiple xattrs for their security attributes this is a useful interface
to them. So there are many uses for this hook but currently the only one
is NFS.

Dave

On Fri, 2008-03-07 at 09:11 -0800, Casey Schaufler wrote:
> --- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:
> 
> > Yea, I didn't get to read the rest of the emails before I responded to
> > this. In the lastest version it is two hooks. inode_notifysecctx and
> > inode_setsecctx which set incore and both respectivly.
> 
> So what is the desired behavior of these two calls in the case
> where on-disk and inode secctx are in lockstep? Does "notify"
> imply "set" in this case?
> 
> What about the case where there is no "disk", as is the case
> for virtual filesystems? Would "set" imply "notify" in this case?
> 
> I think that if the answer to these questions is "it will never
> come up because it's only for NFS" what you have is an NFS
> specific interface in the LSM. That may be OK, but it ain't pretty.
> On the other hand, NFS is sufficiently important that a little
> ugly may be a price worth paying.
>  
> > Dave
> > 
> > 
> > On Fri, 2008-03-07 at 11:05 +0100, Christoph Hellwig wrote:
> > > On Thu, Mar 06, 2008 at 11:47:06AM -0500, Dave Quigley wrote:
> > > > Will do. I have to release a new patch set with the hook changed to take
> > > > a bool instead of a flag so you should see this updated sometime later
> > > > today.
> > > 
> > > I think it really should be a separate hook for the two different
> > > use-cases as suggested by Stephen.
> > 
> > 
> > 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
