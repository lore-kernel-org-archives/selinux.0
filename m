Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O0BTrT022583
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 20:11:29 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O0AiAS007002
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:10:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 40953BF6F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 01:11:28 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 02311-05-3 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 01:11:25 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id DE0C8BF2F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 01:11:24 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzP5I-00074K-T9
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 01:22:44 +0100
Date: Tue, 24 Aug 2004 01:22:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040824002244.GA25356@lkcl.net>
References: <20040823214228.GA13677@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040823214228.GA13677@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

my apologies for the length of the patch which i had not correctly
observed: the /.?u?dev is there to deal with /.dev which on debian
linux with udev is the "real" /dev remounted (--bind?) to a different
point.

if you then run a make relabel WITHOUT the /[.u]dev, ALL devices in
/.dev get marked as oh, i dunno, default_t or something: consequently,
your next reboot will catastrophically fail as /sbin/init or something
fairly major tries to access the "real" i.e. non-udev /dev.

of course this problem would be avoided if udev was available in initrd's.


in amongst this lot are two lines that say /dev/hdc something here
we go:

> +/.?u?dev/hdc		-b	system_u:object_r:tunably_defined_disk_t
> +/.?u?dev/[h]d[^/^c]*	-b	system_u:object_r:fixed_disk_device_t

i added the ^c in order to exclude /dev/hdc, i must warn you i am CRAP
at regular expressions so please do observe sufficient caution.


anyway, as russell describes, this in combination with the tunable
for users to access non-xattr drives e.g. floppy and cd, you should
be able to run kaffeine, xine etc. and possibly even k3b / cdrecord.

but i decided to go for a separate policy file for k3b + cdrecord,
which i will macro-it-ise like mozilla is and release later.

l.


On Mon, Aug 23, 2004 at 10:42:28PM +0100, Luke Kenneth Casson Leighton wrote:
> after russell's excellent suggestion of making /dev/hdc a
> removable_device_t because i happened to have an IDE CD-RW,
> i decided to add this as a tunable because i sure don't want
> to keep on merging / patching stuff and i am sure that not
> everyone has an IDE CD-RW on their second primary ide interface.
> 
> l.
> 
> -- 
> --
> Truth, honesty and respect are rare commodities that all spring from
> the same well: Love.  If you love yourself and everyone and everything
> around you, funnily and coincidentally enough, life gets a lot better.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 

> diff -Naur 
> --- default.1.14/file_contexts/types.fc	2004-08-02 08:28:37.000000000 +0100
> +++ current/file_contexts/types.fc	2004-08-23 10:35:18.000000000 +0100
> @@ -112,109 +117,111 @@
>  #
>  # /dev
>  #
> -/u?dev(/.*)?			system_u:object_r:device_t
> -/u?dev/pts(/.*)?		<<none>>
> -/u?dev/cpu/.*		-c	system_u:object_r:cpu_device_t
> -/u?dev/microcode	-c	system_u:object_r:cpu_device_t
> -/u?dev/MAKEDEV		--	system_u:object_r:sbin_t
> -/u?dev/null		-c	system_u:object_r:null_device_t
> -/u?dev/full		-c	system_u:object_r:null_device_t
> -/u?dev/zero		-c	system_u:object_r:zero_device_t
> -/u?dev/console		-c	system_u:object_r:console_device_t
> -/u?dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
> -/u?dev/nvram		-c	system_u:object_r:memory_device_t
> -/u?dev/random		-c	system_u:object_r:random_device_t
> -/u?dev/urandom		-c	system_u:object_r:urandom_device_t
> -/u?dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
> -/u?dev/cu.*		-c	system_u:object_r:tty_device_t
> -/u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
> -/u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
> -/u?dev/tty		-c	system_u:object_r:devtty_t
> -/u?dev/[shmx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
> -/u?dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/net/.*		-c	system_u:object_r:tun_tap_device_t
> -/u?dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
> -/u?dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t
> -/u?dev/initrd		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
> -/u?dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
> -/u?dev/usb/rio500	-c	system_u:object_r:removable_device_t
> -/u?dev/fd[^/]+		-b	system_u:object_r:removable_device_t
> +/.?u?dev(/.*)?			system_u:object_r:device_t
> +/.?u?dev/pts(/.*)?		<<none>>
> +/.?u?dev/cpu/.*		-c	system_u:object_r:cpu_device_t
> +/.?u?dev/microcode	-c	system_u:object_r:cpu_device_t
> +/.?u?dev/MAKEDEV		--	system_u:object_r:sbin_t
> +/.?u?dev/null		-c	system_u:object_r:null_device_t
> +/.?u?dev/full		-c	system_u:object_r:null_device_t
> +/.?u?dev/zero		-c	system_u:object_r:zero_device_t
> +/.?u?dev/console		-c	system_u:object_r:console_device_t
> +/.?u?dev/(kmem|mem|port)	-c	system_u:object_r:memory_device_t
> +/.?u?dev/nvram		-c	system_u:object_r:memory_device_t
> +/.?u?dev/random		-c	system_u:object_r:random_device_t
> +/.?u?dev/urandom		-c	system_u:object_r:urandom_device_t
> +/.?u?dev/.*tty[^/]*	-c	system_u:object_r:tty_device_t
> +/.?u?dev/cu.*		-c	system_u:object_r:tty_device_t
> +/.?u?dev/vcs[^/]*		-c	system_u:object_r:tty_device_t
> +/.?u?dev/ip2[^/]*		-c	system_u:object_r:tty_device_t
> +/.?u?dev/tty		-c	system_u:object_r:devtty_t
> +/.?u?dev/hdc		-b	system_u:object_r:tunably_defined_disk_t
> +/.?u?dev/[h]d[^/^c]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/[smx]d[^/]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/sg[0-9]+		-c	system_u:object_r:scsi_generic_device_t
> +/.?u?dev/rd.*		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/i2o/hd[^/]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/ubd[^/]*		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/cciss/[^/]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/ida/[^/]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/dasd[^/]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/flash[^/]*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/ataraid/.*	-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/net/.*		-c	system_u:object_r:tun_tap_device_t
> +/.?u?dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/initrd		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/jsfd		-b	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/s(cd|r)[^/]*	-b	system_u:object_r:removable_device_t
> +/.?u?dev/usb/rio500	-c	system_u:object_r:removable_device_t
> +/.?u?dev/fd[^/]+		-b	system_u:object_r:removable_device_t
>  # I think a parallel port disk is a removable device...
> -/u?dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
> -/u?dev/p[fg][0-3]	-b	system_u:object_r:removable_device_t
> -/u?dev/aztcd		-b	system_u:object_r:removable_device_t
> -/u?dev/bpcd		-b	system_u:object_r:removable_device_t
> -/u?dev/gscd		-b	system_u:object_r:removable_device_t
> -/u?dev/hitcd		-b	system_u:object_r:removable_device_t
> -/u?dev/pcd[0-3]		-b	system_u:object_r:removable_device_t
> -/u?dev/mcdx?		-b	system_u:object_r:removable_device_t
> -/u?dev/cdu.*		-b	system_u:object_r:removable_device_t
> -/u?dev/cm20.*		-b	system_u:object_r:removable_device_t
> -/u?dev/optcd		-b	system_u:object_r:removable_device_t
> -/u?dev/sbpcd.*		-b	system_u:object_r:removable_device_t
> -/u?dev/sjcd		-b	system_u:object_r:removable_device_t
> -/u?dev/sonycd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/pd[a-d][^/]*	-b	system_u:object_r:removable_device_t
> +/.?u?dev/p[fg][0-3]	-b	system_u:object_r:removable_device_t
> +/.?u?dev/aztcd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/bpcd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/gscd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/hitcd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/pcd[0-3]		-b	system_u:object_r:removable_device_t
> +/.?u?dev/mcdx?		-b	system_u:object_r:removable_device_t
> +/.?u?dev/cdu.*		-b	system_u:object_r:removable_device_t
> +/.?u?dev/cm20.*		-b	system_u:object_r:removable_device_t
> +/.?u?dev/optcd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/sbpcd.*		-b	system_u:object_r:removable_device_t
> +/.?u?dev/sjcd		-b	system_u:object_r:removable_device_t
> +/.?u?dev/sonycd		-b	system_u:object_r:removable_device_t
>  # parallel port ATAPI generic device
> -/u?dev/pg[0-3]		-c	system_u:object_r:removable_device_t
> -/u?dev/rtc		-c	system_u:object_r:clock_device_t
> -/u?dev/psaux		-c	system_u:object_r:mouse_device_t
> -/u?dev/atibm		-c	system_u:object_r:mouse_device_t
> -/u?dev/logibm		-c	system_u:object_r:mouse_device_t
> -/u?dev/.*mouse.*	-c	system_u:object_r:mouse_device_t
> -/u?dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
> -/u?dev/input/event.*	-c	system_u:object_r:event_device_t
> -/u?dev/input/mice	-c	system_u:object_r:mouse_device_t
> -/u?dev/input/js.*	-c	system_u:object_r:mouse_device_t
> -/u?dev/js.*		-c	system_u:object_r:mouse_device_t
> -/u?dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
> -/u?dev/ptmx		-c	system_u:object_r:ptmx_t
> -/u?dev/sequencer	-c	system_u:object_r:misc_device_t
> -/u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
> -/u?dev/apm_bios		-c	system_u:object_r:apm_bios_t
> -/u?dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
> -/u?dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
> -/u?dev/winradio.	-c	system_u:object_r:v4l_device_t
> -/u?dev/vttuner		-c	system_u:object_r:v4l_device_t
> -/u?dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
> -/u?dev/mixer.*		-c	system_u:object_r:sound_device_t
> -/u?dev/dsp.*		-c	system_u:object_r:sound_device_t
> -/u?dev/audio.*		-c	system_u:object_r:sound_device_t
> -/u?dev/r?midi.*		-c	system_u:object_r:sound_device_t
> -/u?dev/smpte.*		-c	system_u:object_r:sound_device_t
> -/u?dev/sndstat		-c	system_u:object_r:sound_device_t
> -/u?dev/beep		-c	system_u:object_r:sound_device_t
> -/u?dev/patmgr[01]	-c	system_u:object_r:sound_device_t
> -/u?dev/mpu401.*		-c	system_u:object_r:sound_device_t
> -/u?dev/srnd[0-7]	-c	system_u:object_r:sound_device_t
> -/u?dev/aload.*		-c	system_u:object_r:sound_device_t
> -/u?dev/amidi.*		-c	system_u:object_r:sound_device_t
> -/u?dev/amixer.*		-c	system_u:object_r:sound_device_t
> -/u?dev/snd/.*		-c	system_u:object_r:sound_device_t
> -/u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
> -/u?dev/(n?raw)?qft[0-3]	-c	system_u:object_r:tape_device_t
> -/u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
> -/u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
> -/u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
> -/u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
> -/u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
> -/u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
> -/u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
> -/u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
> -/u?dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
> -/u?dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
> -/u?dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
> +/.?u?dev/pg[0-3]		-c	system_u:object_r:removable_device_t
> +/.?u?dev/rtc		-c	system_u:object_r:clock_device_t
> +/.?u?dev/psaux		-c	system_u:object_r:mouse_device_t
> +/.?u?dev/atibm		-c	system_u:object_r:mouse_device_t
> +/.?u?dev/logibm		-c	system_u:object_r:mouse_device_t
> +/.?u?dev/.*mouse.*	-c	system_u:object_r:mouse_device_t
> +/.?u?dev/input/.*mouse.*	-c	system_u:object_r:mouse_device_t
> +/.?u?dev/input/event.*	-c	system_u:object_r:event_device_t
> +/.?u?dev/input/mice	-c	system_u:object_r:mouse_device_t
> +/.?u?dev/input/js.*	-c	system_u:object_r:mouse_device_t
> +/.?u?dev/js.*		-c	system_u:object_r:mouse_device_t
> +/.?u?dev/jsflash		-c	system_u:object_r:fixed_disk_device_t
> +/.?u?dev/ptmx		-c	system_u:object_r:ptmx_t
> +/.?u?dev/sequencer	-c	system_u:object_r:misc_device_t
> +/.?u?dev/fb[0-9]*		-c	system_u:object_r:framebuf_device_t
> +/.?u?dev/apm_bios		-c	system_u:object_r:apm_bios_t
> +/.?u?dev/cpu/mtrr		-c	system_u:object_r:mtrr_device_t
> +/.?u?dev/(radio|video|vbi|vtx).* -c	system_u:object_r:v4l_device_t
> +/.?u?dev/winradio.	-c	system_u:object_r:v4l_device_t
> +/.?u?dev/vttuner		-c	system_u:object_r:v4l_device_t
> +/.?u?dev/tlk[0-3]		-c	system_u:object_r:v4l_device_t
> +/.?u?dev/mixer.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/dsp.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/audio.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/r?midi.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/smpte.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/sndstat		-c	system_u:object_r:sound_device_t
> +/.?u?dev/beep		-c	system_u:object_r:sound_device_t
> +/.?u?dev/patmgr[01]	-c	system_u:object_r:sound_device_t
> +/.?u?dev/mpu401.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/srnd[0-7]	-c	system_u:object_r:sound_device_t
> +/.?u?dev/aload.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/amidi.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/amixer.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/snd/.*		-c	system_u:object_r:sound_device_t
> +/.?u?dev/n?[hs]t[0-9].*	-c	system_u:object_r:tape_device_t
> +/.?u?dev/(n?raw)?qft[0-3]	-c	system_u:object_r:tape_device_t
> +/.?u?dev/n?z?qft[0-3]	-c	system_u:object_r:tape_device_t
> +/.?u?dev/n?tpqic[12].*	-c	system_u:object_r:tape_device_t
> +/.?u?dev/ht[0-1]		-b	system_u:object_r:tape_device_t
> +/.?u?dev/n?osst[0-3].*	-c	system_u:object_r:tape_device_t
> +/.?u?dev/n?pt[0-9]+	-c	system_u:object_r:tape_device_t
> +/.?u?dev/usb/scanner.*	-c	system_u:object_r:scanner_device_t
> +/.?u?dev/usb/dc2xx.*	-c	system_u:object_r:scanner_device_t
> +/.?u?dev/usb/mdc800.*	-c	system_u:object_r:scanner_device_t
> +/.?u?dev/usb/tty.*	-c	system_u:object_r:usbtty_device_t
> +/.?u?dev/mmetfgrab	-c	system_u:object_r:scanner_device_t
> +/.?u?dev/nvidia.*		-c	system_u:object_r:xserver_misc_device_t
>  
>  /proc(/.*)?			<<none>>
>  /sys(/.*)?			<<none>>
> diff -Naur 
> --- default.1.14/tunables/tunable.te	2004-08-02 08:28:37.000000000 +0100
> +++ current/tunables/tunable.te	2004-08-23 10:34:30.000000000 +0100
> @@ -101,7 +101,11 @@
>  dnl define(`user_net_control')
>  
>  # Allow user to rw usb devices
> -dnl define(`user_rw_usb')
> +dnl define(`user_rw_usb')
>  
>  # Allow user to connect to database server
>  define(`user_db_connect')
> +
> +# Define whether hdc is an IDE CD(RW) DVD(RW)
> +define(`hdc_is_cd_dvd')
> +
> diff -Naur 
> --- default.1.14/types/device.te	2004-08-02 08:28:37.000000000 +0100
> +++ current/types/device.te	2004-08-23 10:31:13.000000000 +0100
> @@ -73,6 +73,14 @@
>  #
>  type removable_device_t, device_type;
>  
> +# /dev/hdc could be an IDE CD/RW or DVD/RW. 
> +
> +ifdef(`hdc_is_cd_dvd', `
> +typealias removable_device_t alias tunably_defined_disk_t;
> +',`
> +typealias fixed_disk_device_t alias tunably_defined_disk_t;
> +')
> +
>  #
>  # clock_device_t is the type of
>  # /dev/rtc.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
