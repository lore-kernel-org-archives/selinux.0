Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SEs1Ha016046
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 10:54:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6SEqlFB014104
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:52:47 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
	by jazzswing.ncsc.mil  with ESMTP id h6SEqlGD014101
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:52:47 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SErpYS002689
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 10:53:51 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6SErpkX002687
	for selinux@tycho.nsa.gov; Mon, 28 Jul 2003 10:53:51 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6RFVpHa013171
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 11:31:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6RFVlDW012036
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 15:31:47 GMT
Received: from unicorn.lemuria.org (b067151.adsl.hansenet.de [62.109.67.151])
        by jazzband.ncsc.mil  with ESMTP id h6RFVkeN012032 for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 15:31:46 GMT
Date: Sun, 27 Jul 2003 17:28:38 +0200
From: Tom <tom@lemuria.org>
To: Dean Anderson <dean@av8.com>
Cc: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Message-ID: <20030727172837.U542@lemuria.org>
References: <1059068428.1698.14.camel@columbia> <Pine.LNX.4.44.0307241434480.23576-100000@vista.av8.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0307241434480.23576-100000@vista.av8.net>; from dean@av8.com on Thu, Jul 24, 2003 at 02:52:02PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 24, 2003 at 02:52:02PM -0400, Dean Anderson wrote:
> Regarding the "useful" damage, if the trojan accepts another pre-defined
> password, then you don't need an outbound connection to tell you the
> passwords.  However, there has been some recent discussion of using
> charactistics of packets to trigger finite state machines. One example I
> read recently of (don't remember the source), was using a FSM in a
> firewall to remotely open holes for authorized users in a manner that
> would be hard to detect with a sniffer.  Sending a certain sequence could
> communicate the port numbers and IP addresses to open.

Actually, the current state of the art is embedding arbitrary commands 
in regular traffic. Opening ports is just one possibility, and usually
unnecessary if you have what is essentially a remote shell.
I've seen working implementations of that. They use encryption and changing 
start/end patterns. You can embed your commands in HTTP requests, or
spam mail, or hidden in the IP flags of a ping series. Good luck with
the IDS.

Which goes to show that you can't have security unless the system
itself is secure. No amount of firewalling, filtering or IDS will
protect a weak system. That's why we need SELinux. (how's that for
getting back on-topic? :) )

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
