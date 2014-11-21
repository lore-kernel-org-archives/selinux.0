Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sALBVUVs025728
 for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2014 06:31:30 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so11687373wid.15
 for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2014 03:31:27 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id fk16sm8362364wic.16.2014.11.21.03.31.24
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 21 Nov 2014 03:31:24 -0800 (PST)
Date: Fri, 21 Nov 2014 12:31:21 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC] systemd the userspace object manager
Message-ID: <20141121113120.GA25417@e145.network2>
References: <546B760D.8070407@tresys.com>
 <20141118192010.GA32498@e145.network2>
 <546DF23A.2000300@tresys.com> <546E52A3.8050802@quarksecurity.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
In-Reply-To: <546E52A3.8050802@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 03:44:19PM -0500, Joshua Brindle wrote:
>=20
> I can see why you'd want someone to be able to restart apache but not
> everything. Certainly having specific permissions is not the way to
> accomplish that.
>=20
> The rule above is kind of strange, permissions should not be equivalence
> classes, types should be, so it should be more like:
>=20
> allow <domain requesting restart> <derived service label> : init {start
> stop}
>=20
> right?

If only it were that simple. Here is my take on the whole thing:

Generally services are managed by "service" access checks on unit file types

allow webadmin webserverunitfile:service {start stop};

However these is also a concept of transient (in-memory) unit files, managi=
ng a service through a transient unit would work like:

allow user self:service {start stop};

or in the case of transient systemd units:

allow user systemd:service {stop start};

Then there is the system(d) class which also has the start, stop permission=
s associated with it (it is yet to be determined for what exactly)

In my policy systemd-logind does the following:

allow logind_t systemd:system(d) { start stop };

I suspect that this is required to spawn the systemd session daemon (at lea=
st)
It may or may not also be required for kexec (not sure as i havent tested t=
hat yet)

This is pretty much just all speculation though, in the sense that this is =
broadly what i see happening in the system, and it might not be the same as=
 what *should* be happening
Instead its probably better to just read the systemd object manager code

--=20
Dominick Grift

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUbyKCAAoJENAR6kfG5xmcpVwL/RRs3uvXYUO+cWdZ2OarN7u5
+8MFkGEtHKR8WP5LLQc8VZ0OPp9WaVphzIloHXY9cHkI+NxSMxRFf1y3z+B3SrqR
tSjllZv2y3LBrFkE9f8UcVZxxa1szKKv6rLI+sRh3QvSGPP+Mns3mU9u7pFbYNUQ
L59A1oE6sDCdxuro98G/4T9eNTuox43XBHxwx9uqSkwRXCWaeIGOeo/DyoK/ruHS
x8GJ5CNb8mYzddUWj8UOAOYF1HHtb1a8Eez+UxbjXQh0T6bfir6+N9zpKV/Wp9Vc
0k3liPizNMV2S10XKjDop81ruebtN16fS50AGbI5HKevvi2z82VnfeHJwdJXqPHH
twelD7gV3V1OYS7Ndz8LPeIm/7svKJ1CP6vUcDO8+lxjsLvuwncHpdXzzDRg3HOd
RD8Z2XRqCNwZryT6htzhSAaMQrrP29vaSBhrcwFtnvO2dz8UH/+AiCN2d6BkkIIF
CwUF4LinDTaS0LffSZJXnbAQZ+nQcPbJKWK7GnubAw==
=Wep7
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
