Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21376
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2001 08:26:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA22497
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2001 12:26:35 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id MAA22493
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2001 12:26:35 GMT
Date: Thu, 9 Aug 2001 08:26:06 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jonathan Day <jd9812@my-deja.com>
cc: selinux@tycho.nsa.gov
Subject: Re: SELinux II
In-Reply-To: <200108090125.SAA27066@mail23.bigmailbox.com>
Message-ID: <Pine.SOL.3.95.1010809081153.19489C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 8 Aug 2001, Jonathan Day wrote:

>I've managed to get the Linux security infrastructure into place, in my
>Linux mega-patch. The challange I'm faced with now is to get SELinux II
>merged in.

What exactly have you put into place as a security infrastructure?
And are you talking about the FOLK (http://folk.sourceforge.net) patch?
Please provide context.

>To keep this on-topic, I need to know if SELinux II adds anything further
>to the security infrastructure (and, if so, what! :), and what components
>of SELinux II are stable enough for non-NSAians to play with.
>(Alpha-quality is fine with me. Anything out of "sheer guesswork &
>white-paper" stage is stable, in my books. :)

To date, development on the LSM-based SELinux prototype (or SELinux II, 
if you prefer) has focused on providing the same functionality present
in the original SELinux prototype (i.e. fine-grained and flexible
nondiscretionary access controls) as a loadable kernel module that
uses the LSM hooks rather than our own custom kernel patch.  
Currently, SELinux II seems to be stable enough for release, and 
does provide most of the functionality of the original prototype
(we're still working on the network access controls).  It should
be released soon on the NSA web site.

We are currently working off of the LSM kernel patch
(lsm-2001_08_07 against 2.4.7) from lsm.immunix.org, so you
could investigate integrating that into your FOLK patch if
you want to support SELinux II.   

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
