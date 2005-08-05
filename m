Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75IjoOb002935
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 14:45:50 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75IbjrI022595
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 18:37:46 GMT
Subject: Re: Red Hat's passwd
From: Colin Walters <walters@verbum.org>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42F3ACF2.9050905@tresys.com>
References: <42F3904F.5080401@tresys.com>
	 <1123261941.20237.9.camel@nexus.verbum.private>
	 <42F3ACF2.9050905@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JbWGMkdfVGOnsmG1GKtd"
Date: Fri, 05 Aug 2005 14:38:39 -0400
Message-Id: <1123267119.20237.19.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-JbWGMkdfVGOnsmG1GKtd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-05 at 14:16 -0400, Joshua Brindle wrote:

> yea, the problem is really upstreaming the change in whatever packages=20
> use it (shadow, and hopefully RH passwd)
>
> and some of Red Hats patches for things like vixie cron will also need=20
> to be fixed.

Ah, hm.  I can see how that is potentially harder.  Are those patches
already really upstreamed (i.e. in their tarballs) though?  Looking in
Fedora it looks like the vixie-cron SELinux support is still a separate
patch for example.

> Personally I'd rather not deal with a major version change needed for an=20
> api change.=20

Well I guess I was arguing that we should be evil and not bump the
soname for it and just fix the few apps that are using it :)  We know
what they are and are in control of the code.

If we are talking about bumping soname, there are other changes we
should probably make too.

> We probably need to be more careful about what functions are=20
> exported in the future.

Yes.

--=-JbWGMkdfVGOnsmG1GKtd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC87IvOIkJWWp2WGURAvnnAJ9B+GxeWRVF1eP22Sp2Y9uTNG5BlgCghGao
BlFwWnmSgizx+q68rPpnM0Q=
=pqhy
-----END PGP SIGNATURE-----

--=-JbWGMkdfVGOnsmG1GKtd--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
