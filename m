Subject: Re: [PATCH] cron changes needed for MLS range checking (requires
	at least the libselinux patches)
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
References: <1162936978.26574.20.camel@code.and.org>
	 <1162994668.3009.82.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dHsQQjfEnVfPgNUL7f1d"
Date: Wed, 08 Nov 2006 15:32:39 -0500
Message-Id: <1163017959.29854.12.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-dHsQQjfEnVfPgNUL7f1d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 at 09:04 -0500, Stephen Smalley wrote:
> On Tue, 2006-11-07 at 17:02 -0500, James Antill wrote:
> >  I think this is what we want for the cron patch. It's basically doing
> > the same checks as the PAM patches. It also limits what the user can
> > change to just the MLS range.
> >  At the moment I've just copied the original functions that need to be
> > replaced, so you can see the old vs. the new. As the final commit the
> > old ones should probably just die.
> >  I've also kept the name SELINUX_ROLE_TYPE, I'm not sure if it should b=
e
> > changed to SELINUX_ROLE_RANGE or something else?
>=20
> As I understood it, you were only going to allow level specification,
> not user/role/domain, so it would just be SELINUX_LEVEL or MLS_LEVEL or
> similar.

 Right, that's what I meant by "if it should be changed...". After
speaking with Dan today, I've changed it to MLS_LEVEL.

> As in the pam case, you should be checking between a context for the
> user with the seusers-specified range and a context for the user with
> the user-specified level.  Your patch doesn't seem to match that
> description - it refers to a file context as the target.

 One context comes from the cron file, and one from that plus the level
change as requested by the user. See cron_get_job_range().
 Changing that to be the result of getseuserbyname(), matching PAM,
instead of the file context would be possible ... although I'm not sure
if using "root" when u->name is "*system*" is the right thing to do.

> Also, the function that performs the setexeccon (which you call
> cron_change_selinux_range) is more general - it is supposed to set the
> entire user context appropriately for the user on whose behalf cron is
> running a job. =20

 Right. Are you saying I need to call, cron_authorize_context() as well
as cron_authorize_range()?
 I decided this wasn't required because that function is called from
within get_security_context(), and instead of being able to change
everything now ... they can only change the level. So we don't need to
re-auth the entire security context, just the level.
 I'm certainly open to just checking it anyway, if you see any holes in
my reasoning or if everyone would just prefer to check it twice.

 If that isn't what you meant, could you explain further what the
problem is?

--=20
James Antill <jantill@redhat.com>

--=-dHsQQjfEnVfPgNUL7f1d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUj7m11eXTEMrxtQRApGlAKC19lTOuCSaR6bWP/KzIZLXiGO5EgCgrg45
PPTr2uhcbQsGYyW7KbpBtuo=
=OH5s
-----END PGP SIGNATURE-----

--=-dHsQQjfEnVfPgNUL7f1d--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
