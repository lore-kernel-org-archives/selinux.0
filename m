Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IFxq7G014971
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 11:59:52 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7IFxQx0006057
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 15:59:26 GMT
Subject: Re: refpoliy issues
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1155910539.14126.17.camel@sgc.columbia.tresys.com>
References: <1155863972.7443.36.camel@wintermute.xmldesign.de>
	 <1155910539.14126.17.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 17:50:51 +0200
Message-Id: <1155916251.14563.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Christopher,
> > - sxid not in role system_r, missing access to /dev
> Already fixed the role.  You'll have to be more specific about access
> to /dev.

How about /dev/*
sxid by nature tries to getattr all files there.

> > - cron needs to su for certain cronjobs
> Can you be more specific?

Amavisd-new for example. /etc/cron.daily/* support, because these files
don't have cron syntax, but are plain shell scripts.
But I had the impression that adding su for system_crond_t is the clean
way, so it wouldn't really matter which of the jobs in there uses su...

> I believe setrans is in fedora cvs.  The access looks like its only due
> to libselinux's init; however, if you're using MLS or MCS, you're really
> going to want the translation daemon anyway.

I agree that I want setrans if I manage to get it from somewhere and
some docs how to set it up... still we should probably handle these
errors. I don't know if they occur on non-MLS-non-MCS systems, though.
But right now, I guess more people might be affected by this.

> Based on the evidence that relabelfrom on unpriv user ptys is
> dontaudited, my guess is this is also a dontaudit.  I'm guessing you
> have sysadm ssh login on?

Yes, that makes selinux policy debugging a bit easier, not having to
auth all the time.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   It's not denial. I'm just selective about the reality I accept.   //\
                 Wege entstehen, wenn wir sie gehen.                 V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
