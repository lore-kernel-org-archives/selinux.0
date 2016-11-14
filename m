Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAEBIs90022603
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 06:18:54 -0500
Received: by mail-wm0-f50.google.com with SMTP id g23so91706035wme.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 03:18:51 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id i15sm28088310wjs.16.2016.11.14.03.18.48
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Nov 2016 03:18:49 -0800 (PST)
Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
 <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
 <b7824486-d9fc-82df-2611-aff0883f1a56@gmail.com>
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <9d4356fb-0d80-af71-770d-d0a37822e182@gmail.com>
Date: Mon, 14 Nov 2016 12:18:43 +0100
MIME-Version: 1.0
In-Reply-To: <b7824486-d9fc-82df-2611-aff0883f1a56@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3aVNEaqDb0Rp3WTTqL1Tx9HNiXvJ06DVk"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3aVNEaqDb0Rp3WTTqL1Tx9HNiXvJ06DVk
Content-Type: multipart/mixed; boundary="5DR34ID8F1TdROwJpH0ENToR4IshBLQxd";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <9d4356fb-0d80-af71-770d-d0a37822e182@gmail.com>
Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
 <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
 <b7824486-d9fc-82df-2611-aff0883f1a56@gmail.com>
In-Reply-To: <b7824486-d9fc-82df-2611-aff0883f1a56@gmail.com>

--5DR34ID8F1TdROwJpH0ENToR4IshBLQxd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/14/2016 11:11 AM, Dominick Grift wrote:
> On 11/09/2016 03:52 PM, James Carter wrote:
>> On 11/09/2016 07:40 AM, Dominick Grift wrote:
>>> I am in the process of a DSSP rewrite, taking a different approach th=
is
>>> time.
>>>
>>> However I encountered something that seems suboptimal:
>>>
>>> SECILC seems to not filter redundant attributes and rules
>>>
>>> Example i have a type attribute and it has rules associated with it.
>>> However, the type attribute is not associated with any types.
>>>
>>> I was hoping that SECILC would be smart enough to determine that it
>>> might as well filter both the type attribute as well as the rules
>>> associated with it.
>>>
>>> To reproduce:
>>>
>>> git clone https://github.com/DefenSec/dssp1-base.git
>>> cd dssp1-base
>>> secilc `ls *.cil`
>>> sesearch -ASCT -s lib.ld_so.read_files_subj_type_attribute policy.30
>>> seinfo -xalib.ld_so.read_files_subj_type_attribute policy.30
>>>
>>>
>>> Am i expecting the impossible by expecting SECILC to be smart enough =
to
>>> determine that something is redundant, and that it can be filtered ou=
t
>>> until it becomes applicable?
>>>
>>>
>>
>> I don't think that it would be too hard to remove attributes that have=

>> no types associated with them along with rules containing those
>> attributes. I have this nagging feeling, though, that there is a reaso=
n
>> that we didn't do that. I'll have to think about it a bit.
>>
>> Jim
>=20
> Have you given this some thought?
>=20
> I suspect this could have significant impact.
>=20
> consider the following:
>=20
> CIL encourages the use of attributes to the fullest extent, and with
> dssp1 i have taken this to heart.
>=20
> This should make dssp1 very scale-able. The more an identifier is used
> the greater the potential benefit.
>=20
> Attributes and templates are at the heart of dssp1 and if the dssp1
> model turns out to work (it is still a work in progress and I dont quit=
e
> see where this is eventually taking me) then this would be a very
> welcome feature.
>=20
> If you want to see the current state of dssp1:
>=20
> git clone https://github.com/DefenSec/dssp1-base.git
> cd dssp1-base
> secilc `ls *.cil`
> seinfo policy.30

Here is a 10 minute demo that tries to explain the benefits and the
current drawbacks of this approach (for anyone interested)

https://www.youtube.com/watch?v=3DMdqjVgjXvM8

>=20
>>
>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>>
>>
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--5DR34ID8F1TdROwJpH0ENToR4IshBLQxd--

--3aVNEaqDb0Rp3WTTqL1Tx9HNiXvJ06DVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYKZ2UAAoJECV0jlU3+Udp4v4L/2gfXXktpDIpwQqFmRHbutY3
QeW+wTqrPSnomMZ28at2EaJdZAuwvGzqAo96GpZSfFgaGhkIb1+E8bl/30mMLvoF
bzWwYI2ZwJiJ2+aVuWXxJ4XeMZ19CfJibk7O2IIklkbDcmgj2jgRlBoBiAXRCgVt
uWxZ/x81MJLpaOtMYF9ZQCB+Rrk4alQkXsTMaNLWATAjDszAugAeqdN+eWrea3Td
Bkz5d+9fIMebKb5ni2L/nKymHxdPxi73ABqVD0k2VQyK6I/XkjC9foVxUpW4WJ2C
6qr72XB/GXiw7ZxHDkyBvcgDVNy5jR1gmHQJpJYtxwVHsNk5xqofuSwyLtrCUgpa
gPWsm2DqlsLjY/mCNuxSq9h6o+6O7SAVSwXSkNjM3/SDNIhbeHSasbbvcf8JxuR5
CXIk+sDbeCAzMcJ/ZXgfmfVYp0FEuwz/Y8xsggAXzcnQ3PKZN92rJ33lgYQrwRZQ
O5inAtkIM65C5Vu5gW/TittSH1vSJq927dUtiFznmQ==
=lXJS
-----END PGP SIGNATURE-----

--3aVNEaqDb0Rp3WTTqL1Tx9HNiXvJ06DVk--
