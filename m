Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1INwMRb025868
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 18:58:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1INuolM014034
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2004 23:56:51 GMT
Date: Wed, 18 Feb 2004 15:58:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org,
   linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: Re: [SELINUX] Event notifications via Netlink
Message-ID: <20040218155819.J1652@build.pdx.osdl.net>
References: <20040218144346.B22989@build.pdx.osdl.net> <Xine.LNX.4.44.0402181845520.29323-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0402181845520.29323-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Feb 18, 2004 at 06:47:33PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Morris (jmorris@redhat.com) wrote:
> 
> Reaching this would be incorrect use of a kernel API, leading to 
> malfunctioning security code, so I feel that a BUG() is appropriate.

Fair enough.  Just making sure it wasn't leftover from testing or something.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
