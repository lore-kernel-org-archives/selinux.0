Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UIwJAv019313
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 14:58:21 -0400
Received: by mail-wm0-f52.google.com with SMTP id b84so99753042wmh.0
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 11:58:12 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id x27sm5909857edb.49.2017.05.30.11.58.10
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 May 2017 11:58:10 -0700 (PDT)
Date: Tue, 30 May 2017 20:58:08 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: libsepol segfaults with typealias and typealiasactual
Message-ID: <20170530185808.GB29502@julius.enp8s0.d30>
References: <20170530140513.GA29502@julius.enp8s0.d30>
 <a2bfd9b2-5aa3-139c-31ea-5a6c226e3ef8@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
In-Reply-To: <a2bfd9b2-5aa3-139c-31ea-5a6c226e3ef8@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 12:43:25PM -0400, Steve Lawrence wrote:
> On 05/30/2017 10:05 AM, Dominick Grift wrote:
> > I have a typealias/typealiasactual in dssp2-standard at:
> >=20
> > https://github.com/DefenSec/dssp2-standard/blob/master/policy/system/rp=
m.cil#L18
> >=20
> > This *works*
> >=20
> > However now i want to additionally associate "unconfined.user.subj" wit=
h "rpm_script_t"
> > So i created a module:
> >=20
> > echo "(typealiasesactual rpm_script_t unconfined.user.subj)" > mytest.c=
il && semodule -i mytest.cil
> > it returns (something along those lines):
> >=20
> > "subj is not an alias"
> >=20
> > however it seems as though the module did install. I cannot think of an=
y simple way to determine whether it works as I cannot find any "seinfo --t=
ypealias" or sesearch "--typealiases"
> >=20
> > Anyway libsepol segfaults when i try to play more with this
> >=20
> > So I tried the following
> >=20
> > (typeattribute rpm_script_aliases_type_attribute)
> > (typeattributeset rpm_script_aliases_type_attribute rpm.script.subj)
> > (typeattributeset rpm_script_aliases_type_attribute unconfined.user.sub=
j)
> >=20
> > (typealias rpm_script_t)
> > (typealiasactual rpm_script_t rpm_script_aliases_type_attribute)
> >=20
> > This also return incoherent messages something like "invalid "." in ...=
", but it seems to install
> >=20
> > and after that everything just segfaults (libsepol), untill i remove my=
 local customizations
> >=20
> > I dont know a better way to explain this but looks to me theres a serio=
us bug in how typealiases are handled by libsepol:
> >=20
> > https://www.youtube.com/watch?v=3Dqe-vqieu2jg
> >=20
>=20
> The first argument to the typealiasactual statement must resolve to a
> typealias, and the second argument must resolve to a type. In your above
> CIL snipppet you have it resolving to an attribute, which is not
> allowed. However, we weren't correctly checking these restrictions,
> which could lead to segfaults and weird error messages. I've just sent a
> patch that should fix this conditions and error out with helpful messages.

Thanks a lot. Yes it should not have let me load that up because once that =
is loaded libsepol keeps segfaulting not matter what youre trying to load

However thats not the whole story:

just adding "(typealiasactual rpm_script_t unconfined.user.subj)"

caused issues as well were it returned something along the lines of:

"subj is not an alias" <- "subj" indicates to me that it only took the type=
 and not the unconfined.user name space

but rpm_script_t is a typealiases and unconfined.user.subj is a type, the o=
nly difference is that there was already another typealiasactual of "(typea=
liasactual rpm_script_t rpm.script.subj)

I suspect that it for some reason in this scenario wasnt able to interpret =
unconfined.user.subj properly

Also perculiar was it complaining about "." in identifiers

Should I be able to associate two types with a single typealias like so?:

(typealias foo)
(typealiasactual foo bar)
(typealiasactual foo baz)

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlktwLsACgkQJXSOVTf5
R2mX7Av8DBrulPb+i5LCdIrhyWXnG7iTYWWmZiJTsom4biQVZOsCNnGAlZSDa/dI
3p8E2ZkWVo9m25Rj502tmKuIfD6Z6lB4NPHRtKIdv1gKjCzwL77YYDrRZNZKK0CX
uen4E8qFwa8H5efLWS0VgvP6eHEpEazp6nW0QnCsj4aEaojFWj2+TykDV+DO6BMF
qRVCLyhw8q2zLry8sRGC0wCtNQY1fz+nnXyu7cgK4TrIDtf4fZuHkta87G5VQrsI
tLduixNrMwL+e9XXIMsS/LssRXFo3FG3cUEB2N4034YFvsxztpq+tSPCaCUCHdMR
ALax537QjBpAfiNbjxP4gdOaUFDitqk4ClYlv7SI46TJmwxXLR2k2MtM+htudY5d
ZDGu1AWrY0hMWoJgQhzSbABQ5JYsUeeFN00WpiaWmDarY08/PD4xwEaxN7qMM3yo
4FBTYVdkGdrAASP1JLVYm5jGUxPX4eF2l4ZGHYdpCYo6PrQnCC5TJujqPVvJGYD5
f0TifCUt
=YjDG
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
