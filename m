Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2MGQmAE016339
 for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2018 12:26:48 -0400
Received: by mail-wm0-f44.google.com with SMTP id f125so17190697wme.4
 for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2018 09:26:44 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id l1sm3732431edi.54.2018.03.22.09.26.42
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 22 Mar 2018 09:26:42 -0700 (PDT)
Date: Thu, 22 Mar 2018 17:26:40 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180322162640.GB6824@julius.enp8s0.d30>
References: <9dc38544-b297-741e-dd7e-e09778a0baf3@debian.org>
 <7ba2608b-f5e1-a3ce-583a-1cabcffdffb9@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <7ba2608b-f5e1-a3ce-583a-1cabcffdffb9@tycho.nsa.gov>
Subject: Re: dbus-daemon patches review
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 12:09:08PM -0400, Stephen Smalley wrote:
> On 03/21/2018 07:58 AM, Laurent Bigonville wrote:
> > Hello,
> >=20
> > Could somebody have a quick look at the two patches that I opened for t=
wo dbus bugs:
> >=20
> > https://bugs.freedesktop.org/show_bug.cgi?id=3D92831 (stop using avc_in=
it())
> >=20
> > https://bugs.freedesktop.org/attachment.cgi?id=3D138021 (stop using sel=
inux_set_mapping())
> >=20
> > I'm also wondering whether the call to avc_add_callback() shouldn't be =
replaced by selinux_set_callback(), an opinion on this?
>=20
> Patches look sane to me although I'm not really familiar with dbus code.
>=20
> Looks like the callback is only used to trigger a reload of the dbus conf=
iguration (for dbus_contexts updates), and thus selinux_set_callback(SELINU=
X_CB_POLICYLOAD) is more appropriate than avc_add_callback(AVC_CALLBACK_RES=
ET), since the latter is called upon setenforce 1 as well.  However, if it =
were truly only for that purpose, one might argue that it ought to be a wat=
ch on the dbus_contexts file instead and not be tied to selinux at all.
>=20
> NB This still won't fix the case where dbusd has already performed a stri=
ng_to_security_class/av_perm lookup and the result has been cached by the l=
ibselinux class cache and then a subsequent policy update alters those valu=
es.  That is what was fixed for systemd's usage of selinux_check_access() b=
y selinux commit b408d72ca9104cb0c1bc4e154d8732cc7c0a9190.  Offhand, I'm no=
w wondering why I didn't just call flush_class_cache() from avc_reset() its=
elf.  That would fix it for other users of the AVC.  You can't directly cal=
l flush_class_cache() from the dbus selinux policyload callback because it =
is hidden presently.  If we can fix it directly in libselinux, then that is=
 better.  If not, we'd need to export it and probably give it a more unique=
 name, ala selinux_flush_class_cache().

dbus-broker also uses selinux_access_check: https://github.com/bus1/dbus-br=
oker/issues/16

>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlqz2T0ACgkQJXSOVTf5
R2kHXwv+N6hmZO+wt0ViUImHzdTBaHDawp+CIFBYwNgIlNuP/7DyHXolcyyc3LK+
s49IJlp1ApoOpKHMnc6Zxr8bS1ARuU93sh+egkHxQBdjS8cW5WWjswwAv8TNzJpl
DBKI0mruCyHUUIG1EqOmaJoXWjRl3/IhqQ5BLinSs87reHiMHyxWMho7zO7mD0bo
A0B+0B/1LR2Sn5jo+JhmVWHFQkf9WI2So0s0f31fEuU6YjAp/LX0pkqy8ZNstdJy
pfQ6SGavUSCSyRDW0V/pbZgNxFYsasS7adevYF/hZiPTt81fgeMvk8ECrRfu33Pb
gKh72DT2vj3KPJlr6eobCNhlwbPR9psa6gLKMnh6HIDyN3Uk3B7AJk6dOj0CK5XW
T93Ml9jmkcGRDUT/U+XWns2Ug6FDQUsbEWq+icoRyVryhjCuJVljLs5MTxUO+fMT
2xVkMuc/731Wc4ZnjG1vOuoHigW2kImMhWg0dG0xmI77rABps6wKYCFIIi37BdtO
SNr2e8KS
=BsRF
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
