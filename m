Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26715
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 10:51:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA17663
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:49:47 GMT
Received: from lyta.coker.com.au ([209.151.19.136])
        by jazzband.ncsc.mil  with ESMTP id OAA17659 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:49:40 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 10:34:00 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627002949.30727.qmail@web40011.mail.yahoo.com>
In-Reply-To: <20020627002949.30727.qmail@web40011.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627145052.795357CC7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Jun 2002 20:29, Brad Chapman wrote:
>        If you are interested, here is another dmesg output after some
> system use.

You need the following in gpm.te (it'll be in my new tree):
ifdef(`devfsd.te', `file_type_auto_trans(gpm_t, device_t, gpmctl_t)')

For alsa, is /dev/snd really the right thing to do?  Probably best to have a 
script do this whcih is labelled such that a transition from initrc_t will 
take place.

For the syslogd/klogs errors, change the syslogd.te and klogd.te you need to 
change the domain_auto_trans() rules to take a transition from init_t instead 
of initrc_t because you are not running those daemons in the normal fashion.

Maybe you should have /usr/X11R6/bin/XFree86 labelled as 
system_u:object_r:xserver_exec_t...

/dev/nvidiactl needs an appropriate type.

There's still a heap of issues that my latest devfsd.te will solve.  See 
http://www.coker.com.au/selinux/selinux-small/ ...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
