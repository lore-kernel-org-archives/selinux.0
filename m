Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA5G1Os3016188
 for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2014 11:01:25 -0500
Received: by mail-wi0-f180.google.com with SMTP id hi2so2475807wib.1
 for <selinux@tycho.nsa.gov>; Wed, 05 Nov 2014 08:00:57 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id 10sm4538813wjs.21.2014.11.05.08.00.55
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 05 Nov 2014 08:00:56 -0800 (PST)
Date: Wed, 5 Nov 2014 17:00:54 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: user_r/sysadm_r/staff_r/unconfined_r
Message-ID: <20141105160051.GA25500@e145.network2>
References: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
In-Reply-To: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 10:37:18PM +1100, Russell Coker wrote:
>=20
> I think that sysadm_r/unconfined_r should not transition for programs lik=
e gpg.

I do not agree, To me the only thing that sets sysadm_t apart from unconfin=
ed_t is that sysadm_t is a strict domain.

Meaning where unconfined_t would run some program in the calling unconfined=
_t domain, sysadm_t would transition to the domain of the program. Unfortun=
ately this currenlty often is not the case.

Walsh once said, and i quote: "sysadm_t is a drunken unconfined_t". He has =
a point there and it should not be like that. sysadm_t should be a strict d=
omain whereas unconfined_t is just some semi-exemption domain

unconfined_t runs for example gpg in the unconfined_t domain , and sysadm_t=
 runs it in the gpg_t domain

>=20
> NB staff_r is my invention. Before that we only had sysadm_r and user_r. =
I invented staff_r before MCS and the seuser constraints were developed.=20

As for using optional security attributes/models to achieve something that =
is often not optional:

It think that is a bad idea. MCS/MLS is optional and so are the UBAC constr=
aints. In my view they should remain optional

My stance is that this should all be up to individuals to decide instead of=
 part of refpolicy.

I recently created a policy model called splash and this, kind of, looks li=
ke how i envision the perfect refpolicy. (although it abuses CIL name space=
s and it only deals with objects that are present in my system)

https://github.com/doverride/splash

This policy (provided it is fixed/finished and bug free) works on all syste=
ms. Sure by itself it provides almost no protection but that is not the poi=
nt of the policy. It is a common base.=20

I am kind of hoping for a refcilpolicy 2.0 with all this applied. Also some=
thing that does not strictly rely on policycoreutils-semanage (e.g. somethi=
ng that is just as suitable for embedded systems)

>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Dominick Grift

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUWkmuAAoJENAR6kfG5xmcYDcL+wSmODA79P3LYS1EwEQ6d+Ue
irdGuursvVAfR/z+uURpXQJNK2QjQRN5aOPwx24XjC7S2IzPsdaSctkvZU6bz1zf
jKdDxxpilGWC7+s2W02qt6IFp1KFn0QfK6KYfB9P0oXfUWk+6Y8s5+sNpDZ0/B0u
yBEYog+9nLvo3MLH8dHi3k4rNTDJlbGndMGQtasTFDUWmNPDb1s8NjHg3iCe6KMu
sUfn03XjRBUxKNzuGp7p+15ZczloeQZ9N8lZ7BoE/WkgbNtjn1iV2roF68nnFFAb
0YV8NDiFlfK5ueg4Sj2tFzViBVynBR5z/fJ8suJfimXWcGysqWCwFIPAMIY+kShj
LBB3NDqcAReMkvfVLlkYRY6ciEPyeuw1dWm9wblaPNK4V5x+NkUkKKJRMmAwqyna
GRJGqJtc7z1dXqnh3IjDy4YF0q/b9EbRTfUG9j6LCLkH4DW72q8HJrmFI4twPUEd
L8sdfroXw95YWSKxp0mLr7lNehrLO26n0UFhL1YLZw==
=/Le1
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
