Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79G5fYt000819
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 12:05:41 -0400
Received: by yhp3 with SMTP id 3so617012yhp.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 09:05:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344526608.28967.1092.camel@edumazet-glaptop>
References: <50215A7E.8000701@linaro.org>
	<1695034.0lrQgQPOMT@sifl>
	<1344523833.28967.996.camel@edumazet-glaptop>
	<5799181.tjlnF0gIh2@sifl>
	<1344526608.28967.1092.camel@edumazet-glaptop>
Date: Thu, 9 Aug 2012 12:05:40 -0400
Message-ID: <CACLa4ptTfMzvhYk7_DaUJd-9u406FXf2CUHjn1mQrPDa4fFW4w@mail.gmail.com>
Subject: Re: [PATCH] ipv4: tcp: security_sk_alloc() needed for unicast_sock
From: Eric Paris <eparis@parisplace.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, David Miller <davem@davemloft.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Stultz <johnstul@us.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov,
        john.johansen@canonical.com,
        LSM <linux-security-module@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 9, 2012 at 11:36 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Thu, 2012-08-09 at 11:07 -0400, Paul Moore wrote:
>
>> Is is possible to do the call to security_sk_alloc() in the ip_init() function
>> or does the per-cpu nature of the socket make this a pain?
>>
>
> Its a pain, if we want NUMA affinity.
>
> Here, each cpu should get memory from its closest node.

I really really don't like it.  I won't say NAK, but it is the first
and only place in the kernel where I believe we allocate an object and
don't allocate the security blob until some random later point in
time.  If it is such a performance issue to have the security blob in
the same numa node, isn't adding a number of branches and putting this
function call on every output at least as bad?  Aren't we discouraged
from GFP_ATOMIC?  In __init we can use GFP_KERNEL.

This still doesn't fix these sockets entirely.  We now have the
security blob allocated, but it was never set to something useful.
Paul, are you looking into this?  This is a bandaide, not a fix....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
