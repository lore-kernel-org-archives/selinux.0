Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA15477
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 06:11:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0KBBZI06268
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 11:11:35 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h0KBBYf06264 for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 11:11:34 GMT
Date: Mon, 20 Jan 2003 12:11:26 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: version mismatch in Debian packages
Message-ID: <20030120121126.A28086@lemuria.org>
References: <20030116160010.A2883@lemuria.org> <20030116221605.GA13472@snoopy.apana.org.au> <20030117080333.E18709@lemuria.org> <20030117215208.GA7599@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030117215208.GA7599@snoopy.apana.org.au>; from bam@snoopy.apana.org.au on Sat, Jan 18, 2003 at 08:52:08AM +1100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jan 18, 2003 at 08:52:08AM +1100, Brian May wrote:
> > Is there a reason for this, is that a bug, or am I missing something?
> > I'd love to use the prepatched kernels for my tutorial, because it will
> > obviously save a lot of time.
> 
> What is your /etc/apt/sources.list entry?

microcomaustralia.com.au/debian/ stable selinux


> Do you have a /etc/apt/preferences file (its not required, and might
> be causing problems if you have one thats incorrect)?

no such file.


> The package names in question are:

Ah, they're in main, so I need to add main to the sources.list entry.

Faye, are you reading? This should be added to your HOWTO.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
