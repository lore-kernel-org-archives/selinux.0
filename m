Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r38M21rH004820
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2013 18:02:01 -0400
From: Paul Moore <pmoore@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, mvadkert@redhat.com,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tcp: assign the sock correctly to an outgoing SYNACK packet
Date: Mon, 08 Apr 2013 18:01:56 -0400
Message-ID: <2162769.UZ73yv7g6c@sifl>
In-Reply-To: <20130408.173325.1683493727549657170.davem@davemloft.net>
References: <3505145.vfXt1x4t0P@sifl> <2921619.mqaHl5PnPI@sifl> <20130408.173325.1683493727549657170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, April 08, 2013 05:33:25 PM David Miller wrote:
> From: Paul Moore <pmoore@redhat.com>
> Date: Mon, 08 Apr 2013 17:24:50 -0400
> 
> > If the void pointer is wrapped by a #ifdef (plenty of precedence for that)
> > and the management of that pointer is handled by LSM hooks why is it a
> > concern?  I apologize for pushing on the issue, but I'm having a hard
> > time reconciling the reason for the "no" with the comments/decisions
> > about the regression fix; at present there seems to be a level of
> > contradiction between the two.
>
> 8 bytes times however many millions of packets per second we can process
> on a big machine, you do the math.
> 
> It's memory, less cache locality, etc. etc. etc.
> 
> It's the most important data structure in the entire networking stack,
> and every single byte matters.
> 
> I want the overhead to be your problem, so that only users of your
> stuff eat the overhead, rather than everyone.

Okay, if the objection is really just one of structure size and not the hooks, 
what if I did the work to consolidate the skb->secmark and skb->sp fields into 
a new structure/pointer?  Assuming it wasn't too painful, it would be a net 
reduction of four bytes.  If that worked would you have an objection to us 
adding a LSM security blob to this new structure?

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
