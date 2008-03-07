Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be
	called from the SELinux hook for inode_setsecctx.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Christoph Hellwig <hch@lst.de>
Cc: casey@schaufler-ca.com, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20080307100538.GB16831@lst.de>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-2-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306122703.GA4648@lst.de>
	 <1204822026.14520.193.camel@moss-terrapins.epoch.ncsc.mil>
	 <20080307100538.GB16831@lst.de>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 11:10:08 -0500
Message-Id: <1204906208.14520.270.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yea, I didn't get to read the rest of the emails before I responded to
this. In the lastest version it is two hooks. inode_notifysecctx and
inode_setsecctx which set incore and both respectivly.

Dave


On Fri, 2008-03-07 at 11:05 +0100, Christoph Hellwig wrote:
> On Thu, Mar 06, 2008 at 11:47:06AM -0500, Dave Quigley wrote:
> > Will do. I have to release a new patch set with the hook changed to take
> > a bool instead of a flag so you should see this updated sometime later
> > today.
> 
> I think it really should be a separate hook for the two different
> use-cases as suggested by Stephen.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
