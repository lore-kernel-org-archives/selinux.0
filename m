Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6EFmOTd008058
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 11:48:24 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6EFmMRj022141
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 15:48:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/2] NetLabel: enable dynamic activation/deactivation of NetLabel/SELinux enforcement
Date: Sat, 14 Jul 2007 11:47:45 -0400
Cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
References: <20070714030401.888612123@hp.com> <200707141021.32253.paul.moore@hp.com> <Line.LNX.4.64.0707141125310.26198@d.namei>
In-Reply-To: <Line.LNX.4.64.0707141125310.26198@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707141147.45687.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 14 July 2007 11:26:18 am James Morris wrote:
> On Sat, 14 Jul 2007, Paul Moore wrote:
> > That is fine with me.  I suspect you might run into problems merging the
> > patches for security/selinux/netlabel.c in reverse order, if that is the
> > case let me know and I can respin the patchset for you.
>
> Yep, they don't apply in that order.  Could you please respin and test
> each one ?

Yep, as soon as I sent that last email I tried it, saw they failed, and 
started fixing the patches.  They apply cleanly now but testing them over the 
weekend is going to be a bit tricky - is it okay to wait until Monday to 
repost the patches?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
