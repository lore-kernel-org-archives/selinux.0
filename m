Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92EhFAG012145
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 10:43:15 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k92Egbcd009253
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 14:42:39 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CF46C@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
Cc: redhat-lspp@redhat.com
Subject: RE: gpm & mls
Date: Mon, 2 Oct 2006 10:42:50 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


It could probably be made into an object manager. For the certification, I
would suggest that gpm is disabled or removed to avoid the problem.

-Chad

> -----Original Message-----
> From: Steve G [mailto:linux_4ever@yahoo.com]
> Sent: Monday, October 02, 2006 8:06 AM
> To: selinux@tycho.nsa.gov
> Subject: gpm & mls
> 
> 
> Hi,
> 
> I was wondering if gpm should be patched to be an Object 
> Manager? The reason I
> ask is that its possible to be logged into 2 consoles at 2 
> levels. Its just a
> copy and paste to downgrade text and it is not controlled or audited.
> 
> -Steve
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
