Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l94LngeF026504
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2007 17:49:42 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l94LnfZY014117
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2007 21:49:41 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: One more problem with genhomedircon replacement.
Date: Thu, 4 Oct 2007 17:45:54 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880110001D@exchange.columbia.tresys.com>
In-Reply-To: <4704ECF8.8050708@redhat.com>
References: <4704ECF8.8050708@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wrote a small genhomedircon frontend for test purposes and it was not
significantly faster than "semodule -Bn" since we still have to create
an semanage tmp dir, populate it, and merge local policy into base
before the actual genhomedircon code can run.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
