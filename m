Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8E2BNOW018061
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 22:11:23 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8E2AVib018012
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 02:10:31 GMT
In-Reply-To: <45071277.5020702@trustedcs.com>
References: <45071277.5020702@trustedcs.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2206D853-00DF-4877-90C7-FD472EA281CF@nall.com>
Cc: selinux@tycho.nsa.gov, chanson@TrustedCS.com
From: Joe Nall <joe@nall.com>
Subject: Re: Labeled IPSec status
Date: Wed, 13 Sep 2006 21:10:44 -0500
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sep 12, 2006, at 3:03 PM, Venkat Yekkirala wrote:

> Here's a quick write-up on using Labeled IPSec enhancements  
> currently available in rawhide.
> ... cool stuff ...
> UPCOMING CHANGES:
> ... really cool stuff ...
> 4. getpeercon fix: See the discussion at: http:// 
> marc.theaimsgroup.com/?l=selinux&m=115755980516072&w=2

When complete, we will be able to determine peer context locally on  
unix domain sockets and remotely via IPSec. What about context via  
local IP sockets?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
