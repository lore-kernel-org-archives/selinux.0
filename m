Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HDVahO019243
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 09:31:36 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HDVYQA005233
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 13:31:34 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH v2 1/2] NetLabel: enable dynamic activation/deactivation of NetLabel/SELinux enforcement
Date: Tue, 17 Jul 2007 09:30:00 -0400
Cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
References: <20070716143633.456262605@hp.com> <20070716143819.585735260@hp.com> <Line.LNX.4.64.0707162022050.14773@d.namei>
In-Reply-To: <Line.LNX.4.64.0707162022050.14773@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707170930.00233.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, July 16 2007 8:23:28 pm James Morris wrote:
> On Mon, 16 Jul 2007, Paul Moore wrote:
> > +{
> > +	/* XXX - at some point we probably want to expose this mechanism to
>
> Please don't put "XXX" in production code, it scares people :-)

Gotcha, I'll save that for my upcoming Haloween themed patchset ;)

> I'll remove it during merge.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
