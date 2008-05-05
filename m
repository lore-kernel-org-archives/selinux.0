Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m45D5O3g023657
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2008 09:05:24 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m45D5NN6022262
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2008 13:05:23 GMT
Date: Mon, 5 May 2008 15:05:21 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-ssh@lists.debian.org
Subject: Re: [refpolicy] initrc_t access to sshd /proc to adjust OOM killer
Message-ID: <20080505130521.GA13631@bobek.pm.i.cz>
References: <20080502143041.GA26592@bobek.pm.i.cz> <481B2E15.7070703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <481B2E15.7070703@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 02, 2008 at 11:07:01AM -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Václav Ovsík wrote:
> > Hi,
> > the startup script of Open SSH server on the Debian Sid adjusts the OOM
> > killer to not kill sshd in the condition of OOM. It simply does
> > 
> >     printf '%s' "$SSHD_OOM_ADJUST" >"/proc/$PID/oom_adj" || true
> > 
> > BTW: I am not certain if this do exactly what was intended, because this
> > parameter is inherited by all child processes, as one can see using
> > attached simple script.
> > 
> > Nevertheless I don't know how to enable such write under SE Linux. It
> > triggers:
> > 
> > [   66.417499] type=1400 audit(1209737438.955:6): avc:  denied  { write
> > } for  pid=1600 comm="S16ssh" name="oom_adj" dev=proc ino=70952 s
> > context=system_u:system_r:initrc_t:s0
> > tcontext=system_u:system_r:sshd_t:s0-s0:c0.c1023 tclass=file
> > 
> > I wrote attached patch, but the denial still appears.
> > 
> > sid:~# sesearch --allow -s initrc_t  -t sshd_t -c file 
> > WARNING: This policy contained disabled aliases; they have been removed.
> > Found 3 semantic av rules:
> >    allow @ttr1634 @ttr2356 : file { ioctl read getattr lock }; 
> >    allow initrc_t sshd_t : file { ioctl write getattr lock append }; 
> >    allow initrc_t @ttr2356 : file { ioctl read getattr lock }; 
> > 
> > sid:~# sestatus   
> > SELinux status:                 enabled
> > SELinuxfs mount:                /selinux
> > Current mode:                   permissive
> > Mode from config file:          permissive
> > Policy version:                 22
> > Policy from config file:        refpolicy
> > sid:~# uname -a
> > Linux sid 2.6.25-1-686 #1 SMP Mon Apr 28 13:54:58 UTC 2008 i686 GNU/Linux
> > 
> > What am I doing wrong please?
> > Best Regards
> > 
> Run the avc messages through audit2why

Great, I got:

[   19.816342] type=1400 audit(1209977556.108:5): avc:  denied  { write } for  pid=1466 comm="S16ssh" name="oom_adj" dev=proc ino=5408 scontext=system_u:system_r:initrc_t:s0 tcontext=system_u:system_r:sshd_t:s0-s0:c0.c1023 tclass=file

        Was caused by:
                Policy constraint violation.

                May require adding a type attribute to the domain or type to satisfy the constraint.

                Constraints are defined in the policy sources in policy/constraints (general), policy/mcs (MCS), and policy/mls (MLS).


I expected problems to enable such thing (to write to file with context
of domain). Constraints in policy/constraints etc are rather complex.
Now I am going in the way of the least friction :) - to fill bugreport
against openssh-server with a patch, that will do OOM adjustment in the
C-code by sshd itself (like udev does).

IMO to write into /proc/N/oom_adj can be need by administrator
sometimes, so there should be some role capable to write there.

Thanks
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
