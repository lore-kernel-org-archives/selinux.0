Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86E1SrT021473
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 10:01:29 -0400 (EDT)
Received: from sccrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86E0bvL023473
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 14:00:37 GMT
Subject: Re: SuSE 9.1 SELinux
From: Chris PeBenito <pebenito@gentoo.org>
To: stefano.zanarini@yacme.com
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1094456102.2213.3.camel@pignoletto.cantina.yacme>
References: 
	 <OF93C1DDD2.9FAF1403-ON49256F06.00517E1E-49256F07.0007F249@jp.ibm.com>
	 <1094456102.2213.3.camel@pignoletto.cantina.yacme>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+ozfQTWLYnhUNQLrtcp7"
Message-Id: <1094479285.11718.31.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Mon, 06 Sep 2004 10:01:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+ozfQTWLYnhUNQLrtcp7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> I'm interested in doing the same thing ,even in suse 9.0 with a custom
> kernel and in 9.1 with defoult one ,but this could be a real problem for
> me ... why doesn't it work with reiserfs ? is there a patch or a
> workaround to make it works ? have you tryed ?=20

This same question was answered a few days ago.  There's a deadlock in
the reiserfs code, and there's no workaround.  To quote Steve:

On Fri, 2004-09-03 at 09:53, Stephen Smalley wrote:=20
> reiserfs is known to not work with SELinux.  There is a deadlock in the
> reiserfs xattr code when interacting with SELinux, and there is no way
> presently for reiserfs to inform SELinux that it shouldn't try to
> mediate access to the internal directories and files used to store the
> xattrs.  reiserfs maintainers know about the issues, but not clear that
> they care...

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-+ozfQTWLYnhUNQLrtcp7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBPG21vI7kLeavkkMRAg6kAJ96skjJZuSuU199ZrOFRSm1cq/CaACffbKO
QINOqzmCClvUSEJB+Ry92Zg=
=jLL2
-----END PGP SIGNATURE-----

--=-+ozfQTWLYnhUNQLrtcp7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
