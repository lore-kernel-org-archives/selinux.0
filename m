Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3EI87vl010227
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 14:08:08 -0400
Received: by mail-wr0-f180.google.com with SMTP id c55so54281749wrc.3
 for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2017 11:07:34 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id 23sm3272356wrx.26.2017.04.14.11.07.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Apr 2017 11:07:32 -0700 (PDT)
Date: Fri, 14 Apr 2017 20:07:31 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
Message-ID: <20170414180731.GA16153@markus>
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
 <1492192590.26072.5.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <1492192590.26072.5.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--cNdxnHkX5QqsyA0e
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

Do you see anything else in there that might cause libselinux linked proces=
ses to think selinux is disabled?

getfilecon/setfilecon does not work with ProtectKernelTunables=3Dyes. There=
 is no mention of it in the (debug) log. It just
skips the whole getfilecon/setfilecon step


>=20
> > The reason we want this is so that processes inside of containers do
> > not
> > attempt to do SELinux stuff.=A0
> >=20
> > http://danwalsh.livejournal.com/73099.html

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljxD98ACgkQJXSOVTf5
R2nQPAv+PH4ZUR5gGp5CXryfSda+Z6z4TNaWOxn61MdOHM2T7Imsl7LTY0jALJ6w
DNyhzxHI8jgZfMyi7h5uxH5YVZkBQfRpnaIBpZV7aGN0Y5w3ctXHEPBQcLSA9BiR
AVVK4gfzruNVX+kwPSZVkG3UUi9h4EkZJHrEQaVqMam4hB1YxENakwiILtmOwTwg
3UvWmTwL1xI+DEc1xEupoN5aeDNPObWfps5Lrp7q4UZv8kyYQ8ZTSZMC6nDs3Ine
VQ5OxeiNlByN+Dgs2t0yENdcsSeNG0f75FapJjN5btnlqYVk6Z+kSf2isuOGRJdp
zI5av9UpVgNtk5sJg8MT6yuPj8lsiPGWhj/djk+qiV9rUWUzK7vFCeCRUcF4Wlr7
9+19F0QFNdgs3I/hWGzBUP+gcLZJ2OEi8w95OuSyAea9seXRhraJa7objfgDNUHW
0NElfruGVMm2zv2vFFnysmHd7JpCuo/Cnyoj1675LbrQ2LgqURCO2QK5+/Eu+Smi
Mk3atS37
=emCl
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
