Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1ILGqxq011098
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 16:16:52 -0500
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1ILGp9O001264
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 21:16:51 GMT
Message-ID: <499C7AA5.7010706@manicmethod.com>
Date: Wed, 18 Feb 2009 16:16:21 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Make removing of a module a warning rather then an error.
References: <496C9DBD.6090008@redhat.com>
In-Reply-To: <496C9DBD.6090008@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This way if I say a command line
> 
> semodule -r mypol -i newmypol
> 
> and mypol was not there the semodule command does not error out.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAklsnb0ACgkQrlYvE4MpobNwFACfTqc17wREKC2aAhLOIkfbqgeg
> GxgAn2/ZBz5ljtyK1aiVkqoCBj98y9Ey
> =I4uX
> -----END PGP SIGNATURE-----
> 

Merged in policycoreutils 2.0.62

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
