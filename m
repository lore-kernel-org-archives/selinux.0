Message-ID: <5550B134.6050606@redhat.com>
Date: Mon, 11 May 2015 15:40:04 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R44vbILPL1LG1AsOlSvfEVfBpHvhGQega"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R44vbILPL1LG1AsOlSvfEVfBpHvhGQega
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 04/17/2015 03:42 PM, Stephen Smalley wrote:
> SELinux can be disabled via the selinux=3D0 kernel parameter or via
> /sys/fs/selinux/disable (triggered by setting SELINUX=3Ddisabled in
> /etc/selinux/config).  In either case, selinuxfs will be unmounted
> and unregistered and therefore it is sufficient to check for the
> selinuxfs mount.  We do not need to check for no-policy-loaded and
> treat that as SELinux-disabled anymore; that is a relic of Fedora Core =
2
> days.  Drop the no-policy-loaded test, which was a bit of a hack anyway=

> (checking whether getcon_raw() returned "kernel" as that can only happe=
n
> if no policy is yet loaded and therefore security_sid_to_context() only=

> has the initial SID name available to return as the context).
>=20
> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=3D1195074
> by virtue of removing the call to getcon_raw() and therefore avoiding
> use of tls on is_selinux_enabled() calls.  Regardless, it will make
> is_selinux_enabled() faster and simpler.
>=20

This patch breaks system with SELinux enabled kernel and without
loaded/installed an SELinux policy, see [1].

Would it be feasible to have is_selinux_enabled() connected to existence
of SELINUX variable in /etc/selinux/config file for the cases when
there's no specific kernel command line option used in running system?
Or would it break something else?

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1219045

Thanks,

Petr
--=20
Petr Lautrbach



--R44vbILPL1LG1AsOlSvfEVfBpHvhGQega
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVULE0AAoJEGOorUuYLENzW0cP/1kM/COGDuFBzzn+X5hZYm0I
iiEItm9crOH0V4WLQ6eJ4HIJkNef+3rZzZ4ieqP5sHlI6SRlxZYj2X7lMGyDBrWw
OdubY/mm007Xx670iplXtq2zwCfiCyCKiDqAPTOr9FGw5vuRrigeWS+A8q7Juy48
ijWHjKGb76u2gWDhIVe+xgQNnUcY8BtxI0up+D1G6/eLWzXk2GU5J8v2Y8HUlbUD
vn+qu/I7+Tj1KmyRNxHkuTdR3QvuHND17hwiPUWi+GtItlOButK7jDhK8AJ3avMd
XbCb4NoLRxu5c95oNPXQNot3PDXZUuaxaQAVxjTo476uOgRO60r5hKqAqD7DqJkv
C2qI69SUDToLpxFNKKGqh9xUZRqVjusDLzA95MpeKFCfZGw0LHepRp0XFx6eAqvv
8izOYAHDcK9XGs3rfsk+CzCnwmOLZzkLaT9+C5Ob84pRLjMLFcAKYMr33yWPPNm+
zypwOkWaabVzVATAo1SozvkD/pGgqFFKl7h2T572CzbHWLcVLwMKmWkuR0Z8vWxj
phZINJd21MgttFeAwg7NgaEgh1knKtUlibNLo3Q3S2ELU9ltIF29sSDK+ZqHM0Qf
MJ1b4/p8LhGe7P0ijoGDy7X9sSlUBMsCRyjR6EpIwAvaZcZ3F2ZH1JjmwHPW8/sQ
e94SACGII1uDD+wr3/a+
=s2mW
-----END PGP SIGNATURE-----

--R44vbILPL1LG1AsOlSvfEVfBpHvhGQega--
