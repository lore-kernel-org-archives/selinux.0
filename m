Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1GIZrma010460
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 13:35:58 -0500
Received: from mail-ew0-f226.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1GIaAGN025967
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 18:36:11 GMT
Received: by ewy26 with SMTP id 26so756715ewy.19
        for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 10:35:56 -0800 (PST)
Message-ID: <4B7AE582.4080907@gmail.com>
Date: Tue, 16 Feb 2010 19:35:46 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se> <4B7AB835.5080008@gmail.com> <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9081CCCE025D1826CC18826"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9081CCCE025D1826CC18826
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/16/2010 07:04 PM, Alan Rouse wrote:
> Dominick, thanks for the reply.   These AVC messages occur during norma=
l bootup (not from a command line), so it is the boot process which is st=
arting these in the wrong context. =20
>=20
> OpenSuSE 11.2 is still using System V init startup, but Fedora 12 is us=
ing upstart.  Perhaps that explains why the recent refpolicy is not start=
ing OpenSuse processes in the right context.  Is the current refpolicy kn=
own to work in System V init -based systems?

Oh right sorry, now i see it is system_r not sysadm_r. Looks like init
is not in the right domain i guess. I am not sure what the reason for
this is but my guess is that its (or some of its) executable(s) is
mislabelled, although that still does not explain how it got to sysadm_t.=


I am interested to hear what others say about this issue.

>=20
> -----Original Message-----
> From: Dominick Grift [mailto:domg472@gmail.com]=20
> Sent: Tuesday, February 16, 2010 10:22 AM
> To: Alan Rouse
> Cc: 'selinux@tycho.nsa.gov'
> Subject: Re: SELinux Policy in OpenSUSE 11.2
>=20
> On 02/16/2010 03:55 PM, Alan Rouse wrote:
> le
>> type=3DAVC msg=3Daudit(1265904613.689:203): avc:  denied  { execstack =
}=20
>> for  pid=3D2382 comm=3D"cupsd" scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess type=3DAVC=20
>> msg=3Daudit(1265904613.690:204): avc:  denied  { execmem } for  pid=3D=
2382=20
>> comm=3D"cupsd" scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dprocess type=3DAVC=20
>> msg=3Daudit(1265904614.260:205): avc:  denied  { read write } for =20
>> pid=3D2448 comm=3D"smartd" name=3D"sda" dev=3Dtmpfs ino=3D1749=20
>> scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:object_r:fixed_disk_device_t tclass=3Dblk_file=20
>> type=3DAVC msg=3Daudit(1265904614.260:206): avc:  denied  { open } for=
 =20
>> pid=3D2448 comm=3D"smartd" name=3D"sda" dev=3Dtmpfs ino=3D1749=20
>> scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:object_r:fixed_disk_device_t tclass=3Dblk_file=20
>> type=3DAVC msg=3Daudit(1265904614.261:207): avc:  denied  { ioctl } fo=
r =20
>> pid=3D2448 comm=3D"smartd" path=3D"/dev/sda" dev=3Dtmpfs ino=3D1749=20
>> scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:object_r:fixed_disk_device_t tclass=3Dblk_file=20
>> type=3DAVC msg=3Daudit(1265904615.964:209): avc:  denied  { read } for=
 =20
>> pid=3D2337 comm=3D"auditd" scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:system_r:sysadm_t tclass=3Dnetlink_audit_socket=20
>> type=3DAVC msg=3Daudit(1265904616.063:212): avc:  denied  { read } for=
 =20
>> pid=3D308 comm=3D"udevd" scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:system_r:sysadm_t=20
>> tclass=3Dnetlink_kobject_uevent_socket
>> type=3DAVC msg=3Daudit(1265904616.063:213): avc:  denied  { write } fo=
r =20
>> pid=3D308 comm=3D"udevd" scontext=3Dsystem_u:system_r:sysadm_t=20
>> tcontext=3Dsystem_u:system_r:sysadm_t=20
>> tclass=3Dnetlink_kobject_uevent_socket
>=20
> With regard to the AVC denials above it seems that these services (cups=
d, smartd, auditd and udevd) run in the wrong domain. When you restart se=
rvices manually, you should use "run_init".
>=20
> run_init /etc/rc.d/init.d/cupsd start
>=20
> Besides that some if this might still not work. For example execstack a=
nd execmem permissions for cupsd, but start by executing these daemons in=
 the proper domains first.
>=20
> As for dbus i have not noticed any dbus specific AVC denials. It may be=
 the dbus denials are directed to /var/log/messages, /var/log/audit/audit=
=2Elog or dmesg.
>=20
>>
>>
>>
>=20
>=20
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list=
=2E
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.go=
v with
> the words "unsubscribe selinux" without quotes as the message.



--------------enigB9081CCCE025D1826CC18826
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt65YoACgkQMlxVo39jgT/xTACfUZzhDPj1EPUJdFJB6qrDXM+R
wRQAoJGPzjoIwO9VipnhFMI0T+RsBFiJ
=sju6
-----END PGP SIGNATURE-----

--------------enigB9081CCCE025D1826CC18826--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
