Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion
	functions
From: James Antill <james.antill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
In-Reply-To: <1204294426.31790.256.camel@moss-spartans.epoch.ncsc.mil>
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net>
	 <1204293273.31790.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1204294426.31790.256.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XDdncawh0yAye7DhVV6f"
Date: Fri, 29 Feb 2008 11:40:55 -0500
Message-Id: <1204303255.11268.326.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XDdncawh0yAye7DhVV6f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2008-02-29 at 09:13 -0500, Stephen Smalley wrote:
> On Fri, 2008-02-29 at 08:54 -0500, Stephen Smalley wrote:
> > The snippet below looks like a step backward rather than an improvement
> > - single sprintf replaced by series of strcat calls.  That can't be mor=
e
> > efficient.
>=20
> Hmm...well, maybe I'm wrong (after looking at the implementations).
> Pity that Linux doesn't have stpcpy (as in glibc) - that is much nicer
> than a series of strcat's since it returns the end pointer and doesn't
> require finding the end of string each time.

 Note that you can do (only slightly abusing the interface):

	ctx =3D *scontext;

	ctx +=3D strlcpy(ctx, policydb.p_user_val_to_name[context->user - 1], -1);
	ctx +=3D strlcpy(ctx, ":", -1);
	ctx +=3D strlcpy(ctx, policydb.p_role_val_to_name[context->role - 1], -1);
	ctx +=3D strlcpy(ctx, ":", -1);
	ctx +=3D strlcpy(ctx, policydb.p_type_val_to_name[context->type - 1], -1);

...which is basically a memcpy() with a simple if test.

> > > -	*scontextp =3D 0;
> > > +	ctx =3D *scontext;
> > > +	strcpy(ctx, policydb.p_user_val_to_name[context->user - 1]);
> > > +	strcat(ctx, ":");
> > > +	strcat(ctx, policydb.p_role_val_to_name[context->role - 1]);
> > > +	strcat(ctx, ":");
> > > +	strcat(ctx, policydb.p_type_val_to_name[context->type - 1]);
> >=20
--=20
James Antill <james.antill@redhat.com>
Red Hat

--=-XDdncawh0yAye7DhVV6f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHyDWX11eXTEMrxtQRAmQTAJ9VjwOvAv/weXcrcFnVt7mO8kNoDACgqw2p
v94fNhKBmJlXhb2d79QO2hE=
=ymQP
-----END PGP SIGNATURE-----

--=-XDdncawh0yAye7DhVV6f--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
