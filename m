Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA29551
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 09:43:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA28534
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:42:47 GMT
Received: from mail.thesportsregister.com (mail.thesportsregister.com [208.53.250.138])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA28530
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 14:42:46 GMT
Date: Wed, 10 Jan 2001 09:47:11 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: William Sloan <wsloan@occamnetworks.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Embedded SE Linux
In-Reply-To: <3A5C118F.36583E35@occamnetworks.com>
Message-ID: <Pine.LNX.4.21.0101100941190.5905-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Tue, 9 Jan 2001, William Sloan wrote:

> Stephen Smalley wrote:
> 
> > > Are there any plans to create an embedded se linux
> > > kernel ?
> >
> > There are currently no plans to create an embedded SELinux kernel.
> 
> Is there anything in SELinux that would prevent it from being used in an embedded
> kernel??

(snip)

Logically, there can't be. I'm guessing that what was meant is that
SELinux isn't going to have any specific patches which are for an
embedded environment.

However, since no such patches are required (except maybe the real-time &
PPS patches), there is no distinction in the Linux world between an
embedded and a non-embedded kernel. That's simply where you happen to be
running it.

Of course, if there's a start-up message box which asks the user "are you
running this as an embedded OS", there might be a problem. :)

Jonathan Day



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
