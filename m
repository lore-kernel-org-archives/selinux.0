Subject: Re: network and module problems
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Paul Krumviede <pwk@acm.org>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0201251401231.7127-100000@raven>
References: <Pine.GSO.4.33.0201251401231.7127-100000@raven>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-AiCDA1AAiB2NHaLD24uy"
Date: 25 Jan 2002 18:22:38 -0500
Message-Id: <1012000959.2215.12.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-AiCDA1AAiB2NHaLD24uy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-01-25 at 14:04, Stephen Smalley wrote:
>I still think you have a bad kernel
> configuration (missing one or both of the Netlink or Routing messages
> options).
>=20
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com

Question.  I noticed you said "routing messages".  Ok, two questions
really.  First off what does routing messages have to do with raising
the interface?  Secondly, why is the routing messages not mentioned in
the install readme?  Because the install mentions netlink, which I
kindly made certain was built into the kernel and why I so greatly
protested that I was not stupid enough to have missed something in the
readme I so carefully followed to the letter.  Also, you mentioned there
was a new version of the lsm out and I just downloaded the one I have
now only like a week ago.  So am I going to the wrong place for all this
stuff or what?  The NSA site is the right place correct?

At any rate it IS working now and I feel terrible that I wasted
everyone's time.  I would like to suggest that the install readme be
updated though and I would be happy to do it if someone would tell me
where I can submit the change.  Thanks again everyone.

Timothy,

--=-AiCDA1AAiB2NHaLD24uy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Uei+f/PqxrKarmgRAhplAJ0ZW9lxqBvQoUnJ8/42MZxGaXOhgQCfQ6SF
EaIfJYPigsY/YRoNZnUO8aA=
=xlAZ
-----END PGP SIGNATURE-----

--=-AiCDA1AAiB2NHaLD24uy--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
