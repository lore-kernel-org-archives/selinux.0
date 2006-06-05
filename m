Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k55Fcvvh000492
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 11:38:57 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k55Fcuhb029592
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 15:38:56 GMT
Subject: Re: Switch between struct security_context_t and context_t
From: James Antill <jantill@redhat.com>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <44844985.754de417.4f4c.ffffbae9@mx.gmail.com>
References: <44844985.754de417.4f4c.ffffbae9@mx.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ypQhFqSq2WldaJsgBMRe"
Date: Mon, 05 Jun 2006 11:38:51 -0400
Message-Id: <1149521931.13928.59.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ypQhFqSq2WldaJsgBMRe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-05 at 17:10 +0200, Mario Fanelli wrote:
> I'm writing some simple program that uses SELinux Api but I don't find an=
y
> function that transform a security_context_t variable in context_t. It's
> possible to force cast but if exists a function that performance this
> operation is better...
> Anyone can give me an help?

 You want to use:

context_t context_new(const char *);

...you can see it being used in the secon program in policycoreutils.

--=20
James Antill <jantill@redhat.com>

--=-ypQhFqSq2WldaJsgBMRe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEhFAL11eXTEMrxtQRAhLaAKCnp9wuuyLbytHarQBBh78VW3OapACdEGMz
BE0+HzUZG4Z9zgIVTI/R3yQ=
=JtmO
-----END PGP SIGNATURE-----

--=-ypQhFqSq2WldaJsgBMRe--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
