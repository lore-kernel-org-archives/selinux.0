Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98CqOWt018628
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:52:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h98CqL0p021018
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:52:21 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h98CqKr7021004
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:52:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov, walters@verbum.org
Subject: Re: Policy patch: /dev/input devices
Date: Wed, 8 Oct 2003 22:52:13 +1000
References: <20031008140226.A12565@lemuria.org>
In-Reply-To: <20031008140226.A12565@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310082252.13122.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 22:02, Tom wrote:
> Attached is a small patch to the Debian/unstable default policy, that
> may be interesting to other distros as well.
>
> Problem: /dev/event* have the generic device_t type. However, they are
> required for some devices that are not happy with /dev/input/mouse* (my
> notebook touchpad is one example).

What is the device for your touchpad?  Is it used by the same programs that 
use mouse devices?

> Solution: I've defined a new input_device_t for anything in /dev/input
> and modified the appropriate policy files to grant access to these.

Why have two different types for mouse devices?  Why have /dev/input/mouse* 
labeled differently to /dev/psaux?

> While this does lump the /dev/input/[mouse*|mice] devices into it as
> well, I don't think there is much problem with that. I don't see what's
> to gain in, say, seperating mouse and keyboard devices, and besides,
> /dev/input/event* munge them as well.

What about /dev/input/ttyACM*?  Are they in the same category?  If so why?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
