Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7BEEUrT010584
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 10:14:30 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7BEES5L007021
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 14:14:29 GMT
Date: Wed, 11 Aug 2004 15:25:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: server-based system for file context restoration
Message-ID: <20040811142538.GA12278@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

this may sound a little weird, but i believe it to be a possible
solution to the amount of time taken to do an selinux context restore.

the issue is that udev is designed to call out to separate programs
to perform the task of adding new devices.

consequently, optimisations that rely on cacheing by a single process
(e.g. russell's suggestion to cache the return result of
is_selinux_enabled() and also the cacheing performed by the
setfilecon() function) are not activated / taken advantage of.

therefore, there needs to be a persistent process around that
performs device creation.

to that end, two possible methods could be used:

1) udevd exec's udev_add which sticks around, and udevd communicates
   to it via a pipe, sending the names of devices to create via
   stdin.

2) similar trick but with setfiles or restorecon instead, this time
   setfiles or restorecon being turned into a "server" which can
   listen on, say, a unix-domain-socket, or via shared memory.

   i hate to suggest the use of udev because udev is not as fast
   as it could be - yet.

   millisecond response time is called for / expected, and udev
   is presently taking like ... one second to start up.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
