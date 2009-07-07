Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n67KolM8015614
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 16:50:47 -0400
Received: from mail.copilotco.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n67KpRUw029830
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 20:51:27 GMT
Date: Tue, 7 Jul 2009 13:50:45 -0700
From: Tracy Reed <treed@ultraviolet.org>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Subject: Possible OpenSSH exploit
Message-ID: <20090707205045.GR22434@tracyreed.org>
References: <4A2D618F.2050509@redhat.com> <4A53A665.8020003@manicmethod.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b0op/nKJ9CeIhp9z"
In-Reply-To: <4A53A665.8020003@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--b0op/nKJ9CeIhp9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So far just rumors but this looks potentially scary:

http://seclists.org/fulldisclosure/2009/Jul/0028.html

http://isc.sans.org/diary.html?storyid=3D6742

One of my biggest reasons for using SE Linux for so long has been the
hopeful mitigation of such exploits. If this is real and SE Linux
mitigates it this could be serious validation for the whole SE Linux
philosophy. If somehow we still get owned while running the latest SE
Linux confined ssh I will be very disappointed.

Hopefully it's just a false alarm.

--=20
Tracy Reed
http://tracyreed.org

--b0op/nKJ9CeIhp9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFKU7Ul9PIYKZYVAq0RAmtGAJ4+RivHRs1beEPTJHFY0OEg3QcZCQCgms4t
jVNY+L5mmFHMql3YwY4oFgc=
=c8T2
-----END PGP SIGNATURE-----

--b0op/nKJ9CeIhp9z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
