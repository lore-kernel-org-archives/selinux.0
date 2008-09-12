Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CDxuFW023987
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 09:59:56 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8CDxBi3007544
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 13:59:11 GMT
Message-ID: <48CA75CD.6080708@manicmethod.com>
Date: Fri, 12 Sep 2008 09:59:41 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Only call gen_requires once.
References: <48C91EBA.8050400@redhat.com>
In-Reply-To: <48C91EBA.8050400@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Currently audit2allow/sepolgen will create two identical gen_requires
> block if you have allow rules and a role statement.
> 
> This patch fixes this problem.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkjJHroACgkQrlYvE4MpobPgMQCghgAMBtaQO0BeZX+ug6IwsWB8
> bNEAoMkRo4cZa0iJhGoGMmCvy5ncGpj8
> =gMFg
> -----END PGP SIGNATURE-----
> 

Merged in sepolgen 1.0.14

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
