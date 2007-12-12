Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCGBqbI012397
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 11:11:52 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBCGBqkC024471
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 16:11:52 GMT
Subject: Re: refpolicy HEAD, patch for Debian logs of syslog rotation
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20071211145208.GA5106@bobek.pm.i.cz>
References: <20071211145208.GA5106@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 12 Dec 2007 11:11:13 -0500
Message-Id: <1197475873.12626.195.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-11 at 15:52 +0100, Václav Ovsík wrote:
> there is another change for the refpolicy, so the Debian system can run
> /etc/cron.daily/sysklogd successfully. This is rotation for logs parsed
> from syslog.conf config file. Script /usr/sbin/syslogd-listfiles lists
> logs, that needs rotation. Logs are rotated using script
> /usr/bin/savelog then.
> 
> Without attached patch domain logrotate_t is not allowed to read
> syslog_conf_t and following denials are generated:
> 
> audit(1197384508.149:3): avc:  denied  { read } for  pid=1589 comm="syslogd-listfil" name="syslog.conf" dev=sda1 ino=213265 scontext=system_u:system_r:logrotate_t:s0 tcontext=system_u:object_r:syslog_conf_t:s0 tclass=file
> audit(1197384508.149:4): avc:  denied  { ioctl } for  pid=1589 comm="syslogd-listfil" name="syslog.conf" dev=sda1 ino=213265 scontext=system_u:system_r:logrotate_t:s0 tcontext=system_u:object_r:syslog_conf_t:s0 tclass=file
> audit(1197384508.149:5): avc:  denied  { getattr } for  pid=1589 comm="syslogd-listfil" name="syslog.conf" dev=sda1 ino=213265 scontext=system_u:system_r:logrotate_t:s0 tcontext=system_u:object_r:syslog_conf_t:s0 tclass=file

Merged.  I renamed the interface and moved the te file change lower to
the preexisting distro_debian block.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
