Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OJ6jHa003076
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 15:06:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OJ6iDW005590
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 19:06:44 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
        by jazzband.ncsc.mil  with ESMTP id h6OJ6heN005587 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 19:06:43 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OJ6hxH014702
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 15:06:43 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6OJ6hT0014700
	for selinux@tycho.nsa.gov; Thu, 24 Jul 2003 15:06:43 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OIvBHa003022
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 14:57:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OIvADW005153
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:57:10 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h6OIv6eN005145 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 18:57:10 GMT
Date: Thu, 24 Jul 2003 14:52:02 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Colin Walters <walters@verbum.org>
cc: selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
In-Reply-To: <1059068428.1698.14.camel@columbia>
Message-ID: <Pine.LNX.4.44.0307241434480.23576-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Someone sent this to me privately:
---------
It was Ken.  Google knows all.  See
http://www.wbglinks.net/pages/reads/hacksexplained/thompson.html
---------

Regarding the "useful" damage, if the trojan accepts another pre-defined
password, then you don't need an outbound connection to tell you the
passwords.  However, there has been some recent discussion of using
charactistics of packets to trigger finite state machines. One example I
read recently of (don't remember the source), was using a FSM in a
firewall to remotely open holes for authorized users in a manner that
would be hard to detect with a sniffer.  Sending a certain sequence could
communicate the port numbers and IP addresses to open.

		--Dean

On 24 Jul 2003, Colin Walters wrote:

> On Wed, 2003-07-23 at 15:34, karlm@mit.edu wrote:
>
> > I believe Dean is mistaken and is actually referring to Ken Thompson's
> > theoretical attack.  The point is you can't see if the backdoor
> > exists.  Unless you have personally recreated the history of modern
> > computing from first priciples in your basement or place of work, you
> > may be 0wn3d and not know it, in theory.
>
> The thing is though that to do any kind of "useful" damage (e.g. send
> passwords back to the author), at some point the trojan is going to have
> to connect to the network.  And if it does that, chances are some
> careful network administrator somewhere is going to notice some strange
> connections, eventually.  I mean, when your file server starts making
> HTTP POST requests or whatever, you'd get very suspicious.
>
> It seems much harder to believe this trojan would have been able to
> compromise all the network traffic sniffers out there.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
