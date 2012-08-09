Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79KJ37j015727
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 16:19:05 -0400
Received: by qcpx40 with SMTP id x40so617766qcp.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 13:19:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACLa4ptkvKj2GT4ZL+msMuWOHW885Hugk8nz3hvptOoY9-totw@mail.gmail.com>
References: <50215A7E.8000701@linaro.org>
	<1344462889.28967.328.camel@edumazet-glaptop>
	<5022FD9A.4020603@schaufler-ca.com>
	<1695034.0lrQgQPOMT@sifl>
	<1344523833.28967.996.camel@edumazet-glaptop>
	<CACLa4ptkvKj2GT4ZL+msMuWOHW885Hugk8nz3hvptOoY9-totw@mail.gmail.com>
Date: Thu, 9 Aug 2012 16:19:03 -0400
Message-ID: <CAHC9VhQo8bh45qcMDo3cC=a0RA50zwBMftbZ3KGdLEXUapuvtw@mail.gmail.com>
Subject: Re: [PATCH] ipv4: tcp: security_sk_alloc() needed for unicast_sock
From: Paul Moore <paul@paul-moore.com>
To: Eric Paris <eparis@parisplace.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, David Miller <davem@davemloft.net>,
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

On Thu, Aug 9, 2012 at 4:06 PM, Eric Paris <eparis@parisplace.org> wrote:
> I'm going to work right now on exposing the equivalent struct sock LSM
> interface so we can call that as well.  But it's going to take me a
> bit.

Before you go too far down this path, can you elaborate on what
exactly you mean by the above?

I'm asking because I'm not convinced the labeling, either the old way
or the new way, was 100% correct and I think we're going to need to
change things regardless.  I'm just not sure what the right solution
is just yet.

-- 
paul moore
www.paul-moore.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
