Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2B8JRio008634
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 03:19:27 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2B8JsA8015261
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 08:19:54 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o2B8JEdU038337
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 09:19:14 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o2B8JDlx072778
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 09:19:14 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Thu, 11 Mar 2010 09:19:13 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: how to cope with file renames?
Message-ID: <20100311081913.GC24034@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I'm struggling with the problem seemingly as old as filesystems - if you
rename() a file, it retains all its permissions, incl. the context,
because its inode stays the same.

My particular problem is moving stuff from /tmp using PHP's
move_uploaded_file function. I'm aware of the copy/delete workaround,
but that just isn't the same (performance, atomicity, etc.) Also there
is the way of post-relabeling the moved file but that requires more
permissions plus there are no selinux bindings in PHP that i'm aware of.

In short, I was wondering if there was a way for a rename()d file to be
subjected to a type transition as if a new file was created? (I tried a
type_trans rule but to no avail.) Or any other way to deal with renaming
files between variously contexted dirs?

Michal Svoboda


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuYp4EACgkQg/fU9pp1uX77cQCfeNFWSN2gsq2Q+R271oRwE+sm
m10AnA7vItuC5jJhtcUDNyMk5Fk2K541
=NZF7
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
