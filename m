Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6JHvcoS023746
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 13:57:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 41WhYr2zpSz2Vp8y
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 17:57:36 +0000 (UTC)
Received: from UPBD19PA01.eemsg.mil (unknown [192.168.18.2])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 41WhYp3k9vz2Vp8Y
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 17:57:34 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id w14-v6so7727264eds.6
 for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2018 10:57:33 -0700 (PDT)
Date: Thu, 19 Jul 2018 19:57:30 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Lukas Vrabec via refpolicy <refpolicy@oss.tresys.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20180719175730.GD26209@julius.enp8s0.d30>
References: <11ce07ad-6001-f686-29be-202c9062730e@redhat.com>
 <20180719164025.GA26209@julius.enp8s0.d30>
 <20180719165139.GB26209@julius.enp8s0.d30>
 <04962941-3775-f83e-fdc8-4dc30354d345@redhat.com>
 <20180719174713.GC26209@julius.enp8s0.d30>
 <a1d08e17-773d-0234-8b38-d0608384b239@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
In-Reply-To: <a1d08e17-773d-0234-8b38-d0608384b239@redhat.com>
Subject: Re: [refpolicy] map permission in can_exec() but not in
 domain_transition_pattern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 07:54:22PM +0200, Lukas Vrabec via refpolicy wrote:
> On 07/19/2018 07:47 PM, Dominick Grift wrote:
> > On Thu, Jul 19, 2018 at 07:42:53PM +0200, Lukas Vrabec via refpolicy wr=
ote:
> >> On 07/19/2018 06:51 PM, Dominick Grift via refpolicy wrote:
> >>> On Thu, Jul 19, 2018 at 06:40:25PM +0200, Dominick Grift wrote:
> >>>> On Thu, Jul 19, 2018 at 06:17:46PM +0200, Lukas Vrabec via refpolicy=
 wrote:
> >>>>> Hi All,
> >>>>>
> >>>>> I found one thing in refpolicy which I don't completely understand.
> >>>>>
> >>>>> In "policy/support/misc_patterns.spt" there is definition of
> >>>>> "domain_transition_pattern" and this contains line:
> >>>>> allow $1 $2:file { getattr open read execute };
> >>>>>
> >>>>> There is missing map permission.
> >>>>>
> >>>>> However in "policy/support/misc_macros.spt" there is definition of
> >>>>> "can_exec" and it contains allow rule:
> >>>>> define(`can_exec',`allow $1 $2:file { mmap_exec_file_perms ioctl lo=
ck
> >>>>> execute_no_trans };')
> >>>
> >>> Sorry can_exec() should just use exec_file_perms which would should b=
e mmap_exec_file_perms + execute_no_trans IMHO
> >>>
> >>>>
> >>>> This should just use mmap_exec_file_perms
> >>>>
> >>
> >> Should we remove lock permission?
> >=20
> > I would say yes, but i am not sure why it was added in the first place
> >=20
>=20
> It could be dangerous to remove it in such general macro. Let's test it
> before.

You might also just add it to mmap_exec_file_perms, even though i do not be=
lieve that either mmap_exec_file_perms or exec_file_perms need it, its not =
such a big deal.

>=20
> >>
> >>>>>
> >>>>> There is a mmap_exec_file_perms which contains:
> >>>>> define(`mmap_exec_file_perms',`{ getattr open map read execute ioct=
l }')
> >>>>>
> >>>>> Map is present in can_exec().
> >>>>>
> >>>>> So for domain transitions we don't allow map permission from calling
> >>>>> domain on binary type but in can_exec macro there is map permission.
> >>>>>
> >>>>> I think this is a bug and in "domain_transition_pattern" there shou=
ld be
> >>>>> this line:
> >>>>> allow $1 $2:file { getattr open read execute map };
> >>>>
> >>>> This should just use mmap_exec_file_perms as well
> >>>>
> >>>>>
> >>>>> instead of:
> >>>>> allow $1 $2:file { getattr open read execute };
> >>>>>
> >>>>> Am I right or missing something?
> >>>>>
> >>>>> Thanks for help!
> >>>>> Lukas.
> >>>>
> >>>> permission sets provide a single point of failure and should used as=
 much as possible
> >>>>
> >>>> These were overlooked and because of this we now have a good example=
 what the purpose of permission sets and patterns is.
> >>>>
> >>
> >> Thanks, I'll prepare patch.
> >>
> >> Lukas.
> >>
> >>>>>
> >>>>> --=20
> >>>>> Lukas Vrabec
> >>>>> Software Engineer, Security Technologies
> >>>>> Red Hat, Inc.
> >>>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>> _______________________________________________
> >>>>> refpolicy mailing list
> >>>>> refpolicy@oss.tresys.com
> >>>>> http://oss.tresys.com/mailman/listinfo/refpolicy
> >>>>
> >>>>
> >>>> --=20
> >>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B=
02
> >>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02
> >>>> Dominick Grift
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> _______________________________________________
> >>> refpolicy mailing list
> >>> refpolicy@oss.tresys.com
> >>> http://oss.tresys.com/mailman/listinfo/refpolicy
> >>>
> >>
> >>
> >> --=20
> >> Lukas Vrabec
> >> Software Engineer, Security Technologies
> >> Red Hat, Inc.
> >>
> >=20
> >=20
> >=20
> >=20
> >> _______________________________________________
> >> refpolicy mailing list
> >> refpolicy@oss.tresys.com
> >> http://oss.tresys.com/mailman/listinfo/refpolicy
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
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

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAltQ0QUACgkQJXSOVTf5
R2l97wwAk3t7Gv02fE2lHGV21VTvLwRtpNAkLhyS2+py9aqp5TGY02/uQvL2IwOX
2TjOGEQ+RlNIzXspuC0jjhX0eGcM2y9p/4sevAbf+96C3zPpVzcfDhu2YyZO0W32
ZAFctVcdSyPvaq5IoBLyT/t2WEXfr7T02LrFC847QT0iFfJny5SHOm6UuxOpeqwE
KZozimFFHWm6P4V1wtvDmj8RL6xWVml2wAjk2DJfrnokTqH1RaqT09t0jfkdNutu
R/lpmUj4hE2UpAfbUXrt2zcz7HMmoNLafZzWGxjhcGGOfPg5URFd3dNdJ9V+y0Xf
AvfjaBn3pixJuLq6CP4ZpqS8b8AqasAXJaDhEB6Fvac1NVOQjYMxrtjr4GEVMUex
LCiV0t1hUY9QflaFZsz3PSY6tWP6WKnZpOT2F8eWCtNbt3lS10zKMopFNl00mENL
zKj2JmHLYeo+4ntC2sdr7dx8UPkPp5V8xCMhCHzCWOLClP2kZnwsxpiOxYBaiymC
y1H8XL5K
=WILM
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
