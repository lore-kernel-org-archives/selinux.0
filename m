Date: Thu, 3 Sep 2015 14:40:14 +0200
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150903124013.GB2118@x250>
References: <20150903094844.GA18832@x250>
 <55E83A89.5010208@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
In-Reply-To: <55E83A89.5010208@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 08:18:17AM -0400, James Carter wrote:
> On 09/03/2015 05:48 AM, Dominick Grift wrote:
> >Anyone tried "secilc test/in_test.cil" lately? It dumps core here.
> >
> >$ secilc test/in_test.cil
> >Segmentation fault (core dumped)
> >
> >
>=20
> It works for me for the current master branch of SELinux userspace instal=
led
> locally. What version are you using?
>=20
> Jim

It may just be my incompetence but i can't get current master branch
selinux user space to build on Fedora rawhide manually like so:

# cd selinux
# make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64

I have installed all the build dependencies i believe

This is what it is failing with here:

cc1: all warnings being treated as errors
Makefile:113: recipe for target 'direct_api.o' failed
make[2]: *** [direct_api.o] Error 1
make[2]: Leaving directory
'/home/kcinimod/Workspace/selinux/libsemanage/src'
Makefile:2: recipe for target 'all' failed
make[1]: *** [all] Error 2
make[1]: Leaving directory
'/home/kcinimod/Workspace/selinux/libsemanage'
Makefile:11: recipe for target 'all' failed
make: *** [all] Error 1

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

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6D+oAAoJENAR6kfG5xmcG0AMALjc428jOA7MQbDklVVObCJY
l3aavCoSgxaDDoWSN0c+vXt8SjAWiuQ35MUoz4BsZjsEVUlpJl3BXAzjbRFuQMpv
ctlT/5F4p86yFC6S/IHuTVkimLXDWxiom3/OQaiBBVZBtBZkc8u9UVDgAlO0VBFo
xzkfbFJBtDVRsTp9g1yXmHw2XgdBe4bmyD5FBPoX3vgTu/1kPWTJzLSLze/LKlYb
fCN/rv2Md2Mupvj2dOehhq/PocBEmpgnuFa/RGmrgl0LK80MJLVoJKzelPCE0FZG
/pCNMyPEhSi80q8F/JJ1jj6SBuncnuNB/rWlaPcRN1XQgSozm6PHqp/Y4egrVZ4Z
awbTY64sruHVa1j5Nh8UFvzsM1s3UTbmDF9SH1oXhKMi0yxFoQoNpryPWA74jUWy
UrCMYoPhMYZRt4ErrWrzvYdfP1R7zh/tz67MwtIk+dh88IOaPm4RFxYrcNNiSXuO
mbfL5sO2fyfPLxC9vD0aLoxI/T6PTEPwvNrv71Ng4w==
=f+z9
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
