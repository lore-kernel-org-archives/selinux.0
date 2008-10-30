Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9UJcG8R031834
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 15:38:16 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9UJahbY017803
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 19:36:44 GMT
Message-ID: <490A0D0E.9060703@redhat.com>
Date: Thu, 30 Oct 2008 15:37:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sanjai Narain <narain@research.telcordia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux policy parser
References: <490A0775.8040001@research.telcordia.com>
In-Reply-To: <490A0775.8040001@research.telcordia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sanjai Narain wrote:
> Hello, I would appreciate pointers to any tools that parse SELinux
> policy files (either text or binary). I am planning to write algorithms
> to analyze such policies.
> 
> Not sure if this makes sense but given that tools like apol  read policy
> files, can they be made to dump their internal representations into a
> text file?
> 
> Thanks. -- Sanjai
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Take a look at sesearch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkKDQ4ACgkQrlYvE4MpobMpoQCgghWWdI9ztFNO005ss4sTuCZe
RwgAn1T8zw3JruIIrQQzBmrhM0vXyMhY
=qTG8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
