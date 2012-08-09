Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79G92EU001001
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 12:09:02 -0400
Received: by qcpx40 with SMTP id x40so419053qcp.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 09:09:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACLa4ptTfMzvhYk7_DaUJd-9u406FXf2CUHjn1mQrPDa4fFW4w@mail.gmail.com>
References: <50215A7E.8000701@linaro.org>
	<1695034.0lrQgQPOMT@sifl>
	<1344523833.28967.996.camel@edumazet-glaptop>
	<5799181.tjlnF0gIh2@sifl>
	<1344526608.28967.1092.camel@edumazet-glaptop>
	<CACLa4ptTfMzvhYk7_DaUJd-9u406FXf2CUHjn1mQrPDa4fFW4w@mail.gmail.com>
Date: Thu, 9 Aug 2012 12:09:00 -0400
Message-ID: <CAHC9VhTD17py3tozogz1aoHWMNV4aFV1fy44UO7++YM1rECpZg@mail.gmail.com>
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

On Thu, Aug 9, 2012 at 12:05 PM, Eric Paris <eparis@parisplace.org> wrote:
> Paul, are you looking into this?  This is a bandaide, not a fix....

Yep, I mentioned this a few times in the other thread.  The problem is
there is not going to be an easy fix for the labeling so I'd rather we
see this patch, or something like it, go in now to resolve the kernel
panic, and fix the labeling later.

-- 
paul moore
www.paul-moore.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
