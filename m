Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8PDqSGb024592
 for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2018 09:52:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so19412907edq.3
 for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2018 06:46:22 -0700 (PDT)
Date: Tue, 25 Sep 2018 15:46:17 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Message-ID: <20180925134617.GA27672@julius.enp8s0.d30>
References: <CAPhFHN8TfDUC8CP=bMiKx0BVNNZuzKcCNPC6hVawMyjBAz1x3Q@mail.gmail.com>
 <CAPhFHN_tOXnaU7EGZ9o_ht4XGqqsAS-VmauH5o7Cb71KF3eN3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <CAPhFHN_tOXnaU7EGZ9o_ht4XGqqsAS-VmauH5o7Cb71KF3eN3w@mail.gmail.com>
Subject: Re: autorelabel loops in system executed 'semodule -d
 unconfined'
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 25, 2018 at 07:19:23AM +0900, Shintaro Fujiwara wrote:
> Hi, SELinux.
>=20
> I captured a picture saying this.
>=20
> rm: cannot remove '/.autorelabel' : Permission denied
>=20
> /.autorelabel could not be removed, so going into the loop, I guess.
>=20
> How can I autorelabel properly even if I delete unconfined module?

This may or may not be a policy issue (see avc denials), but:

Generally you want to do a full relabel in permissive mode.

>=20
> Thanks.
> 2018=E5=B9=B49=E6=9C=8825=E6=97=A5(=E7=81=AB) 6:55 Shintaro Fujiwara <shi=
ntaro.fujiwara@gmail.com>:
> >
> > Hello, SELinux.
> >
> > I was playing with my F28 latest with 'semodle -d unconfined'.
> > I executed this and relabeling starts even after finished relebeling
> > and looks like going into the loop.
> > # touch /.autorelabel
> > # shtudown -r now
> >
> > I have attached a picure.
> >
> > Thanks.
>=20
>=20
>=20
> --=20
> Help analyzing sar file
> https://github.com/intrajp/sar-analyzer
>=20
> LFS Scripts will make Linux From Scratch easy
> https://github.com/intrajp/LFS-scripts-systemd
>=20
> SHIRASAGI-hardening Project
> https://github.com/intrajp/shirasagi-hardening
>=20
> Linux Distribution Project
> http://sourceforge.net/projects/pinkrabbitlinux/
>=20
> Introducing hardrock and heavymetal
> http://heavymetalhardrock.no-ip.info/
>=20
> Open Source Software to manage SELinux at ease
> http://sourceforge.net/projects/segatex/
>=20
> Help SELinux administration
> https://github.com/intrajp/segatex-ng
>=20
> network-magic ( Useful tool for network-administrators )
> https://github.com/intrajp/network-magic
>=20
> CMS=EF=BC=88with PHP & PostgreSQL=EF=BC=89
> http://sourceforge.net/projects/webon/
> https://github.com/intrajp/irforum_jp


> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAluqPCQACgkQJXSOVTf5
R2nR6wv+OCdPg9P0eMr/CcFNyjirzwAQLVN3zeqns3pvfjj0uVBgXB8HGtntM5qF
G8+L7YnPCF4j5KfS7+HnDOJxD3rxvGYRWrSUnctZxEbkGd9Es9YGZnROeK6feXdc
tT3aJYgQD3KlgufqzRmQ+mU/u1CD1Qwe8cG2m4QUnly4DTRTvn+oF0bxAKRISjJa
/TWQmHjiTw19HHuJnkz3B6zkdeLy/2kc4kXTCRcg0tOZwOhlT7HrFolf/NvrdoM8
fI1MsqUNxzoR/nTx+4HGOPxrUP9EPimihQ0YuwX/am+b+1vH8m7YS7g+vIjieSqJ
7DAyEwcf13UPcAQifuRroedNFoN4xNoqqyOzxUXvnVl9yNKtnpIJ1PbsOvpgVAMD
5+IOfkOaaCcNBWjYv23N+WnhlfzGIi4ik0yjSnjdR0hGSP1TVNv3WF+CK7cYaOZY
N/pfbYw2IyAyjq65ojgI/Cp5zkS7Ls3DIFk8xJGQ8ulP81HQGQ1/fAOsIm4mCHIJ
wz7HR1xg
=Tzp4
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
