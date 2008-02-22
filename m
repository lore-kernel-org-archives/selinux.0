Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MKfGnO004756
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 15:41:16 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1MKfAiH023846
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 20:41:10 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Not that anyone would ever run in permissive mode but...
Date: Fri, 22 Feb 2008 15:39:38 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195C742@exchange.columbia.tresys.com>
In-Reply-To: <47BF1EBD.6050603@redhat.com>
References: <47BF1EBD.6050603@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This patch is needed for sudo.
> 
> Also added setkeycreatecon, although this will not work the way the
> code is currently.
> 
> Pam activity should probably be happening after setkeycreatecon and
> setexeccon
> 
> But I am not sure how pam_keyinit should work here any ways.
> 
> Currently you loose access to your keying material when you su or
> sudo. 
> 
> These things will not be labeled corectly as currently used.

Thanks, I've merged that into the sudo tree.  I think I understand
why setkeycreatecon and setexeccon ought to be called before PAM.

I am correct in believing that the tty does _not_ need to be relabeled
before calling PAM since the conversation function runs in the current
context?

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
