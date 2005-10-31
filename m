Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9VGN4MA014330
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 11:23:04 -0500 (EST)
Received: from smtp101.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j9VGIGmc025931
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 16:18:16 GMT
In-Reply-To: <200510311812.02462.russell@coker.com.au>
References: <200510311812.02462.russell@coker.com.au>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FE184DBF-12F5-4387-AC3E-71A2B64E69FA@nall.com>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Re: unreasonably long SE Linux context display
Date: Mon, 31 Oct 2005 10:18:03 -0600
To: russell@coker.com.au
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 31, 2005, at 1:11 AM, Russell Coker wrote:

> Would it be possible to use shorter names in the setrans.conf file  
> than
> SystemLog and SystemHigh?  For example could we have "Low-High" or
> "sLow-sHigh" instead?

How about adding a capability to name ranges and shorten
  "SystemLow-SystemHigh"
to
  "all"
or even
  "*"

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
