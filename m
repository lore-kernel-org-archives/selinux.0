Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0DKhmAZ013418
 for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2017 15:43:48 -0500
Received: by mail-wm0-f50.google.com with SMTP id c206so87974543wme.0
 for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2017 12:43:41 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id x135sm6740876wme.23.2017.01.13.12.43.39
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Jan 2017 12:43:39 -0800 (PST)
Subject: Re: New Blog on how SELinux blocked Docker container escape.
To: selinux@tycho.nsa.gov
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <dafd89f0-fb98-8f7b-89fe-8fce530be57f@gmail.com>
Date: Fri, 13 Jan 2017 21:43:29 +0100
MIME-Version: 1.0
In-Reply-To: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mP6I0TB7vX5ATloPGenGoQ5SU52vDJJhe"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mP6I0TB7vX5ATloPGenGoQ5SU52vDJJhe
Content-Type: multipart/mixed; boundary="bqIA4WRiLTsLTkWItwpfHuQ736Lb68rxw";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <dafd89f0-fb98-8f7b-89fe-8fce530be57f@gmail.com>
Subject: Re: New Blog on how SELinux blocked Docker container escape.
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
In-Reply-To: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>

--bqIA4WRiLTsLTkWItwpfHuQ736Lb68rxw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 08:48 PM, Daniel J Walsh wrote:
> http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-seli=
nux/

good job, but a minor suggestion. you raise the impression that SELinux
did this, and even though SELinux made this possible, your policy is
what actually achieved this by telling SELinux what to do.

I think it is important to make this distinction, not for us, but for
the crowd that is not so familiar with the matter. People often
blame/praise SELinux for the policy it enforces.


>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--bqIA4WRiLTsLTkWItwpfHuQ736Lb68rxw--

--mP6I0TB7vX5ATloPGenGoQ5SU52vDJJhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYeTv1AAoJECV0jlU3+UdpOsAL/iU/LjazCkidy9uE04OxSizD
iu5kRqMi46mC2HAkaiqo2AVB53L1Wp0c7WthOnOAa9Y/lvaLeUCc/6lcnTIsuHWX
4ozWQrlcLrSrnaynXldViLWP9IoKY9Buuza3vOqY4oPM9MadEHp4mmblEXBRyg/Q
HAONHQ2gt5KCm/bo07inQaGZlfEFjd427TXeULbIaL8hzuBNOrPuPazb4xixmIpm
AIOIuPzH4VRwWMwRui6vpq+S2QB5M9fu7ySANn5ijgz0JYv5fqmZl9x83eSNQdfd
hyH7Kwi8MFnn8QST/xiWLtDrftpDxPm6tseKYjls4eIJfowHp8AzAjTLXcsYAUnC
fWL/pJD6qLwZ1hEAAuhmy0+LUC2/HJnazwi8I2kEdVg9tLkKYqPaisQ+36cu07Fp
Q/9UISKZV9JVUPSLZGHjYAdAI0KMkS0lCQBST3z6CnDOXl4P9NL516l9dLts7SDg
EGSyyGujrCmxic5RVDR6zDoWMGcF+ThDPJKTCt0SIg==
=Jza1
-----END PGP SIGNATURE-----

--mP6I0TB7vX5ATloPGenGoQ5SU52vDJJhe--
