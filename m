Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l410vM1n002014
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 20:57:22 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l410vL6j008596
	for <selinux@tycho.nsa.gov>; Tue, 1 May 2007 00:57:21 GMT
Subject: Re: Patch to cleanup audit handling in policy.
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Steve G <linux_4ever@yahoo.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1177951993.3570.115.camel@sgc>
References: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
	 <1177951993.3570.115.camel@sgc>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 20:49:51 -0400
Message-Id: <1177980591.13269.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-30 at 16:53 +0000, Christopher J. PeBenito wrote:
> On Mon, 2007-04-30 at 07:59 -0700, Steve G wrote:

<snip>

> 
> > The interfaces that Dan created allows the exact kind of permission to be applied
> > without having to copy and paste individual permissions which is error prone.
> > (There are only 4 use cases of the audit system.) Part of what makes it error
> > prone is the naming convention for all the pieces. Example: "audit_write" is that
> > for the capability, the netlink interface, or audit logs?
> 
> This is the reason policy patterns exist.
> 

So far the policy patterns have been very hard to automatically generate
using sepolgen. Note that this deficiency is not something that I can
address - it is a problem with the patterns themselves. Given that and
my concerns over their clarity I would prefer that no more patterns be
introduced.

Can I ask why you are so against these audit interfaces and would prefer
patterns?

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
