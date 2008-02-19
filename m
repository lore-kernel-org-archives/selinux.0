Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JEIqls013697
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 09:18:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JEIpPP028638
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 14:18:51 GMT
Subject: Re: refpolicy: patch for Debian backup cron daily jobs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080219122951.GA23700@bobek.pm.i.cz>
References: <20080219122951.GA23700@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 19 Feb 2008 09:16:11 -0500
Message-Id: <1203430571.13618.88.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-19 at 13:29 +0100, Václav Ovsík wrote:
> Hi,
> this patch solves following denials on Debian:
> 
> audit(1203020199.510:16): avc:  denied  { execute } for  pid=1841 comm="aptitude" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> audit(1203020199.526:17): avc:  denied  { remove_name } for  pid=1847 comm="rm" name="aptitude.pkgstates.6.gz" dev=sda1 ino=213244 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:backup_store_t:s0 tclass=dir
> audit(1203020199.526:18): avc:  denied  { unlink } for  pid=1847 comm="rm" name="aptitude.pkgstates.6.gz" dev=sda1 ino=213244 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:backup_store_t:s0 tclass=file
> audit(1203020199.538:19): avc:  denied  { rename } for  pid=1848 comm="mv" name="aptitude.pkgstates.5.gz" dev=sda1 ino=213147 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:backup_store_t:s0 tclass=file
> audit(1203020212.719:22): avc:  denied  { fsetid } for  pid=1932 comm="cp" capability=4 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:system_r:backup_t:s0 tclass=capability
> audit(1203020212.759:23): avc:  denied  { execute } for  pid=1940 comm="standard" name="bash" dev=sda1 ino=81922 scontext=system_u:system_r:backup_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
> 
> Aptitude backup script /etc/cron.daily/aptitude saves the aptitude state
> into /var/backup. Cron backup script /etc/cron.daily/standard saves
> shadow files and the dpkg status into /var/backup.
> 
> The utility savelog from debianutils is used for rotating state
> information of aptitude and dpkg (unfortunately). Savelog context
> (logrotate_exec_t) should be removed (no specialisation for log files
> only). Log rotation cron jobs /etc/cron.{daily,weekly}/sysklogd has
> logrotate_exec_t already and some init scipts that uses savelog for
> rotating logs during the boot has persmissions already too. So this is
> ok alone hope.
> 
> Attached patch adds context for /etc/cron.daily/{aptitude,standard}
> backup_exec_t. Permission to execute shell and manage files under
> /var/backup is granted further.

Merged.  I moved the file context change into a distro_debian block,
though I suspect the backup policy is fairly Debian-specific.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
