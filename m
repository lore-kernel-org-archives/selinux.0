Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79FxBjU032587
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 11:59:11 -0400
Received: by qcpx40 with SMTP id x40so405850qcp.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 08:59:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344526608.28967.1092.camel@edumazet-glaptop>
References: <50215A7E.8000701@linaro.org>
	<1695034.0lrQgQPOMT@sifl>
	<1344523833.28967.996.camel@edumazet-glaptop>
	<5799181.tjlnF0gIh2@sifl>
	<1344526608.28967.1092.camel@edumazet-glaptop>
Date: Thu, 9 Aug 2012 11:59:09 -0400
Message-ID: <CAHC9VhRpYdN3tFhik-9v7BQvr+wer2ocZuXGi0x0-pV+fA-mDw@mail.gmail.com>
Subject: Re: [PATCH] ipv4: tcp: security_sk_alloc() needed for unicast_sock
From: Paul Moore <paul@paul-moore.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@parisplace.org>, John Stultz <johnstul@us.ibm.com>,
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

Okay, makes sense.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
