Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10086
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 11:54:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA27624
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 15:53:42 GMT
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id PAA27620
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 15:53:40 GMT
Message-Id: <200208051553.PAA27620@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: Security settings for fcron
Date: Mon, 5 Aug 2002 17:54:14 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020805142804.4209A120@lyta.coker.com.au>
In-Reply-To: <20020805142804.4209A120@lyta.coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Montag, 5. August 2002 16:28 schrieb Russell Coker:
> One problem that I am having is determining the distinction between
> system cron jobs and system-administrator cron jobs.
>
> System cron jobs are those such as the /etc/cron.{daily,weekly,monthly}
> jobs in Debian.  They are provided as part of the OS to maintain
> applications, and they are designed to run as the identity "system_u", as
> the role "system_r", and the domain "system_crond_t" giving the context
> system_u:system_r:system_crond_t.  Cron jobs applied by the administrator
> via "fcrontab -e" should be run in the same fashion as regular cron jobs
> applied by "crontab -e", in the context "root:sysadm_r:sysadm_crond_t".

I read the crond rules this weekend too. I mean you distrinction is right.

But the system_crond_t is too powerfull (can_exec_any) I think. Isn't it 
better to wite each system cronjob an own domain with the transition he 
needs?

Carsten


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
