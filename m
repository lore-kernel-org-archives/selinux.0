Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43ECNWt023054
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 10:12:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l43ECMqf010891
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 14:12:22 GMT
Subject: Re: Additional fixes for consolekit.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46278259.9080509@redhat.com>
References: <46278259.9080509@redhat.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 14:11:58 +0000
Message-Id: <1178201518.445.55.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 10:53 -0400, Daniel J Walsh wrote:
> Consolekit when started via startx needs additional privs.
> 
> Consolekit read users terminals to see who is logged in.
> 
> It also reads the .Xauthority file.

Merged with some reordering.  I reworked the xauth part a little so that
it will work on strict too.  

> --- nsaserefpolicy/policy/modules/system/locallogin.te  2007-03-26 10:39:07.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/system/locallogin.te      2007-04-11 17:07:34.000000000 -0400
> @@ -162,6 +165,10 @@
>  ')
>  
>  optional_policy(`
> +       consolekit_dbus_chat(local_login_t)
> +')
> +
> +optional_policy(`
>         gpm_getattr_gpmctl(local_login_t)
>         gpm_setattr_gpmctl(local_login_t)
>  ')

I dropped this part because it seemed incomplete since local login can't
connect to a dbus.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
