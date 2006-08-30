Message-ID: <44F59022.30907@hp.com>
Date: Wed, 30 Aug 2006 09:18:26 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, akpm@osdl.org
Subject: Re: [PATCH 0/6] Various NetLabel fixes and cleanups
References: <20060829144251.452774000@hp.com> <20060829.175644.66176288.davem@davemloft.net>
In-Reply-To: <20060829.175644.66176288.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Miller wrote:
> From: paul.moore@hp.com
> Date: Tue, 29 Aug 2006 10:42:51 -0400
> 
> 
>>This patchset contains a series of small patches to fix a bug and some general
>>ugliness from the original author (that moron ...).  All of the following
>>patches are against David's net-2.6.19 tree.
>>
>>Please consider these for 2.6.19, thanks.
> 
> Applied to net-2.6.19, thanks a lot Paul.

No problem.

> Does the bug fix in that first patch fix the ssh problem?

As far as the kernel is concerned, yes.  There was a problem in the
kernel of the sk_security_struct->sclass variable not being initialized
correctly which the posted patch fixes as well as a problem with the ssh
daemon rejecting all connections with IP options.  Looking at the ssh
code it appears that they wanted to reject source routed connections but
they were a bit heavy handed and simply rejected connections if any
options were present.

There is more information in this Fedora Bugzilla:

 * https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202856

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
