Subject: Re: refpolicy: syscall init_module needs sys_nice & setsched
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: SELinux List <selinux@tycho.nsa.gov>, Martin Orr <martin@martinorr.name>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@gentoo.org>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <20080522122919.GA32485@bobek.pm.i.cz>
References: <1197949627.4790.4.camel@defiant.pebenito.net>
	 <1197984841.7967.5.camel@moss-spartans.epoch.ncsc.mil>
	 <1197986223.7967.17.camel@moss-spartans.epoch.ncsc.mil>
	 <476988ED.4070003@martinorr.name>
	 <1199374256.12626.292.camel@gorn.columbia.tresys.com>
	 <47673B12.6040205@tycho.nsa.gov>
	 <1197949627.4790.4.camel@defiant.pebenito.net>
	 <1197984841.7967.5.camel@moss-spartans.epoch.ncsc.mil>
	 <1197986223.7967.17.camel@moss-spartans.epoch.ncsc.mil>
	 <476988ED.4070003@martinorr.name>  <20080522122919.GA32485@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 22 May 2008 14:29:46 -0400
Message-Id: <1211480986.11188.152.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-05-22 at 14:29 +0200, Václav Ovsík wrote:
> while playing with current Debian Sid, Linux 2.6.25 I noticed, denials
> on modprobe:
> 
> May 22 07:26:11 sid kernel: [    9.195474] type=1400 audit(1211433957.144:3): avc:  denied  { sys_nice } for  pid=801 comm="modprobe" capability=23 scontext=system_u:system_r:insmod_t:s0-s0:c0.c1023 tcontext=system_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=capability
> May 22 07:26:11 sid kernel: [    9.198362] type=1400 audit(1211433957.144:3): avc:  denied  { setsched } for  pid=801 comm="modprobe" scontext=system_u:system_r:insmod_t:s0-s0:c0.c1023 tcontext=system_u:system_r:kernel_t:s0 tclass=process
> 
> After a longer investigation with git-bisect I found, that above
> denials appeared after kernel commit:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=85653af7d488702165eba72c6c1dd0250fae4e70
> A function stop_machine() (from kernel/stop_machine.c) was changed in
> this commit in such a way, that system calls init_module()
> & delete_module() needs sys_nice & setsched. I did'n try to understand
> code too much (consequences of this commit).
> 
> I found in the history of SE Linux mailing list Martin Orr sent a patch
> already. (The correspondence attached.)
> The Martins patch is available at URL:
> http://www.martinorr.name/selinux/patches/151_module_setsched

I added that and comments as to why its needed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
