Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBIH9SwI026633
	for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2006 12:09:28 -0500
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBIHA3Zo019366
	for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2006 17:10:03 GMT
Date: Mon, 18 Dec 2006 12:10:00 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] A bugfix patchset for NetLabel
In-Reply-To: <4586C0C5.4010502@hp.com>
Message-ID: <XMMS.LNX.4.64.0612181208300.8879@d.namei>
References: <20061215214926.018950000@hp.com> <XMMS.LNX.4.64.0612151840370.26929@d.namei>
 <4586C0C5.4010502@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 Dec 2006, Paul Moore wrote:

> ... however, I still think this might qualify for the 2.6.19 stable kernel.
> When a MLS sensitivity level or category maps to zero then whenever the NetLabel
> subsystem is called to resolve the security attributes of a packet it will, in
> certain configurations, return security attributes/contexts which are incorrect.
> 
> Please let me know if you think that has merit for the stable tree and I'll send
> the patch to the stable mailing list.

I really don't know.  Try submitting them and see what happens :-)


-- 
James Morris <jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
