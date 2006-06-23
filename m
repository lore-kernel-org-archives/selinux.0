Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NEWNCs005401
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 10:32:23 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NEWMZW027583
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 14:32:22 GMT
Subject: Re: Selinux Sources
From: Thorsten Scherf <tscherf@redhat.com>
Reply-To: tscherf@redhat.com
To: Miguel Fernandes <esmiguelfc@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7b5ba3cd0606230706p7775ab9cx4dcc4ba1d70798c1@mail.gmail.com>
References: <7b5ba3cd0606230706p7775ab9cx4dcc4ba1d70798c1@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ze7zZVkQ3B3APAcQlH8X"
Date: Fri, 23 Jun 2006 16:32:15 +0200
Message-Id: <1151073136.16104.3.camel@tiffy.tuxgeek.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Ze7zZVkQ3B3APAcQlH8X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 10:06 -0400, Miguel Fernandes wrote:
> Hi, I'm using FC5 with SELinux enable, but I'm unable to find the
> ploicy sources that should be located in /etc/selinux/targeted/src.
> The src folder doesn't exist on /etc/selinux/targeted. In
> /etc/security doesn't exist a selinux directory either. I dont know
> which package I have to install to obtain this files. Thanks in
> advance!

There is no longer a selinux-policy-<targeted/strict/mls>-sources RPM
available in FC5. All Policies are build from a selinux-policy.srpm
package, which contains all of the policy source files.

Happy Day.
Thorsten

--=20
Thorsten Scherf <tscherf@redhat.com>
Red Hat GmbH

--=-Ze7zZVkQ3B3APAcQlH8X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEm/tvwfkoLTuSgLsRAkVUAJ9b/8Yos4t6PvYrUh8oAW3JhU948QCeMCZd
yyLGAareaiwGXzzrlhsN31w=
=yXOo
-----END PGP SIGNATURE-----

--=-Ze7zZVkQ3B3APAcQlH8X--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
