Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i062a5Rb006871
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2004 21:36:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i062a3iV012634
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 02:36:03 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i062Zp06012602 for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2004 02:36:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ignacio Tripodi <ignaciot@unt.edu>, selinux@tycho.nsa.gov
Subject: Re: UML support
Date: Tue, 6 Jan 2004 13:34:25 +1100
References: <F3EFFBE2-3F93-11D8-85C4-000393013D1A@unt.edu>
In-Reply-To: <F3EFFBE2-3F93-11D8-85C4-000393013D1A@unt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401061334.25315.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 6 Jan 2004 02:29, Ignacio Tripodi <ignaciot@unt.edu> wrote:
> Has anybody tried using UML (user mode linux) on an SELinux system yet?
> More precisely, I'm asking about the possibility of running a
> non-SELinux or SELinux-enabled environment, depending on who logs in.
> Can you have a virtual block device with a labeled filesystem?

A UML block device is just a mapping of a regular file to a block device 
inside the UML.  It can be used in any way that block devices are used with 
all the usual file system options, this includes SE Linux labeling.

SE Linux requires minor kernel patches to work with UML, I have been 
maintaining such patches on http://www.coker.com.au/uml/ .  I will soon 
release new patches for 2.4.24.

As for SE or non-SE depending on who logs in.  You can have SE Linux UML 
kernels and non-SE UML kernels running at the same machine.  I'm not sure if 
this is what you want though.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
