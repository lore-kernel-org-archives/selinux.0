Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1SMclaU012951
	for <selinux@tycho.nsa.gov>; Sun, 28 Feb 2010 17:38:47 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1SMd7kO011939
	for <selinux@tycho.nsa.gov>; Sun, 28 Feb 2010 22:39:07 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o1SMcZrK014846
	for <selinux@tycho.nsa.gov>; Sun, 28 Feb 2010 23:38:35 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o1SMcYim054224
	for <selinux@tycho.nsa.gov>; Sun, 28 Feb 2010 23:38:35 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Sun, 28 Feb 2010 23:38:34 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux <selinux@tycho.nsa.gov>
Subject: denials with filesystem associate
Message-ID: <20100228223834.GE3990@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

see log below... what could be causing these denials? And, what
operations exactly are those?

With regards,
Michal Svoboda

[    0.000000] Linux version 2.6.32-trunk-amd64 (Debian 2.6.32-5)
(ben@decadent.org.uk) (gcc version 4.3.4 (Debian 4.3.4-6) ) #1 SMP Sun
Jan 10 22:40:40 UTC 2010
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-trunk-amd64
root=UUID=6f30ce45-1f28-4abb-9271-aa56e2af839d ro selinux=1

...

[    2.840057] usb 1-2: new full speed USB device using uhci_hcd and
address 2
[    3.159070] udev: starting version 151
[    3.191497] usb 1-2: New USB device found, idVendor=0627,
idProduct=0001
[    3.192862] usb 1-2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    3.193672] usb 1-2: Product: QEMU USB Tablet
[    3.194362] usb 1-2: Manufacturer: QEMU 0.11.1
[    3.195071] usb 1-2: SerialNumber: 1
[    3.200148] type=1400 audit(1267376854.206:4): avc:  denied  {
associate } for  pid=219 comm="khubd" name="002"
scontext=system_u:object_r:unlabeled_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
[    3.202848] usb 1-2: configuration #1 chosen from 1 choice
[    3.403509] type=1400 audit(1267376854.406:5): avc:  denied  {
associate } for  pid=383 comm="modprobe" name="event0"
scontext=system_u:object_r:unlabeled_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
[    3.413673] input: PC Speaker as
/devices/platform/pcspkr/input/input3
[    3.422709] processor LNXCPU:00: registered as cooling_device0
[    3.440793] piix4_smbus 0000:00:01.3: SMBus Host Controller at
0xb100, revision 0
[    3.442750] type=1400 audit(1267376854.446:6): avc:  denied  {
associate } for  pid=383 comm="modprobe" name="event1"
scontext=system_u:object_r:unlabeled_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
[    3.503568] type=1400 audit(1267376854.506:9): avc:  denied  {
associate } for  pid=383 comm="modprobe" name="event2"
scontext=system_u:object_r:unlabeled_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem


--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuK8GoACgkQg/fU9pp1uX5RLQCgmD79IqxifdXId6d/rvjTVDFy
XAEAn2c7E0F8AK1Rry/W/77BnuZZYgc+
=bL8f
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
