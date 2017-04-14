Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3EFjm1n029646
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 11:45:48 -0400
Received: by mail-wr0-f171.google.com with SMTP id c55so52756397wrc.3
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 08:45:46 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id k199sm3094239wmd.20.2017.04.14.08.45.44
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Apr 2017 08:45:45 -0700 (PDT)
Date: Fri, 14 Apr 2017 17:45:43 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
Message-ID: <20170414154543.GB7980@markus>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
In-Reply-To: <1492184005.26072.3.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2017 at 11:33:25AM -0400, Stephen Smalley wrote:
> On Fri, 2017-04-14 at 16:57 +0200, Dominick Grift wrote:
> > Bear with me please, because i might not fully grasp the issue (i
> > received help with diagnosing this issue):
> >=20
> > This commit causes issues (and is, i think, a lousy hack):
> > e3cab998b48ab293a9962faf9779d70ca339c65d
> >=20
> > The commit causes entities to "think" that SELinux is disabled after
> > "mount -o remount,ro /sys/fs/selinux
> >=20
> > It is "neat" to be able to make processes "think" that selinux is
> > disabled on a selinux enabled system but not if it break anything
> >=20
> > The above results in the following:
> >=20
> > Systemd services that have ProtectKernelTunables=3Dyes set in their
> > respective service units, think that SELinux is disabled.
> >=20
> > However we have found that some of these services actually rely on
> > SELinux to ensure proper labeling.
> >=20
> > So we have the option to make people aware that if you set
> > ProtectKernelTunables=3Dyes that then the process cannot be SELinux-
> > aware properly, or we can just get rid of the commit above and just
> > accept that process know that SELinux is enabled.
> >=20
> > Actual bug that caused me to look into this: systemd-localed selinux
> > awareness is broken due it having ProtectKernelTunables=3Dyes in its
> > service unit
>=20
> If selinuxfs is mounted read-only, then they can't use most of the
> selinuxfs interfaces, including even the ability to validate or
> canonicalize security contexts.  That will break most SELinux-aware
> services if we tell them that SELinux is enabled.  Are you sure
> systemd-localed would actually work if you told it SELinux was enabled
> when selinuxfs was mounted read-only?  What SELinux interfaces is it
> using?

AFAIK its just getfilecon/setfilecon to ensure proper labeling of various f=
iles in /etc that it creates with random names. I understand that removing =
ProtectKernelTunables=3Dyes atleast makes the functionality that I identifi=
ed to have been broken before work. Whether something was overlooked. I do =
not know.


>=20
> The other question is whether ProtectKernelTunables ought to be
> mounting selinuxfs read-only.  SELinux already controls the ability to
> use its interfaces, including limiting even root, so it is unclear what
> benefit we derive from having systemd add a further restriction on top.
>=20

These are questions that I cannot answer. I am not sure whether systemd mou=
nts selinux r/o as part of ProtectKernelTunables, but I understand that it =
does. I agree that if it does that it should be do that in the first place.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljw7qMACgkQJXSOVTf5
R2kN4gv+OF6A+ctYKuS45D+zPaztfD5hG8/DA7YQAeZ4PiZnTz50uegFJuIDcvfy
ow8/xz4mKuLTU5DuzZfC0GmO561rJWqxJurPivw2YLlh/6zfXIogR2lKhbPI9qyc
3pAlhI41+P/dR4wIbUE5JnnBNpHEyRH0COqy9umyV/5IzcU0SI40H+cWFjRVejqi
kWTklRU/JvFcHRw3B31aTuO5G2xAinrmnbR5e1nB/eBmKZEW3OEYuY0MM50t85Df
inH+crhFobi1s3Gpa5RBEwxsEh332hT73whp5DOo3qtN2HTsySMAjdeQYlj1P3jK
RGaLvccBznsuY/cMrEP60U9H6dK/O+kTVbaR6Whf3TJxis248F1NkWbkJ0upQaiK
elDDITXCGZJs/eYy4LneTVbbAM54SdxNaXFPFddQnKvPtEPVIJfSFK332DL7nj5/
eZa8QvE4UpxvVjWtIOaySPjS5ViEtd/dGV8TB4Xlxi9ThsxL0QKFpD8fQO2cbV+0
Jh1yj8qR
=cmE0
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
