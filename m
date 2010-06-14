Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5EDbEM1022037
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 09:37:14 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5EDaOaI019150
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 13:36:24 GMT
Received: by wyb35 with SMTP id 35so4029287wyb.12
        for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2010 06:37:10 -0700 (PDT)
Date: Mon, 14 Jun 2010 15:37:05 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Display all processes using ps
Message-ID: <20100614133702.GA2734@localhost.localdomain>
References: <1276385764.2972.5.camel@tesla.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <1276385764.2972.5.camel@tesla.lan>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 13, 2010 at 01:36:04AM +0200, Guido Trentalancia wrote:
> Hello everybody !
>=20
> I am logging as root on a remote MLS machine using ssh so the default
> role is staff_r. However, I need to execute ps (to display all system
> processes, "ps -ax") over ssh. Unfortunately, ps does not show all
> processes that are normally displayed when using the sysadm_r role
> because it runs in the staff_r role.
>=20
> What would be the safest way to allow ps over ssh to show all processes
> running on the system ?

login using the sysadm_t domain? ssh root/sysadm_r@localhost

>=20
> Thanks for your help.
>=20
> Guido
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkwWMH4ACgkQMlxVo39jgT/XKgCdHNGUYNy4XQc5LBS0IKn1bO80
CL0AoIZgkASBgML9wokwwD/I6VnBq+Fm
=gREL
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
