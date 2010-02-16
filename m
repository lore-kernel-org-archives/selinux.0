Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1GFMbXA026842
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 10:22:41 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1GFMRIP013982
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 15:22:28 GMT
Received: by ey-out-1920.google.com with SMTP id 3so1404348eyh.32
        for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 07:22:38 -0800 (PST)
Message-ID: <4B7AB835.5080008@gmail.com>
Date: Tue, 16 Feb 2010 16:22:29 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig381C762C6CE63F5F2E01162A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig381C762C6CE63F5F2E01162A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/16/2010 03:55 PM, Alan Rouse wrote:
le
> type=3DAVC msg=3Daudit(1265904613.689:203): avc:  denied  { execstack }=
 for  pid=3D2382 comm=3D"cupsd" scontext=3Dsystem_u:system_r:sysadm_t tco=
ntext=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess
> type=3DAVC msg=3Daudit(1265904613.690:204): avc:  denied  { execmem } f=
or  pid=3D2382 comm=3D"cupsd" scontext=3Dsystem_u:system_r:sysadm_t tcont=
ext=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess
> type=3DAVC msg=3Daudit(1265904614.260:205): avc:  denied  { read write =
} for  pid=3D2448 comm=3D"smartd" name=3D"sda" dev=3Dtmpfs ino=3D1749 sco=
ntext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:fixed_dis=
k_device_t tclass=3Dblk_file
> type=3DAVC msg=3Daudit(1265904614.260:206): avc:  denied  { open } for =
 pid=3D2448 comm=3D"smartd" name=3D"sda" dev=3Dtmpfs ino=3D1749 scontext=3D=
system_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:fixed_disk_device=
_t tclass=3Dblk_file
> type=3DAVC msg=3Daudit(1265904614.261:207): avc:  denied  { ioctl } for=
  pid=3D2448 comm=3D"smartd" path=3D"/dev/sda" dev=3Dtmpfs ino=3D1749 sco=
ntext=3Dsystem_u:system_r:sysadm_t tcontext=3Dsystem_u:object_r:fixed_dis=
k_device_t tclass=3Dblk_file
> type=3DAVC msg=3Daudit(1265904615.964:209): avc:  denied  { read } for =
 pid=3D2337 comm=3D"auditd" scontext=3Dsystem_u:system_r:sysadm_t tcontex=
t=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_audit_socket
> type=3DAVC msg=3Daudit(1265904616.063:212): avc:  denied  { read } for =
 pid=3D308 comm=3D"udevd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=3D=
system_u:system_r:sysadm_t tclass=3Dnetlink_kobject_uevent_socket
> type=3DAVC msg=3Daudit(1265904616.063:213): avc:  denied  { write } for=
  pid=3D308 comm=3D"udevd" scontext=3Dsystem_u:system_r:sysadm_t tcontext=
=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_kobject_uevent_socket

With regard to the AVC denials above it seems that these services
(cupsd, smartd, auditd and udevd) run in the wrong domain. When you
restart services manually, you should use "run_init".

run_init /etc/rc.d/init.d/cupsd start

Besides that some if this might still not work. For example execstack
and execmem permissions for cupsd, but start by executing these daemons
in the proper domains first.

As for dbus i have not noticed any dbus specific AVC denials. It may be
the dbus denials are directed to /var/log/messages,
/var/log/audit/audit.log or dmesg.

>=20
>=20
>=20



--------------enig381C762C6CE63F5F2E01162A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt6uDwACgkQMlxVo39jgT9iKgCeNTuMuzrS64q4RElmO8i6fgdB
15AAniS7jX0Sen+3FCRB5+rmHLdBTPQN
=ZBJg
-----END PGP SIGNATURE-----

--------------enig381C762C6CE63F5F2E01162A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
