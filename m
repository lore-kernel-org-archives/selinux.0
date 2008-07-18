Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IFaP82009366
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 11:36:25 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IFaOGo012395
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 15:36:24 GMT
Message-ID: <4880B872.20202@manicmethod.com>
Date: Fri, 18 Jul 2008 11:36:18 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Critical bug in semanage
References: <487F93C3.1040701@redhat.com>
In-Reply-To: <487F93C3.1040701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> homedirs in /var and /usr/local were not being matched, causing bad
> context to be added.
> 
> genhomedircon port problem.
> 
> An extra / at the end of the regex was causing the problem
> 
> Geesh I love 'C'.  :^P

It has less to do with C and more to do with crazy string libraries :)

I'm not sure what the intention is here though, the comment directly below your patch says
" 	/* Append pattern to eat up trailing slashes */"

How is that not what you are trying to do?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
