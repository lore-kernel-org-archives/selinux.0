Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24290
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:49:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA25954
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:48:43 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA25950
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:48:43 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id OAA03015
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:49:08 -0500 (EST)
Date: Tue, 26 Dec 2000 14:49:07 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: Using other Linux distributions 
Message-ID: <Pine.SOL.3.95.1001226144420.29240N-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


One of the SuSE developers sent me an email correcting my prior message
about using other Linux distributions.  I've enclosed the contents of his
note below:

The only real fix is to move selinux to new system call numbers. The LFS system
calls must be either implemented or return -ENOSYS, but any other implementation
causes chaos with any newer glibc. The best is to reserve the system call 
numbers you're going to use by submitting a patch to Linus Torvalds for 2.4.*
that marks them as reserved in the system call table (the "official system call
allocation" is always defined by what is in the current development kernel) 

This breaks the selinux ABI, but it is probably better to break it now than
later when more people use it.

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
