Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9LGeYXZ009952
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 12:40:34 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9LGeY8L024098
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 16:40:34 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i9LGg6gq013292
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 12:42:06 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i9LGg6Ai013291
	for selinux@tycho.nsa.gov; Thu, 21 Oct 2004 12:42:06 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9L6T0XZ006924
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 02:29:00 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9L6RjDK023290
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2004 06:27:45 GMT
Subject: ANN: imsep 0.6
From: Colin Walters <walters@gnome.org>
To: selinux@tycho.nsa.gov
Cc: gtk-devel-list@gnome.org
Content-Type: text/plain
Date: Thu, 21 Oct 2004 02:29:17 -0400
Message-Id: <1098340157.11607.12.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'd like to announce the first release of a little project called Imsep.
The goal, in short, is to completely isolate image loaders using
SELinux, so that a compromised or buggy image loader can do essentially
nothing.   It's designed for the "targeted" SELinux policy to be
released with Fedora Core 3.

I've put up a little web page here with slightly more information:

http://web.verbum.org/imsep/

The source includes a sample SELinux policy.

For people reading on the GTK+ list: I've created an initial patch to
make gdk-pixbuf use imsep, it seems to work:

http://web.verbum.org/imsep/download/gdk-pixbuf-imsep-0.6.patch

The GDK_PIXBUF_FORMAT_REQUIRES_LOAD feels like a hack, but I didn't see
a better alternative.

Comments welcome.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
