Subject: Re: [PATCH v2] libselinux: flush the class/perm string mapping cache
 on policy reload
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1442938808-31924-1-git-send-email-sds@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <560BE13D.6070302@redhat.com>
Date: Wed, 30 Sep 2015 15:18:53 +0200
MIME-Version: 1.0
In-Reply-To: <1442938808-31924-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BlMEnRXQNSqrG5U1aEJHKCHWqX5gDjgiE"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BlMEnRXQNSqrG5U1aEJHKCHWqX5gDjgiE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/22/2015 06:20 PM, Stephen Smalley wrote:
> This improves the robustness of programs using selinux_check_access()
> in the face of policy updates that alter the values of the class or
> permissions that they are checking.  Otherwise, a policy update can
> trigger false permission denials, as in
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1264051

Thank you, Stephen.

I've applied it to Fedora 23 and Rawhide and prepared scratch builds [1]
and according to my testing it fixes the problem. So after a little more
testing I'll push it to Fedoras.

[1]
http://koji.fedoraproject.org/koji/taskinfo?taskID=3D11276795
http://koji.fedoraproject.org/koji/taskinfo?taskID=3D11275234

Petr

> Changes to the userspace class/permission definitions should still be
> handled with care, as not all userspace object managers have been conve=
rted
> to use selinux_check_access() and even those that do use it are still n=
ot
> entirely safe against an interleaving of a policy reload and a call to
> selinux_check_access().  The change does however address the issue in
> the above bug and avoids the need to restart systemd.
>=20
> This change restores the flush_class_cache() function that was removed =
in
> commit 435fae64a931 ("libselinux: Remove unused flush_class_cache metho=
d")
> because it had no users at the time, but makes it hidden to avoid expos=
ing
> it as part of the libselinux ABI.
>=20
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 fixes various whitespace and style issues.
>=20
>  libselinux/src/checkAccess.c      | 27 ++++++++++++++++++++++-----
>  libselinux/src/selinux_internal.h |  2 ++
>  libselinux/src/stringrep.c        | 22 ++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 5 deletions(-)
>=20
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.=
c
> index 29be16e..8de5747 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -10,11 +10,26 @@
>  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
>  static int selinux_enabled;
> =20
> +static int avc_reset_callback(uint32_t event __attribute__((unused)),
> +		      security_id_t ssid __attribute__((unused)),
> +		      security_id_t tsid __attribute__((unused)),
> +		      security_class_t tclass __attribute__((unused)),
> +		      access_vector_t perms __attribute__((unused)),
> +		      access_vector_t *out_retained __attribute__((unused)))
> +{
> +	flush_class_cache();
> +	return 0;
> +}
> +
>  static void avc_init_once(void)
>  {
>  	selinux_enabled =3D is_selinux_enabled();
> -	if (selinux_enabled =3D=3D 1)
> -		avc_open(NULL, 0);
> +	if (selinux_enabled =3D=3D 1) {
> +		if (avc_open(NULL, 0))
> +			return;
> +		avc_add_callback(avc_reset_callback, AVC_CALLBACK_RESET,
> +				 0, 0, 0, 0);
> +	}
>  }
> =20
>  int selinux_check_access(const char *scon, const char *tcon, const cha=
r *class, const char *perm, void *aux) {
> @@ -33,9 +48,11 @@ int selinux_check_access(const char *scon, const cha=
r *tcon, const char *class,
>  	if (rc < 0)
>  		return rc;
> =20
> -       rc =3D avc_context_to_sid(tcon, &tcon_id);
> -       if (rc < 0)
> -	       return rc;
> +	rc =3D avc_context_to_sid(tcon, &tcon_id);
> +	if (rc < 0)
> +		return rc;
> +
> +	(void) avc_netlink_check_nb();
> =20
>         sclass =3D string_to_security_class(class);
>         if (sclass =3D=3D 0) {
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> index 844e408..46566f6 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -102,6 +102,8 @@ hidden_proto(security_get_initial_context);
>  hidden_proto(security_get_initial_context_raw);
>  hidden_proto(selinux_reset_config);
> =20
> +hidden void flush_class_cache(void);
> +
>  extern int load_setlocaldefs hidden;
>  extern int require_seusers hidden;
>  extern int selinux_page_size hidden;
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index 9ae8248..2dbec2b 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -158,6 +158,28 @@ err1:
>  	return NULL;
>  }
> =20
> +hidden void flush_class_cache(void)
> +{
> +	struct discover_class_node *cur =3D discover_class_cache, *prev =3D N=
ULL;
> +	size_t i;
> +
> +	while (cur !=3D NULL) {
> +		free(cur->name);
> +
> +		for (i =3D 0; i < MAXVECTORS; i++)
> +			free(cur->perms[i]);
> +
> +		free(cur->perms);
> +
> +		prev =3D cur;
> +		cur =3D cur->next;
> +
> +		free(prev);
> +	}
> +
> +	discover_class_cache =3D NULL;
> +}
> +
>  security_class_t string_to_security_class(const char *s)
>  {
>  	struct discover_class_node *node;
>=20





--BlMEnRXQNSqrG5U1aEJHKCHWqX5gDjgiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWC+E9AAoJEGOorUuYLENzhssQAKgA1D/V2DiwekHt48AKLGCl
0zILt1qKf6ctsKW/4+fvMQxHcIqFiskaCTsPSQxEVoVOqdO8CM2Ah+YzSfVnHjs8
vVQKqFSgjUGP7GemEA9C2G9qceUgyBOp1VIVWWlXzhbX7te+IwdvTUJRS4v4/OVO
7dDKuuERSWozZIZxhB+ReCy5Hu2AIwZt7KT82TmNRpLqhtePOTrUwxvVZLtNoX2N
LoROc6HJMxRGyqgxwSc4VDO9t/MhLobKKNMqZ0B9J9DVQTTLCRjaY6/BqkHWgleL
wF5bs2s2M4hcpy+Fb6zTfpntp4k+wu+b3Sq/vz9n3TCSgzI3OdMtFMDKmOT9z7ul
kkoB+lBQd9qMKhHp5fK5sWXBRr70RfbVTisDPZ8h43o9sa4ACjMFmhUya9VtRoJM
XPSVpOl3/knOXQvQ5LUryyxMkPlWOJXOF/VywgzwU33h7xALgJFlpmDZaAZCVflc
1/A4YhOKex5WVVksbvv2oPn7Z16CLx/giHelN+RCDGxTeL5VbWQfo4kBzaJlUF5r
4fuZrSY+lxkI1kbqoNlJX3XAdTv3BdZjiM8G8k+HZdI3Y4SFjCAxRHbI3pL/rs1x
VcVcN5kPvRddDnALmHii5CHHZHCd1Mvlc2gozghY+zmND/Pjg6XSG1A3Jl0UGMWM
lsxCYEy/YitVt39KBwxt
=sUCF
-----END PGP SIGNATURE-----

--BlMEnRXQNSqrG5U1aEJHKCHWqX5gDjgiE--
