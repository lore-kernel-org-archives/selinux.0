Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5TJPZsG011008
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 15:25:35 -0400
Received: by wiga1 with SMTP id a1so79925589wig.0
 for <selinux@tycho.nsa.gov>; Mon, 29 Jun 2015 12:25:05 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by mx.google.com with ESMTPSA id fo13sm13487684wic.0.2015.06.29.12.25.04
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2015 12:25:04 -0700 (PDT)
Date: Mon, 29 Jun 2015 21:25:02 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: type inheritance in CIL
Message-ID: <20150629192501.GA1380@x250>
References: <5590F3DE.8070202@redhat.com> <20150629075651.GA8191@x250>
 <559129C1.4010201@redhat.com> <559194E2.20501@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <559194E2.20501@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2015 at 02:56:34PM -0400, James Carter wrote:
> On 06/29/2015 07:19 AM, Miroslav Grepl wrote:
> >On 06/29/2015 09:56 AM, Dominick Grift wrote:
> >>On Mon, Jun 29, 2015 at 09:29:34AM +0200, Miroslav Grepl wrote:
> >>>Trying to make sandbox working using CIL but I see it does not
> >>>support typeinherit statement.
> >>
> >>One of those features that really define CIL but that is currently
> >>not available or fully working yet.
> >>
>=20
> Inheritance in CIL is handled with blocks.
>=20
> The following policy:
>=20
> (block b1
>   (type t)
>   (allow t self (CLASS (PERM)))
> )
>=20
> (block b2
>   (blockinherit b1))
>=20
> Would result in two types (b1.t and b2.t) and two rules.
>=20
> See block_test.cil and name_resolution_test.cil in secilc/test/ for more
> examples. Everything should work, but, of course, it has seen less testing
> at this point.

Thanks I am aware of that featurew, namespacing is also still a bit buggy i=
n my view though.

If this is meant to be a substitute for typeinherit then how is one suppose=
d to implement something that behaves like typeinheritfilter?

You are aware the typeinherit and typeinheritfilter are still documented on=
 https://github.com/SELinuxProject/cil/wiki?
>=20
> Jim
>=20
> >>My suggestion is to study the "cilpolicy" (which is really just a
> >>snapshot of reference policy transformed to cil with hll i
> >>believe)
> >>
> >>This will give you some pointers as to how to create an alternative
> >>implementation that achieves a similar result.
> >>
> >>When you write CIL policy, there are some "bugs" to take into
> >>account and to workaround.
> >>
> >
> >Sure there are different ways how to write it. I just wanted to
> >combine it with the current Fedora policy as much as possible without
> >re-writing the current Fedora policy.
> >
> >>>
> >>>-- Miroslav Grepl Senior Software Engineer, SELinux Solutions Red
> >>>Hat, Inc. _______________________________________________ Selinux
> >>>mailing list Selinux@tycho.nsa.gov To unsubscribe, send email to
> >>>Selinux-leave@tycho.nsa.gov. To get help, send an email
> >>>containing "help" to Selinux-request@tycho.nsa.gov.
> >>
> >>
> >>
> >>_______________________________________________ Selinux mailing
> >>list Selinux@tycho.nsa.gov To unsubscribe, send email to
> >>Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> >>"help" to Selinux-request@tycho.nsa.gov.
> >>
> >
> >
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVkZuJAAoJENAR6kfG5xmck44L/1gebFbB20VjFe8p+Mhe2DMq
qZKiTRgaaA0GDPpDiV/aMomSdYroJzX1R0EwHU0cWsVAyRw/8NNhF9iaRBPIMWO6
UrTHE2PkPJ+9/68hjjpN+OYOopv8wA/btPcx/yRc1XBUiKanwdbZ/fkIERURfa+X
RGXb77tFlGQmw5Rxn2I5uHneseiqhSsvOf1yGZppjzNJwRv2sYjlVu1AAxJ3DHer
AUcGbHEf5yVSkZ2nfYdKYq1zyQGQDKnmGIuqT07rxswTgMC1WYqhHU6ZR6YFT5fs
xyyc4JAAQn9v+SzcUepU0eO6JeCJHCSd6if4kybj1vExcv8wmYP7ydYVTFQ467Yt
rYrMqUUVvk11kS4XSUahHlR3JdBqLfw2xOUnQZzSOorJ21nJS314XXHMItks3l/s
3Cctndhn5pID2LCWi2fjMMaoZKGwD5vvroiG7k+/+CD+devnvkGH8Lw+NTKVqiw1
Ux9NJnDbGzGJrZkbImnCOaDfPr8qJh/jPzn0Gi736w==
=wISg
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
