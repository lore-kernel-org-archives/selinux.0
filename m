Subject: Re: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. mattock" <justinmattock@gmail.com>
Cc: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4B8372FB.4040605@gmail.com>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7F06F1.4070305@gmail.com>
	 <1266847250.15933.23.camel@moss-pluto.epoch.ncsc.mil>
	 <dd18b0c31002221127j4c22e9d1v94c037e86e7bb74e@mail.gmail.com>
	 <dd18b0c31002221129s4be9b56cha13b7be39c2cba36@mail.gmail.com>
	 <4B82E190.5060306@gmail.com>
	 <1266870268.15933.132.camel@moss-pluto.epoch.ncsc.mil>
	 <dd18b0c31002221325ie418a7ep589e9ac0fe98f1f5@mail.gmail.com>
	 <4B8300B8.7060501@gmail.com>
	 <dd18b0c31002221435s39a27b0fvf4f9dfa4699360ae@mail.gmail.com>
	 <4B8372FB.4040605@gmail.com>
Content-Type: text/plain
Date: Tue, 23 Feb 2010 08:40:25 -0500
Message-Id: <1266932425.871.13.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-22 at 22:17 -0800, Justin P. mattock wrote:
> ahh.. I see what you mean by transition
> i.g. with enable_upstart=0
> 
> under ps auxZ
> I see everything is with sysadm_t
> example when dbus starts:
> with enable_upstart=0
> system_u:system_r:sysadm_t
> and continues to have sysadm_t
> 
> (with enable_upstart=1)
> system_u:system_r:udev_t
> and all other daemons etc.. go into there
> proper name(udev_t,hald_t,xdm_t)down the line.
> 
> 
> I've looked at the file contexts, and
> am not seeing anything out of the ordinary
> (but could be wrong).
> 
> any ideas?

Looks like /etc/init.d/rc is labeled correctly.
And /etc/init.d/rc and /etc/init.d/boot have the #!/bin/sh prefix?

Looking at the sysvinit code, it appears that it will invoke the command
specified in /etc/inittab via a shell if:
- the command string has any meta characters in it that need
interpretation (but your /etc/inittab didn't look that way), or
- the attempt to exec the command directly returns with errno ENOEXEC
(this will happen if the script lacks a #!/path/to/interpreter header).

The proper domain transition only happens upon direct execution of the
script, not if it is invoked indirectly via the shell.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
