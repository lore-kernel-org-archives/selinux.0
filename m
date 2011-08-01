Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71KNm9I003458
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 16:23:48 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p71KNlho020776
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 20:23:47 GMT
Received: by ewy8 with SMTP id 8so3481390ewy.12
        for <selinux@tycho.nsa.gov>; Mon, 01 Aug 2011 13:23:46 -0700 (PDT)
Subject: Re: chown affecting type_transition?
From: Dominick Grift <domg472@gmail.com>
To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 01 Aug 2011 22:23:43 +0200
In-Reply-To: <CAFPpqQEYmrYQWDS8t0Y2DcF3jXoyO=2f929jNuvFKyXjNG=OhQ@mail.gmail.com>
References: 
	<CAFPpqQEYmrYQWDS8t0Y2DcF3jXoyO=2f929jNuvFKyXjNG=OhQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-A3kuI/WBkgtWUxMt9DmQ"
Message-ID: <1312230225.28822.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-A3kuI/WBkgtWUxMt9DmQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2011-08-01 at 10:32 -0500, Ted Toth wrote:
> I'm writing policy for some scripts. Script 'a' runs script 'b' and they
> each have their own entry file and domain type. There is a type transitio=
n
> for a_t through b_exec_t to b_t in the policy. However the transition
> doesn't happen. Script 'a' does a chown on script 'b' prior to running it=
.
> If I remove the chown the transition does happen as expected. Can chown
> somehow affect the file label? 'ls -Z' doesn't show any change.

only thing i can think of is that the execute bit is not set for the
owner or group you chowned the file to.

In that case a dac issue.
>=20
> Ted

--=-A3kuI/WBkgtWUxMt9DmQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk43C08ACgkQMlxVo39jgT8PWwCfdZ1J1whQ6unDrjn7Zgecv0mP
9aQAoMhXSuDI0YMFLV1sJumdvOW4c3b7
=Nv5R
-----END PGP SIGNATURE-----

--=-A3kuI/WBkgtWUxMt9DmQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
