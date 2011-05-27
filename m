Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4RD191S018019
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 09:01:09 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4RD18ma002156
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 13:01:08 GMT
Received: by bwg12 with SMTP id 12so1510493bwg.12
        for <selinux@tycho.nsa.gov>; Fri, 27 May 2011 06:01:08 -0700 (PDT)
Subject: Re: Regarding SELinux User mapping
From: Dominick Grift <domg472@gmail.com>
To: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 27 May 2011 15:01:06 +0200
In-Reply-To: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
References: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-f6dpR4R32ytDv0DwY6NL"
Message-ID: <1306501267.4346.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-f6dpR4R32ytDv0DwY6NL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2011-05-27 at 18:20 +0530, c.r.madhusudhanan@gmail.com wrote:
> Hi All,
>=20
> I am trying to map Linux user to different SELinux user (user_u, guest_u,
> xguest_u), but when I login it shows only as
> system_u:system_r:local_login_t for all users. =20

SElinux uses pam (pam_selinux) to tell login programs what context they
should set for a user that logs in, i believe.

pam_selinux gets these from /etc/selinux/*/contexts/ { default_contexts
users/.* }, i think
>=20
> Regards,
> Madhu

--=-f6dpR4R32ytDv0DwY6NL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk3foJIACgkQMlxVo39jgT8j7QCfVE+xx9Ezu0KpMfPALqGzzcGg
KLgAoKtYVco5YNrqRo+LLaZrT2h6paSS
=5pWf
-----END PGP SIGNATURE-----

--=-f6dpR4R32ytDv0DwY6NL--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
