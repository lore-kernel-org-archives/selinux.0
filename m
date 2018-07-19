Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JHlMrN023585
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 13:47:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so7723685edq.7
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 10:47:17 -0700 (PDT)
Date: Thu, 19 Jul 2018 19:47:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180719174713.GC26209@julius.enp8s0.d30>
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
 <20180719165139.GB26209@julius.enp8s0.d30>
 <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
In-Reply-To: <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 07:42:53PM +0200, Lukas Vrabec via refpolicy wrote:
> On 07/19/2018 06:51 PM, Dominick Grift via refpolicy wrote:
> > On Thu, Jul 19, 2018 at 06:40:25PM +0200, Dominick Grift wrote:
> >> On Thu, Jul 19, 2018 at 06:17:46PM +0200, Lukas Vrabec via refpolicy w=
rote:
> >>> Hi All,
> >>>
> >>> I found one thing in refpolicy which I don't completely understand.
> >>>
> >>> In "policy/support/misc_patterns.spt" there is definition of
> >>> "domain_transition_pattern" and this contains line:
> >>> allow $1 $2:file { getattr open read execute };
> >>>
> >>> There is missing map permission.
> >>>
> >>> However in "policy/support/misc_macros.spt" there is definition of
> >>> "can_exec" and it contains allow rule:
> >>> define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lock
> >>> execute_no_trans };')
> >=20
> > Sorry can_exec() should just use exec_file_perms which would should be =
mmap_exec_file_perms + execute_no_trans IMHO
> >=20
> >>
> >> This should just use mmap_exec_file_perms
> >>
>=20
> Should we remove lock permission?

I would say yes, but i am not sure why it was added in the first place

>=20
> >>>
> >>> There is a mmap_exec_file_perms which contains:
> >>> define(`mmap_exec_file_perms',`{ getattr open map read execute ioctl =
}')
> >>>
> >>> Map is present in can_exec().
> >>>
> >>> So for domain transitions we don't allow map permission from calling
> >>> domain on binary type but in can_exec macro there is map permission.
> >>>
> >>> I think this is a bug and in "domain_transition_pattern" there should=
 be
> >>> this line:
> >>> allow $1 $2:file { getattr open read execute map };
> >>
> >> This should just use mmap_exec_file_perms as well
> >>
> >>>
> >>> instead of:
> >>> allow $1 $2:file { getattr open read execute };
> >>>
> >>> Am I right or missing something?
> >>>
> >>> Thanks for help!
> >>> Lukas.
> >>
> >> permission sets provide a single point of failure and should used as m=
uch as possible
> >>
> >> These were overlooked and because of this we now have a good example w=
hat the purpose of permission sets and patterns is.
> >>
>=20
> Thanks, I'll prepare patch.
>=20
> Lukas.
>=20
> >>>
> >>> --=20
> >>> Lukas Vrabec
> >>> Software Engineer, Security Technologies
> >>> Red Hat, Inc.
> >>>
> >>
> >>
> >>
> >>
> >>> _______________________________________________
> >>> refpolicy mailing list
> >>> refpolicy@oss.tresys.com
> >>> http://oss.tresys.com/mailman/listinfo/refpolicy
> >>
> >>
> >> --=20
> >> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> >> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
> >> Dominick Grift
> >=20
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > refpolicy mailing list
> > refpolicy@oss.tresys.com
> > http://oss.tresys.com/mailman/listinfo/refpolicy
> >=20
>=20
>=20
> --=20
> Lukas Vrabec
> Software Engineer, Security Technologies
> Red Hat, Inc.
>=20




> _______________________________________________
> refpolicy mailing list
> refpolicy@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/refpolicy


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAltQzp0ACgkQJXSOVTf5
R2nLmAwAiJcKLpf3L89Getk5Ch0TqW8xPsWJTrgVcB+mCJt8vuHU8RUNCgmTTsOO
KSTYNBx/d9Z6FoTxXu4suIRuAazcJbsd7Fc2Mi/61EOz4O5gYsKUJTvSqVzs0xgD
6p+PuLynfZ539VAN+mlw7Sp6cEdSAJGu//vizodr/GKAtBaXqqC4fC5M+hYF9Jy2
/MbhJOGOapzWPnl6kHlHjIU/rMW4C0+TQL/sIAPBo2Leh35mEF0pgRoeb15GbrMd
r+XbWUsi+POOYKTQ9PhvyTM9tQ+SXYGgGS1XbvnQXhn/vhMW6o+ds+ftXQL+PWxI
DtFj+BmJNuRK9Mfafqhpd+1E6nW3KBvK0DzDHYg4eEtNBRnLWyPgxXEjT/cnipe4
K8k5bpz/tR1n3lRI0ivTnJWhPR04Y6u6YI1mDNG3XyEJtppPB2EJ6duFJSCf3Gw1
u0YAAbV3O3arxPw+MwZbv/d9JtnExFisn99HxLQ8llU2TOccm56UXsgaolKOl0m2
6qEOkxJw
=b+Bt
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
