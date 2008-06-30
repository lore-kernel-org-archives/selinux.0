Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UI3OMK007102
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 14:03:24 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5UI3Nhx005830
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 18:03:23 GMT
Message-ID: <48691FE9.4080608@manicmethod.com>
Date: Mon, 30 Jun 2008 14:03:21 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: fixfiles patch
References: <4869044A.3070109@redhat.com>
In-Reply-To: <4869044A.3070109@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> This patch adds a function onboot
> 
> which creates the /.autorelabel file
> 
> It also removes tmp files that map directly to a user.  This fixes the
> problem where a user login gets created with the wrong context in /tmp
> and then can not login, even after a relabel.
> 

Acked-by: Joshua Brindle <method@manicmethod.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
