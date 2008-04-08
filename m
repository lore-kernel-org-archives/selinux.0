Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m38IpdrQ018763
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 14:51:39 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m38Ipcgo017419
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 18:51:38 GMT
Message-ID: <47FBB698.7070103@redhat.com>
Date: Tue, 08 Apr 2008 14:16:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: gdm login problem when polyinstantiating /tmp
References: <cadfc0e40804070718s23964c78p5f8f7da33e946733@mail.gmail.com> <cadfc0e40804080819y14c0f18el220681d1f14f2d40@mail.gmail.com>
In-Reply-To: <cadfc0e40804080819y14c0f18el220681d1f14f2d40@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Toth wrote:
> Resolved: You've also got to move /tmp/.gdm-xauth`id -u -n`.* to the
> polyinstantiated directory.
> 
Looks like we are getting a new version of gdm that stops using /tmp.
/var/run/gdm


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkf7tpgACgkQrlYvE4MpobPq3gCg2EE9n4YbVukR9g/hM5qYT75E
6QYAniXLRznndn1S/JmEJSIRURBxtDNV
=oY7R
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
