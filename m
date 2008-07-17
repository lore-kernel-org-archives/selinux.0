Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6HBFUpF028224
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 07:15:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6HBFTAx027681
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2008 11:15:30 GMT
Message-ID: <487F29BF.2080701@manicmethod.com>
Date: Thu, 17 Jul 2008 07:15:11 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
CC: selinux@tycho.nsa.gov
Subject: Re: Proposed patch for policycoreutils/sestatus
References: <Pine.LNX.4.64L.0807161749060.10705@ruuvi.it.helsinki.fi>
In-Reply-To: <Pine.LNX.4.64L.0807161749060.10705@ruuvi.it.helsinki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vesa-Matti J Kari wrote:
> Hello,
> 
> I have refactored sestatus.c and attached the patch for
> policycoreutils-2.0.46.
> 
> However, the latter part of the patch is a bit unreadable due to the
> extensive changes in the code layout. In fact the line count of the
> patch is larger than sestatus.c itself.
> 

split the layout changes from the functional changes and submit 2 patches please.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
