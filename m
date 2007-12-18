Message-ID: <47673B12.6040205@tycho.nsa.gov>
Date: Mon, 17 Dec 2007 22:14:26 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Xorg modprobe denials
Content-Type: multipart/mixed;
 boundary="------------090608040604050105090801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090608040604050105090801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached are some denials that modprobe is encountering while loading 
Xorg DRI kernel modules while X server is starting up.  tty7 is the 
terminal where the X server is being launched (Ctrl-Alt-F7).  I'm aware 
that the Xorg.0.log file is supposed to be labeled xserver_log_t, but my 
guess is that would be denied as well.  Think this may be log messages 
except for the renicing stuff.

This is xselinux branch of refpolicy running in enforcing mode.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------090608040604050105090801
Content-Type: text/plain;
 name="audit_x.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit_x.txt"

Dec 17 21:25:34 moss-charon kernel: audit(1197944734.892:71): avc:  denied  { read write } for  pid=2220 comm="modprobe" name="tty7" dev=tmpfs ino=240 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
Dec 17 21:25:34 moss-charon kernel: audit(1197944734.893:72): avc:  denied  { write } for  pid=2220 comm="modprobe" path="/usr/local/var/log/Xorg.0.log" dev=dm-0 ino=5701638 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:object_r:usr_t:s0 tclass=file
Dec 17 21:25:34 moss-charon kernel: audit(1197944734.893:73): avc:  denied  { read write } for  pid=2220 comm="modprobe" path="/dev/tty7" dev=tmpfs ino=240 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
Dec 17 21:25:34 moss-charon kernel: audit(1197944734.926:74): avc:  denied  { sys_nice } for  pid=2220 comm="modprobe" capability=23 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tclass=capability
Dec 17 21:25:34 moss-charon kernel: [drm] Initialized drm 1.1.0 20060810
Dec 17 21:25:34 moss-charon kernel: audit(1197944734.932:75): avc:  denied  { sys_nice } for  pid=2220 comm="modprobe" capability=23 scontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tcontext=system_u:system_r:insmod_t:s0-s0:c0.c255 tclass=capability
Dec 17 21:25:34 moss-charon kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
Dec 17 21:25:34 moss-charon kernel: [drm] Initialized i915 1.11.0 20071122 on minor 0
Dec 17 21:25:34 moss-charon kernel: mtrr: type mismatch for c0000000,10000000 old: write-back new: write-combining
Dec 17 21:25:40 moss-charon kernel: mtrr: type mismatch for c0000000,10000000 old: write-back new: write-combining


--------------090608040604050105090801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
