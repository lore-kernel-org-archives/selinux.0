Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8G0bOrT021622
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 20:37:24 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8G0bOhN025817
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 00:37:24 GMT
Subject: Re: SELinux policy discussion.
From: Colin Walters <walters@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, ivg2@cornell.edu
In-Reply-To: <4148A003.6080309@redhat.com>
References: <4148A003.6080309@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lDs+zQ2gD+CL/BcI/rYB"
Date: Wed, 15 Sep 2004 20:38:45 -0400
Message-Id: <1095295125.4231.127.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-lDs+zQ2gD+CL/BcI/rYB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-15 at 16:03 -0400, Daniel J Walsh wrote:
> Ivan Gyurdiev (ivg2@cornell.edu) Has reported a bug that several files=20
> in /etc/ are world readable and yet SELinux is
> preventing them from being read.  Should we add usercanread attribute to=20
> most of these files (/etc/exports, /etc/yp.servers) ?
> Any file in /etc/ that has a security_context other than etc_t and=20
> doesn't have an attribute of usercanread, is a problem.

I disagree that every file that allows user access via Unix permissions
should have the corresponding MAC permissions as well.  If you use the
strict policy it should be as close to least privilege as possible.
Normal users don't just randomly cat files in /etc.

If a case can be made for a particular file (perhaps some user program
parses /etc/exports and displays a list of mount options or something),
then we can add it to usercanread.

It's also a lot easier for users to add custom permissions than to
remove them.  Just drop the files you want added in
domains/misc/local.te, and that will persist even through policy-sources
upgrades.



--=-lDs+zQ2gD+CL/BcI/rYB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD4DBQBBSOCVOIkJWWp2WGURAmjsAJ9jhsoLjeufxuTfHUpBub7ZwskGKgCYiJPc
n7ssrSHS1i5G0/DQK6U52w==
=7HVM
-----END PGP SIGNATURE-----

--=-lDs+zQ2gD+CL/BcI/rYB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
