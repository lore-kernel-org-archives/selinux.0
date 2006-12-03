Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB3Kbht6026564
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 15:37:43 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB3Kax2j019539
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 20:37:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: root home directory and system cron jobs
Date: Mon, 4 Dec 2006 07:38:01 +1100
Cc: selinux@tycho.nsa.gov
References: <1165110951.19409.8.camel@hepcat.vitavonni.de> <200612031541.27320.russell@coker.com.au> <1165155806.4758.5.camel@hepcat.vitavonni.de>
In-Reply-To: <1165155806.4758.5.camel@hepcat.vitavonni.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612040738.04298.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 04 December 2006 01:23, Erich Schubert <erich@debian.org> wrote:
> > > Also some cronjobs will try to use "su" to switch to a different
> > > userid. (e.g. the amavisd-new cronjob to do maintainance on the
> >
> > There is no reason why they couldn't be installed in /etc/cron.d instead.
>
> There is: the jobs in /etc/cron.daily are run in sequence once a day.

Do you have some examples of jobs that need to be run in sequence?

> If they were installed in /etc/cron.d they would each have to pick a
> time to run (and the admin to eventually change each of them). The
> cron.daily solution will execute them one-by-one (AFAIK) and thus create
> less load on the machine without extra configuration by the maintainers
> or the system administrator.

The cron daemon has code to monitor the system load and refrain from launching 
too many processes.  The default value for this is high enough that most 
systems will never reach such a load, but it can be changed with the -l 
parameter (incidentally I have not tested this, just read the man page and 
read the source long ago).

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
