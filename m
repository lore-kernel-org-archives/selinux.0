Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6ESpia006503
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 09:28:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB6ESo4h023075
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 14:28:51 GMT
Subject: Re: refpolicy HEAD, Debian, syslogd & setrlimit
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20071205141324.GA1211@bobek.pm.i.cz>
References: <20071205141324.GA1211@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 06 Dec 2007 09:28:35 -0500
Message-Id: <1196951315.12626.21.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-05 at 15:13 +0100, Václav Ovsík wrote:
> audit(1196861341.205:26): avc:  denied  { setrlimit } for  pid=2160 comm="cron" scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=process
> 
> There is a content of /etc/pam.d/cron from my Debian Etch:
[...]
>     # Sets up user limits, please define limits for cron tasks
>     # through /etc/security/limits.conf
>     session    required   pam_limits.so
> 
> /etc/security/limits.conf
> 
> has only comment sections.
> 
> Can be rlimit allowed or should be solved this in some other way?

I added this in distro_debian for now, so if someone does put limits, it
will work.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
