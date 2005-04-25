Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3PD3pgA000426
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 09:03:51 -0400 (EDT)
Received: from web51505.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j3PCwGYj011419
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 12:58:16 GMT
Message-ID: <20050425125803.25719.qmail@web51505.mail.yahoo.com>
Date: Mon, 25 Apr 2005 05:58:02 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Strange audit messages - whitespace
To: Stephen Smalley <sds@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>IIRC, this is believed to be a bug in the handling of the "%*.*s" format
>by printk as used by the kernel audit framework.

Yes.

>What's the status on getting the patch by Peter Martucelli to eliminate that 
>usage upstreamed?

It got dropped from the -mm tree because of merge problems with Andi's code.
Andrew said it will be picked up again. So I'd say it will land in 2.6.13. In any
event, we are trying to get all the patches that were in the mm tree and dropped
into FC4 kernel this week. This includes the comm/exe patch.

-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
