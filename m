Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T9tUrT029283
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 05:55:30 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T9tSis027058
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 09:55:29 GMT
Date: Sun, 29 Aug 2004 11:06:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: fedora-selinux-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>,
   Tom London <selinux@comcast.net>
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
Message-ID: <20040829100641.GG7610@lkcl.net>
References: <4130CF1B.3090909@comcast.net> <200408291737.17497.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408291737.17497.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

btw i didn't see an acknowledgement from the person who sent the
last udev patch (dan was it you?)

the use of the "mode" argument it is clear has not been used,
to call i think it was matchpathcon.

instead, because i had three near-identical code portions all
of which had different S_IFXXX thingies, dan-i-think-it-was
moved the near-identical code into a function with a "mode"
argument...

... and forgot to use the "mode" argument such that matchpathcon
is called with S_IFDIR.

given that i haven't seen an acknowledgement of this issue
either in my inbox or on the mailing lists (which i am checking
manually) i thought it best to hassle people until i know it's
been spotted.

this is IMPORTANT because it will impact the contexts on
inodes and stuff created in /dev: the "optimising" argument
"mode" passed to matchpathcon and setfscreatecon, if wrong,
results in relevant (and correct!) file_context entries being
skipped!

l.

On Sun, Aug 29, 2004 at 05:37:17PM +1000, Russell Coker wrote:

> On Sun, 29 Aug 2004 04:29, Tom London <selinux@comcast.net> wrote:
> > Newest Rawhide updates (including udev-030-10, mkinitrd-4.1.8-1,
> > kernel-2.6.8-1.532, and selinux-policy-strict-1.17.5-2)
> > now boots in strict/enforcing.
> 
> I've attached a diff against the CVS policy as well as the .te and .fc files 
> for udev changes which fix this and address some other issues as well.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
