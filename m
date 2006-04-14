Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3ECKur4026340
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 08:20:56 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3ECKtZb011766
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 12:20:55 GMT
Subject: Re: Latest patches.
From: Russell Coker <rcoker@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <443F90CB.6080208@redhat.com>
References: <443F90CB.6080208@redhat.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 22:20:46 +1000
Message-Id: <1145017247.2840.173.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-04-14 at 08:08 -0400, Daniel J Walsh wrote:
> mailman interaction with postfix

One thing to note is that I'm not certain that mailman will actually
work with this policy.

The suggested configuration (according to mailman documentation and
default config files) fails to work correctly in some situations due to
Unix permissions (can't deliver to the dead-mail store).  It is quite
possible that if this Unix permission issue is solved then other SE
Linux policy issues will be revealed.

But all the most obvious issues with Mailman and Postfix are fixed, it
will probably work for many people now.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
