Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3RGs6qU013559
 for <selinux@tycho.nsa.gov>; Thu, 27 Apr 2017 12:54:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id u65so22181264wmu.1
 for <selinux@tycho.nsa.gov>; Thu, 27 Apr 2017 09:54:02 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id y24sm1034367edb.62.2017.04.27.09.54.00
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Apr 2017 09:54:00 -0700 (PDT)
Date: Thu, 27 Apr 2017 18:53:58 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: is_selinux_enabled() always returns 0 after
 selinux_set_policy_root()
Message-ID: <20170427165358.GA26305@julius>
References: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
 <1493238298.32540.13.camel@tycho.nsa.gov>
 <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
 <1493240908.1837173.957437120.416E6DD8@webmail.messagingengine.com>
 <1493298251.2524.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
In-Reply-To: <1493298251.2524.3.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 09:04:11AM -0400, Stephen Smalley wrote:
> On Wed, 2017-04-26 at 17:08 -0400, Colin Walters wrote:
> >=20
> > On Wed, Apr 26, 2017, at 04:43 PM, Colin Walters wrote:
> > > On Wed, Apr 26, 2017, at 04:24 PM, Stephen Smalley wrote:
> > > >=20
> > > > Your analysis and proposed fix sound correct to me.=A0=A0I blame Dan
> > > > ;)
> > >=20
> > > Thanks.=A0=A0I tested the patch and confirmed it fixed ostree as it
> > > stands today,
> > > but I'm going to change ostree to cache the result of
> > > `is_selinux_enabled()`
> > > itself to work around this, since for our use cases it should never
> > > really
> > > change dynamically.
> >=20
> > Although as I was working on the workaround, which I just put up as:
> > https://github.com/ostreedev/ostree/pull/815
> >=20
> > I was thinking about this a bit more and I realized (maybe) why
> > Dan added that call.=A0=A0
> >=20
> > Right now (ignoring #ifdef ANDROID):
> > int is_selinux_enabled()
> > {
> > return (selinux_mnt && has_selinux_config);
> > }
> >=20
> > And conceptually "has_selinux_config" derives from the policy root.
> > But in practice it doesn't today - that variable is also only
> > initialized
> > in the constructor.=A0=A0=A0Should it?=A0=A0I'm not sure.
> >=20
> > The way libostree uses the policy root is basically for the regexp
> > labeling
> > database.=A0=A0=A0We're using `is_selinux_enabled()` to determine wheth=
er
> > or not we should call `setfscreatecon()`.=A0
> >=20
> > Eh.=A0=A0My inclination is not think too much more about this.=A0=A0The=
 patch
> > is unlikely to break anything, it does fix a bug, and I'm not aware
> > of a
> > case where someone would be using e.g. a host system with SELinux
> > fully disabled to do anything related to ostree, so we don't
> > need to care about trying to disentangle those cases.=A0=A0Hopefully!
>=20
> 1. The has_selinux_config test was added long after the introduction of
>  selinux_set_policy_root(), and only to avoid a regression due to
> removal of the test to see if policy is loaded.  See commits
> c08c4eacab8d55598b9e5caaef8a871a7a476cab and
> 685f4aeeadc0b60f3770404d4f149610d656e3c8.
>=20
> 2. The test for has_selinux_config wouldn't actually be affected by
> selinux_set_policy_root() even if we were to re-evaluate it.=20
> selinux_set_policy_root() sets the prefix for the policy files (e.g.
> from /etc/selinux/targeted to /etc/selinux/mls), it does not affect the
> path for /etc/selinux/config.  We don't presently provide any way to
> redirect libselinux to a different config file.
>=20
> 3. Originally, is_selinux_enabled() returned 1 if selinuxfs was
> registered (in /proc/filesystems), even if not mounted. This was
> dropped by commit e3cab998b48ab293a9962faf9779d70ca339c65d, which
> changed the test to only return 1 if selinuxfs was mounted and only if
> it is mounted rw, so that a ro mount could be used in mock and other
> tools to make SELinux appear disabled.  Recent discussions on the list
> (subject: "let's revert e3cab998b48ab293a9962faf9779d70ca339c65d") have
>  proposed removing the ro check and only considering it disabled if
> selinuxfs is not mounted at all because systemd is remounting
> everything under /sys as ro for ProtectKernelTunables=3Dyes and this is
> leading services to conclude that SELinux is disabled and then failing
> to label files correctly.  However, my impression is that systemd will
> alter its behavior and I don't think we can in the near term change
> libselinux in this regard as it will break various chroot and container
> implementations.

I hope you're not being too optimistic. The way i see it is that reverting =
the patch will give these entities a reason to remove the mounting of selin=
uxfs in containers. If you keep it in for "compatibility" then i fear that =
it will never get fixed because there is not sense of urgency.

Also the discussion on github WRT to ProtectKernelTurnables is seemingly ov=
er but no action has been decided upon.
=20
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkCIiIACgkQJXSOVTf5
R2n7DAv7BtuPrYRPFUVFedqzEcpAiQBz6GJipXNESHmQPqCiK7ZgzPm4YtlAPoyJ
fd7FonV28lSIyBv1QKZhWnsfsQ7As5UMzNedeayafZrm06BxaLFnvaJ9d9mC87x7
vs46rIhafyvSVXgcYkF+f3TUoFipNeoURtUPQSeWZMAZwxWKIhJEh8KF7/TEwsLS
InJ5iR7Zc0FewEoW3+We+eZmymbWpnjSORL5BEsrsjlzX8eZFCx0H5ApytRBvLTU
6CvIb/YZQGDUSGv8LNx+7Y7w5nI3nVIZcbi+1cYaFlQCHHCzJo8I7+59viRx8AJs
Hlj/VAnkgifGqe9v6dcFuhuTSKbLeLnhpX1VunMXB42JVkxDpkA9UEwQzp2vTZur
0cxSNjDxPcSkn4rB0dofq+kgF+D1qlDtB8gLn5JxenRk1rWz2CjQT/dhJ7xWGW5Q
QGD3KAJbetl0VeG2f/cUnWaDVUDP+sax1VsUFpAZbwoXTlU7YSgVBQk6dmSolVKm
CkF/z9DQ
=mg1K
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
