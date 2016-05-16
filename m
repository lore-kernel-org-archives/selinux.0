Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4GAp4oI008544
 for <selinux@tycho.nsa.gov>; Mon, 16 May 2016 06:51:04 -0400
Subject: Re: [PATCH] policycoreutils: fix the extract example in semodule.8
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <1462865989-19741-1-git-send-email-plautrba@redhat.com>
 <5adb4684-4503-9f5c-2657-3c84fa4d1514@m4x.org>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <ec899032-388e-8ad2-5f58-03e5e052646b@redhat.com>
Date: Mon, 16 May 2016 12:50:57 +0200
MIME-Version: 1.0
In-Reply-To: <5adb4684-4503-9f5c-2657-3c84fa4d1514@m4x.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NSGV1rid3esqS3Ev2x9hjOqfiwrBXVdot"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NSGV1rid3esqS3Ev2x9hjOqfiwrBXVdot
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/10/2016 07:04 PM, Nicolas Iooss wrote:
> On 05/10/2016 09:39 AM, Petr Lautrbach wrote:
>> The man page's example suggested to use -g instead of -E
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  policycoreutils/semodule/semodule.8 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/sem=
odule/semodule.8
>> index 6db390c..e5b54b3 100644
>> --- a/policycoreutils/semodule/semodule.8
>> +++ b/policycoreutils/semodule/semodule.8
>> @@ -121,7 +121,7 @@ $ semodule \-B \-p "/tmp"
>>  $ semodule \-B \-S "/tmp/var/lib/selinux"
>>  # Write the HLL version of puppet and the CIL version of wireshark
>>  # modules at priority 400 to the current working directory
>> -$ semodule \-X 400 \-g wireshark \-\-cil \-g puppet \-\-hll
>> +$ semodule \-X 400 \-E wireshark \-\-cil \-E puppet \-\-hll
>=20
> Actually this command extracts the HLL version of wireshark and the CIL=

> version of puppet (it creates wireshark.pp and puppet.cil on my system
> with checkpolicy 2.5).  In order to do what the comment suggests, the
> --cil and --hll flags need to be set before the -E options: semodule -X=

> 400 --cil -E wireshark --hll -E puppet.
>=20
> -- Nicolas
>=20

I overlooked that. Thanks.

I'll prepare another patch.

Petr
--=20
Petr Lautrbach



--NSGV1rid3esqS3Ev2x9hjOqfiwrBXVdot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXOaYRAAoJEGOorUuYLENzFWAQAI1jeDFfr6NXXOeB+7U5IfRL
wTuFC85oZ31R30CNqTWb6eHQEMXr5Q0mFgcIkAkPvnSewYFHbuwORu7uFY/t96Ro
AZrbNjqNR2uErDD//9WbysItr43whEyNYexAna5gFwkFp7UGOBo0Aap5yJE5zo8G
JD91fv6/WkH+xEPGHbWsCD/9FblkvAg6Wp41on4y6wef7y2fcW1iZuFF48k6JiUg
JaIJ8ovJ42OL+flYt+MypxUBPxqnK4vrYd0VkfnBIn2/wSHVAXH4tbC3kKPMiheo
2Y1ePQUYjouRYe+ZfDfVUUP/c4TH+fW7kHHzLaNv2o15rC+ORMEG0Eaz+b2r6MSX
LIFQdmsvZeu6wRhF5Oc2PdLbDPp40nZOrjPiC98KEie17FToP9UoY97qaB921L11
A0CliXQaO0Y3ibLH2yvm1Ddsm2L9Nwa+4toK/wbyzHYMybFtp1F+ER+1nsGc1WSy
zJAXr9fMJCdT4LQapvK68ashC0zl5CmPs7wqhFoBhYgcGtVnu920wZBNT3ehKJIg
//cgZMZzmr+k3sixx//8YyXUsS6MpeavcnjB9dkSqLjGxt6F5GqXvSBwHgmhLXc5
5hB0C0mXE6X7mzHPZw7xwkpW2iy3rrrm/rf8xaMXE5ojvACxBRjL36aHtjjzSBnT
MOuIeQihIItqXWECAQuc
=+BdQ
-----END PGP SIGNATURE-----

--NSGV1rid3esqS3Ev2x9hjOqfiwrBXVdot--
