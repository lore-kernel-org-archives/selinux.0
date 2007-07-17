Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HEseiS026442
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 10:54:40 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HEsdbS007895
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 14:54:39 GMT
Date: Tue, 17 Jul 2007 10:54:37 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov, zohar@us.ibm.com,
        safford@watson.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
In-Reply-To: <1184682614.5929.10.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0707171046060.5764@d.namei>
References: <1184594240.5860.5.camel@localhost.localdomain>
 <200707161523.39706.paul.moore@hp.com> <1184682614.5929.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Jul 2007, Mimi Zohar wrote:

> No, it isn't being audited, but should be.  The question is what type of audit 
> message would be appropriate here.  It could be the normal denied/granted 
> message, but that would be confusing as this isn't based on a permission or 
> capability check, but an integrity error.  Any suggestions how to handle this 
> here and in the other places? 

If integrity is being enforced, then the final AVC denial should include 
information that it was because of an integrity failure.

I'm not sure that it's useful to have non-enforced integrity, aside from 
debugging/development use.

For general use, it should either be enabled or disabled.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
