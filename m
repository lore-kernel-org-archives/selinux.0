Message-ID: <557AD7D9.8090400@redhat.com>
Date: Fri, 12 Jun 2015 15:00:09 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Only invoke RPM on RPM-enabled Linux distributions
References: <20150609112624.GA10618@siphos.be>
 <5576D9CC.3020102@tycho.nsa.gov> <20150611152202.GA13058@siphos.be>
In-Reply-To: <20150611152202.GA13058@siphos.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S7aIE5tvBg5u2jRR9We9fBHjhurfk5AGa"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S7aIE5tvBg5u2jRR9We9fBHjhurfk5AGa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dne 11.6.2015 v 17:22 Sven Vermeulen napsal(a):
> On Tue, Jun 09, 2015 at 08:19:24AM -0400, Stephen Smalley wrote:
>> On 06/09/2015 07:26 AM, Sven Vermeulen wrote:
>>> In this patch, we use the Python platform module to get the Linux
>>> distribution, and only start the RPM-related activities on Linux
>>> distributions that use RPM as their native package manager.
>>>
>>> Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
>>
>> Is there a more general way that we could do this without hardcoding
>> checks of distribution names?  Maybe we could just test for the
>> existence of rpm?
>=20
> That wouldn't be sufficient.
>=20
> The rpm binary might be installed for other reasons. The code in sepoli=
cy is
> used to query the rpm database and search for specific package names. T=
his
> is distribution-specific behavior.
>=20
> If you rather check on the rpm binary, then additional checks will need=
 to
> be added to make sure that the assumptions that the code takes (such as=

> "selinux-policy" package being available) are valid as well.


It might be useful to amend the code to check a return value of
get_rpm_nvr_list(). If it's None, you can assume that rpm is not
installed since rpmlib is probably unusable or there's no valid rpm
database entries.

Petr
--=20
Petr Lautrbach



--S7aIE5tvBg5u2jRR9We9fBHjhurfk5AGa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVetfeAAoJEGOorUuYLENzMacP/107LtHD2F8WfecXcJg2v4gV
C2KdnFzLhnM6CI4zA7vS1ymxEteZvLDEBF0dqx5yuoDw4KBHAhdiOmjLWCSLjZ4m
XqsRQm9RwhBrtA9qioIQ0LXb23eII9bmqW7TMsyiFTPPbchLbtSnNTqBRzmn+omU
MfhF1X66sdVmpO2pzoM0wqXa7DigwNR0X3ws1wtiqgFmi9MorVKGVQJcYxjUst2k
s9E0u8cyssygGEc43+dKxY7A7fqv5k3cF9ZKMMWsiTg5xYyDwPyKIMtNeLoIk6Iz
P37gAQrCsQTorIFvFmkCmdp5fEeI7Qo+JE0dGe6rzRVZE8eFSJE0t2nKEp3oh/HD
u38/t5eGVRmqR0ieAsKJEYTWiIbrSCOiXZvnm3V0/bxJEUrxfM+RYSwfHN6k0+Cn
v3R/cynJ0jA6sUNXjrabHQZylxm/um5thGWlvBH/cKvk+w9HFzqZ5BsmLDX6djPO
Ts39G+/oZ2Vu17co09yYQr/4N3GuobrDuyUXzuviOovJrE64lcOjfJGdGIPeXQgq
esyGxpA/0nRza0/OaX3oQiM0S5hxm3sh9VK8GEhYj5XRiyWnkIdqqvQ2DxiROnKC
tLWmaw3rodKrDbHXUmTp7VBo9gVeUjqt4C0xfnjPurGoNQQYZOgNUHnrC5sK0ejh
091uEMG4GQxwr6cuDC3H
=jaJF
-----END PGP SIGNATURE-----

--S7aIE5tvBg5u2jRR9We9fBHjhurfk5AGa--
