Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CDxN1F023866
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 09:59:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8CDwYi3007428
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 13:58:38 GMT
Message-ID: <48CA75A8.4070204@manicmethod.com>
Date: Fri, 12 Sep 2008 09:59:04 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: fixfiles fixes
References: <48C57707.3090906@redhat.com>
In-Reply-To: <48C57707.3090906@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Removes all files from /tmp, previous one would leave /tmp/.a and /tmp/.b
> 
> Fixed context on unlabeled_t and file_t files in /tmp and /var/tmp.
> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkjFdwYACgkQrlYvE4MpobMZJACfRsCuVFja3fvYZYtptyW2h3lH
> yAQAn0xmDAYELt+res60OIcL3UDrUFRv
> =09W1
> -----END PGP SIGNATURE-----
> 

Merged in policycoreutils 2.0.56

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
