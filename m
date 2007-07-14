Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6EFobVO008197
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 11:50:38 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6EFoa6M010144
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 15:50:37 GMT
Date: Sat, 14 Jul 2007 11:50:34 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
Subject: Re: [PATCH 2/2] NetLabel: enable dynamic activation/deactivation of
 NetLabel/SELinux enforcement
In-Reply-To: <200707141147.45687.paul.moore@hp.com>
Message-ID: <Line.LNX.4.64.0707141150280.26405@d.namei>
References: <20070714030401.888612123@hp.com> <200707141021.32253.paul.moore@hp.com>
 <Line.LNX.4.64.0707141125310.26198@d.namei> <200707141147.45687.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Jul 2007, Paul Moore wrote:

> On Saturday 14 July 2007 11:26:18 am James Morris wrote:
> > On Sat, 14 Jul 2007, Paul Moore wrote:
> > > That is fine with me.  I suspect you might run into problems merging the
> > > patches for security/selinux/netlabel.c in reverse order, if that is the
> > > case let me know and I can respin the patchset for you.
> >
> > Yep, they don't apply in that order.  Could you please respin and test
> > each one ?
> 
> Yep, as soon as I sent that last email I tried it, saw they failed, and 
> started fixing the patches.  They apply cleanly now but testing them over the 
> weekend is going to be a bit tricky - is it okay to wait until Monday to 
> repost the patches?

Yep.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
