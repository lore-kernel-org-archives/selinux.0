Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44EhQt5001859
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 10:43:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id o78-v6so5303851wmg.0
 for <selinux@tycho.nsa.gov>; Fri, 04 May 2018 07:43:21 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id g15-v6sm10076331edb.69.2018.05.04.07.43.19
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 May 2018 07:43:19 -0700 (PDT)
Date: Fri, 4 May 2018 16:43:18 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180504144318.GD3263@julius.enp8s0.d30>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504075510.GB5101@baraddur.perfinion.com>
 <3c51abc9-2d3a-3cef-2ba1-d976dee651c5@tycho.nsa.gov>
 <20180504132629.GC3263@julius.enp8s0.d30>
 <acd4d278-d819-4491-7cae-9644a2b9adfb@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
In-Reply-To: <acd4d278-d819-4491-7cae-9644a2b9adfb@tycho.nsa.gov>
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 09:36:12AM -0400, Stephen Smalley wrote:
> On 05/04/2018 09:26 AM, Dominick Grift wrote:
> > On Fri, May 04, 2018 at 09:08:36AM -0400, Stephen Smalley wrote:
> >> On 05/04/2018 03:55 AM, Jason Zaman wrote:
> >>> On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
> >>>> Hi,
> >>>>
> >>>> If you have encountered any unreported problems with the 2.8-rcX rel=
eases or have any
> >>>> pending patches you believe should be included in the 2.8 release, p=
lease post them soon.
> >>>
> >>> the rc2 release has been fine for me for several days now. And I have=
nt
> >>> heard any issues from any gentoo users either so we're probably good =
to
> >>> go. -rc1 failed to boot properly for me because some important things=
 in
> >>> /run or /dev didnt get labeled but that was fixed in rc2.
> >>
> >> Hmm...I'd like to understand that better. The change was verifying fil=
e_contexts when using restorecon,
> >> which was reverted in -rc2.  But the fact that it prevented labeling f=
iles in -rc1 means that either
> >> you have a bug in your file_contexts configuration or there is some ot=
her bug there.
> >=20
> > If it cannot validate_context then it will be unhappy:
> >=20
> > [root@julius ~]# dnf history info last
> > Transaction ID : 364
> > Begin time     : Fri 04 May 2018 01:12:36 PM CEST
> > Begin rpmdb    : 1404:e739a03c49fec80ed41a1ea4c599d8f877b01d76
> > End time       : Fri 04 May 2018 01:14:01 PM CEST (85 seconds)
> > End rpmdb      : 1404:27bd40dce7edbf226ffad80f482cd75231f1b6ab **
> > User           : kcinimod <kcinimod>
> > Return-Code    : Success
> > Command Line   : update --exclude efi-filesystem
> > Transaction performed with:
> >     Installed     dnf-2.7.5-12.fc29.noarch @rawhide
> >         Installed     rpm-4.14.1-8.fc28.x86_64 @tmp-rawhide
> > 	Packages Altered:
> > 	    Upgraded cockpit-166-1.fc29.x86_64                      @rawhide
> > ... snip ...
> > Scriptlet output:
> >    1 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contex=
ts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> >       2 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_con=
texts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> >          3 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_=
contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:=
s0
> > 	    4 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_cont=
exts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> > 	       5 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_c=
ontexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
>=20
> So, just to be clear: these contexts are in fact valid but the lack of pe=
rmission to use the /sys/fs/selinux/context interface (for security_check_c=
ontext) causes it to think the context is invalid and therefore fails?  If =
so, then=20
> that makes sense and would be another reason for reverting that change.  =
In any case, -rc2 should have the fix.

Yes contexts are valid but since validate_context was blocked this happened=
=2E By allowing validate_context this works fine

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrscYIACgkQJXSOVTf5
R2kWIQv9GCHSWFr3V52trIg/vswxQ5XG1e7Wji99Vh6rVqWZmBoi+kW6/TnipxTd
X192cHC1YWfjuIper54XahZ91DpgWj1j4dqiBIcNtKmKwyz9y3OhH/ZPOfY65F1p
l0dlgPpb1V6E/UbPthEb1V3NJ9wU3b+OLOIvSvnQE2AxS13CBvTmf6GJiOHTLDqq
/v/UT+p/qrqWnDSXG5bQzz8uGDzNwynzvHoMDfVVNxxzjHKr+J5azrO39q0POpfg
/vnsmxUjPajjCXJTPJatv956QnP7uCGRH62rEGYN10fO1mDqLsFxxw4yg42KWBYS
ExcS9yCjjVHsbz2+Db5utrAMShfky5xtJGq+YefK+W5IhsgOmRDXOQTK4LiOzZ7q
q4wJJRPSPZjNoB78q3+F2oZFWaJ9ijC+VGmq2qNFaZ4ITRCYrjR0UPJyM+5X+fqg
rek0PJAf2dKy+HT0j0xDLeJL92DamQ6lXqsMs6FbzsTYoGocQ+6iOAYx5g+zkOUY
SGADuA44
=DtYj
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
