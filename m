Date: Thu, 8 May 2008 10:08:09 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH v5] selinux:  support deferred mapping of contexts
In-Reply-To: <1210180498.6434.94.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805081007310.19912@us.intercode.com.au>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
 <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805072342570.15234@us.intercode.com.au>
 <1210173123.6434.78.camel@moss-spartans.epoch.ncsc.mil>
 <1210179800.6434.90.camel@moss-spartans.epoch.ncsc.mil>
 <1210180498.6434.94.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 May 2008, Stephen Smalley wrote:

> > This version of the patch solves the problem for fscreate by introducing support for obtaining
> > the raw context value for use by selinux_inode_init_security().  The example sequence above
> > has been updated and tested to confirm correct operation for both setxattr() and fscreate usage
> > by exercising both chcon and mkdir -Z.  I believe that this patch is now ready for inclusion
> > in -mm and Fedora rawhide kernels for F10.  If we want to add support for other aspects like
> > including raw context values in audit messages, conditionally returning them via getxattr for
> > privileged processes, etc. I think we'll do it as separate follow-on patches.

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
