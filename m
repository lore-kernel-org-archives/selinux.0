Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
	LSM security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Christoph Hellwig <hch@lst.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1204906016.14520.268.camel@moss-terrapins.epoch.ncsc.mil>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306123013.GB4648@lst.de>
	 <1204811422.1397.205.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306135444.GA5216@infradead.org>
	 <1204812304.1397.213.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306140713.GA20087@infradead.org>
	 <Xine.LNX.4.64.0803070124160.2139@us.intercode.com.au>
	 <1204814886.1397.244.camel@moss-spartans.epoch.ncsc.mil>
	 <1204823638.14520.202.camel@moss-terrapins.epoch.ncsc.mil>
	 <20080307100353.GA16831@lst.de>
	 <1204906016.14520.268.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 16:23:02 -0500
Message-Id: <1204924982.14520.323.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually I think I might have a solution to this. The inode structure
has a list_head of all dentries that reference it. On CIFS (correct me
if I am wrong) wouldn't this list consist of only one entry, or would
there be more in the event that the same CIFS share is mounted in
different places? Even if there might be more than one I don't think
that would be an issue since we don't have a vfsmount structure so we
can't effectively tell with a dentry alone where in the tree the share
is mounted (and it shouldn't matter anyway since it seems the operation
is full_path based on the share). Anyone have any comments on this
approach? 

Dave 


On Fri, 2008-03-07 at 11:06 -0500, Dave Quigley wrote:
> So I have converted all the xattr internals over to an inode from a
> dentry but there is one issue with that. To set EAs on CIFS they need a
> full path for the file. I don't think we can reconcile using inodes in
> the vfs operation with CIFS needing a path. If you have a suggestion on
> how to handle this I'm more than willing to listen. Everything else
> however seems to be a trivial change.
> 
> Dave
> 
> On Fri, 2008-03-07 at 11:03 +0100, Christoph Hellwig wrote:
> > On Thu, Mar 06, 2008 at 12:13:58PM -0500, Dave Quigley wrote:
> > > So are we keeping the dentry parameter for these calls, or am I changing
> > > them over to an inode. If it is going to use an inode this means I need
> > > to change the parameters for the xattr code. Is there a reason why the
> > > xattr code takes dentries instead of an inode? 
> > 
> > Ah, that's the reason why you use dentries.    Either keep the dentry
> > in the call that does the xattr modification for now and document that
> > why you're doing it, or if you feel eager fix up the xattr interface.
> > 
> > In fact the new fine-grained xattr interface already only passed inodes
> > which is what the inode operations should have been doing aswell -
> > xattrs are a concept tied to the inode and not in any way to a
> > hiearchical pathname component.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
