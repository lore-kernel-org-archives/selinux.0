Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k19FFwXf024574
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 10:15:59 -0500 (EST)
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k19FEb7q009019
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 15:14:37 GMT
Date: Thu, 9 Feb 2006 10:15:53 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: James Morris <jmorris@redhat.com>
cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating
 audit messages
In-Reply-To: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
Message-ID: <Pine.LNX.4.64.0602091013450.388@excalibur.intercode>
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Feb 2006, James Morris wrote:

> You also need to verify the policy serial number.
> 
> I wonder if it might be better to use the security context directly.

Also consider adding a security field to netlink messages, to managed by 
the LSM.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
