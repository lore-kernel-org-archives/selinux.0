Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9LB4tW5019410
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 07:04:55 -0400
Received: from ey-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9LB4twL023229
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 11:04:56 GMT
Received: by ey-out-1920.google.com with SMTP id 4so782741eyg.30
        for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 04:04:54 -0700 (PDT)
Subject: Re: Conditional Access to Network Resources
From: Dominick Grift <domg472@gmail.com>
To: Chris Kuester <c.kuester@tarent.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20081021092518.GA6606@localdomain>
References: <20081021092518.GA6606@localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-74/iKBIV8NIcPwwfLdTm"
Date: Tue, 21 Oct 2008 13:04:52 +0200
Message-Id: <1224587092.9326.3.camel@rawhide.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-74/iKBIV8NIcPwwfLdTm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On Tue, 2008-10-21 at 11:25 +0200, Chris Kuester wrote:

> I want to allow my domain to access certain ports on the local interface
> and certain ports on a nonlocal interface.=20

I think that you would have to first declare your interfaces with for examp=
le "semanage interface -{a|d|m} [-tr] interface_spec"
(man semanage) and then define policy about how domains may interact with t=
he interfaces that you have declared.
By default no interfaces are declared and domain may interact with any
interface.

--=-74/iKBIV8NIcPwwfLdTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj9t04ACgkQL00QnzrVtlwD4wCfZeHEhT7q39Nkw3KpvlxHNBPf
5TkAnjdcNfOaTI66NrVsbspGYN9Sbaow
=5pfF
-----END PGP SIGNATURE-----

--=-74/iKBIV8NIcPwwfLdTm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
