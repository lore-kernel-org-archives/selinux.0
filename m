Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JGpn9x015747
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 12:51:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 41Wg5t3d99z2Sj4c
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 16:51:46 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 41Wg5r6LNvz2Sj4B
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 16:51:44 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so7598200edr.5
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 09:51:44 -0700 (PDT)
Date: Thu, 19 Jul 2018 18:51:39 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>,
 selinux@tycho.nsa.gov
Message-ID: <20180719165139.GB26209@julius.enp8s0.d30>
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
In-Reply-To: <20180719164025.GA26209@julius.enp8s0.d30>
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 06:40:25PM +0200, Dominick Grift wrote:
> On Thu, Jul 19, 2018 at 06:17:46PM +0200, Lukas Vrabec via refpolicy wrot=
e:
> > Hi All,
> >=20
> > I found one thing in refpolicy which I don't completely understand.
> >=20
> > In "policy/support/misc_patterns.spt" there is definition of
> > "domain_transition_pattern" and this contains line:
> > allow $1 $2:file { getattr open read execute };
> >=20
> > There is missing map permission.
> >=20
> > However in "policy/support/misc_macros.spt" there is definition of
> > "can_exec" and it contains allow rule:
> > define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lock
> > execute_no_trans };')

Sorry can_exec() should just use exec_file_perms which would should be mmap=
_exec_file_perms + execute_no_trans IMHO

>=20
> This should just use mmap_exec_file_perms
>=20
> >=20
> > There is a mmap_exec_file_perms which contains:
> > define(`mmap_exec_file_perms',`{ getattr open map read execute ioctl }')
> >=20
> > Map is present in can_exec().
> >=20
> > So for domain transitions we don't allow map permission from calling
> > domain on binary type but in can_exec macro there is map permission.
> >=20
> > I think this is a bug and in "domain_transition_pattern" there should be
> > this line:
> > allow $1 $2:file { getattr open read execute map };
>=20
> This should just use mmap_exec_file_perms as well
>=20
> >=20
> > instead of:
> > allow $1 $2:file { getattr open read execute };
> >=20
> > Am I right or missing something?
> >=20
> > Thanks for help!
> > Lukas.
>=20
> permission sets provide a single point of failure and should used as much=
 as possible
>=20
> These were overlooked and because of this we now have a good example what=
 the purpose of permission sets and patterns is.
>=20
> >=20
> > --=20
> > Lukas Vrabec
> > Software Engineer, Security Technologies
> > Red Hat, Inc.
> >=20
>=20
>=20
>=20
>=20
> > _______________________________________________
> > refpolicy mailing list
> > refpolicy@oss.tresys.com
> > http://oss.tresys.com/mailman/listinfo/refpolicy
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAltQwZcACgkQJXSOVTf5
R2lmGQwAjgnq4ft7Cx+bIQ1bMpLziH04uW9flU0E70EAPex3aXymdCzeRfH8b4SZ
IOkXSlF7u56FXU8NJ6qRmpG2nTiBJqAfULoqF3hHjB3eyHlc6pfd2AbbBsbT5gtv
dG2JIHwYtY75UBLSBh2iSkkJQF2qRWPUlkfmmJn1mFA6TpM1iAROrP5pQh4rrjqQ
sQdOk4Nzdwwegg7S0gWLrENrDWzzSlinctt4gXP7SVgiKL+0qmolYOZiL2TOycsy
tQC8IhJYHuQ1TCvDMg/ZB893llHglS/L17SjUPEnOwVihNKm/jkVCFWIAi8nJMDR
n5/RAlhBHbqCCtLT3c9WW3B2K0cKyfbES/nUYe+qCbZgyYbluc5ie5wugwZ8RhNe
qNeeQgzbW9AMC6fcaEx2jurgf1Qd3hOcM64XikbZsibg07ux4lORDnagexLQtpxq
DCNUHljkrk9AE0Bt6iYf9LM5d6xqRUQdDKur8gseZe/SehJaeMSN8s2FKKhS79vy
3eAUSvyh
=CmhR
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
