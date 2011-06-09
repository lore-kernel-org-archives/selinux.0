Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p59D51hr029760
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2011 09:05:01 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p59D50PU017964
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2011 13:05:00 GMT
Received: by eyh5 with SMTP id 5so608477eyh.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Jun 2011 06:04:59 -0700 (PDT)
Subject: Re: SELinux Common Intermediate Language Update
From: Dominick Grift <domg472@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 09 Jun 2011 15:04:56 +0200
In-Reply-To: <4DEFE619.9080606@tresys.com>
References: <4DEFE619.9080606@tresys.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tmGUtYb1B0Nzv7VokSPR"
Message-ID: <1307624698.2645.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tmGUtYb1B0Nzv7VokSPR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2011-06-08 at 17:14 -0400, Steve Lawrence wrote:

> As to the purpose of this email, we've recently reached a pretty
> significant milestone with the compiler, in that it now supports most of
> the features that are currently supported by reference policy (e.g.
> macros, optionals, tunables, etc) as well as the standard SELinux policy
> rules (e.g. allow, type, role, etc). Now that the compiler has reached
> this milestone, we would love for the community to play around with it a
> bit and give us any feedback as we continue on to integration and
> implementing the more advanced features, such has inheritance and
> transforms.

Could not get it to build. One dependency not mentioned in the README is
"flex".

src/cil_list.c: In function =E2=80=98cil_list_get_tail=E2=80=99:
src/cil_list.c:73:68: error: parameter =E2=80=98tail=E2=80=99 set but not u=
sed
[-Werror=3Dunused-but-set-parameter]
cc1: all warnings being treated as errors


--=-tmGUtYb1B0Nzv7VokSPR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk3wxPgACgkQMlxVo39jgT/HrQCffWv4bxba+5+J2PxhOPen7gf2
5qEAniuNcoxYeBBqVaePh6vqlbZFR/qL
=00oW
-----END PGP SIGNATURE-----

--=-tmGUtYb1B0Nzv7VokSPR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
