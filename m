Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UE5s7g020298
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 10:05:54 -0400
Received: by mail-wm0-f50.google.com with SMTP id d127so98867827wmf.0
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 07:05:21 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id t57sm8542876edb.28.2017.05.30.07.05.14
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 May 2017 07:05:14 -0700 (PDT)
Date: Tue, 30 May 2017 16:05:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: libsepol segfaults with typealias and typealiasactual
Message-ID: <20170530140513.GA29502@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a typealias/typealiasactual in dssp2-standard at:

https://github.com/DefenSec/dssp2-standard/blob/master/policy/system/rpm.ci=
l#L18

This *works*

However now i want to additionally associate "unconfined.user.subj" with "r=
pm_script_t"
So i created a module:

echo "(typealiasesactual rpm_script_t unconfined.user.subj)" > mytest.cil &=
& semodule -i mytest.cil
it returns (something along those lines):

"subj is not an alias"

however it seems as though the module did install. I cannot think of any si=
mple way to determine whether it works as I cannot find any "seinfo --typea=
lias" or sesearch "--typealiases"

Anyway libsepol segfaults when i try to play more with this

So I tried the following

(typeattribute rpm_script_aliases_type_attribute)
(typeattributeset rpm_script_aliases_type_attribute rpm.script.subj)
(typeattributeset rpm_script_aliases_type_attribute unconfined.user.subj)

(typealias rpm_script_t)
(typealiasactual rpm_script_t rpm_script_aliases_type_attribute)

This also return incoherent messages something like "invalid "." in ...", b=
ut it seems to install

and after that everything just segfaults (libsepol), untill i remove my loc=
al customizations

I dont know a better way to explain this but looks to me theres a serious b=
ug in how typealiases are handled by libsepol:

https://www.youtube.com/watch?v=3Dqe-vqieu2jg

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlktfBQACgkQJXSOVTf5
R2m+qgwAsyHXdI/YJdCzDyVfx98prrzDVrFpCdOZ6NtO9HaZRJviLyxOkBL6SBBb
NlufwzVWHzjJj77eA+jtv4a3ikR3xIf4Kb47DvVzqKPMRG5tiLC8Mv8sDFdHLnCm
Cf8CLbkYfoeKZ7BvhmHb1eE6gBQDVqLsapPB6JYahHVEMmxFHHZacf8o5RSftGFm
3KhRWsK5BRLMKj2ccdDnlfH/CXTveHhBAWYNiejUcGFtRyV1DPEqW0iR4PaQ4VEi
HpyEdz6UIK8dPP8AGON3UEnApo/1CmhDgP9GVkHzDZ7Ee1sfNuJAVJdama+yElHp
Mj4Uh/+yV9mEqo2OjNI/dvfohVVICLqpD8Oyh6dZxQJAgFYj06i43KfKA6DF0tnr
Qq7tHsrFG9fxPyzr+iKQh0qLDggCZ2HF8F7VYh1VMCuveHdJGQ1e+St+KfUe7nzu
qVm7eMo0Udb1gRbg1aB7byLrraQxAEgHVyFIz3X2OVMyYWQDRyqK/87ePjujH1qY
Mmg+l7Q3
=tNxH
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
