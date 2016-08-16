Date: Tue, 16 Aug 2016 16:59:10 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] genhomedircon: add support for %group syntax
Message-ID: <20160816155910.GA12097@workstation.home>
References: <1469654706-26930-1-git-send-email-gary.tierney@gmx.com>
 <2a66b4e4-6064-1248-bdfc-8b41b822c749@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <2a66b4e4-6064-1248-bdfc-8b41b822c749@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Replied inline below.

On Mon, Aug 15, 2016 at 03:58:44PM -0400, Stephen Smalley wrote:
> On 07/27/2016 05:25 PM, Gary Tierney wrote:
> > semanage-login supports login mappings using the %group syntax, but
> > genhomedircon does not expand groups to the users belonging to them.
> >=20
> > This commit adds support for generating home directory contexts for log=
in
> > mappings using the group syntax and adds error reporting for handling c=
ases
> > where there is ambiguity due to a user belonging to multiple groups map=
ped by
> > semanage-login. If a login mapping is added for the user which belongs =
to
> > multiple groups it will take precedence and resolve the ambiguity issue.
>=20
> Sorry for the long delay in responding.  One question/comment below.
>=20
> > Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> > ---
> >  libsemanage/src/genhomedircon.c | 319 +++++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 247 insertions(+), 72 deletions(-)
> >=20
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index c5ea436..2955b19 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -838,94 +1064,43 @@ static genhomedircon_user_entry_t *get_users(gen=
homedircon_settings_t * s,
> >  		nusers =3D 0;
> >  	}
> > =20
> > +	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *),
> > +	      &seuser_sort_func);
> >  	qsort(user_list, nusers, sizeof(semanage_user_t *),
> >  	      (int (*)(const void *, const void *))&user_sort_func);
> > =20
> > -	/* Allocate space for the getpwnam_r buffer */
> > -	rbuflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
> > -	if (rbuflen <=3D 0)
> > -		goto cleanup;
> > -	rbuf =3D malloc(rbuflen);
> > -	if (rbuf =3D=3D NULL)
> > -		goto cleanup;
> > -
> >  	for (i =3D 0; i < nseusers; i++) {
> >  		seuname =3D semanage_seuser_get_sename(seuser_list[i]);
> >  		name =3D semanage_seuser_get_name(seuser_list[i]);
> > =20
> > -		if (strcmp(name,"root") && strcmp(seuname, s->fallback->sename) =3D=
=3D 0)
> > -			continue;
> > -
>=20
> This appears to change the behavior of genhomedircon in general, not
> just with respect to %group handling.  Was this intentional?
> I'm not necessarily opposed to this change, but I am unclear on the
> implications.  It seems that previously genhomedircon would not generate
> file_contexts.homedirs entries for users who were mapped to the fallback
> seuser, with an exception for root for /root labeling.  With this
> change, they will have entries added.
>

Hmm, yes, you're right. This is a mistake. We do need to skip this
conditional however, so we can check if a user already has a mapping=20
when we're expanding the members of a group.

To prevent this from happening it should suffice to check if the user that
we're writing contexts for shares an sename with the __default__ mapping,=
=20
and if so, simply skip writing contexts for that user.  We can do this check
inside write_gen_home_dir_contexts() like so:

https://github.com/garyttierney/selinux/commit/ebdb7f225ddbd5f311b2db75f68e=
2896285a5090#diff-b298746a257be78548f69d5d296dcd09R1140

An alternative fix would be to prevent these users from being added to
the `genhomedircon_user_entry_t` stack in the first place, and have=20
get_group_users() search the seusers list for a login mapping which matches
the group members username, skipping the group member if a match is found.

Any thoughts on either of these solutions?

> >  		if (strcmp(name, DEFAULT_LOGIN) =3D=3D 0)
> >  			continue;
> > =20
> >  		if (strcmp(name, TEMPLATE_SEUSER) =3D=3D 0)
> >  			continue;
> > =20
> > -		/* %groupname syntax */
> > -		if (name[0] =3D=3D '%')
> > -			continue;
> > -
> >  		/* find the user structure given the name */
> > -		u =3D bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
> > +		u =3D bsearch(seuname, user_list, nusers,
> > +			    sizeof(semanage_user_t *),
> >  			    (int (*)(const void *, const void *))
> >  			    &name_user_cmp);
> > -		if (u) {
> > -			prefix =3D semanage_user_get_prefix(*u);
> > -			level =3D semanage_user_get_mlslevel(*u);
> > -			if (!level)
> > -				level =3D FALLBACK_LEVEL;
> > -		} else {
> > -			prefix =3D name;
> > -			level =3D FALLBACK_LEVEL;
> > -		}
> > -
> > -		retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
> > -		if (retval !=3D 0 || pwent =3D=3D NULL) {
> > -			if (retval !=3D 0 && retval !=3D ENOENT) {
> > -				*errors =3D STATUS_ERR;
> > -				goto cleanup;
> > -			}
> > -
> > -			WARN(s->h_semanage,
> > -			     "user %s not in password file", name);
> > -			continue;
> > -		}
> > =20
> > -		int len =3D strlen(pwent->pw_dir) -1;
> > -		for(; len > 0 && pwent->pw_dir[len] =3D=3D '/'; len--) {
> > -			pwent->pw_dir[len] =3D '\0';
> > +		/* %groupname syntax */
> > +		if (name[0] =3D=3D '%') {
> > +			retval =3D get_group_users(s, &head, *u, seuname,
> > +						name);
> > +		} else {
> > +			retval =3D add_user(s, &head, *u, name,
> > +					  seuname, name);
> >  		}
> > =20
> > -		if (strcmp(pwent->pw_dir, "/") =3D=3D 0) {
> > -			/* don't relabel / genhomdircon checked to see if root
> > -			 * was the user and if so, set his home directory to
> > -			 * /root */
> > -			continue;
> > -		}
> > -		if (ignore(pwent->pw_dir))
> > -			continue;
> > -
> > -		len =3D snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
> > -		if (len < 0 || len >=3D (int)sizeof(uid)) {
> > +		if (retval !=3D 0) {
> >  			*errors =3D STATUS_ERR;
> >  			goto cleanup;
> >  		}
> > -		len =3D snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
> > -		if (len < 0 || len >=3D (int)sizeof(gid)) {
> > -			*errors =3D STATUS_ERR;
> > -			goto cleanup;
> > -		}
> > -
> > -		if (push_user_entry(&head, name, uid, gid, seuname,
> > -				    prefix, pwent->pw_dir, level) !=3D STATUS_SUCCESS) {
> > -			*errors =3D STATUS_ERR;
> > -			break;
> > -		}
> >  	}
> > =20
> >        cleanup:
> > -	free(rbuf);
> >  	if (*errors) {
> >  		for (; head; pop_user_entry(&head)) {
> >  			/* the pop function takes care of all the cleanup
> >=20
>=20

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXszhIAAoJEHBu12WFqnnYUmIIAIpOJlb6DSkU1o9q9tYybe7h
CpfcN5QLP9gNXWla647qoAhFOjC4q2OAZ2ymSiYaGz81LG+I/k7MEc/b6DEFJWxF
lRHP6Jmf+o92WzhKXjepn1gd1FaCg94H2yjIOxRJzLdfgpxEgm4DpHfINODj+Tqe
iGdmM0L8jglViZsa9V+ySWLN6GJ3uiP/NUW7anoijASqNh8g6BaLKD90TTVrEkOw
6t+hYFR/ulIaG+gSQdMkvJMPJxQbCqh8KK0FARuJunSCH6HmawtbyYHtAb6ZBjzq
tH2LuOTyKhkPXkCKJbhPK0uyug3ypCByvWfNk4KISfTAmkzdmC/dlBBJda6BQhs=
=gaPF
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
