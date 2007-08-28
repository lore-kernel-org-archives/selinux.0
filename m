Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SGWQxR015047
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 12:32:26 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7SGWPqN025109
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:32:25 GMT
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521401@HAVOC.tcs-sec.com>
References: <D709A20F2164C84E8B7014B0301F5EF8521401@HAVOC.tcs-sec.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <738C5DA5-53CF-4730-A745-1D5E0CD1DA19@nall.com>
Cc: Paul Moore <paul.moore@hp.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 11:32:06 -0500
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 28, 2007, at 11:13 AM, Venkat Yekkirala wrote:
>
> You are right. I think the whole thing boils down to what you trust  
> and
> this can theoretically vary from case to case. For example, if one  
> trusts
> a host to compartmentalize/segregate/mac services appropriately but  
> cannot
> do OTW labeling, and they trust the network path to it (say by use of
> IPSec),
> it's conceivable that they may want the ability to fallback per-port
> (granted
> it could get challenging with the use of ephemeral ports by  
> clients) and
> further
> flow-control per-port as well. But I guess we could always start  
> with the
> current ideas on what can *reasonably* and *commonly* be trusted,  
> which it
> looks like would be the netif and the node (usually using IPSec as you
> mention below)
> and see how far that will take us in the real world. At least this  
> should
> meet
> our current needs. I would be curious to see specifically what  
> other current
> users such as Joe Nall, Ted Toth and others would like to see. IOW,  
> will
> this
> meet their needs. An explicit (N)ACK would be great.

 From an untrustworthy host (no MAC enforcement), every port ought to be
the same for Bell-Lapadula MAC purposes.

I'm sure there are some fringe cases that would violate that rule, but
they can be handled with IP aliasing on the untrusted host.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
