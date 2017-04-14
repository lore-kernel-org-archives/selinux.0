Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3EInrMI021955
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 14:49:53 -0400
Received: by mail-wr0-f181.google.com with SMTP id c55so54719014wrc.3
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 11:49:49 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id l19sm3382645wre.2.2017.04.14.11.49.47
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Apr 2017 11:49:48 -0700 (PDT)
Date: Fri, 14 Apr 2017 20:49:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
Message-ID: <20170414184946.GB16153@markus>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
 <1492192590.26072.5.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
In-Reply-To: <1492192590.26072.5.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2017 at 01:56:30PM -0400, Stephen Smalley wrote:
> On Fri, 2017-04-14 at 13:47 -0400, Daniel Walsh wrote:
> > On 04/14/2017 11:33 AM, Stephen Smalley wrote:
> > > On Fri, 2017-04-14 at 16:57 +0200, Dominick Grift wrote:
> > > > Bear with me please, because i might not fully grasp the issue (i
> > > > received help with diagnosing this issue):
> > > >=20
> > > > This commit causes issues (and is, i think, a lousy hack):
> > > > e3cab998b48ab293a9962faf9779d70ca339c65d
> > > >=20
> > > > The commit causes entities to "think" that SELinux is disabled
> > > > after
> > > > "mount -o remount,ro /sys/fs/selinux
> > > >=20
> > > > It is "neat" to be able to make processes "think" that selinux is
> > > > disabled on a selinux enabled system but not if it break anything
> > > >=20
> > > > The above results in the following:
> > > >=20
> > > > Systemd services that have ProtectKernelTunables=3Dyes set in their
> > > > respective service units, think that SELinux is disabled.
> > > >=20
> > > > However we have found that some of these services actually rely
> > > > on
> > > > SELinux to ensure proper labeling.
> > > >=20
> > > > So we have the option to make people aware that if you set
> > > > ProtectKernelTunables=3Dyes that then the process cannot be
> > > > SELinux-
> > > > aware properly, or we can just get rid of the commit above and
> > > > just
> > > > accept that process know that SELinux is enabled.
> > > >=20
> > > > Actual bug that caused me to look into this: systemd-localed
> > > > selinux
> > > > awareness is broken due it having ProtectKernelTunables=3Dyes in
> > > > its
> > > > service unit
> > >=20
> > > If selinuxfs is mounted read-only, then they can't use most of the
> > > selinuxfs interfaces, including even the ability to validate or
> > > canonicalize security contexts.=A0=A0That will break most SELinux-awa=
re
> > > services if we tell them that SELinux is enabled.=A0=A0Are you sure
> > > systemd-localed would actually work if you told it SELinux was
> > > enabled
> > > when selinuxfs was mounted read-only?=A0=A0What SELinux interfaces is
> > > it
> > > using?
> > >=20
> > > The other question is whether ProtectKernelTunables ought to be
> > > mounting selinuxfs read-only.=A0=A0SELinux already controls the abili=
ty
> > > to
> > > use its interfaces, including limiting even root, so it is unclear
> > > what
> > > benefit we derive from having systemd add a further restriction on
> > > top.
> > >=20
> >=20
> > Why is selinuxfs mounted readonly in this case?
>=20
> I don't actually see this in upstream systemd unless I am just missing
> it.
>=20
> systemd/src/core/namespace.c:
> /* ProtectKernelTunables=3D option and the related filesystem APIs */
> static const MountEntry protect_kernel_tunables_table[] =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/sys",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0RE=
ADONLY,=A0=A0=A0=A0=A0false },
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/sysrq-trigger", READONLY,=A0=A0=A0=A0=A0=
true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/latency_stats", READONLY,=A0=A0=A0=A0=A0=
true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/mtrr",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0READ=
ONLY,=A0=A0=A0=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/apm",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0RE=
ADONLY,=A0=A0=A0=A0=A0true=A0=A0}, /* Obsolete
> API, there's no point in permitting access to this, ever */
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/acpi",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0READ=
ONLY,=A0=A0=A0=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/timer_stats",=A0=A0=A0READONLY,=A0=A0=A0=
=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/asound",=A0=A0=A0=A0=A0=A0=A0=A0READONLY=
,=A0=A0=A0=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/bus",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0RE=
ADONLY,=A0=A0=A0=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/fs",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
READONLY,=A0=A0=A0=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/proc/irq",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0RE=
ADONLY,=A0=A0=A0=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/sys",=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0READONLY,=A0=A0=A0=A0=A0false },
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/sys/kernel/debug",=A0=A0=A0READONLY,=A0=A0=A0=
=A0=A0true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/sys/kernel/tracing", READONLY,=A0=A0=A0=A0=A0=
true=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0{ "/sys/fs/cgroup",=A0=A0=A0=A0=A0=A0READWRITE,=
=A0=A0=A0=A0false }, /* READONLY is
> set by ProtectControlGroups=3D option */
> };
>=20
> No mention of selinuxfs at all.  Maybe it is a Fedora patch?
>=20
> > The reason we want this is so that processes inside of containers do
> > not
> > attempt to do SELinux stuff.=A0
> >=20
> > http://danwalsh.livejournal.com/73099.html

Before one dismisses my concern (8 minute proof):

https://www.youtube.com/watch?v=3DYqiM1MlOG0w

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljxGcYACgkQJXSOVTf5
R2kaywv9HxVqZU2uegMRHSI6XMMeSp10SmBM2QOhnk2A4Ur9KdyNGbIG3S0ticzc
XbB2MS0hNcL0iNtWtI84sz2rnQVmnIPAE7P4NBzIeOeVemXGQ8G3Kl4myQU4RuOI
0OJe7AwIpZuKKAHYl930xyXurfIlJ0E4NGwOSpymfQWvqq6G2evH0W/m2MGQoxWR
8zQMAG9t8Q3NwcIheCejrdgqd5/LjNscYf3UkxBTLO0jKqaMgDeSJc3kZZF+/aNq
dN4wC1aqRkctdXECf2gRzYs0ZiAkmdfiNFKv3vuh5AdO9yi2yeH6vtNOBsdBb2hf
7lqdjzRbvzoBtF1I4PJNnvFn9DmUBM0RBNrZorGovmFW20N23E4GGyYeI+Fe1gfJ
UcXg/dPldLmyhDCx3Yz8Y+HmOt9sfjmW9MkG+K3D/OSwCajpJbDrjFILRjOFNbI4
jau06Pj5yfZqTe0B4lp7CEf5hFDud74BwZkrOr1sAIhjqQFB20F2Vgkl8GSlKXZv
wA/aljC1
=p3Ft
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
