Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9UGOdWt013808
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 11:24:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9UGOLC7016722
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 16:24:21 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
	by jazzswing.ncsc.mil  with ESMTP id h9UGOLuw016719
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 16:24:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Diamond Rio 500 and other device nodes
Date: Fri, 31 Oct 2003 03:23:46 +1100
Cc: Diyab <diyab@diyab.net>, SE Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
References: <200310300227.27364.russell@coker.com.au> <200310310133.36055.russell@coker.com.au> <1067529776.30233.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1067529776.30233.54.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310310323.46525.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 31 Oct 2003 03:02, Stephen Smalley wrote:
> On Thu, 2003-10-30 at 09:33, Russell Coker wrote:
> > However there is a more important issue, we can't allow anyone other than
> > an administrator to mount a ext3 file system from a floppy disk or other
> > removable media.  If we do then it would be trivial to create a file
> > system with a file of type newrole_exec_t and take over the system.
> >
> > Steve, any ideas on how to solve this?
>
> Just to clarify, subverting newrole isn't fatal to security, as newrole
> can only change to roles for which you are authorized in the policy, and
> that is enforced by the kernel.  newrole is _not_ like su.

True.

However currently newrole has permissions to read /etc/shadow...

I can probably change this now as with the latest PAM changes newrole should 
only need auth_chkpwd not auth.

> To answer your question, at the suggestion of James Morris, we
> overloaded the nosuid mount option back in July to also prohibit domain
> transitions on programs in the filesystem.  Hence, if you mount with
> nosuid, it won't matter whether any programs on the filesystem are
> labeled with an entrypoint type.

Great.  This just leaves the issue of symlink race-condition attacks to try 
and trick sysadm_t into running a file that you label as bin_t, so I guess 
that noexec is needed for full protection.  But the modified nosuid should 
cover 99% of the problems.

> However, that isn't a full solution to the general problem, as you
> really want to be able to constrain the set of security contexts that
> can exist on files in a given filesystem.  Likely requires changes to
> mount(8) as well as the kernel and new mount options to support such
> functionality.  Simplest implementation is to just allow a single
> context to be applied to an entire filesystem via a mount option,
> similar to the existing uid= and gid= options.

This would solve some of the issues we discussed recently regarding /boot...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
