Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAAFqJ1l002641
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 10:52:19 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAAFoV2C026964
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 15:50:36 GMT
Message-ID: <491858A7.6090608@manicmethod.com>
Date: Mon, 10 Nov 2008 10:52:07 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils patch
References: <4900B11F.2050101@redhat.com>
In-Reply-To: <4900B11F.2050101@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Fix error message in newrole.
>
> Change semange fcontext -a to check for local customizations rather then
>  global, so you can modify a file context.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkkAsR4ACgkQrlYvE4MpobPkRgCfQQNFw9DE8oGt7ecsl7ikXJhM
> vGIAoKRp+37SMzpfgIoOC9VY0S7bmR+V
> =pwc5
> -----END PGP SIGNATURE-----
>   
Merged in to policycoreutils-2.0.58


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
