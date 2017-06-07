Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v57IFEiM026026
 for <selinux@tycho.nsa.gov>; Wed, 7 Jun 2017 14:15:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id x3so3761585wme.0
 for <selinux@tycho.nsa.gov>; Wed, 07 Jun 2017 11:15:09 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id a18sm2328032edd.23.2017.06.07.11.15.06
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 07 Jun 2017 11:15:06 -0700 (PDT)
Date: Wed, 7 Jun 2017 20:15:05 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: icmp and rawip socket
Message-ID: <20170607181505.GB739@julius.enp8s0.d30>
References: <20170607173742.GA739@julius.enp8s0.d30>
 <1496859237.15470.12.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
In-Reply-To: <1496859237.15470.12.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 02:13:57PM -0400, Stephen Smalley wrote:
> On Wed, 2017-06-07 at 19:37 +0200, Dominick Grift wrote:
> > Was it intentional to add icmp_socket class? Because this use to be
> > rawip_socket. rawip_socket includes more than just icmp (IGMP/OSPF)
> > but still I thought that the extended socket classes only applied to
> > what is otherwise generic "socket"
>=20
> It was intentional, yes, and described in the patch description (for
> both the kernel and refpolicy) and in the inline documentation for the
> policy capability in refpolicy.  I chose to address all known gaps in
> our ability to distinguish among sockets at once.
>=20
> Note btw that icmp_socket is only used for the unprivileged ICMP
> sockets (aka "ping sockets") created via socket(PF_INET, SOCK_DGRAM,
> IPPROTO_ICMP) or socket(PF_INET6, SOCK_DGRAM, IPPROTO_ICMP6).=20
> rawip_socket is still used for SOCK_RAW ICMP sockets.

Thanks for the answer, I suppose I was unable to connect the dots.

> =20
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlk4QqUACgkQJXSOVTf5
R2kbagv/UhKbum+EV9f0YoMiHd8H/p0fBuhi2SspTwXCbZosXKjh5HbnNU/nTmSO
e/tSzHYTXTcY6jb/yq3NUM7OPe5Qxbcfgh5qznJt/Q32ppO3xAnrQDuctxhAkBse
4XgtxerJk8DpaXnQpsXsOrsC6Jzbne1/aCcX8G22nT+BBPZi3N3QLtw3YZP15sqC
n09qpnkuHAcAow8ztlJx/7nX5xH35buOGZIdzSjeJviKDGvnJRj8zYaG8uQYLLEA
GQgA9HW/0O3jjy/JWjAdYeosD1OGgIIu+Qts2aLcPnq+hJb+JCefBfzpuwSfrZHW
v4m4B8FbLrzrTL9sIK+1MB3/tELGRDuTxwRAslMg3UJGjinXs0dUtqah0ZWkVOUM
a9ufwf/IUODsg0o5qVzsEs8+4QPu8ywRTExuJLAJ8I7PM1SSmcWP9+ptf4xYlkjS
mPH2KQYpEeF7L7QsaXeQ8yIUm4aDPfzzAnHmDf9kyM+u2H6zzj/7mCYKS0vgb++g
g5bW2HiB
=r/ni
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
