Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93FYSPi014648
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 11:34:28 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93FXHe7015441
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:33:18 GMT
Message-ID: <452282F2.1000107@hp.com>
Date: Tue, 03 Oct 2006 11:34:10 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, redhat-lssp@redhat.com, paul.moore@hp.com,
        vyekkirala@TrustedCS.com, jmorris@namei.org
Subject: Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain>
In-Reply-To: <1159834998.28144.115.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric,

I've booted your kernel on the following systems:

ia64 box running rhel5 beta 1 targeted policy
x86 box running fc6t2 mls policy

I don't have any labeled networking specifically configured.

Networking only works in permissive mode.  If I put either system
in enforcing mode, I can't ping, bring up X, or do anything.

Are there some policy changes that are needed?   Seems like by default
everything should work like it did before?

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
