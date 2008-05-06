Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m46E4X3H002750
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 10:04:34 -0400
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m46E4VF5013833
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 14:04:32 GMT
Date: Tue, 6 May 2008 16:04:29 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-ssh@lists.debian.org
Subject: Re: [refpolicy] initrc_t access to sshd /proc to adjust OOM killer
Message-ID: <20080506140429.GA24757@bobek.pm.i.cz>
References: <20080502143041.GA26592@bobek.pm.i.cz> <481B2E15.7070703@redhat.com> <20080505130521.GA13631@bobek.pm.i.cz> <481F3ACE.9090908@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <481F3ACE.9090908@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 05, 2008 at 12:50:22PM -0400, Daniel J Walsh wrote:
...
> Václav Ovsík wrote:
...
> > Great, I got:
> > 
> > [   19.816342] type=1400 audit(1209977556.108:5): avc:  denied  { write } for  pid=1466 comm="S16ssh" name="oom_adj" dev=proc ino=5408 scontext=system_u:system_r:initrc_t:s0 tcontext=system_u:system_r:sshd_t:s0-s0:c0.c1023 tclass=file
> > 
> >         Was caused by:
> >                 Policy constraint violation.
> > 
> >                 May require adding a type attribute to the domain or type to satisfy the constraint.
> > 
> >                 Constraints are defined in the policy sources in policy/constraints (general), policy/mcs (MCS), and policy/mls (MLS).
> > 
> > 
> > I expected problems to enable such thing (to write to file with context
> > of domain). Constraints in policy/constraints etc are rather complex.
> > Now I am going in the way of the least friction :) - to fill bugreport
> > against openssh-server with a patch, that will do OOM adjustment in the
> > C-code by sshd itself (like udev does).
> > 
> > IMO to write into /proc/N/oom_adj can be need by administrator
> > sometimes, so there should be some role capable to write there.
> > 
> > Thanks
> 
> The problem is that initrc_t is running at s0 and you are trying to
> communicate with s0-s0:c0.c1024.  I think at reboot this would work.
> Strange that you are logging in at s0?
...

Yes, you are right! I did ssh to machine and then run
newrole -r sysadm_r from account with default MLS - s0.

sid:~# semanage login -l

Login Name                SELinux User              MLS/MCS Range            

__default__               user_u                    s0                       
root                      root                      s0-s0:c0.c1023           
system_u                  system_u                  s0-s0:c0.c1023           
zito                      staff_u                   s0                       

When I login directly on console as root, I have context
root:sysadm_r:sysadm_t:s0-s0:c0.c1023 and after adding the TE rule:

    allow sysadm_t sshd_t:file write_file_perms;

The operation

    echo 0 >/proc/$(</var/run/sshd.pid )/oom_adj

was quiet! The operation in boot sshd startup script in domain initrc_t
has also level s0 only. I must learn more about MLS and play with it
a bit.
Thanks for reply.
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
