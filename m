Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71G2FTx014896
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 12:02:15 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o71G2Mmu016073
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 16:02:22 GMT
Received: by ewy19 with SMTP id 19so1327871ewy.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 09:02:14 -0700 (PDT)
Message-ID: <4C559A84.4060004@gmail.com>
Date: Sun, 01 Aug 2010 18:02:12 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com> <4C559624.6040709@gmail.com>
In-Reply-To: <4C559624.6040709@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF96DF8774CDA03B7B9D9A27C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF96DF8774CDA03B7B9D9A27C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/01/2010 05:43 PM, Ralph Blach wrote:
> I have discovered that ports 443 and 22 are in module tcp.
>=20
> How do i rewrite module tcp so that I can configure as I want it.
>=20
> Where do I find module tcp?
>=20
> I did a semanage port -l | grep 22 and module tcp was listed.
> I did the same for port 443
>=20
> Thanks

ports are declared (defined) in the corenetwork module. This module is
part of the base module. modules that are part of the base module are
not listed with semodule -l.

What exactly do you want to achieve? If you are specific about your
requirements we can try to help you implement it.

> Chip
>=20
> On 07/27/2010 08:29 PM, Jason Axelson wrote:
>> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.com> =
wrote:
>>> how do I use semanage to list the policy modules.
>=20
>> Hi Chip,
>=20
>> Perhaps you are looking for "semodule -l"? That will list out all the
>> installed policy modules (besides base).
>=20
>> Jason
>=20
>=20

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.



--------------enigF96DF8774CDA03B7B9D9A27C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxVmoQACgkQMlxVo39jgT9FFACgh7iWzOqpRh5fkYOFgU14xVUg
+xwAoIvEfnwzRpeflDqCaLBeBdNT9S3o
=ko3S
-----END PGP SIGNATURE-----

--------------enigF96DF8774CDA03B7B9D9A27C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
