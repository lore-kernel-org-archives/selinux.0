Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91DwgsJ025170
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 09:58:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h91Dwe7d005455
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:58:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h91DwdRn005449 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:58:40 GMT
Subject: Re: assertions in kernel
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310012233.24193.russell@coker.com.au>
References: <200310012233.24193.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065016709.350.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Oct 2003 09:58:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-01 at 08:33, Russell Coker wrote:
> I think that this approach does not work.  I think that to maintain sane state 
> of the file system labeling we need to have some rules in the kernel, if 
> those rules are violated (either on first access after boot or when a new 
> policy load changes the rules) then the filesystem object gets relabeled to 
> unlabeled_t.  Then setfiles only needs relabelfrom access to unlabeled_t to 
> be able to fix all manner of file system stuff-ups.
> 
> I am aware that what I am suggesting involves a moderate amount of kernel 
> coding (which I am not capable of doing).  However there has been some recent 
> discussion for a number of new features in regard to kernel management of 
> policy, so I presume that the feature list is up for discussion.

The existing assertion checking support is likely to migrate into the
kernel in the future to allow a base set of assertions to be applied to
subsequent attempts to load policy modules.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
