Subject: Re: [patch] allow users of tmp_domain to read /usr/tmp
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1105566103.23136.32.camel@moss-spartans.epoch.ncsc.mil>
References: <1105565245.4415.29.camel@nexus.verbum.private>
	 <1105566103.23136.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/6xDMP6UaCmnrhXTsD0w"
Date: Wed, 12 Jan 2005 17:27:00 -0500
Message-Id: <1105568820.4415.44.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/6xDMP6UaCmnrhXTsD0w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-12 at 16:41 -0500, Stephen Smalley wrote:
> On Wed, 2005-01-12 at 16:27, Colin Walters wrote:
> > Hi,
> >=20
> > On Fedora at least, /usr/tmp is a symlink to /var/tmp.  Users of
> > tmp_domain get write access to tmp_t:dir, so I think it makes sense to
> > automatically grant access to tmp_t:lnk_file as well, so that programs
> > which refer to /usr/tmp work.  This should be safe since as discussed
> > earlier no non-unconfined domain can create tmp_t:lnk_file.
> >=20
> > This came up on the #fedora-selinux channel where a user was trying to
> > get their CGI script to work.
>=20
> Hmm...I had thought that we had agreed that /usr/tmp should be dropped
> from types.fc and left in usr_t, then just allow read to usr_t:lnk_file
> as a safer approach.  In fact, the current types.fc file only assigns
> tmp_t if /usr/tmp is a directory (via the -d flag), and it is labeled
> usr_t on my FC3 systems (strict).

Ok, sounds reasonable.  So I just needed to relabel then with the latest
policy.  Another reason we need automatic relabeling :)


--=-/6xDMP6UaCmnrhXTsD0w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB5aQ0OIkJWWp2WGURAmS2AJ0YGuy8qMZPRuJ4OWo8Z6DJvU6wCQCdFOF3
427M/B9Op6AdUWcfbvO5kZ0=
=tYNR
-----END PGP SIGNATURE-----

--=-/6xDMP6UaCmnrhXTsD0w--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
