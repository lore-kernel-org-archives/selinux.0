Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MI937o013701
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 14:09:03 -0400
Received: by wiga1 with SMTP id a1so84533740wig.0
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 11:09:01 -0700 (PDT)
Received: from localhost.localdomain (84-245-28-90.dsl.cambrium.nl.
 [84.245.28.90])
 by mx.google.com with ESMTPSA id l6sm18414581wib.18.2015.06.22.11.08.59
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jun 2015 11:09:00 -0700 (PDT)
Date: Mon, 22 Jun 2015 20:08:58 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
Message-ID: <20150622180857.GB10451@localhost.localdomain>
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
 <20150313184330.GC9437@linksys-wireless-usb.network2>
 <55033162.8040508@tycho.nsa.gov>
 <20150314072253.GA26393@linksys-wireless-usb.network2>
 <5506CFD9.2030606@tycho.nsa.gov> <558832B8.8020705@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
In-Reply-To: <558832B8.8020705@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2015 at 06:07:20PM +0200, Miroslav Grepl wrote:

>=20
> In Fedora, we have unconfined_service_t domain for unconfined services
> started by init. So there is init_t @bin_t -> unconfined_service_t and
> we get op=3Dsecurity_bounded_transition for init_t against
> unconfined_service_t. But of course it is not going to work with
>=20
> typebounds init_t unconfined_service_t;
>=20
> because there is
>=20
> # <audit-1401> op=3Dsecurity_compute_av reason=3Dbounds
> scontext=3Dsystem_u:system_r:unconfined_service_t:s0
> tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile perms=3Dentrypoint
>=20
> So this logic breaks our concept with unconfined_service_t.
>=20

What is running in the unconfined_service_t domain in that event?

> --=20
> Miroslav Grepl
> Senior Software Engineer, SELinux Solutions
> Red Hat, Inc.
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

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJViE81AAoJENAR6kfG5xmciIsL/3Xz3tJpET0LYqh0DDi7+d0j
PaJiIkBfxpoQIj8VCIkW9AfhmwE/8GGaiWL9lkb/4/Iq0kuu98zVmLi5jgSO+Kjp
k66FJhe3m/KiCEecXG6Pt2u7/EEyfaWu7CKcEW2DWQjxR8/Y5IdEL9mRfspdWkZB
e6/IVDc5NrpwPjIEE549pKfpEAGgidXE2d3jM8tc4NdikFZ7UipvK5OSjYT/+DaJ
5jcbVFtCnEpGzXMlTJUpkSCfTWUi4unYOvq1spmNFZCAYDlddQE4QI4TzHFCFXx8
LDdQiws7G4CgeQzmFY7PwN+cpZ6hf0kMVRfnhGDv95ntEsO0xioidvfxyENVnzRd
qMr6pGJtGT4OFP9U4x7ueLsIoswaA9dVYJlHTk/v9begseXcLiRjSaijvwOC5HVx
a400EvQtbVmDhyln7cAmAuhUKK0ozuHzKiHvmgebnG3c5DBjvMq+E3EKiImZuSLc
zYETLMsXZP4KYls/sKgIJtMbvKKwkK7cG4xfwNl+ow==
=p2b0
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
