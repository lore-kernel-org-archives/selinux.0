Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6H0NWdt031864
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 20:23:32 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6H0NT2I001496
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 00:23:29 GMT
Date: Mon, 16 Jul 2007 20:23:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
Subject: Re: [PATCH v2 1/2] NetLabel: enable dynamic activation/deactivation
 of NetLabel/SELinux enforcement
In-Reply-To: <20070716143819.585735260@hp.com>
Message-ID: <Line.LNX.4.64.0707162022050.14773@d.namei>
References: <20070716143633.456262605@hp.com> <20070716143819.585735260@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Jul 2007, Paul Moore wrote:

> +{
> +	/* XXX - at some point we probably want to expose this mechanism to

Please don't put "XXX" in production code, it scares people :-)

I'll remove it during merge.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
