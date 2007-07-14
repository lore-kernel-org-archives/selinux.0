Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6EELh8P004871
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 10:21:43 -0400
Received: from ccerelrim04.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6EELg6M000538
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 14:21:42 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/2] NetLabel: enable dynamic activation/deactivation of NetLabel/SELinux enforcement
Date: Sat, 14 Jul 2007 10:21:32 -0400
Cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
References: <20070714030401.888612123@hp.com> <20070714031651.566974004@hp.com> <Line.LNX.4.64.0707141008330.25781@d.namei>
In-Reply-To: <Line.LNX.4.64.0707141008330.25781@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707141021.32253.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 14 July 2007 10:09:48 am James Morris wrote:
> On Fri, 13 Jul 2007, Paul Moore wrote:
> > Create a new NetLabel KAPI interface, netlbl_enabled(), which reports on
> > the current runtime status of NetLabel based on the existing
> > configuration.  LSMs that make use of NetLabel, i.e. SELinux, can use
> > this new function to determine if they should perform NetLabel access
> > checks.  This patch changes the NetLabel/SELinux glue code such that
> > SELinux only enforces NetLabel related access checks when
> > netlbl_enabled() returns true.
>
> This should be the first patch, so a git-bisect doesn't break userspace.
> (I can re-order them for merge, as long as they apply ok in that order).

That is fine with me.  I suspect you might run into problems merging the 
patches for security/selinux/netlabel.c in reverse order, if that is the case 
let me know and I can respin the patchset for you.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
