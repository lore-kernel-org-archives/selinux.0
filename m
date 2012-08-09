Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79F3xHD029023
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 11:04:01 -0400
Received: by qadb17 with SMTP id b17so299783qad.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 08:04:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1344522472.28967.936.camel@edumazet-glaptop>
References: <50215A7E.8000701@linaro.org>
	<1344462889.28967.328.camel@edumazet-glaptop>
	<5022FD9A.4020603@schaufler-ca.com>
	<1695034.0lrQgQPOMT@sifl>
	<1344522472.28967.936.camel@edumazet-glaptop>
Date: Thu, 9 Aug 2012 11:04:00 -0400
Message-ID: <CAHC9VhSOQo-6hv09QpwjNEVJPudk60uE=pz-dbuX3T+t3KYaQw@mail.gmail.com>
Subject: Re: NULL pointer dereference in selinux_ip_postroute_compat
From: Paul Moore <paul@paul-moore.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        Eric Paris <eparis@parisplace.org>, John Stultz <johnstul@us.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov,
        Eric Dumazet <edumazet@google.com>, john.johansen@canonical.com,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 9, 2012 at 10:27 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Thu, 2012-08-09 at 09:30 -0400, Paul Moore wrote:
>
>> In the case of a TCP syn-recv and timewait ACK things are a little less clear.
>> Eric (Dumazet), it looks like we have a socket in tcp_v4_reqsk_send_ack() and
>> tcp_v4_timewait_ack(), any reason why we can't propagate the socket down to
>> ip_send_unicast_reply()?
>>
>
> timewait 'sockets' are not full blown sockets.
>
> We need a socket (well, a good part of it) to build the IP frame and
> send it.

Yes, of course you're right.

Ideally we need a better solution here from a LSM perspective, but I
don't think this should hold up the fix as the labeling was broken
even before the postroute_compat() code broke.

-- 
paul moore
www.paul-moore.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
