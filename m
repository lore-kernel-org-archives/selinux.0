Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA22327
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 03:22:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA04532
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 07:21:31 GMT
Received: from mail.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id HAA04528
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 07:21:30 GMT
Date: Tue, 28 Aug 2001 09:25:32 +0200
From: Tom <tom@lemuria.org>
To: james@spunkysoftware.com
Cc: selinux@tycho.nsa.gov
Subject: Re: No RAM swapout to disk for "sandbox" run programs
Message-ID: <20010828092532.A10338@lemuria.org>
References: <005201c12f50$c8891240$b9fe3c3f@spunky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <005201c12f50$c8891240$b9fe3c3f@spunky>; from james@spunkysoftware.com on Tue, Aug 28, 2001 at 09:34:10AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 28, 2001 at 09:34:10AM +1000, james@spunkysoftware.com wrote:
> I have written Linus Torvalds talking about a range of PIDs, or a new field
> in the task_struct, which would indicate to the mm in the kernel that
> swapping this process' address space out to disk was forbidden.

this strikes me as redundant because such a mechanism already exists.

> programs, since PGP on WinNT at least was already doing it. I'm not sure how
> GnuPG handles this at the moment.

GPG will use existing system calls to achieve exactly this effect. I
don't know the details by heart, but I did once. grab the gpg source
and take a look around.


> Also, I am wondering where I can get software that will allow me to look at
> arbitrary memory ranges, the purpose being to look at "deleted" files on
> Windows and Linux. Anybody know of any such software? Is there a kernel
> module that allows this?

/proc/mem is your friend. :)



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
