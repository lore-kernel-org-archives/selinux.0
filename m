Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SHZHHa017058
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 13:35:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6SHZGDW010960
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 17:35:16 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id h6SHZFeN010957 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 17:35:15 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SHZFYS012658
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 13:35:15 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6SHZFf0012656
	for selinux@tycho.nsa.gov; Mon, 28 Jul 2003 13:35:15 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SHKOHa017013
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 13:20:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6SHKNDW010253
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 17:20:23 GMT
Received: from unicorn.lemuria.org (b067151.adsl.hansenet.de [62.109.67.151])
        by jazzband.ncsc.mil  with ESMTP id h6SHKMeN010248 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 17:20:23 GMT
Date: Mon, 28 Jul 2003 19:17:07 +0200
From: Tom <tom@lemuria.org>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: Linuxfromscratch.org
Message-ID: <20030728191705.G5998@lemuria.org>
References: <1059068428.1698.14.camel@columbia> <Pine.LNX.4.44.0307241434480.23576-100000@vista.av8.net> <20030727172837.U542@lemuria.org> <1059336784.13122.260.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1059336784.13122.260.camel@columbia>; from walters@verbum.org on Sun, Jul 27, 2003 at 04:13:04PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jul 27, 2003 at 04:13:04PM -0400, Colin Walters wrote:
> That is clever, but it seems to me you'd still have to take into account
> the machine's usage.  Again, none of what you listed above should be
> going to a file server, for example.  

Those were just examples. You can put your stuff into ANY traffic. If
the machine has any outside connections whatsoever, and be they DNS
requests, you have a channel you can use.

> to a development workstation.  So it doesn't seem too unlikely that some
> machine learning based IDS, somewhere, will eventually pick up on it. 
> Once that happens in multiple places, people will get suspicious.
> I guess all I'm saying is that the chances of a trojan going undetected
> for a long period of time approaches nil.

True, but "long period of time" is relative. All you need is enough
time to accomplish your goal. That may be months or seconds, depending
on what the goal is.

Again, we see why SELinux is what it is - all the race conditions and
other timing-based exploits show that "we'll catch them quickly" isn't
enough. Catching them works if you talk about theft or something else
where you can still undo the damage. It doesn't work for murder or
rape. Same in computer security: If you have something where the damage
likely can't be undone, monitoring isn't the correct approach because
it acts too late.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
