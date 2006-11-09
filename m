Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA94cXJQ005842
	for <selinux@tycho.nsa.gov>; Wed, 8 Nov 2006 23:38:33 -0500
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA94avr6027486
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 04:36:57 GMT
Date: Wed, 8 Nov 2006 23:38:39 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: vyekkirala@TrustedCS.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 2/3] mlsxfrm: Various fixes
In-Reply-To: <4552A9AC.3060708@hp.com>
Message-ID: <Pine.LNX.4.64.0611082337520.5916@d.namei>
References: <000501c70342$83b9df70$cc0a010a@tcssec.com> <4552A9AC.3060708@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Nov 2006, Paul Moore wrote:

> 1. Functionality is available right now, no additional kernel changes needed
> 2. No special handling for localhost, I tend to like the idea of having
> consistent behavior for all addresses/interfaces

I don't agree.  SO_PEERSEC should always just work for loopback, just like 
with Unix sockets.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
