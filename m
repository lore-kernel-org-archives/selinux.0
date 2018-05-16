Date: Wed, 16 May 2018 09:31:02 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20180516073101.GC17168@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <152641822270.15123.8804483748550258349.stgit@chester>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
In-Reply-To: <152641822270.15123.8804483748550258349.stgit@chester>
Subject: Re: [RFC PATCH] selinux-testsuite: check the "expand-check"
 setting in semanage.conf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 05:03:42PM -0400, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
>=20
> If expand-check is non-zero in semanage.conf the policy load will likely =
fail,
> try to provide a more helpful error to users running the tests.
>=20
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  policy/Makefile |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/policy/Makefile b/policy/Makefile
> index 8ed5e46..cc022e3 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -87,6 +87,14 @@ build: $(BUILD_TARGET)
>  load: $(LOAD_TARGET)
>  unload: $(UNLOAD_TARGET)
> =20
> +expand_check:
> +	# Test for "expand-check =3D 0" in /etc/selinux/semanage.conf
> +	@cat /etc/selinux/semanage.conf | \
> +		sed -n 's/^[ \t]*expand-check[ \t]*=3D[ \t]*0/OK/p' | \
> +		grep -q "OK" || \
> +		(echo "ERROR: set 'expand-check =3D 0' in semanage.conf"; \
> +		 /bin/false)
> +

You can use grep directly:

+ grep -q '^[ \t]*expand-check[ \t]*=3D[ \t]*0' /etc/selinux/semanage.conf =
|| \
+      (echo "ERROR: set 'expand-check =3D 0' in semanage.conf";
+      /bin/false)


>  build_rhel: $(TARGETS)
>  	# RHEL specific policy build
>  	$(MAKE) -C redhat/$(RHEL_VERS) all
> @@ -103,11 +111,11 @@ build_general: $(TARGETS)
>  		echo "ERROR: You must have selinux-policy-devel installed."; \
>  	fi
> =20
> -load_rhel: all
> +load_rhel: expand_check all
>  	# RHEL specific policy load
>  	$(MAKE) -C redhat/$(RHEL_VERS) load
> =20
> -load_general: all
> +load_general: expand_check all
>  	# General policy load
>  	@-/usr/sbin/setsebool allow_domain_fd_use=3D0
>  	$(SEMODULE) -i test_policy/test_policy.pp
>=20
>=20

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAlr73i4ACgkQviIJHj72
InXbPw//Wt0F8AmaTPQgx7H5VusRFOZkGINi9c0Fo4XU/Snc+n47dwCfqBM+jKqs
LP1a8i3ZSPLrep7vprdb6SWV28N2q3nLTnzgrwlJSB7ryTh807ANU2uZkdwpoY0k
Xz0Riuiq4NOpBPpMZ1h232+LH2dPNhjebq+7fQUj/6do6YZb3HG8FPEzD/K+NlSe
N5LweKNHBjUjgllyI7L52Ectqn9hyEEv6ZdI3nXn0jZN6sljrJ/OF9fn5/9MyrF3
L/auIxlnYgW+eqnFn91Dkmvxui7cXcdX55zayiyJ6/dNDLXz7H7fhk3H/GBtvltS
qB7Mg6h47E7DDFvoPhYEZldwQIJ6OBh68Gz1qx693ZB52YJfAbHCG/t2opW7ynSn
j4OZ0LNoqTB4aoCLmy82IVKqHOoGTfhmWjYUebNr6Z/QPVQpt6tJUhHHNgAsxddH
N8XbY3Wl8G/sDPLYKqx5MfZjsLIXVqTJ6leI4TRVDEBieYC9Qa9LtIoo/CtyaScG
3MQZcG4XfNqCH/dKFvmT68KBoDgioQAPHp3q+0afIwIafT19ONv2PnVL3X5lFhfM
to/+sKGkPUZi2uq7ngFvccIg6ydDgtOCX5gw59FzHE0A/jSU3/+Gd9WLeVKudCTv
hsSAZSjSH88mfFjp4hTpJg3xLsvnGwrX9GbBVVMO7dG80dlNLA8=
=Ek9p
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
