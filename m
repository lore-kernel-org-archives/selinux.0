Subject: Re: network and module problems
From: Timothy Wood <timothy@hallcomp.com>
To: Paul Krumviede <pwk@acm.org>
Cc: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tislabs.com>
In-Reply-To: <78301711.1011942185@localhost>
References: <1011969383.1945.1.camel@phobos>
	<78301711.1011942185@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BVS0PnIGfVNyV9Bt1aT6"
Date: 25 Jan 2002 11:35:22 -0500
Message-Id: <1011976523.2215.4.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BVS0PnIGfVNyV9Bt1aT6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-01-25 at 10:03, Paul Krumviede wrote:
> --On Friday, 25 January, 2002 09:36 -0500 Timothy Wood=20
> <timothy@hallcomp.com> wrote:
>=20
> are you running this inside a VMware virtual machine? i had to create
> a policy file for that environment (which is yet to be tested with the
> latest release; i'll send it to the list once that happens). the VMware
> dualconf script instantiates /etc/modules.conf (and some other
> files for X11) as a symlink to the appropriate "real" file depending
> on whether one boots the guest OS as a virtual machine or on the
> real hardware.
>=20
> -paul

Yes, I am running it in a VM.  I just looked at the context of the
modules files in /etc and noticed they were different, probably because
I installed the VMware tools after I relabled the files.  I did a make
relabel and I can insmod things now but the lo and eth0 interfaces still
never raise.  What I still don't see is how the lo interface never loads
because as far as I know the lo interface doesn't have a module.  I'm
sifting through dmesg once again, a little more closely this time, and
I"m seeing a lot of wierd things.  Someone tell me if all this looks
right.

(right after journalled loads)
kernel: There is already a security framework initialized,
register_security failed.
kernel: Failure registering capabilities with the kernel
kernel: selinux_register_security:  Registering secondary module
capability
localhost kernel: Capability LSM initialized

...

kernel: pcnet32_probe_pci: found device 0x001022.0x002000
kernel: PCI: Enabling device 00:11.0 (0001 -> 0003)
kernel: PCI: Assigned IRQ 10 for device 00:11.0
keytable: Loading system font: succeeded
kernel: ioaddr=3D0x001080 resource_flags=3D0x000101
kernel: eth0: PCnet/PCI II 79C970A at 0x1080, 00 50 56 4a 80 ad
kernel: pcnet32: pcnet32_private lp=3Dc1151000 lp_dma_addr=3D0x1151000
assigned IRQ 10
kernel: pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de

...

kernel: task_precondition:  assigning context system_u:system_r:kernel_t
to pid 1 exe=3Dnone
kernel: task_precondition:  assigning context system_u:system_r:kernel_t
to pid 1 exe=3Dnone

...

kernel: avc:  denied  { read } for  pid=3D74 exe=3D/sbin/insmod
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:insmod_t
tcontext=3Dsystem_u:object_r:modules_conf_t tclass=3Dlnk_file
kernel:
kernel: avc:  denied  { read } for  pid=3D108 exe=3D/sbin/depmod
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:depmod_t
tcontext=3Dsystem_u:object_r:modules_conf_t tclass=3Dlnk_file
kernel:
kernel: avc:  denied  { read } for  pid=3D110 exe=3D/bin/grep
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:initrc_t
tcontext=3Dsystem_u:object_r:modules_conf_t tclass=3Dlnk_file
kernel: task_precondition:  assigning context system_u:system_r:init_t
to pid 2 exe=3Dnone
kernel: task_precondition:  assigning context system_u:system_r:kernel_t
to pid 3 exe=3Dnone
kernel: task_precondition:  assigning context system_u:system_r:kernel_t
to pid 4 exe=3Dnone
kernel: task_precondition:  assigning context system_u:system_r:kernel_t
to pid 5 exe=3Dnone
kernel: task_precondition:  assigning context system_u:system_r:kernel_t
to pid 6 exe=3Dnone
kernel: task_precondition:  assigning context system_u:system_r:init_t
to pid 7 exe=3Dnone

...

kernel: avc:  denied  { read } for  pid=3D220 exe=3D/usr/sbin/updfstab
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:fsadm_t
tcontext=3Dsystem_u:object_r:modules_conf_t tclass=3Dlnk_file

...

kernel: avc:  denied  { read } for  pid=3D220 exe=3D/usr/sbin/updfstab
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:fsadm_t
tcontext=3Dsystem_u:object_r:modules_conf_t tclass=3Dlnk_file

...

kernel: avc:  denied  { unlink } for  pid=3D251 exe=3D/bin/rm
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:initrc_t
tcontext=3Dsystem_u:object_r:modules_conf_t tclass=3Dlnk_file

...

kernel: avc:  denied  { unlink } for  pid=3D253 exe=3D/bin/rm
path=3D/etc/X11/X dev=3D08:01 ino=3D102038 scontext=3Dsystem_u:system_r:ini=
trc_t
tcontext=3Dsystem_u:object_r:etc_t tclass=3Dlnk_file

...

kernel: avc:  denied  { read } for  pid=3D268 exe=3D/sbin/insmod
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:kmod_t
tcontext=3Dsystem_u:object_r:etc_runtime_t tclass=3Dlnk_file

...

kernel: avc:  denied  { read } for  pid=3D329 exe=3D/sbin/insmod
path=3D/etc/modules.conf dev=3D08:01 ino=3D213709
scontext=3Dsystem_u:system_r:insmod_t
tcontext=3Dsystem_u:object_r:etc_runtime_t tclass=3Dlnk_file

...

network: Setting network parameters:  succeeded=20
ifup: Cannot send dump request: Connection refused=20

now I tried doing a tail -f on /var/log/messages and then switching to
another VT to raise both the lo and eth0 interfaces and nothing was
logged but I still get that dump request refused message.  Could the
selinux be blocking the device from being opened or something?

I'm going to download this new version, but should I just get the patch
and apply it to the current version I have or what?

Timothy,


--=-BVS0PnIGfVNyV9Bt1aT6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8UYlKf/PqxrKarmgRAt26AJ92W5yHupLcpDFM34J0vX/YykYQjACeMY5w
8usXXrxiqBawHu4TWMEQ1A0=
=yXp3
-----END PGP SIGNATURE-----

--=-BVS0PnIGfVNyV9Bt1aT6--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
