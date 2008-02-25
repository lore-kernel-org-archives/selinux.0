Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PJ6mPt019999
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:06:48 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PJ6hqv006047
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 19:06:44 GMT
Cc: selinux <selinux@tycho.nsa.gov>
Message-Id: <E6973E05-7EEA-4924-A6B3-B0608766D771@nall.com>
From: Joe Nall <joe@nall.com>
To: w.chimiak@ieee.org
In-Reply-To: <200802251311.09098.w.chimiak@ieee.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Silly audit2allows
Date: Mon, 25 Feb 2008 13:06:08 -0600
References: <200802251311.09098.w.chimiak@ieee.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 25, 2008, at 12:11 PM, Bill Chimiak wrote:

> Three things:
> 1. If one does the audit2allow ...
> 	checkmodule -M -m -o mynewmodule.mod mynewmodule.te
> 	semodule_package -o mynewmodule.pp -m mynewmodule.mod
> 	semodule -i mynewmodule.pp
>
> How does one undo that if mynewmodule.te is a stupid policy?

semodule -r mynewmodule

(no .pp)

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
