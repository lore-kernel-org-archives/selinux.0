Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8CDxcoD023923
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 09:59:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8CDwri3007491
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2008 13:58:53 GMT
Message-ID: <48CA75BD.60403@manicmethod.com>
Date: Fri, 12 Sep 2008 09:59:25 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Changes to semanage to allow it to handle transactions.
References: <48C57780.6090408@redhat.com>
In-Reply-To: <48C57780.6090408@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> semanage -S targeted -i - << __eof
> user -a -P user -R "unconfined_r system_r" -r s0-s0:c0.c1023 unconfined_u
> user -a -P user -R guest_r guest_u
> user -a -P user -R xguest_r xguest_u
> __eof
> semanage -S targeted -i - << __eof
> login -m  -s unconfined_u -r s0-s0:c0.c1023 __default__
> login -m  -s unconfined_u -r s0-s0:c0.c1023 root
> __eof
> 
> So you can add multiple records in a single pass.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkjFd4AACgkQrlYvE4MpobMaoQCgxeqYTX2mpRIiIr0461/fvblU
> 3fQAoIbM8x9rWL0f8iPz0UeoM2mf60XW
> =hxC3
> -----END PGP SIGNATURE-----
> 

Merged in policycoreutils 2.0.56

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
