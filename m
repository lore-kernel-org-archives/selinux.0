Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA5J84Vh026521
 for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2016 15:08:04 -0400
Received: by mail-wm0-f51.google.com with SMTP id a197so110330128wmd.0
 for <selinux@tycho.nsa.gov>; Sat, 05 Nov 2016 12:07:44 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id k2sm9913046wjv.11.2016.11.05.12.07.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Nov 2016 12:07:43 -0700 (PDT)
Subject: Re: Security context of shared libraries
To: selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <450453c1-af39-8875-2c2d-4db7b2171f0a@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <a9c13f40-9833-1693-2685-970e936fd86c@gmail.com>
Date: Sat, 5 Nov 2016 20:07:37 +0100
MIME-Version: 1.0
In-Reply-To: <450453c1-af39-8875-2c2d-4db7b2171f0a@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FEX024X2mCJAbibbxWji6RkAv6isq3iLo"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FEX024X2mCJAbibbxWji6RkAv6isq3iLo
Content-Type: multipart/mixed; boundary="e90ptGqcnEVJ5FwEP3PfqhlnGKglGm9NR";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <a9c13f40-9833-1693-2685-970e936fd86c@gmail.com>
Subject: Re: Security context of shared libraries
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <450453c1-af39-8875-2c2d-4db7b2171f0a@gmail.com>
In-Reply-To: <450453c1-af39-8875-2c2d-4db7b2171f0a@gmail.com>

--e90ptGqcnEVJ5FwEP3PfqhlnGKglGm9NR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/05/2016 08:04 PM, Dominick Grift wrote:
> On 11/05/2016 07:55 PM, mm wrote:
>> Hi all,
>>
>> I have an executable started by /bin/foo which runs confined within th=
e
>> context foo_t.
>> The process loads (actually does LD_PRELOAD) bar.so which needs to
>> access resources outside foo_t (actually unconfined_t).
>>
>> I can allow access to such resources from foo_t, but I would like to
>> allow such access only for code running within bar.so, instead of the
>> whole process.
>>
>> I have been looking in the docs, but I could not find if it is possibl=
e
>> to specify a source context for shared libraries, instead of whole
>> processes.
>> My idea would be to define a context bar_t for code running within
>> bar.so, and allow the required access (to unconfined_t) from bar_t,
>> without extending access for foo_t.
>>
>> Makes sense? Is it possible?
>>
>=20
> Makes sense, but is not possible AFAIK (not transparently anyway)

I mean it makes that you would want that.

>> Thanks in advance,
>> M. Manfredini
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--e90ptGqcnEVJ5FwEP3PfqhlnGKglGm9NR--

--FEX024X2mCJAbibbxWji6RkAv6isq3iLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYHi35AAoJECV0jlU3+Udpkw8MALoHLWs19YnJ9tqs9xr/RWFz
9ZU8vL6Te028mYoO36B4eplVRPGyAANw0XtSMGykiS9gabkiCcr0W2bQ6SEFZr1e
CoOWWUY+TsbmPsLTJ6+DGpeMQY7N9miuvhgUBmvUfdf508eMcEMS70HwMCxPIyvp
TTPgSbXWk1tlDIC10raHM/QjFY/OEYuND+f4jP9V2DCT+iQEC51Yc/2Se3DEePGq
uZql7UVQbZ4CjCK1z1eSM0AD4AccFyyf+Vn6tcY5ExYYbAN6sFr1Uv2E9TefOYKB
4PhvdNQFnreAX4uHInQeeIFcJEu5+3GHjK4Sjp2GHOBwc0nerzDEhRLnyVtWp6+L
esflKXTpQLglSVgHMAX62znsgr64j+7jyWgPNlpY7XskG/7aoHBpxV03xsjQtCC1
TYaaAZXhpQP9//4QMolXC3qSVFISFMqQHnTxQFEw2HMUEQ4124qEOMstHN2MUIWc
mHtTCvhH41SzcVgkJfVhhqJ6R7tSTw8uI9csis0xsQ==
=aj07
-----END PGP SIGNATURE-----

--FEX024X2mCJAbibbxWji6RkAv6isq3iLo--
