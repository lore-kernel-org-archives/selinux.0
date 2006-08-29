Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TLBjE1032761
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 17:11:45 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TLB8RT019666
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 21:11:09 GMT
Date: Tue, 29 Aug 2006 16:11:36 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        paul.moore@hp.com
Subject: Re: ipsec and getpeercon()
Message-ID: <20060829211136.GA12307@w-m-p.com>
References: <1156874881.6255.5.camel@twoface.columbia.tresys.com> <1156880256.22210.216.camel@moss-spartans.epoch.ncsc.mil> <1156880819.8075.14.camel@twoface.columbia.tresys.com> <1156883110.22210.222.camel@moss-spartans.epoch.ncsc.mil> <1156883571.22210.225.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1156883571.22210.225.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 29, 2006 at 04:32:51PM -0400, Stephen Smalley wrote:
> BTW, Joy & Venkat - it would be nice if the usage/configuration of the
> ipsec labeling was documented somewhere.  I've seen emails in the past
> with sample usage, but has it been captured anywhere we can refer people
> to, like in the Fedora SELinux wiki?

I have the impression that the Fedora SELinux wiki isn't being updated
anymore since it's not editable without jumping through hoops that seem
excessive even to people working on a MLS/RBAC system...

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
