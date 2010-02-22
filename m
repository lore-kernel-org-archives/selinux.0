Subject: Re: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <dd18b0c31002221325ie418a7ep589e9ac0fe98f1f5@mail.gmail.com>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7EDC9A.40801@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7F06F1.4070305@gmail.com>
	 <1266847250.15933.23.camel@moss-pluto.epoch.ncsc.mil>
	 <dd18b0c31002221127j4c22e9d1v94c037e86e7bb74e@mail.gmail.com>
	 <dd18b0c31002221129s4be9b56cha13b7be39c2cba36@mail.gmail.com>
	 <4B82E190.5060306@gmail.com>
	 <1266870268.15933.132.camel@moss-pluto.epoch.ncsc.mil>
	 <dd18b0c31002221325ie418a7ep589e9ac0fe98f1f5@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 22 Feb 2010 16:42:36 -0500
Message-Id: <1266874956.15933.156.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-22 at 13:25 -0800, Justin Mattock wrote:
> > You don't need to rebuild sysvinit; it already has the selinux support
> > in opensuse.
> >
> > The only issue is how they have configured /etc/inittab (which you still
> > haven't sent) or how they have set up their init scripts.  Things to
> > look for:
> > - Does /etc/inittab invoke the rc scripts directly or indirectly via a
> > shell command?
> > - Are the scripts under /etc/init.d and /etc/rc.d labeled properly (e.g.
> > with initrc_exec_t)?  Otherwise they won't transition properly.
> > - Do the scripts under /etc/init.d and /etc/rc.d have a #! header?  If
> > not, then an attempt to execve() them will fail and it will fall back on
> > the caller to feed them to the shell, at which point you won't have the
> > normal domain transition.
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> >
> 
> my bad.. got tied up looking for the avc's denial
> of init. attached is inittab-orig of what suse has.

Ok, so they invoke /etc/init.d/rc with the runlevel as an argument.
So:
- What does ls -Z /etc/init.d/rc show?
- What does head /etc/init.d/rc show?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
