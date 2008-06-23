Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5ND2IfR024606
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 09:02:18 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5ND2Hvu020766
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 13:02:17 GMT
Subject: Re: x_extension use
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40806191533j265e146q2070b19d2bcd10d@mail.gmail.com>
References: <cadfc0e40806191533j265e146q2070b19d2bcd10d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Jun 2008 09:01:18 -0400
Message-Id: <1214226078.11146.220.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-06-19 at 17:33 -0500, Xavier Toth wrote:
> I'm seeing a number of AVCs out of gnome applications for a range of X
> extensions. Now I wondering about allowing access to X extensions. In
> general should apps be able to use any extension or are there specific
> one that need greater access control?

I can't really add anything to what Eamon said but there is one thing I
wanted to note:

> type=USER_AVC msg=audit(1213883755.647:918): user pid=23989 uid=0
> auid=4294967295 ses=4294967295
> subj=system_u:system_r:xdm_xserver_t:s0-s15:c0.c1023 msg='avc:  denied
>  { use } for request=XFree86-VidModeExtension:QueryVersion
> comm=gnome-screensaver extension=XFree86-VidModeExtension
> scontext=user_u:user_r:user_t:s0
> tcontext=system_u:object_r:directhw_xext_t:s0 tclass=x_extension :
> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'

This extension gives direct access to hardware, so you may not want to
allow this one.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
