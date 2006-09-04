Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k84Jhh3i011996
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 15:43:43 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k84JhL79024272
	for <selinux@tycho.nsa.gov>; Mon, 4 Sep 2006 19:43:21 GMT
Subject: Re: refpolicy updates from debian
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157394109.3199.234.camel@sgc>
References: <1157161065.9799.28.camel@wintermute.xmldesign.de>
	 <1157394109.3199.234.camel@sgc>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 21:43:35 +0200
Message-Id: <1157399016.4446.20.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Chris,
> - changed fsadm_var_log_t to fsadm_log_t

Okay.

> - dropped netuser

I'm still convinced it's useful.
It's an easy way of allowing only certain users to setup network
servers.
If like, 10% of your users should be allowed to setup network servers,
the others should not.

> - dropped dev/.static/dev/ stuff.  please put in distro_debian

It might be removed again. This directory isn't really used apparently;
it was added to allow the admin to configure the static /dev dir while
running udev.
I don't think we need to support switching from udev to static /dev
while selinux is in enforcing mode.

> - please make a more descriptive name for usbmodules_var_lib_t.  maybe
> usbmodules_ids_t?

Right now there is only the usbmodules ids file in there, so that name
is fine with me. I have no idea if usbmodules might get extra var files
later on. AFAICT the file is generated from one single source file on my
system anyway. That might differ for certain USB hardware not supported
by the stock kernel, though.

> - why does crond_t transition to amavis? why not system_crond_t?

Should be system_crond_t I think. Maybe a typo. Must have done that
change some months ago, actually.
This is the cronjob rebuilding or doing maintainance on the amavis
spamassassins bayes database. It will have to su to user amavis, too; I
didn't complete these changes I think. The amavisd-new maintainer
uploaded a useful change to unstable; however my only selinux system
with amavis in use was a sarge system.

> - why does system_crond_t connect to mysql?

I'm not sure, I believe it's cron signaling mysql some maintainance.
I don't actually use MySQL.

>From the cronjob:
# This script only rotates the binary logs. The normal logs are rotated
# via /etc/logrotate.d/mysql-server.

I don't know why logrotate is not used for the binary logs, too.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     Which is worse: ignorance or apathy? Who knows? Who cares?      //\
  Bei dem Freunde halte still, der dich nur, nicht das deine will.   V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
