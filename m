Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98JIaWt021663
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 15:18:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98JIZ6g011170
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 19:18:35 GMT
Received: from unicorn.lemuria.org (c152019.adsl.hansenet.de [213.39.152.19])
        by jazzband.ncsc.mil  with ESMTP id h98JIYdq011166 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 19:18:35 GMT
Date: Wed, 8 Oct 2003 21:13:20 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov, walters@verbum.org
Subject: Re: Policy patch: /dev/input devices
Message-ID: <20031008211316.E14104@lemuria.org>
References: <20031008140226.A12565@lemuria.org> <200310082252.13122.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310082252.13122.russell@coker.com.au>; from russell@coker.com.au on Wed, Oct 08, 2003 at 10:52:13PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 08, 2003 at 10:52:13PM +1000, Russell Coker wrote:
> > Problem: /dev/event* have the generic device_t type. However, they are
> > required for some devices that are not happy with /dev/input/mouse* (my
> > notebook touchpad is one example).
> 
> What is the device for your touchpad?  Is it used by the same programs that 
> use mouse devices?

Yes. The device X uses to read the touchpad is /dev/input/event0

The event devices are generic - they could be mouse, keyboard,
anything.


> > Solution: I've defined a new input_device_t for anything in /dev/input
> > and modified the appropriate policy files to grant access to these.
> 
> Why have two different types for mouse devices?  Why have /dev/input/mouse* 
> labeled differently to /dev/psaux?

That was a good question I fought with myself for a while.
In the end, I opted for local consistency - this way, all devices in
/dev/input are labelled identically.
The other alternative would have been to add a new type for the other
specific devices (keyboard, joystick, etc.) and one for the generic
event devices. I didn't want that many types for devices that
essentially all do the same.

We could, of course, relabel all mouse devices to input_device_t - I
didn't want to make such a massive change.


> > While this does lump the /dev/input/[mouse*|mice] devices into it as
> > well, I don't think there is much problem with that. I don't see what's
> > to gain in, say, seperating mouse and keyboard devices, and besides,
> > /dev/input/event* munge them as well.
> 
> What about /dev/input/ttyACM*?  Are they in the same category?  If so why?

I don't think the keyboard input devices are named tty* but I'm not
sure.

Yes, I believe they belong to the same category. My reason is that the
event* devices already grant a second path to them. In other words: All
these devices share a backdoor - why label the front doors differently?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
