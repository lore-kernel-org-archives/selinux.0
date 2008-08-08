Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78HvN8c024867
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 13:57:23 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78HvNd0022620
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 17:57:23 GMT
Message-ID: <489C88BE.4010506@redhat.com>
Date: Fri, 08 Aug 2008 13:56:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Can we make libsemanage default to expand-check=0
References: <489864B4.1090605@redhat.com> <489C7879.1030905@manicmethod.com>
In-Reply-To: <489C7879.1030905@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> 
> I'd rather we not do this. We are already losing the vast majority of testers for those codepaths by Fedora turning it off, if it becomes off by default I'm afraid that code will rot like crazy.
That is fine.  The selinux-policy package does do a validate now on
build.  We need to hack something up though to get this to happen in the
makefile in the devel package.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiciL4ACgkQrlYvE4MpobORlQCg2qK/dOdIKoCJ5XocdCI9qBvc
CdkAoLqdTrRGUpeIgLm/51t+K3tv6Dr4
=TPU6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
