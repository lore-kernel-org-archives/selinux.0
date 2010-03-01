Subject: Re: denials with filesystem associate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20100228223834.GE3990@myhost.felk.cvut.cz>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Mon, 01 Mar 2010 09:10:01 -0500
Message-Id: <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-02-28 at 23:38 +0100, Michal Svoboda wrote:
> Hello,
> 
> see log below... what could be causing these denials? And, what
> operations exactly are those?

On file creation, there is an associate check between the security
context of the file and the security context of the containing
filesystem.  In your particular case though the real issue is that you
have an unlabeled filesystem type that needs a genfscon or fs_use rule
added to your policy.   Look for a log message that says something along
the lines of:
SELinux:  initialized (dev ..., type ...), not configured for labeling

You might need to enable kern.debug logging in your syslog
configuration.

> 
> With regards,
> Michal Svoboda
> 
> [    0.000000] Linux version 2.6.32-trunk-amd64 (Debian 2.6.32-5)
> (ben@decadent.org.uk) (gcc version 4.3.4 (Debian 4.3.4-6) ) #1 SMP Sun
> Jan 10 22:40:40 UTC 2010
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-trunk-amd64
> root=UUID=6f30ce45-1f28-4abb-9271-aa56e2af839d ro selinux=1
> 
> ...
> 
> [    2.840057] usb 1-2: new full speed USB device using uhci_hcd and
> address 2
> [    3.159070] udev: starting version 151
> [    3.191497] usb 1-2: New USB device found, idVendor=0627,
> idProduct=0001
> [    3.192862] usb 1-2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    3.193672] usb 1-2: Product: QEMU USB Tablet
> [    3.194362] usb 1-2: Manufacturer: QEMU 0.11.1
> [    3.195071] usb 1-2: SerialNumber: 1
> [    3.200148] type=1400 audit(1267376854.206:4): avc:  denied  {
> associate } for  pid=219 comm="khubd" name="002"
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
> [    3.202848] usb 1-2: configuration #1 chosen from 1 choice
> [    3.403509] type=1400 audit(1267376854.406:5): avc:  denied  {
> associate } for  pid=383 comm="modprobe" name="event0"
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
> [    3.413673] input: PC Speaker as
> /devices/platform/pcspkr/input/input3
> [    3.422709] processor LNXCPU:00: registered as cooling_device0
> [    3.440793] piix4_smbus 0000:00:01.3: SMBus Host Controller at
> 0xb100, revision 0
> [    3.442750] type=1400 audit(1267376854.446:6): avc:  denied  {
> associate } for  pid=383 comm="modprobe" name="event1"
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
> [    3.503568] type=1400 audit(1267376854.506:9): avc:  denied  {
> associate } for  pid=383 comm="modprobe" name="event2"
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
