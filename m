Message-ID: <52EA8D4D.5080707@mthode.org>
Date: Thu, 30 Jan 2014 11:35:09 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org> <52EA80AC.2070802@tycho.nsa.gov>
 <52EA86D2.104@mthode.org> <2218414.0HDc6YTzKt@sifl>
In-Reply-To: <2218414.0HDc6YTzKt@sifl>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kJModphsqGs4XmxM4wLMMaIHdv07hEuEo"
Cc: behlendorf@llnl.gov, Richard Yao <ryao@gentoo.org>,
 Brian Behlendorf <behlendorf1@llnl.gov>, selinux@tycho.nsa.gov
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kJModphsqGs4XmxM4wLMMaIHdv07hEuEo
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
Any chance for backport to 3.13?

--=20
-- Matthew Thode


--kJModphsqGs4XmxM4wLMMaIHdv07hEuEo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6o1TAAoJECRx6z5ArFrDjdgQALbfyPAWLdMqClvEzCwdfWoa
Tn9boQazVoqWAoIns/7PV6pJNxRAnDlGu/r7enGwcjwpnq83oiK87WpdICWuwQwo
+3IOk0OGzQcAlN8EfO4H/AM8VFgXlyPEESTHVU9JDPRlWqcvXL6U2K1+V2miHwTk
ntyN1WhSooIj8Y6Od0ZLWJqSS0W++5gmx5EJkZQPc2BMxK35/WZueLa0xSn7ooxB
/RjhZL7t+i8YqrCPzGl4+fgYWOF5lrD7Iz8URab6PBwc2pq6jduw0jujLcvfj9JR
2aetSZ65s5hfpOi1JAbKnNP+bTBhXzkF1BBtio2dUmnq4Xn3oaS8BYtY/YV9kRRZ
hTjW2MGQU5t3HP/YdCgZJQfsiXiX31ANpWf+mRKqg66Cqddoz8yl79meg2gUZAI9
JC7m1WAMpnDdwl1V7Kgx5HcpTGrsMn+Xl2Avj3c2EtU6pjbBPXg7dlXrY5iNDrJ9
bHwp2NWrLtJhrQXzWZv0EQOl9hA2Ih1vvcRQwpfAK0jhHl46qOV4LcZJmY+vjGKv
WXNcdFb6mFskLIjm8Cd9GTfhE3dF9lGTELZL2KEDwcdUBcXEiTXc7zS2nX374A6Z
daHBlcNAcl9UK2pSMUIUM+4slXDPA8kOpPDPNvSupgROWt0PlK5BJIq3JOux1dfm
0gIlE/moyLiZGYebZwnD
=kpD0
-----END PGP SIGNATURE-----

--kJModphsqGs4XmxM4wLMMaIHdv07hEuEo--
