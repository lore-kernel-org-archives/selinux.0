Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23663
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2001 09:28:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA09261
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2001 13:28:19 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA09257
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2001 13:28:18 GMT
Date: Tue, 12 Jun 2001 09:27:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Jonathan Day <jd9812@my-deja.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Query on next release
In-Reply-To: <200106121205.FAA31180@mail6.bigmailbox.com>
Message-ID: <Pine.SOL.3.95.1010612090928.1611F-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 12 Jun 2001, Jonathan Day wrote:

>Some time previously, it was mentioned that there was a snapshot of
>SELinux expected for 2.4.5. Also mentioned was that development on the
>initial SELinux branch had been essentially suspended, and that work was
>progressing on what (to me) sounded like an "SELinux II".

Yes, this is essentially accurate.  Linus gave some guidance on the
kind of security framework he would be willing to consider for 
integration into the mainstream kernel.  In its current form, SELinux 
doesn't correspond to that framework.  We're working with the LSM effort
(lsm.immunix.org) in the development of the new framework and we are
developing a SELinux module for that framework.  We did plan on continuing
to upgrade the original SELinux prototype for newer versions of the
Linux kernel, but it isn't clear how high a priority that should be.

>Is there any indication yet as to when the first development snapshot of
>this "next generation" of SELinux is likely to hit the website? I'm
>hesitent to try and do too much more with the current SELinux, if the
>core is likely to radically change any time soon.

That probably depends on how mature and useable you would want that
snapshot to be.  The LSM framework is still undergoing significant
changes, and it is quite incomplete.  However, I wouldn't let that
discourage you from using SELinux today.  The core functionality
of SELinux isn't really changing.  

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
