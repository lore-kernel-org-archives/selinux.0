Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91GU1sJ026721
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 12:30:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h91GU07d014778
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 16:30:00 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id h91GTxRn014775 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 16:29:59 GMT
Date: Wed, 1 Oct 2003 12:29:01 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: assertions in kernel
In-Reply-To: <200310012233.24193.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0310011227210.13429-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003, Russell Coker wrote:

> I think that this approach does not work.  I think that to maintain sane state 
> of the file system labeling we need to have some rules in the kernel, if 
> those rules are violated (either on first access after boot or when a new 
> policy load changes the rules) then the filesystem object gets relabeled to 
> unlabeled_t.  Then setfiles only needs relabelfrom access to unlabeled_t to 
> be able to fix all manner of file system stuff-ups.

I don't think relabeling files from kernelspace is a good idea.  A better 
approach may be to use an implicit label if a kernel assertion fails.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
