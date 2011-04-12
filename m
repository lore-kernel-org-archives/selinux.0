Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3CGCuVr000860
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 12:12:56 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3CGCteR026552
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 16:12:55 GMT
Message-ID: <4DA47A02.400@redhat.com>
Date: Tue, 12 Apr 2011 12:12:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: This patch adds a new subs_dist file.
References: <4D9CD64B.7020207@redhat.com> <4DA454A8.7030005@tresys.com>
In-Reply-To: <4DA454A8.7030005@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Your current patch for libsepol is broken.  It is missing Epasis File
Trans patch so you have holes in the numbering




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2kegEACgkQrlYvE4MpobM5cwCghnkuLSBr4MkJB7whBJNCDEOl
3+oAoI6IBvOWmlb/tx5e0goKLy9lpcf6
=IrVR
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
