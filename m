Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA20315
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 04:59:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA12703
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 08:57:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id IAA12699 for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 08:57:40 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>
Subject: Re: grsec
Date: Sun, 16 Jun 2002 10:58:39 +0200
References: <000001c214e8$a7672c40$0a01a8c0@ed>
In-Reply-To: <000001c214e8$a7672c40$0a01a8c0@ed>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020616085839.A75D4129F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 16 Jun 2002 05:48, you wrote:
> I noticed that you have done some work with grsecurity.  Was wondering
> what you thought about it and if you could compare it with selinux and
> tell me your opinions on the two.

If you want a quick and easy security improvement then grsec is a good 
option.  Simply rebuild your kernel with the patch and everything will work 
as before.  It's got a simple MAC implementation which will solve some basic 
requirements and is easy to setup.  Also it's got a number of other patches 
for security which aren't in LSM such as the patches for randomising various 
numbers used by the network stack.

But the real feature of grsec is the chroot environment you can't escape 
from.  A chroot in grsec is like a different domain in SE Linux, programs in 
different chroot's can't affect each other or the rest of the system.  I plan 
to write a policy file for SE Linux to give the same result as this is a good 
feature!

Grsec lacks domain-type enforcement, and the identity and role tracking, so 
it doesn't try to do the things that SE Linux does.  So for controlling 
access to files, processes, etc it's not as powerful as SE.  But it does many 
things that SE doesn't do.

I'd prefer to have both, maybe when LSM becomes part of the standard kernel 
I'll be able to have SE Linux plus grsec for it's network operations.

Here are some of the things from grsec I'd like to see in LSM:
fork() rate limiting, various network limiting and randomizing options, 
memory page protection on IA32, restricting mprotect(), random PIDs, random 
mmap(), and secure keymap loading.

I'm replying publically because this is something that will interest many 
people.  Also if someone decides that SE Linux is too difficult for them (it 
is too difficult for most people) then it's best that they choose an easier 
option for improving security such as grsec, openwall, or others rather than 
just skipping kernel options for improving security entirely.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
