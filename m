Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h92EZjsJ003339
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 10:35:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h92EZi7d028039
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 14:35:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h92EZiRn028036 for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 14:35:44 GMT
Subject: Re: assertions in kernel
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.44.0310020733290.16953-100000@thoron.boston.redhat.com>
References: 
	 <Pine.LNX.4.44.0310020733290.16953-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1065105309.31707.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Oct 2003 10:35:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-02 at 07:43, James Morris wrote:
> On Wed, 1 Oct 2003, James Morris wrote:
> 
> > I don't think relabeling files from kernelspace is a good idea.  A better 
> > approach may be to use an implicit label if a kernel assertion fails.
> 
> Just to clarify following an off-list enquiry, what I mean by an implicit
> label is that the kernel returns 'unlabeled_t' following an assertion
> failure for a file, but does not change the disk structure.  This should
> be transparent to the user APIs.

The SELinux kernel module can internally mark the inode with the
unlabeled SID and use that for its own access controls, but it cannot
"filter" getxattr requests in this manner.  The LSM hooks only support
access control, not data filtering.  Hence, if you truly want the file
to appear to userspace as if it had the unlabeled context, then the
SELinux module would need to invoke the inode's setxattr method with
that context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
