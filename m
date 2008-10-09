Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99LkCS7018739
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 17:46:13 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99Lj0To013686
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 21:45:00 GMT
Received: by ug-out-1314.google.com with SMTP id z36so1198768uge.17
        for <selinux@tycho.nsa.gov>; Thu, 09 Oct 2008 14:46:12 -0700 (PDT)
Subject: Re: building base policy on RHEL5
From: Dominick Grift <domg472@gmail.com>
To: Andy Warner <warner@rubix.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48EE7546.2080006@rubix.com>
References: <48EE7546.2080006@rubix.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xBbDtOkmIc0fNhWXDMJk"
Date: Thu, 09 Oct 2008 23:46:08 +0200
Message-Id: <1223588768.13559.8.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xBbDtOkmIc0fNhWXDMJk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-10-09 at 23:19 +0200, Andy Warner wrote:

>=20
> which results in the following failure:
>=20
> /usr/bin/checkpolicy policy.conf -o policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> policy/modules/services/fail2ban.te:59:ERROR 'syntax error' at token
> 'corenet_tcp_connect_whois_port' on line 439903:
> =20
> corenet_tcp_connect_whois_port(fail2ban_t)
> checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.21] Error 1

It is best to rebuild the package using the included modules.conf,
selinux-policy.spec and other included files by redhat in the source
rpm.

The redhat modules.conf does not include fail2ban module (it will not
try to build and install that module)

The issues with that entry is that the whois port is not declared in the
corenetwork module and thus you get a syntax error.

That whole fail2ban module doesnt work, fail2ban itself has a nasty bug
(leaked file descriptor) which makes it difficult to confine with
selinux

I recently made a screencast that shows how to rebuild, maintain selinux
policy using red hat rpms this may or may not be helpful for you:

http://82.197.205.60/~domg472/test.ogg

I hope this helps



--=20
Dominick Grift <domg472@gmail.com>

--=-xBbDtOkmIc0fNhWXDMJk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjue5sACgkQL00QnzrVtlwr6ACcC3L5bIkKA74rAun/jGLmcH6t
xTUAoLBME+sXiWtiSqrENRNFLDNdFxwZ
=k4QZ
-----END PGP SIGNATURE-----

--=-xBbDtOkmIc0fNhWXDMJk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
