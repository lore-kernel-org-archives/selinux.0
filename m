Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SEs0Ha016041
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 10:54:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6SEqnFB014114
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:52:49 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
	by jazzswing.ncsc.mil  with ESMTP id h6SEqnGD014111
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:52:49 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SErvYS002695
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 10:53:57 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6SErvus002693
	for selinux@tycho.nsa.gov; Mon, 28 Jul 2003 10:53:57 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6RKF4Ha013488
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 16:15:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6RKDtFB002800
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 20:13:55 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6RKDsGD002797
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 20:13:54 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 2465132A6C0
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 04:19:51 -0400 (EDT)
Subject: Re: Linuxfromscratch.org
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <20030727172837.U542@lemuria.org>
References: <1059068428.1698.14.camel@columbia>
	 <Pine.LNX.4.44.0307241434480.23576-100000@vista.av8.net>
	 <20030727172837.U542@lemuria.org>
Content-Type: text/plain
Message-Id: <1059336784.13122.260.camel@columbia>
Mime-Version: 1.0
Date: 27 Jul 2003 16:13:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-07-27 at 11:28, Tom wrote:
> On Thu, Jul 24, 2003 at 02:52:02PM -0400, Dean Anderson wrote:
> > Regarding the "useful" damage, if the trojan accepts another pre-defined
> > password, then you don't need an outbound connection to tell you the
> > passwords.  However, there has been some recent discussion of using
> > charactistics of packets to trigger finite state machines. One example I
> > read recently of (don't remember the source), was using a FSM in a
> > firewall to remotely open holes for authorized users in a manner that
> > would be hard to detect with a sniffer.  Sending a certain sequence could
> > communicate the port numbers and IP addresses to open.
> 
> Actually, the current state of the art is embedding arbitrary commands 
> in regular traffic. Opening ports is just one possibility, and usually
> unnecessary if you have what is essentially a remote shell.
> I've seen working implementations of that. They use encryption and changing 
> start/end patterns. You can embed your commands in HTTP requests, or
> spam mail, or hidden in the IP flags of a ping series. Good luck with
> the IDS.

That is clever, but it seems to me you'd still have to take into account
the machine's usage.  Again, none of what you listed above should be
going to a file server, for example.  And most of it shouldn't be going
to a development workstation.  So it doesn't seem too unlikely that some
machine learning based IDS, somewhere, will eventually pick up on it. 
Once that happens in multiple places, people will get suspicious.
I guess all I'm saying is that the chances of a trojan going undetected
for a long period of time approaches nil.

> Which goes to show that you can't have security unless the system
> itself is secure. No amount of firewalling, filtering or IDS will
> protect a weak system. That's why we need SELinux. (how's that for
> getting back on-topic? :) )

Good work :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
