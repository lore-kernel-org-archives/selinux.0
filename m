Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4EwYjP020396
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 09:58:34 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lB4EwYNt006157
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 14:58:34 GMT
Subject: Re: Many confined domains are calling getpw calls.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47545A14.3060602@redhat.com>
References: <47545A14.3060602@redhat.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 09:57:54 -0500
Message-Id: <1196780274.5854.42.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-03 at 14:33 -0500, Daniel J Walsh wrote:
> This causes these confined domains to require auth_use_nsswitch.
> 
> I have searched through and cleaned up a lot of policy using this method.
> 
> Extracted from my massive patch for easier application.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
