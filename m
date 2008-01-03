Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03ISL5T018494
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 13:28:21 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m03ISKjV019731
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 18:28:20 GMT
Subject: Re: locallogin patch for Fedora 8
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: bigotp@acm.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64.0712261559160.27141@euphrosyne.pab>
References: <Pine.LNX.4.64.0712261559160.27141@euphrosyne.pab>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 13:27:08 -0500
Message-Id: <1199384828.12626.318.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-26 at 16:01 -0700, Peter A. Bigot wrote:
> This patch appears necessary to get the reference policy to run on Fedora
> 8.  Without it attempts to login on the console get:
> 
> type=SYSCALL msg=audit(12/26/2007 15:03:13.840:126) : arch=i386 syscall=write success=no exit=-1(Operation not permitted) a0=4 a1=bff0a630 a2=1 a3=1 items=0 ppid=1 pid=2221 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=tty2 comm=login exe=/bin/login subj=system_u:system_r:local_login_t:s0-s15:c0.c255 key=(null) 
> type=AVC msg=audit(12/26/2007 15:03:13.840:126) : avc:  denied  { audit_control } for  pid=2221 comm=login capability=audit_control scontext=system_u:system_r:local_login_t:s0-s15:c0.c255 tcontext=system_u:system_r:local_login_t:s0-s15:c0.c255 tclass=capability
> 
> The basic fix was previously submitted by Dan Walsh to the SELinux mailing
> list on 14 Apr 2005, noting that pam_loginuid required this capability.  If
> subsequently another way to work around this was preferred, please let me
> know; I'm extremely new to SELinux and am still fumbling.

The rule is in auth_login_pgm_domain() but was mistakenly commented out.
I have uncommented it in trunk.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
