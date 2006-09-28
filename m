Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SKAr1S028665
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 16:10:53 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SK9lbB019492
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 20:09:48 GMT
Date: Thu, 28 Sep 2006 16:10:49 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-audit@redhat.com, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] NetLabel: add audit support for configuration changes
In-Reply-To: <451C2AEA.7050608@hp.com>
Message-ID: <Pine.LNX.4.64.0609281609560.28355@d.namei>
References: <20060928180326.896170000@hp.com> <20060928180337.570612000@hp.com>
 <Pine.LNX.4.64.0609281547060.28120@d.namei> <451C2AEA.7050608@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Sep 2006, Paul Moore wrote:

> Agreed, in fact, as I suspect you have already noticed, this was ripped
> right from that function.  It was private to kernel/auditsc.c making it
> offlimits, but I would have gladly used it instead; making
> audit_log_task_info() public seemed like something that was beyond this
> NetLabel specific patch.

Don't ever be afraid to improve core kernel code :-)




- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
