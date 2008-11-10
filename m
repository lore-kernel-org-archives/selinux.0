Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAAFrB5W002935
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 10:53:11 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAAFpR2C027181
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2008 15:51:27 GMT
Message-ID: <491858E4.5090400@manicmethod.com>
Date: Mon, 10 Nov 2008 10:53:08 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: seobject_fcontext patch allows you to modify a preexisting file
 context.
References: <491454CC.3000708@redhat.com>
In-Reply-To: <491454CC.3000708@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Currently semanage is not allowed to change a file context mapping if it
> matches exactly,  this patch allows you to modify the file context.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkkUVMwACgkQrlYvE4MpobONMgCgi6UbaQXR2yK+tXzh6ouLNtfY
> PFQAn38zI31rZtdBqKTS34SaEfQ5K4VG
> =6jM8
> -----END PGP SIGNATURE-----
>   
Merged in to policycoreutils-2.0.58

With one minor change, I removed the list l that was no longer being 
referenced.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
