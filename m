Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9UG3AWt013651
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 11:03:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9UG2pC7014873
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 16:02:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9UG2puw014870
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 16:02:51 GMT
Subject: Re: Diamond Rio 500 and other device nodes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Diyab <diyab@diyab.net>, SE Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <200310310133.36055.russell@coker.com.au>
References: <200310300227.27364.russell@coker.com.au>
	 <3FA08C65.2020309@diyab.net>  <200310310133.36055.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1067529776.30233.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Oct 2003 11:02:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-30 at 09:33, Russell Coker wrote:
> However there is a more important issue, we can't allow anyone other than an 
> administrator to mount a ext3 file system from a floppy disk or other 
> removable media.  If we do then it would be trivial to create a file system 
> with a file of type newrole_exec_t and take over the system.
> 
> Steve, any ideas on how to solve this?

Just to clarify, subverting newrole isn't fatal to security, as newrole
can only change to roles for which you are authorized in the policy, and
that is enforced by the kernel.  newrole is _not_ like su.

To answer your question, at the suggestion of James Morris, we
overloaded the nosuid mount option back in July to also prohibit domain
transitions on programs in the filesystem.  Hence, if you mount with
nosuid, it won't matter whether any programs on the filesystem are
labeled with an entrypoint type.

However, that isn't a full solution to the general problem, as you
really want to be able to constrain the set of security contexts that
can exist on files in a given filesystem.  Likely requires changes to
mount(8) as well as the kernel and new mount options to support such
functionality.  Simplest implementation is to just allow a single
context to be applied to an entire filesystem via a mount option,
similar to the existing uid= and gid= options.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
