Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7L0tTrT008043
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 20:55:29 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7L0tLQ6014570
	for <selinux@tycho.nsa.gov>; Sat, 21 Aug 2004 00:55:28 GMT
Subject: Re: conflict between libselinux and libsepol
From: Colin Walters <walters@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <4126812A.2050004@tresys.com>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
	 <1093035295.4212.9.camel@nexus.verbum.private>
	 <4126812A.2050004@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7p2mPaeN4nPcuYGzx4Jn"
Date: Fri, 20 Aug 2004 20:56:15 -0400
Message-Id: <1093049775.4212.18.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-7p2mPaeN4nPcuYGzx4Jn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-20 at 18:54 -0400, Joshua Brindle wrote:

> How is this the case at all? Conceptually the file contexts is *not*=20
> part of the system policy, afaik that is a major design feature of=20
> SELinux, that the enforcement and labeling is totally seperate (with the=20
> exception of ocontext stuff ofcourse)

This is all unrelated to enforcement, which is still entirely separate.

As for labeling - it is still a separate step to apply labels.  All this
patch is doing is ensuring by default that your labels don't conflict
with the policy.  If people feel strongly about it we can move it to a
separate "check" target or something.


--=-7p2mPaeN4nPcuYGzx4Jn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJp2vOIkJWWp2WGURAgB2AKCAhg+8RMO+NbvFVfu4ow0jQTmZ1QCeOj8p
LxoWvp2C/xMn2xgTQKxt6dE=
=87Sy
-----END PGP SIGNATURE-----

--=-7p2mPaeN4nPcuYGzx4Jn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
