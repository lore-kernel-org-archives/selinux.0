Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB3ENIBV016533
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 09:23:18 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB3ELX2d029477
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 14:21:33 GMT
Subject: Re: root home directory and system cron jobs
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200612031541.27320.russell@coker.com.au>
References: <1165110951.19409.8.camel@hepcat.vitavonni.de>
	 <200612031541.27320.russell@coker.com.au>
Content-Type: text/plain; charset=utf-8
Date: Sun, 03 Dec 2006 15:23:26 +0100
Message-Id: <1165155806.4758.5.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russel,

> > Also some cronjobs will try to use "su" to switch to a different userid.
> > (e.g. the amavisd-new cronjob to do maintainance on the spamassassin
> > bayes database); some might be able to be rewritten to use the other
> > userid directly, but some might not...
> > (e.g. because they're installed in /etc/cron.daily, which doesn't use
> > the cronjob syntax but is just a collection of shell scripts; they need
> > to use su to switch to a different user)
> 
> There is no reason why they couldn't be installed in /etc/cron.d instead.

There is: the jobs in /etc/cron.daily are run in sequence once a day.
If they were installed in /etc/cron.d they would each have to pick a
time to run (and the admin to eventually change each of them). The
cron.daily solution will execute them one-by-one (AFAIK) and thus create
less load on the machine without extra configuration by the maintainers
or the system administrator.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
             Reality continues to ruin my life --- Calvin            //\
   Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.   V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
