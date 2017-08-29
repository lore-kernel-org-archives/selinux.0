Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7TEEDRB003473
 for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2017 10:14:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id e67so3669138wmd.0
 for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2017 05:56:07 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id t12sm1239555edi.29.2017.08.29.05.56.04
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Aug 2017 05:56:04 -0700 (PDT)
Date: Tue, 29 Aug 2017 14:56:02 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170829125602.GB7206@julius.enp8s0.d30>
References: <CABXk95BhYEZUQn74_H5Y0Ogxm23ZoLZA2Eiz22QTJwKG741B=Q@mail.gmail.com>
 <1504011284.5220.2.camel@tycho.nsa.gov>
 <1504011407.5220.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
In-Reply-To: <1504011407.5220.3.camel@tycho.nsa.gov>
Subject: Re: sysfs symlinks in genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 08:56:47AM -0400, Stephen Smalley wrote:
> On Tue, 2017-08-29 at 08:54 -0400, Stephen Smalley wrote:
> > On Mon, 2017-08-28 at 14:58 -0700, Jeffrey Vander Stoep via Selinux
> > wrote:
> > > Genfs_contexts does not label symlinks in sysfs, instead it leaves
> > > them with the default =E2=80=9Csysfs=E2=80=9D label. Is this a bug?
> >=20
> > We excluded symlinks from genfscon labeling back when only proc was
> > using genfscon for per-file labeling and we encountered a
> > compatibility
> > problem when /proc/net was moved to /proc/self/net for network
> > namespaces (see commit cited below). Suddenly applications were
> > getting
> > proc_net_t:lnk_file read denials when accessing /proc/net because
> > existing policies only allowed proc_t:lnk_file read and
> > proc_net_t:dir/file read, so new kernel + old policy broke userspace,
> > which is not allowed by Linus. =C2=A0At the time, I couldn't see a use
> > case
> > where we would need to support per-file labeling of symlinks in proc,
> > since the only meaningful operation on a proc symlink is
> > read/getattr.=C2=A0
> > The real access controls are to the individual directories/files, not
> > the symlinks.
> >=20
> > Do you truly need per-file labeling of symlinks in sysfs?=C2=A0=C2=A0Wh=
at's the
> > use case?=C2=A0=C2=A0I guess it is an inconsistency between the support=
 for
> > sysfs
> > labeling via setxattr vs genfscon, but there are likely other more
> > significant inconsistencies due to the support for pathname regexes
> > in
> > file_contexts versus pathname prefixes in genfscon, e.g. see
> > https://github.com/SELinuxProject/selinux-kernel/issues/29
> >=20
> > That said, I agree it is an ugly hack and should likely be removed if
> > it doesn't cause compatibility problems (we'd need to test on RHEL
> > 6/7
> > at least).
>=20
> I guess we should probably wrap the change with a policy capability so
> that it can be conditionally enabled by new policies and then we don't
> have to worry about any compatibility problems with old policies.

A policy capability would be nice. I would be interested in reading more ab=
out the use-case for this as well.

>=20
> >=20
> > Have you measured to see the impact of switching from setxattr to
> > genfscon for sysfs labeling?
> >=20
> > commit ea6b184f7d521a503ecab71feca6e4057562252b
> > Author: Stephen Smalley <sds@tycho.nsa.gov>
> > Date:=C2=A0=C2=A0=C2=A0Mon Sep 22 15:41:19 2008 -0400
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0selinux: use default proc sid on symlinks
> > =C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0As we are not concerned with fine-grained contr=
ol over reading of
> > =C2=A0=C2=A0=C2=A0=C2=A0symlinks in proc, always use the default proc S=
ID for all proc
> > symlinks.
> > =C2=A0=C2=A0=C2=A0=C2=A0This should help avoid permission issues upon c=
hanges to the proc
> > tree
> > =C2=A0=C2=A0=C2=A0=C2=A0as in the /proc/net -> /proc/self/net example.
> > =C2=A0=C2=A0=C2=A0=C2=A0This does not alter labeling of symlinks within=
 /proc/pid
> > directories.
> > =C2=A0=C2=A0=C2=A0=C2=A0ls -Zd /proc/net output before and after the pa=
tch should show
> > the
> > differenc
> > e.
> > =C2=A0=C2=A0=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by:=C2=A0=C2=A0Stephen D. Smalley <s=
ds@tycho.nsa.gov>
> > =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: James Morris <jmorris@namei.org>

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmlZF8ACgkQJXSOVTf5
R2kqUwv+O1Bjr3cUv0QNEzrbmYovwnJct9k9TB+muaGvuPYPrEPkd88DSUaOAEIZ
77t3XO121zK/x6H4Drhgi5QTNKDRXe4tBbSUWMdmIuvnl7Mw9iAEVti0887N807r
PCfNRT1TPcKBt+MsHPGz8ZXg+OL1lb+Uh1+8hfWMMJVJUULXxQY2ZP+ip9ePE/zO
erPpjPXoSwaxeKloOqz1T6U0Kn/0BBKqOkPeidwIgLBb6JS2h7iGqUxAlkaw4Xio
zRQUcFKkXAwySs/oIdA6nZJnH7RTkDcaHmSGE3LO+NX4mGz39C08mGTxQ8AnNuWU
i7i4uPDlpDOgyfaalI0fgRGKKB3uXOBc6hN1IUS8HtUa91GIH8AjSuvynpH5ON4f
G4DqV82QqlmDlukvmR/h3y392g+6aHdyqa/KnqcEIIYH+r/IKKl2JeEbuULjR8xF
fXKz1Y6QdxFAQkETbuwRr8InDcujalhdEwYnQn6SCGwX8lNdwlr/Zql0GTRdkKXe
K9gZ9Geh
=tV3l
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
