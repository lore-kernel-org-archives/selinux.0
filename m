Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29357
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:33:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA02445
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:32:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA02441 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:32:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 14:33:17 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627160257.11062.qmail@web40014.mail.yahoo.com>
In-Reply-To: <20020627160257.11062.qmail@web40014.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627183317.C75077CF1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 12:02, Brad Chapman wrote:
> > For the syslogd/klogs errors, change the syslogd.te and klogd.te you need
> > to change the domain_auto_trans() rules to take a transition from init_t
> > instead
> >
> > of initrc_t because you are not running those daemons in the normal
> > fashion.
>
>        "Normal fashion?" Do other distros start syslogd and klogd straight
> from /etc/inittab? Done

No, most distributions start them from /etc/init.d scrips.  I guessed that 
you started them from inittab because they were running as init_t instead of 
initrc_t.

What you want to do is have the script that calls all the startup scripts 
labelled as initrc_exec_t, usually one of the following catches it:
/etc/rc.d/rc                    system_u:object_r:initrc_exec_t
/etc/rc.d/rc.sysinit            system_u:object_r:initrc_exec_t
/etc/rc.d/rc.local              system_u:object_r:initrc_exec_t
/etc/init.d/rc.*                system_u:object_r:initrc_exec_t

> > Maybe you should have /usr/X11R6/bin/XFree86 labelled as
> > system_u:object_r:xserver_exec_t...
>
>        How do I do that?

Put the appropriate entry in file_contexts/programs/whatever and relabel the 
file system.

> > /dev/nvidiactl needs an appropriate type.
>
>        How do I do this too? Should I mess with devfs_contexts or
> devfsd.conf?

Either can work, although due to a devfs related bug devfs_contexts is a 
better option at the moment.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
