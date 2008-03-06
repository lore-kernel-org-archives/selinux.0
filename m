Subject: Re: [PATCH 2/2] LSM/SELinux: inode_{get,set}secctx hooks to access
	LSM security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>, casey@schaufler-ca.com,
        chrisw@sous-sol.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1204814886.1397.244.camel@moss-spartans.epoch.ncsc.mil>
References: <1204743288-3461-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1204743288-3461-3-git-send-email-dpquigl@tycho.nsa.gov>
	 <20080306123013.GB4648@lst.de>
	 <1204811422.1397.205.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306135444.GA5216@infradead.org>
	 <1204812304.1397.213.camel@moss-spartans.epoch.ncsc.mil>
	 <20080306140713.GA20087@infradead.org>
	 <Xine.LNX.4.64.0803070124160.2139@us.intercode.com.au>
	 <1204814886.1397.244.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 12:13:58 -0500
Message-Id: <1204823638.14520.202.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-03-06 at 09:48 -0500, Stephen Smalley wrote:
> On Fri, 2008-03-07 at 01:25 +1100, James Morris wrote:
> > On Thu, 6 Mar 2008, Christoph Hellwig wrote:
> > 
> > > Ok, this makes a lot more sense.  These defintively should be different
> > > hooks in that case, and no matter what name they have (no good ideas
> > > from me either currently)
> > 
> > Perhaps setsecctx and storesecctx ? 
> 
> Or possibly notifysecctx (notify security module of a secctx value for
> the inode) vs. setsecctx (set this sectx on this inode, including both
> in-core update and invoking the __vfs_setxattr_noperm helper).
> 

So are we keeping the dentry parameter for these calls, or am I changing
them over to an inode. If it is going to use an inode this means I need
to change the parameters for the xattr code. Is there a reason why the
xattr code takes dentries instead of an inode? 

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
