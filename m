Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA22897
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 07:40:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA11666
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 11:39:11 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA11662
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2001 11:39:10 GMT
Date: Tue, 28 Aug 2001 07:40:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: james@spunkysoftware.com
cc: selinux@tycho.nsa.gov
Subject: Re: No RAM swapout to disk for "sandbox" run programs
In-Reply-To: <005201c12f50$c8891240$b9fe3c3f@spunky>
Message-ID: <Pine.SOL.3.95.1010828073947.14347B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 28 Aug 2001 james@spunkysoftware.com wrote:

> PGP uses, or did use, a (sloppy?) memory driver which prevented process
> address space active in RAM from being swapped out to disk.
> 
> I have written Linus Torvalds talking about a range of PIDs, or a new field
> in the task_struct, which would indicate to the mm in the kernel that
> swapping this process' address space out to disk was forbidden.

This seems a bit off-topic for this mailing list.  Anyway, why can't you
use the mlock system call?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
