Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA10265
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 12:15:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA02148
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 16:14:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA02138 for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 16:14:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: Security settings for fcron
Date: Mon, 5 Aug 2002 18:15:27 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020805142804.4209A120@lyta.coker.com.au> <20020805155436.B7FF2FA93@ivanova.coker.com.au>
In-Reply-To: <20020805155436.B7FF2FA93@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020805161528.953A73940@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 5 Aug 2002 17:54, Carsten Grohmann wrote:
> Am Montag, 5. August 2002 16:28 schrieb Russell Coker:
> > One problem that I am having is determining the distinction between
> > system cron jobs and system-administrator cron jobs.

> I read the crond rules this weekend too. I mean you distrinction is right.
>
> But the system_crond_t is too powerfull (can_exec_any) I think. Isn't it
> better to wite each system cronjob an own domain with the transition he
> needs?

can_exec_any() doesn't give much real power.  It's the access to /var/log 
that gives system_crond_t it's power.

There are a number of domains for cron jobs, the ntp cron job runs as ntpd_t, 
there's logrotate_t, sxid_t, and a few others.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
