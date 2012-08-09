Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79MRBl4022445
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 18:27:11 -0400
Message-ID: <5024392D.3060608@schaufler-ca.com>
Date: Thu, 09 Aug 2012 15:26:53 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: Eric Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>,
        David Miller <davem@davemloft.net>, John Stultz <johnstul@us.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov,
        john.johansen@canonical.com,
        LSM <linux-security-module@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] ipv4: tcp: security_sk_alloc() needed for unicast_sock
References: <50215A7E.8000701@linaro.org>  <1344462889.28967.328.camel@edumazet-glaptop>  <5022FD9A.4020603@schaufler-ca.com> <1695034.0lrQgQPOMT@sifl>  <1344523833.28967.996.camel@edumazet-glaptop>  <CACLa4ptkvKj2GT4ZL+msMuWOHW885Hugk8nz3hvptOoY9-totw@mail.gmail.com>  <1344547743.31104.582.camel@edumazet-glaptop>  <5024313F.1010404@schaufler-ca.com> <1344549920.31104.701.camel@edumazet-glaptop>
In-Reply-To: <1344549920.31104.701.camel@edumazet-glaptop>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/9/2012 3:05 PM, Eric Dumazet wrote:
> On Thu, 2012-08-09 at 14:53 -0700, Casey Schaufler wrote:
>> On 8/9/2012 2:29 PM, Eric Dumazet wrote:
>>> smack_sk_alloc_security() uses smk_of_current(): What can be the
> I repeat: There are no true socket for these control packets.

OK, fine. You have an optimization. I'm good with that. Just don't
expect that the entire software stack you are taking advantage of
is going to change to accommodate your special case.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
