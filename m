Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3SDxWRb006645
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 09:59:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3SDvJa1000198
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 13:57:20 GMT
Subject: Re: preserving user-set contexts
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1083152961.25987.20.camel@moss-spartans.epoch.ncsc.mil>
References: <1082752649.12608.111.camel@nexus.verbum.private>
	 <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil>
	 <1083116682.3390.34.camel@nexus.verbum.private>
	 <1083152961.25987.20.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EjCeEaG40qNC9n8k71wn"
Message-Id: <1083157990.8370.19.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Wed, 28 Apr 2004 09:13:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EjCeEaG40qNC9n8k71wn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-28 at 07:49, Stephen Smalley wrote:
> On Tue, 2004-04-27 at 21:44, Colin Walters wrote:
> > Well, users should still be stopped by DAC in setting xattrs on files
> > they didn't own, which covers all the practical cases I can think of
> > right now.
>=20
> DAC isn't applied to the security namespace.  SELinux controls access to
> its attributes (including an identity-based restriction on
> relabelfrom/relabelto via policy/constraints).  Other attributes in the
> security namespace are presently limited to CAP_SYS_ADMIN.
>=20
> And relying on DAC to prevent the ability to _block_ a MAC policy from
> being applied is not a good idea anyway.

I agree.

> That's debatable.  Many MAC policies aren't going to allow ordinary
> users to relabel _anything_. =20

Well, presently the sample policy does.  I recently added another
user-customizable type to the Red Hat policy, e.g.
staff_mount_source_t.  I think that other types like this will be
created in the future as well.

> And allowing users to export arbitrary
> data to the web server is not a good idea, if you want to enforce any
> kind of confidentiality policy.

True.  But it seems to me that without something like MLS, it is
currently difficult to enforce a reasonable and strong confidentiality
policy using SELinux anyways.

> setfiles already skips files that have no matching specification.  But
> at present, every file matches at least the /.* regex at the beginning
> of types.fc.  So you can achieve the above by simply removing that
> pattern (but I wouldn't recommend this).  Note that even if you do this,
> you'll still want some context applied for the initial install.  So
> you'll need two variants of the file_contexts configuration; one for
> installation and one for runtime relabels (which isn't necessarily a bad
> idea anyway).

Yes, the two variants idea sounds reasonable to me for the /build
problem.

> >   For the
> > httpd_user_content_t problem, we could add an attribute e.g.
> > "customizable_type".  setfiles would by default not relabel that have
> > this type.
>=20
> And how do you control the ability to set this attribute?

Ah, sorry; I meant a SELinux policy attribute, not an xattr.  So
checkpolicy could gather these and perhaps write out a separate
"customizable_types" file.  setfiles would parse this and by default not
relabel files with one of these types.


--=-EjCeEaG40qNC9n8k71wn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAj63mOIkJWWp2WGURAoZxAJ9n+UVLjsdmBPcezLTaBLnrkOHStwCfUJGx
R7RdDge8dlH+zREeiKaVHww=
=yW5e
-----END PGP SIGNATURE-----

--=-EjCeEaG40qNC9n8k71wn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
