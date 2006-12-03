Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB3M3V5G028498
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 17:03:32 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB3M1lHK011817
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 22:01:47 GMT
Subject: Re: root home directory and system cron jobs
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200612040738.04298.russell@coker.com.au>
References: <1165110951.19409.8.camel@hepcat.vitavonni.de>
	 <200612031541.27320.russell@coker.com.au>
	 <1165155806.4758.5.camel@hepcat.vitavonni.de>
	 <200612040738.04298.russell@coker.com.au>
Content-Type: text/plain; charset=utf-8
Date: Sun, 03 Dec 2006 23:03:54 +0100
Message-Id: <1165183434.5326.12.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> Do you have some examples of jobs that need to be run in sequence?

No. It's just that I can imagine it to be nice to have them run in
sequence on a high-load-system. OTOH, such systems can be adjusted by
the admin as needed.

But it would require lots of changes to packages to
deprecate /etc/cron.daily /etc/cron.weekly and /etc/cron.monthly
Apart from the increased amount of work for the admin if he wants to
reschedule maintainance cronjobs. Having a default time for all of the
daily cronjobs is useful.
btw, it makes me wonder how many of the monthly cronjobs actually assume
they'll be run on the first of each month, and not just once a month.
Well, maybe it's specified somewhere that /etc/cron.monthly is to be run
on the first of each month, I didn't check LSB on that.

Upstart, from Ubuntu, is to get some cron-like functionality IIRC. We
should also talk to them about these problems.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
       The best things in life are free: Friendship and Love.       //\
   Während das Glück dir lacht, wirst Freunde du zählen in Menge;   V_/_
     wenn sich der Himmel bewölkt, findest du dich bald allein.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
