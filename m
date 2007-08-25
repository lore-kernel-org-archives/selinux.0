Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7PL0dW1003538
	for <selinux@tycho.nsa.gov>; Sat, 25 Aug 2007 17:00:39 -0400
Received: from atlantic.devin.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7PL0bk5025108
	for <selinux@tycho.nsa.gov>; Sat, 25 Aug 2007 21:00:38 GMT
Date: Sat, 25 Aug 2007 14:00:36 -0700
From: Devin Carraway <selinux-list@devin.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [refpolicy] policy & patch for bitlbee
Message-ID: <20070825210036.GN28833@atlantic.devin.com>
References: <20070819045707.GJ18641@atlantic.devin.com> <46D00510.80608@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
In-Reply-To: <46D00510.80608@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 25, 2007 at 06:31:44AM -0400, Daniel J Walsh wrote:
> First comment, if you have files directories that the confined domain
> does not need to write, and the data within is not secret,  IE You dont
> want other domains to be able to read it.  DO NOT create a type.  Just
> leave the files the default type, and use the interface to allow you
> domain to read it.

Hmm, okay.  bitlbee_share_t I put in not because /usr/share/bitlbee contains
anything sensitive (just one helpfile, at the moment), but because it has no
need to read any files of type usr_t, so by making a type for it I could av=
oid
granting anything on usr_t:file (usr_t:dir has r/o perms implied by
libs_legacy_use_shared_libs()).  Should I go ahead and let it read usr_t:fi=
le
for sake of avoiding the extra type, trading off a somewhat broader scope of
access for the domain?

> type bitlbee_conf_t;
> files_config_file(bitlbee_conf_t)

There's a single sensitive piece of data here, namely an (optional) password
to connect to the bitlbee server -- roughly analogous in policy terms to an
Apache htpasswd/htdigest file.

Thanks for the feedback!


--=20
Devin  \ aqua(at)devin.com, IRC:Requiem; http://www.devin.com
Carraway \ 1024D/E9ABFCD2: 13E7 199E DD1E 65F0 8905 2E43 5395 CA0D E9AB FCD2

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0Jh0U5XKDemr/NIRAuiMAKDbCQkCQyiL5+ZSaAtIsVQ3q2pVwACfYXA2
DD2zIc+gYkabz/SLU1nPNQ4=
=UbGQ
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
