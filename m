Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8ELvxZO019709
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 17:57:59 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8ELv6Jg025170
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 21:57:06 GMT
Message-ID: <36282A1733C57546BE392885C061859201513A9B@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joe Nall <joe@nall.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
Subject: RE: Labeled IPSec status
Date: Thu, 14 Sep 2006 17:57:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > 4. getpeercon fix: See the discussion at: http:// 
> > marc.theaimsgroup.com/?l=selinux&m=115755980516072&w=2
> 
> When complete, we will be able to determine peer context locally on  
> unix domain sockets and remotely via IPSec. What about context via  
> local IP sockets?

The secid reconciliation patch posted to netdev last week labels all locally
generated packets (normally with the socket's context initially but the
context
could undergo transitions as dictated by policy) as well. And so one could
use
getpeercon to retrieve this context (once I tie secmark to peer_sid that
is).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
