Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h997VJWt023936
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 03:31:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h997VG0p000907
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 07:31:16 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h997V9r7000899
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2003 07:31:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov, walters@verbum.org
Subject: Re: Policy patch: /dev/input devices
Date: Thu, 9 Oct 2003 17:31:01 +1000
References: <20031008140226.A12565@lemuria.org> <200310082252.13122.russell@coker.com.au> <20031008211316.E14104@lemuria.org>
In-Reply-To: <20031008211316.E14104@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310091731.01304.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Oct 2003 05:13, Tom wrote:
> > Why have two different types for mouse devices?  Why have
> > /dev/input/mouse* labeled differently to /dev/psaux?
>
> That was a good question I fought with myself for a while.
> In the end, I opted for local consistency - this way, all devices in
> /dev/input are labelled identically.
> The other alternative would have been to add a new type for the other
> specific devices (keyboard, joystick, etc.) and one for the generic
> event devices. I didn't want that many types for devices that
> essentially all do the same.
>
> We could, of course, relabel all mouse devices to input_device_t - I
> didn't want to make such a massive change.
>
> > > While this does lump the /dev/input/[mouse*|mice] devices into it as
> > > well, I don't think there is much problem with that. I don't see what's
> > > to gain in, say, seperating mouse and keyboard devices, and besides,
> > > /dev/input/event* munge them as well.
> >
> > What about /dev/input/ttyACM*?  Are they in the same category?  If so
> > why?
>
> I don't think the keyboard input devices are named tty* but I'm not
> sure.

On one of my systems I have some /dev/input/ttyACM* devices and I am not sure 
of how to deal with them.

> Yes, I believe they belong to the same category. My reason is that the
> event* devices already grant a second path to them. In other words: All
> these devices share a backdoor - why label the front doors differently?

This makes sense.  I think that we should also give the same label to
/dev/psaux, there is no reason for a USB mouse to have a different label to a 
PS/2 mouse IMHO.  I'll do that in my tree soon if no-one gives a reason for 
doing otherwise.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
