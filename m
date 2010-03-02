Subject: Re: denials with filesystem associate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20100302111231.GK3990@myhost.felk.cvut.cz>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
	 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
	 <20100301165602.GH3990@myhost.felk.cvut.cz>
	 <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20100302111231.GK3990@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Tue, 02 Mar 2010 08:40:21 -0500
Message-Id: <1267537221.10026.59.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-03-02 at 12:12 +0100, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > On file creation, there is an associate check between the security
> > context of the file and the security context of the containing
> > filesystem.  
> 
> OK, I think I now understand this permission. But it seems that in a
> normal (reference) policy all files are permitted on all filesystems.
> Are there cases when they're not?

I think the refpolicy allows most associations, although it wouldn't
need to allow types that should only appear on filesystems that support
per-file security labeling to appear on filesystems that do not support
security labeling.  The original concept was that we might bind specific
types and/or specific levels to specific filesystems.  But that requires
a custom configuration for a particular system.  Note that in the
original SELinux implementation, we had a way to store the filesystem
security context in the filesystem (as part of the persistent label
mapping), before we transitioned to using xattrs.  Today the only way to
assign a particular filesystem security context to a particular
filesystem is to use the fscontext= mount option; otherwise you'll just
get the default for that filesystem type from the policy.

> And secondly, it seems that every file type has an associate permission
> on itself, ie.
> 
>    allow etc_runtime_t etc_runtime_t : filesystem associate ; 
> 
> Why is this so?

Likely to allow all possible cases of context= mounts up front.

FWIW, SELinux-specific mount options include:
1) context= Assign the specified security context to the filesystem and
all files within it, ignoring xattrs even if they are present/supported.
2) fscontext= Assign the specified security context to the filesystem
rather than the policy-defined default for that filesystem type; does
not affect the mechanism for determining the context of files within the
filesystem.
3) defcontext= Assign the specified security context to files in the
filesystem that lack an xattr value rather than the policy-defined
default.
4) rootcontext= Assign the specified security context to the root
directory of the filesystem.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
