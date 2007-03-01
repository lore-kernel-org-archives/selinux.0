Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21JBh6P015859
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:11:43 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21JD3tV001088
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 19:13:04 GMT
Subject: Re: [PATCH] restorecond init cleanup
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <587425.14975.qm@web51505.mail.yahoo.com>
References: <587425.14975.qm@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 14:12:23 -0500
Message-Id: <1172776343.3099.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-27 at 06:15 -0800, Steve G wrote:
> Hi,
> 
> The following patch changes restorecond to follow LSB return codes and most
> importantly, start after the audit daemon so that anything it changes gets
> recorded.
> 
> Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>
> 
> 

Thanks - merged into trunk and stable.

>  
> ____________________________________________________________________________________
> Never Miss an Email
> Stay connected with Yahoo! Mail on your mobile.  Get started!
> http://mobile.yahoo.com/services?promote=mail


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
