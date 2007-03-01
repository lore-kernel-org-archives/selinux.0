Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21KxGjv021477
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 15:59:16 -0500
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21L0ctV029096
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 21:00:38 GMT
Date: Thu, 1 Mar 2007 16:00:36 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [RFC v2] SELinux: move security_skb_extlbl_sid() out of the
 security server
In-Reply-To: <20070301193537.997427466@hp.com>
Message-ID: <Line.LNX.4.64.0703011600220.26228@d.namei>
References: <20070301193537.997427466@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Mar 2007, Paul Moore wrote:

> As suggested, move the security_skb_extlbl_sid() function out of the security
> server and into the SELinux hooks file.


Applied to git://git.infradead.org/~jmorris/selinux-2.6#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
