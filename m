Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RB7nrT019019
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 07:07:49 -0400 (EDT)
Message-ID: <011901c48c26$1c9c0790$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   "James Morris" <jmorris@redhat.com>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil> <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp> <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil> <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp> <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Fri, 27 Aug 2004 20:07:58 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen, thanks for your comments.

> > By this method, the decision-making is available irrespective of
> > the result of kmalloc(). Is it robustless?
> > The original implementation has too many lock contensitons in Big-SMP
> > environment. It is more positive to consider the method using RCU.
> 
> Yes, that would address my concern.  However, I'm still unclear as to
> why using RCU mandates that we migrate from preallocated nodes to
> dynamic allocation.  I certainly agree that the existing global spinlock
> doesn't scale.  

When avc_reclaim_node() is called, one or some nodes are reclaimed
in both approachs(spinlock/RCU).

But we can't use the reclaimed nodes immediately in RCU-approach,
because it can't guarantee that nobody refers the nodes.
(These nodes are released actually after non-deterministic period.)
The success of avc_reclaim_node() does not mean that we can hold
an avc_node object immediately!
Therefore, we need to allocate a new avc_node object by kmalloc().

In original spinlock implementation, the reclaimed node is chained
to the 'avc_node_freelist' under the spinlock. Thus, we can use
the reclaimed node immediately.

Indeed, I had considered the RCU-approach with pre-allocation,
but I faced to the above difficult problem, and gave up.
Then, I make it with kmalloc() alternatively, so fine.

> > Please wait for a patch, thanks.
> 
> Thanks for working on this.  Could you also supply updated performance
> data when you have a newer patch?  Thanks.

OK, the benchmark results will also be updated.
Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
