Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6H2RIKn007376
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 22:27:18 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6H2RG2I020340
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 02:27:17 GMT
Date: Mon, 16 Jul 2007 22:27:13 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
Subject: Re: [PATCH v2 0/2] Respun patches from Friday the 13th
In-Reply-To: <20070716143633.456262605@hp.com>
Message-ID: <Line.LNX.4.64.0707162226340.18383@d.namei>
References: <20070716143633.456262605@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Jul 2007, Paul Moore wrote:

> The same patches as I posted last Friday, just flipped in order and fixed up so
> they play nicely.  I've tested both patches in order this morning and everythinglooks good to me.

Applied to:
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm

I'll push to Linus within the next day or so.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
