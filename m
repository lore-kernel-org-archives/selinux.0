Message-ID: <52F271AF.6080902@mthode.org>
Date: Wed, 05 Feb 2014 11:15:27 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org> <52EA80AC.2070802@tycho.nsa.gov>
 <52EA86D2.104@mthode.org> <2218414.0HDc6YTzKt@sifl>
In-Reply-To: <2218414.0HDc6YTzKt@sifl>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RnfCQwjBd8RJLfDWr4bPQEAHwxNppstcg"
Cc: behlendorf@llnl.gov, Richard Yao <ryao@gentoo.org>,
 Brian Behlendorf <behlendorf1@llnl.gov>, selinux@tycho.nsa.gov
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RnfCQwjBd8RJLfDWr4bPQEAHwxNppstcg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/30/2014 11:19 AM, Paul Moore wrote:
> On Thursday, January 30, 2014 11:07:30 AM Matthew Thode wrote:
>> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
>>> Try the attached patch.
>>
>> Confirmed that this fixes it :D thanks a ton for this.
>=20
> Queued up in my stable branch, I'll send a pull request to James once -=
rc1 is=20
> released.
>=20
> Thanks guys.
>=20
Mind letting me know when this has been upstreamed?

--=20
-- Matthew Thode


--RnfCQwjBd8RJLfDWr4bPQEAHwxNppstcg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8nHLAAoJECRx6z5ArFrDHSEQAKC+2nRT3Iw9EI2KNT3mR6FX
M0srumE/sLMBSfwMDYqly9mmsmgDySfvarxdbcmJCLbOA2e1jWnrveAWh9aO+S+p
fsjz+gFeVJAS1FolnHdXUKjoBgplgg/+83Tw59z+BH4TMqHnFCPjibwIi+JyAfPD
pqwgFJKsOPUqThs9Zs+4WvLUQmJ+Ikni0oJsEvYIlkYJD7aas/xnntJg8gVsFpOh
KWQbn8/bOvf7+3uj7d+D2RJZ+MyR2FbpiiaeS5RdTlNJV5mKGc7Lj6GsbW4/s+qn
Dgn48BnM/SITSPX/Qu+5/IOlePXdWAAiZmGuLuCwnRqIpLlKFGkHzB1HBxAashdZ
Bap720vTGBewqueqtBoENaYzLL6Hcv3UUWWw+L7N+9dx05q9IqMU+H+WjeQLLIvp
ER+gXr1QnM69Ujw86BmA2DSvzyBbbI4KPxgUfK8ntYfqwElJmDfnFYk7Pu4jVHRV
u0WOYmvkLurABI9KUMZDQJsl3TwqIWgedzC7a+SBmVhjnOr+ENJSapHMlGOkpk14
JS01Rzy+xPcFQMZuirRf6Ps2SLYjaKKChqMAOSu1ICJSrUshLhGYjN3FIX6RtGs9
bGYG8WcvhXKHt96PKmNrCzYqZwIVQxxBqc2kMQe13TF/oid112olCgGpp0TLPNOw
f0jMrYCpJ+bd6D3ycTWk
=KroJ
-----END PGP SIGNATURE-----

--RnfCQwjBd8RJLfDWr4bPQEAHwxNppstcg--
