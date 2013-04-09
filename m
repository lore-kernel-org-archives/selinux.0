Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r39H0Yte014879
	for <selinux@tycho.nsa.gov>; Tue, 9 Apr 2013 13:00:34 -0400
From: Paul Moore <pmoore@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: eric.dumazet@gmail.com, casey@schaufler-ca.com, netdev@vger.kernel.org,
        mvadkert@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tcp: assign the sock correctly to an outgoing SYNACK packet
Date: Tue, 09 Apr 2013 13:00:06 -0400
Message-ID: <1392983.dvWWkBd8H0@sifl>
In-Reply-To: <20130409.125635.1837917915399498838.davem@davemloft.net>
References: <1365520026.3887.139.camel@edumazet-glaptop> <1365521576.3887.147.camel@edumazet-glaptop> <20130409.125635.1837917915399498838.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 09, 2013 12:56:35 PM David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Tue, 09 Apr 2013 08:32:56 -0700
> 
> > It looks like _I_ have to do your work. Sorry, I have no more time to
> > spend on this topic. You'll have to convince David, not me.
> 
> I already have no interest in considering these changes seriously,
> and I've already asked Paul multiple times to drop this idea.

If we address all of your technical concerns, why are you not interested in 
allowing a security blob in the sk_buff?

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
