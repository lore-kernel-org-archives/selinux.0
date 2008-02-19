Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JDwn9G011438
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 08:58:49 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JDwnPP023146
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 13:58:49 GMT
Subject: Re: refpolicy: patch for Debian cracklib-runtime daily cron job
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080219100312.GA19763@bobek.pm.i.cz>
References: <20080219100312.GA19763@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 19 Feb 2008 08:56:30 -0500
Message-Id: <1203429390.13618.85.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-19 at 11:03 +0100, Václav Ovsík wrote:
> Hi,
> the package cracklib-runtime on Debian contains a daily maintenance script
> /etc/cron.daily/cracklib-runtime, that calls
>     update-cracklib and that calls
> 	crack_mkdict, witch is a shell script. :)
> Run of the job daily cron job emits:
> 
> audit(1203412448.496:30): avc:  denied  { execute } for  pid=1961 comm="crack_mkdict" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:crack_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> audit(1203412448.496:31): avc:  denied  { read } for  pid=1961 comm="crack_mkdict" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:crack_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> 
> A patch is attached that suppresses these two denials.

Merged.  I moved this into a distro_debian block.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
