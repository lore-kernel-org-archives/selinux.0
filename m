Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA27637
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 12:02:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA12933
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 16:02:32 GMT
Received: from web40014.mail.yahoo.com (web40014.mail.yahoo.com [66.218.78.54])
	by jazzswing.ncsc.mil  with SMTP id QAA12929
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 16:02:31 GMT
Message-ID: <20020627160257.11062.qmail@web40014.mail.yahoo.com>
Date: Thu, 27 Jun 2002 09:02:57 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020627145052.795357CC7@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> On Wed, 26 Jun 2002 20:29, Brad Chapman wrote:
> >        If you are interested, here is another dmesg output after some
> > system use.
> 
> You need the following in gpm.te (it'll be in my new tree):
> ifdef(`devfsd.te', `file_type_auto_trans(gpm_t, device_t, gpmctl_t)')

       Done

> 
> For alsa, is /dev/snd really the right thing to do?  Probably best to have a 
> script do this whcih is labelled such that a transition from initrc_t will 
> take place.

       I prefer to use /dev/snd because it's cleaner and follows the devfs
tradition; I keep a bunch of symlinks laying around in /dev just to keep
certain programs happy.

> 
> For the syslogd/klogs errors, change the syslogd.te and klogd.te you need to 
> change the domain_auto_trans() rules to take a transition from init_t instead
> 
> of initrc_t because you are not running those daemons in the normal fashion.

       "Normal fashion?" Do other distros start syslogd and klogd straight from
/etc/inittab? Done

> 
> Maybe you should have /usr/X11R6/bin/XFree86 labelled as 
> system_u:object_r:xserver_exec_t...

       How do I do that?

> 
> /dev/nvidiactl needs an appropriate type.

       How do I do this too? Should I mess with devfs_contexts or devfsd.conf?

> 
> There's still a heap of issues that my latest devfsd.te will solve.  See 
> http://www.coker.com.au/selinux/selinux-small/ ...
> 

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
