Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OKIvI4010612
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:18:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3OKIu7R007567
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 20:18:56 GMT
Received: from Allen.fw.matav.hu (matav-2.matav.hu [145.236.241.99])
        by jazzband.ncsc.mil  with ESMTP id h3OKIsKP007552 for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 20:18:55 GMT
Date: Thu, 24 Apr 2003 20:18:34 +0000
To: Robert Bihlmeyer <robbe@orcus.priv.at>
Cc: selinux@tycho.nsa.gov
Subject: Re: [selinux] broad domains
Message-ID: <20030424201834.GB4047@bunuel.tii.matav.hu>
References: <87n0ilej7x.fsf@orcus.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <87n0ilej7x.fsf@orcus.priv.at>
From: mag@bunuel.tii.matav.hu (Magosányi Árpád)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Although I work with RSBACs RC modell, maybe my experiences could be of
use for you also.

To be able to understand what might of concern to you, a short explanation
of the model I have implemented:
The TCB have the standard roles and types (sort of), with generic,
secadm and sysadm roles. I also have a type for tty devices and a
type for "logging", which is write-only for most.
The userspace is in a chrooted environment, where I have system,
public, confidential, secret/{work} and secret/{private} roles,
and the types corresponding to them. The MAC policy is something
resembling to Bell&LaPadula.
I have a special domain for the X server to allow it to mmap, and for
or five additional file related extras (AUTH_MAY_SETUID flag in
sudo, login and su, RC role dependant symlinks for /tmp and /home, and
it is nearly everything).

I use gnome.


Zeroth, no x client have setuid bit. They just do not need it, and
they are too big to have one.

First, most of the X clients need nothing special. Actually I do not
have any special domain for them. For a more fine-grained modell,
you would need extra access to wtmp and tty files for xterm and
such thingies, but it is not because they are x programs, but because
they are hmm... use login mechanisms.

The obvius thing to set for X clients is the right to access the
X server. As it runs in another domain (and because for a while it seemed
that it will run as part of the TCB), I chose to use tcp transport.

Another thing to consider is xdm and such things. I do not (yet?)
use xdm:) I guess it will need a new role.

Another thing is the question of handling of MIT cookies.
I use static keys (yet), and I regard this problem to be either
related to xdm or (as?) the implementation of a correct trusted
mechanism for key distribution for X sessions.

Another thing is the MITSHM extension. My clients cannot actually
use it due to a rsbac problem related to the initial type of the
created IPC objects, but if it would work fine, this could be set
up by modifying the X server role. Anyway, libs are smart enough to
live without mitshm.

Another thing is the Ice extension, gnome config daemon and such.
I see that these machanisms are working in a statisfactory (for me)
level, which means that the instances in different levels do not
interfere much because the namespace separation of the user
writeable directories, and I cannot see any functional problem
worth mentioning. I can even run different openoffice.org
instances for each domain, and even cannot cut&paste between
them, because they use a mechanisms above the standard X one
which is domain separated.

The main problem area for me is the separation of domains in use
of the X server mechanisms (think cut&paste), and the visualisation
of the different security levels. Reading some X documentation
it became clear that the neded security functions cannot and should
not be implemented using some existing mechanisms of the X server
(it cannot tell you authentication info or security attributes about
the owner of a window), or some new server extensions (to have security
infrastructure within the X server, it should have been completely
rewritten). But the X protocol is a point where these mechanisms should
and can be handled in an assured way. So I figured out that I should
write a X proxy as the core component of X security, but don't hold
your breath.



A levelezõm azt hiszi, hogy Robert Bihlmeyer a következõeket írta:
> Hi,
> 
> I started work on a generic X client domain, but now I get the feeling
> that this may not be the right way to go. As I have to add this
> permission for this client, and that permission for that program, the
> domain gets quite broad. Maybe these generic domains are a mistake?
> 
> A have the same problem with the games domain provided in the default
> policy (or at least in Russell's package). As is, it doesn't fit half
> the stuff in my /usr/games.
> 
> On the other hand, having a domain for every teensy toy out there
> seems a bit excessive.
> 
> Any advice?
> 
> 
> 
> BTW, can't setfiles assume some default user & role if none is given?
> Repeating system_u:object_r: a million times is superflous.
> 
> -- 
> Robbe



-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
