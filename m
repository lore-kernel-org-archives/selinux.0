Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAT85YIi009564
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 03:05:34 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAT85Vkk023326
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 08:05:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, Tom London <selinux@gmail.com>
Subject: Re: cups-config-daemon ?
Date: Mon, 29 Nov 2004 19:04:52 +1100
References: <4c4ba153041128115177c696b8@mail.gmail.com>
In-Reply-To: <4c4ba153041128115177c696b8@mail.gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ogtqBicpgVOxpi8"
Message-Id: <200411291904.56706.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_ogtqBicpgVOxpi8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 29 November 2004 06:51, Tom London <selinux@gmail.com> wrote:
> Running strict/enforcing, latest Rawhide.
>
> I think the following is coming from cups-config-daemon
>
> I'm always a bit suspicious of fd denials....
> these are to /dev/null...
> Is this an open file leaking across an exec?

I don't think that this is a problem.  Granting access to /dev/null is not an 
issue.  For cron jobs this sort of thing is common.

The attached patch should do the job.

> Help welcomed.....
>    tom
>
>
> Nov 28 10:12:25 fedora cups: cupsd shutdown succeeded
> Nov 28 10:12:25 fedora kernel: audit(1101665545.088:0): avc:  denied
> { use } for  pid=4223 exe=/usr/bin/python path=/dev/null dev=tmpfs
> ino=3516 scontext=system_u:system_r:cupsd_config_t
> tcontext=system_u:system_r:system_crond_t tclass=fd
> Nov 28 10:12:25 fedora kernel: audit(1101665545.088:0): avc:  denied
> { use } for  pid=4223 exe=/usr/bin/python path=/dev/null dev=tmpfs
> ino=3516 scontext=system_u:system_r:cupsd_config_t
> tcontext=system_u:system_r:logrotate_t tclass=fd
> Nov 28 10:12:25 fedora kernel: audit(1101665545.088:0): avc:  denied
> { use } for  pid=4223 exe=/usr/bin/python path=/dev/null dev=tmpfs
> ino=3516 scontext=system_u:system_r:cupsd_config_t
> tcontext=system_u:system_r:logrotate_t tclass=fd
> Nov 28 10:12:25 fedora kernel: audit(1101665545.232:0): avc:  denied
> { use } for  pid=4226 exe=/usr/sbin/cupsd path=/dev/null dev=tmpfs
> ino=3516 scontext=system_u:system_r:cupsd_t
> tcontext=system_u:system_r:system_crond_t tclass=fd
> Nov 28 10:12:25 fedora cups: cupsd startup succeeded

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_ogtqBicpgVOxpi8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/cups.te	2004-11-12 14:11:26.000000000 +1100
+++ /tmp/cups.te	2004-11-29 19:02:25.548101438 +1100
@@ -211,7 +211,7 @@
 allow cupsd_t userdomain:dbus send_msg;
 allow cupsd_t hald_t:dbus send_msg;
 allow hald_t cupsd_t:dbus send_msg;
-')
+')dnl end if dbusd.te
 
 can_exec(cupsd_config_t, { bin_t sbin_t shell_exec_t })
 allow cupsd_config_t { bin_t sbin_t }:dir { search getattr };
@@ -225,7 +225,11 @@
 allow cupsd_config_t urandom_device_t:chr_file { getattr read };
 
 domain_auto_trans(hald_t, cupsd_config_exec_t, cupsd_config_t)
+ifdef(`logrotate.te', `
+allow cupsd_config_t logrotate_t:fd use;
+')dnl end if logrotate.te
+allow cupsd_config_t system_crond_t:fd use;
+')dnl end if hald.te
 
-')
 # Alternatives asks for this
 allow cupsd_config_t initrc_exec_t:file getattr;

--Boundary-00=_ogtqBicpgVOxpi8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
