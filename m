From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
	 <1161803724.29689.57.camel@code.and.org>
	 <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
	 <1161970810.29689.88.camel@code.and.org>
	 <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
	 <1162238632.31104.11.camel@code.and.org>
	 <1162239394.31104.13.camel@code.and.org>
	 <1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PkRA2KkhpVTtu4QXDFFb"
Date: Tue, 31 Oct 2006 10:00:39 -0500
Message-Id: <1162306839.31104.23.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-PkRA2KkhpVTtu4QXDFFb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-31 at 09:24 -0500, Stephen Smalley wrote:
> On Tue, 2006-10-31 at 09:23 -0500, Stephen Smalley wrote:
> >=20
> > In addition to the permission name, I'd have expected the rule (and the
> > check in the code) to always use the same type in both contexts, so the
> > rules could just be:
> > 	allow $1 self:context <permissionname>;
> >=20
> > Not allow $1 domain:context, which will yield many more rules without
> > any real justification.

 Ok, I can fix that to be just self:context.

> I'm also unclear as to what you are checking - you seem to be putting
> this in authlogin, but I had expected this to be a check between two
> user contexts, identical in all respects except for the MLS ranges (one
> from seusers, one from the user-supplied input).

 AIUI the code in authlogin allows all of the login type programs (like
getty) to call the check. The check being performed is in policy/mls and
is just:

mlsconstrain context transition
       ( h1 dom h2 );

...have I misunderstood this?

--=20
James Antill <jantill@redhat.com>

--=-PkRA2KkhpVTtu4QXDFFb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFR2UX11eXTEMrxtQRAnp7AJwMd7WgaGPxhBLVPcTFrtVww+LXJgCfR9rS
95wKVAl6GBTsosIdSkNh3X8=
=8Pbt
-----END PGP SIGNATURE-----

--=-PkRA2KkhpVTtu4QXDFFb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
