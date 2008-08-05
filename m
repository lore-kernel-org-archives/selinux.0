Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75JYKZq025272
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 15:34:20 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m75JYJw3012410
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 19:34:19 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1192451nfd.4
        for <selinux@tycho.nsa.gov>; Tue, 05 Aug 2008 12:34:01 -0700 (PDT)
Subject: [refpolicy patch] Updated Git daemon domain.
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jVEBG4iG6Fv2YhhmDPQQ"
Date: Tue, 05 Aug 2008 21:33:32 +0200
Message-Id: <1217964812.7747.21.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jVEBG4iG6Fv2YhhmDPQQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached is my latest take on confining Git daemon. I removed Git user
domain and userdom_git_user_template and added a
git_daemon_git_user_template instead. There is no user domain able to
read or write git_daemon_system_content. One would have to create a user
domain, call git_daemon_git_user_template in it, and since the Git user
domain has to be a primary domain, one would also have a default user
context.

Also note that apache calls git_daemon_read_all_git_content in an
optional policy block. I have tried to wrap this call into a tunable
block first and then into optional policy. Although this did compile, it
did not yield the expected results. This is why i decided to not make
this tunable. It has to optional in my view.

The Git daemon domain is a coarse implementation. Content only has two
general types, system content and user content. Because Git daemon uses
SSH daemon to push content, the system ACLs are transparent. This means
i may be able to implement finer grained access control. For example
which Git user domain may access which Git daemon content?

Attachement: http://pastebin.ca/1093095
--=20
Dominick Grift <domg472@gmail.com>

--=-jVEBG4iG6Fv2YhhmDPQQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiYqwoACgkQL00QnzrVtlz1TwCghcFOWoqsbQmwqxYAVSzPrqCF
DBQAn2IVFMA06YCS2RIP9jy8duExocmi
=QDM9
-----END PGP SIGNATURE-----

--=-jVEBG4iG6Fv2YhhmDPQQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
