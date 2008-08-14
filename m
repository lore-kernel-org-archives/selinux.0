Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EIO7WD030409
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:24:07 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7EIO6BU007456
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 18:24:06 GMT
Message-ID: <48A477F6.9070406@redhat.com>
Date: Thu, 14 Aug 2008 14:22:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Missing interfaces for kudzu
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/SELinux/F10/admin_kudzu.patch

Also included a change to modutils updatete_modules_run need to call
modutils_run_insmod
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkikd/YACgkQrlYvE4MpobMAyACgt78FJXHbDAA6h3ykQxfv/GSq
0JsAoKhwU1kYupZconozYzJbGYNosQuM
=V6Cb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
