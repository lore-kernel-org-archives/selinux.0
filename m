Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1ILH2Y7011162
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 16:17:02 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1ILDdp4002965
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 21:13:39 GMT
Message-ID: <499C7AAF.4070007@manicmethod.com>
Date: Wed, 18 Feb 2009 16:16:31 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Several fixes to restorecond
References: <499AE896.8000709@redhat.com>
In-Reply-To: <499AE896.8000709@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Init script should be 755
> 
> libflashplayer.so has moved in the homedir and is now correct so no
> longer needs to have labeling checked.
> 
> restorecond supports glob matching and should not complain on multiple
> hard links if they match a glob.
> 
> So if a file has > 1 link and is an exact match complain, otherwise do not.
> 
> Also fix a couple of error messages.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkma6JYACgkQrlYvE4MpobOoIACfUgUfpCuhvVTWyHgsq7/8hY0z
> 9WcAmgPK2KktAlY84HhtRmdu/Hy+9eE/
> =zcCj
> -----END PGP SIGNATURE-----
> 

Merged in policycoreutils 2.0.62

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
