Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5M2ewgA013378
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 22:40:58 -0400 (EDT)
Received: from estila.tuxedo-es.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5M2UrK0012626
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 02:30:53 GMT
Subject: RE: ANN: SELinux Reference Policy Release
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'antoine'" <antoine@nagafix.co.uk>,
   "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
   "'Colin Walters'" <walters@verbum.org>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>
In-Reply-To: <200506220148.j5M1ltqc008740@gotham.columbia.tresys.com>
References: <200506220148.j5M1ltqc008740@gotham.columbia.tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1HjT6h8GVY++B5fkyNaD"
Date: Wed, 22 Jun 2005 04:31:27 +0200
Message-Id: <1119407487.27105.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1HjT6h8GVY++B5fkyNaD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 21-06-2005 a las 21:47 -0400, Karl MacMillan escribi=F3:
> See below for my thoughts on the format. If you are interested in helping=
 we
> would be happy for any contributions. The sf cvs is updated nightly. We s=
hould
> get what we view as the task list up on the website soon and welcome any
> suggestions for what should be accomplished in the near or long term.=20

I will be glad to help during this summer for sure, just lemme know
about the group of people going to work over it and we can try to
organize a common schedule for it, as it seems a huge job which needs a
well organized development and deployment process. (Well, some are
getting paid for it ;) ).

The road-map in http://serefpolicy.sourceforge.net/ doesn't look
meaningful to me though.

> I think that we can make this more readable without punting on the xml (w=
hich I
> actually think is easier to read than the javadoc style @ tags). We are g=
oing to
> trim down the XML to look more like:
>=20
> ##=20
> ## <description>
> ##	Allows the caller to get the mode of policy enforcement
> ## </description>
> ##
> ## <param name=3D"domain">
> ## 	The process type to allow to get the enforcing mode.
> ## </param>
> ##

So, we strip out the '##', then parse each "chain" (should we
concatenate it and thus making an only one XML file with the whole
reference?), and then use the proper style-sheet to run the formatting?

It makes sense but a per-file basis approach would be more easy to
deploy, anyways, more challenge, more fun.

> That means that the interface name will be derived from the actual interf=
ace
> declaration, which should probably be changed to a macro for declaring
> interfaces. The final xml file that is output won't change, we will just
> generate some of the tags. Thoughts?

 - for each file (.te, .fc, ...) we strip out the commented XML
   - we dump it in a xml/dir/file.extension
     - we concatenate each file.{fc, te, ...}
      - we produce a single XML file
        - we're done for parsing and doing any formatting on top of the
          source XML file.

Though It's not the best time to think about it, will give it a further
look later.

How it looks to you?

> Not yet - if you want the parsing code I can release it though.

It would be good to have all-in-place. With single, separated pieces we
can't do it, either we have everything clear and well exposed in the
proper place or we have nothing.

I'm new around this (the ref. policy) and also on the policy itself, I'm
still not too familiar with it (hadn't enough time to deal with it
properly), so, I may be wrong, then please give advice and I'll try to
make it going smooth and straight forward ;).

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-1HjT6h8GVY++B5fkyNaD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCuM1/DcEopW8rLewRAlvbAKCKVbGWXyKKdRZd0aWqWBBGiBuPkwCgvQHM
I6Rg5Gu3RPd6Ku/e2nHVMio=
=GTj2
-----END PGP SIGNATURE-----

--=-1HjT6h8GVY++B5fkyNaD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
