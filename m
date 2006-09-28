Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SLPIpw030952
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 17:25:18 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SLOiin005583
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 21:24:45 GMT
Message-ID: <451C3DBA.9040007@hp.com>
Date: Thu, 28 Sep 2006 17:25:14 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-audit@redhat.com, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] NetLabel: add audit support for configuration changes
References: <20060928180326.896170000@hp.com> <20060928180337.570612000@hp.com> <Pine.LNX.4.64.0609281547060.28120@d.namei> <451C2AEA.7050608@hp.com> <Pine.LNX.4.64.0609281609560.28355@d.namei>
In-Reply-To: <Pine.LNX.4.64.0609281609560.28355@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 28 Sep 2006, Paul Moore wrote:
> 
>>Agreed, in fact, as I suspect you have already noticed, this was ripped
>>right from that function.  It was private to kernel/auditsc.c making it
>>offlimits, but I would have gladly used it instead; making
>>audit_log_task_info() public seemed like something that was beyond this
>>NetLabel specific patch.
> 
> Don't ever be afraid to improve core kernel code :-)

Okay, I just added it to my todo list.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
