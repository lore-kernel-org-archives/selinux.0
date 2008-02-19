Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JJPIZ3021061
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 14:25:20 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JJPHsW003499
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 19:25:17 GMT
Subject: Re: [refpolicy] samba
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1202137522.2667.5.camel@vogon>
References: <1202029647.2674.1.camel@vogon>  <47A71B22.90506@redhat.com>
	 <1202137522.2667.5.camel@vogon>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 14:22:47 -0500
Message-Id: <1203448967.13618.102.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-04 at 16:05 +0100, Stefan Schulze Frielinghaus wrote:
> On Mon, 2008-02-04 at 09:03 -0500, Daniel J Walsh wrote:
> > Stefan Schulze Frielinghaus wrote:
> > > On Debian machines smbd needs append rights for samba logfiles.
> > > 
> > In Fedora smbd_t needs manage_files_pattern on smbd_log_t.  Our
> samba
> > developers informed me that this is ok, since these are not security
> > relevent log files.

> OK than we can easily substitute create_files_pattern with
> manage_files_pattern. Attached patch should do that.

Merged.

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (samba.te.patch)
> 
> --- /usr/src/refpolicy-20071214/policy/modules/services/samba.te        2007-12-14 15:23:18.000000000 +0100
> +++ policy/modules/services/samba.te    2008-02-04 15:59:56.000000000
> +0100
> @@ -222,7 +222,7 @@
>  allow smbd_t samba_etc_t:file { rw_file_perms setattr };
>  
>  create_dirs_pattern(smbd_t,samba_log_t,samba_log_t)
> -create_files_pattern(smbd_t,samba_log_t,samba_log_t)
> +manage_files_pattern(smbd_t,samba_log_t,samba_log_t)
>  allow smbd_t samba_log_t:dir setattr;
>  dontaudit smbd_t samba_log_t:dir remove_name;
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
