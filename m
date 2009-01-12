Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0CKvNuS005336
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2009 15:57:23 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n0CKsbwX021111
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2009 20:54:37 GMT
Message-ID: <496BAEB1.30900@manicmethod.com>
Date: Mon, 12 Jan 2009 15:57:21 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chcat patch.
References: <49145324.3040808@redhat.com>
In-Reply-To: <49145324.3040808@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Prevent chcat from expanding number of categories above max size of
> command line.  Arbitrarily picked 25.

merged in policycoreutils 2.0.61

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
