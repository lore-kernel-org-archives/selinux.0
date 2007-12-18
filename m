Subject: Re: Xorg modprobe denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1197949627.4790.4.camel@defiant.pebenito.net>
References: <47673B12.6040205@tycho.nsa.gov>
	 <1197949627.4790.4.camel@defiant.pebenito.net>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 08:34:01 -0500
Message-Id: <1197984841.7967.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-17 at 22:47 -0500, Chris PeBenito wrote:
> On Mon, 2007-12-17 at 22:14 -0500, Eamon Walsh wrote:
> > Attached are some denials that modprobe is encountering while loading 
> > Xorg DRI kernel modules while X server is starting up.  tty7 is the 
> > terminal where the X server is being launched (Ctrl-Alt-F7).  I'm aware 
> > that the Xorg.0.log file is supposed to be labeled xserver_log_t, but my 
> > guess is that would be denied as well.  Think this may be log messages 
> > except for the renicing stuff.
> > 
> > This is xselinux branch of refpolicy running in enforcing mode.
> 
> Based on the other kernel messages, I'm guessing that the insmod
> succeeded despite the tty and capability denials?  If so I suppose we
> can dontaudit it.

I don't think we want to dontaudit the capability denials.

> > plain text document attachment (audit_x.txt)
> > Dec 17 21:25:34 moss-charon kernel: audit(1197944734.892:71): avc:  denied  { read write } for  pid=2220 comm="modprobe" name="tty7" dev=tmpfs ino=240 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
> > Dec 17 21:25:34 moss-charon kernel: audit(1197944734.893:72): avc:  denied  { write } for  pid=2220 comm="modprobe" path="/usr/local/var/log/Xorg.0.log" dev=dm-0 ino=5701638 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:object_r:usr_t:s0 tclass=file
> > Dec 17 21:25:34 moss-charon kernel: audit(1197944734.893:73): avc:  denied  { read write } for  pid=2220 comm="modprobe" path="/dev/tty7" dev=tmpfs ino=240 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
> > Dec 17 21:25:34 moss-charon kernel: audit(1197944734.926:74): avc:  denied  { sys_nice } for  pid=2220 comm="modprobe" capability=23 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tclass=capability
> > Dec 17 21:25:34 moss-charon kernel: [drm] Initialized drm 1.1.0 20060810
> > Dec 17 21:25:34 moss-charon kernel: audit(1197944734.932:75): avc:  denied  { sys_nice } for  pid=2220 comm="modprobe" capability=23 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tclass=capability
> > Dec 17 21:25:34 moss-charon kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
> > Dec 17 21:25:34 moss-charon kernel: [drm] Initialized i915 1.11.0 20071122 on minor 0
> > Dec 17 21:25:34 moss-charon kernel: mtrr: type mismatch for c0000000,10000000 old: write-back new: write-combining
> > Dec 17 21:25:40 moss-charon kernel: mtrr: type mismatch for c0000000,10000000 old: write-back new: write-combining
> > 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
