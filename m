Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BMKNT1016923
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 18:20:23 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BMKNKW005680
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 22:20:23 GMT
Message-ID: <48A0BAE4.3080001@redhat.com>
Date: Mon, 11 Aug 2008 18:19:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Kerberos Patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/SELinux/F10/services_kerberos.patch


kpropd policy

Had to add a lot of policy to handle host_rcache_t files.


Kerberos library, has builtin SELinux awareness that causes it to change
the context of files it creates to the system default labeling.

In general case we need to dontaudit calls of setfscreate and validation
of the file context

dns is done outside of kerberos and should not be allowed within the domain.

For domains that create keytabs we need a template to allow them to
label them properly.

Allow userdomain and login programs to connect to kerberos master ports


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiguuQACgkQrlYvE4MpobOcXwCfRI116zquF4YFWpkNr0Mr9ikp
X74AnijDJIgAvPMuwDWpO9f9TMDYCbI/
=YjwO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
