Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5SCuR0S018620
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 08:56:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5SCuQ5e023902
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 12:56:26 GMT
Received: from TheWorld.com (pcls2.std.com [199.172.62.104])
        by jazzband.ncsc.mil  with ESMTP id h5SCuP92023898 for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 12:56:26 GMT
Date: Sat, 28 Jun 2003 08:56:15 -0400
From: Bart Mallio <bmallio@theworld.com>
To: Colin Walters <walters@verbum.org>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: screen.te zsh fixes
In-Reply-To: <1056787174.14920.94.camel@columbia>
Message-ID: <Pine.SGI.4.40.0306280843350.5647676-100000@shell01.TheWorld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 28 Jun 2003, Colin Walters wrote:

> > Does Red Hat have something like /etc/alternatives?  Or is it only a Debian
> > thing?
>
> I think I heard that they adopted the idea, although not the specific
> Debian implementation.  Hopefully a Red Hat person here can speak up.

It does, actually.  On my vanilla install of RH 9, its got 21 links
bridging mta stuff to sendmail, and lp stuff to cups.  RH's man pages
claim that their "alternatives" is "a reimplementation of the Debian
alternatives system...primarily to remove the dependency on perl."

Let me know if there's any RH-generic config stuff (copies of man pages,
settings, etc.) I can pass on.

Best,
-Bart



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
