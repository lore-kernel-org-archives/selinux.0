Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5SB2otL032594
 for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2016 07:02:51 -0400
Received: by mail-wm0-f44.google.com with SMTP id r201so22005475wme.1
 for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2016 04:02:33 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id qm9sm1252483wjc.36.2016.06.28.04.02.30
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Jun 2016 04:02:30 -0700 (PDT)
Subject: Re: New rules on restrict kernel module loading
To: selinux@tycho.nsa.gov
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
Date: Tue, 28 Jun 2016 13:02:21 +0200
MIME-Version: 1.0
In-Reply-To: <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F1em5vAqoUPXOkj1uhRrqMLP4xsco3Uud"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F1em5vAqoUPXOkj1uhRrqMLP4xsco3Uud
Content-Type: multipart/mixed; boundary="4cEkR9Aj89NAX3LkTN01wn3hrMEV9NBi4"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
Subject: Re: New rules on restrict kernel module loading
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
In-Reply-To: <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>

--4cEkR9Aj89NAX3LkTN01wn3hrMEV9NBi4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/22/2016 09:02 PM, Jeffrey Vander Stoep wrote:
> selinux@tycho.nsa.gov to bcc
>=20
> Hi Ravi,
>=20
> The intent is not to restrict which processes may load modules, but to
> place restrictions on the origin of the module itself. Modules, like th=
e
> kernel, should live on a verity protected partition.
>=20
> If you want system apps to load a kernel module from the system partiti=
on
> you just need to add an allow rule. e.g.
>=20
> # system_app loads /system/lib/module/wlan.ko
> allow system_app system_file:system module_load;
>=20
> Similar rules may be added for platform_app or system_server.
>=20

In Fedora rawhide i see these where the target is "self". example:

allow kmod self:system module_load;

is that intended?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--4cEkR9Aj89NAX3LkTN01wn3hrMEV9NBi4--

--F1em5vAqoUPXOkj1uhRrqMLP4xsco3Uud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXcllBAAoJECV0jlU3+UdpNTIL/A01owSpkoEErPdQb/M6mcvi
6UMQQTYzYVxhlG9VnJneC1JNj2fJ6G+ki5ma2QVnjTXSZ332GraKwotxRVcpz9SK
eFo044AcUgM/88QpI4VPx0namTzIeptJX3/0IHCchZl0iD7NtiyfxdPzVKVNVahh
n7dEPUrDNA5icpVzwbiAyIJ692RlibtJWtkvWiKHR5ja3O2j39PGm3pQYgv0TYAH
V9LH/LVb7cFTAXiDsVt7b9RPtiFg2nDAL9ABnRZ7M7uf82o0zZMIRcVA9pAeBOgR
IGsRZXQink+AxbCxIoenlDPW8CEhX83L3hSZ22LBOeGRBJ03muF5Hz8CcmiXe+km
eXqg5BwfyrnSP/7NIj3TsLueZywiBvh9esulHUJtOczIsy1XmPYJSDKCsdMdiPQL
FNCKKEYvIpcOQ03yPQ7exuEpE7yG3LN6VK5GM5wNuW9lZhipRCsnAfcdsK3YMt0C
zRuzAyLgM8FmVyQlutRtHV014l4nsJx048Q3AuIG6w==
=mpQN
-----END PGP SIGNATURE-----

--F1em5vAqoUPXOkj1uhRrqMLP4xsco3Uud--
