Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10901
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 11:03:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA26936
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 15:03:18 GMT
Received: from mail22.bigmailbox.com (mail22.bigmailbox.com [209.132.220.199])
	by jazzband.ncsc.mil  with ESMTP id PAA26932
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 15:03:17 GMT
Date: Fri, 8 Jun 2001 08:03:21 -0700
Message-Id: <200106081503.IAA15302@mail22.bigmailbox.com>
Content-Type: text/plain
Mime-Version: 1.0
From: "Jonathan Day" <jd9812@my-deja.com>
To: selinux@tycho.nsa.gov, zu22@andrew.cmu.edu
Subject: RE: hello?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm sure other people will throw in their 2 cents worth, too, so keep listening.

First, as I understand it, the web archives of the mailing list are updated if and only if (iff, to maths-types) there are other changes made. Thus, when the next selinux patch comes out, the archives will rush forward to that time.

Second, selinux and OpenBSD aim for security in two orthogonal ways. (ie: They don't interact at all.) SELinux aims for security through setting up quantifiable boundaries on resources. Nothing goes in or out, without explicit permission. Thus, if a program is compromised, the impact of that is going to be much smaller than it would be, otherwise.

OpenBSD is an exercise in phenominal auditing. I think they've found one, maybe two, potential security problems in the pasy year. It is also a hotbed of encryption. Their IPSec implementation is extremely good, for example, and OpenSSH is one of the best SSH clones going.

As for which is better, it depends on which track suits your needs the best. Personally, I suspect that when the Stanford Checker is released onto the world, the wholesale auditing of Linux, the various extensions, and every package ever written for it, will become an industry of its own.

The other thing you need to consider is that SELinux, as it stands, isn't designed to work with MOSIX, yet MOSIX seems (from the publicity) to be destined for the kernel. This means that SELinux is going to need some degree of extending and bashing to get it to work with a distributed environment.

I've never tried SELinux with Debian, but it should run just fine. It's not distribution-specific.

Hope this helps



>Date: Thu, 7 Jun 2001 17:47:35 -0400 (EDT)
>From: Zachary Uram <zu22@andrew.cmu.edu>
>To: selinux@tycho.nsa.gov
>SUBJECT
>i am interested in Secure Linux.
>do you have guid that shows how to build/patch your source code
>into an exiting Linux kernel. 
>what is expected completion date for the user and administrative
>guides?
>is this more secure than OpenBSD?
>can i use this in an existing Debian distribution?
>i see no activity in list archives since april,
>is this effort still active?
>i am just beginning to really learn how to program but let me
>know if i can help in any way, i have some experience with code
>documentation and v&v testing.
>
>regards,
>Zach
>
>
>uram@cmu.edu
>"Blessed are those who have not seen and yet have faith." - John 20:29
>
>
>
>
>
>--
>You have received this message because you are subscribed to the selinux list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.



------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
