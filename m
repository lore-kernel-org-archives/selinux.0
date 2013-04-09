Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r39FHm7l006471
	for <selinux@tycho.nsa.gov>; Tue, 9 Apr 2013 11:17:48 -0400
From: Paul Moore <pmoore@redhat.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        mvadkert@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tcp: assign the sock correctly to an outgoing SYNACK packet
Date: Tue, 09 Apr 2013 11:17:41 -0400
Message-ID: <5235720.yJLYRg7eit@sifl>
In-Reply-To: <1365520026.3887.139.camel@edumazet-glaptop>
References: <3505145.vfXt1x4t0P@sifl> <7718638.lBZi8geXkP@sifl> <1365520026.3887.139.camel@edumazet-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 09, 2013 08:07:06 AM Eric Dumazet wrote:
> On Tue, 2013-04-09 at 10:52 -0400, Paul Moore wrote:
> > Perhaps I'm misunderstanding, but these comments above only apply if we
> > were to increase the size of the sk_buff struct, yes?  What I proposed,
> > replacing "secmark" with a blob, does not currently change the size of
> > the sk_buff struct so the performance and memory usage should remain
> > unchanged as well.
>
> If blob size is 4 bytes, thats fine.
> 
> If not, read again my mail.

The "blob" is a void pointer, so 8 bytes.  We're talking about removing the 
"secmark" field (4 bytes) and adding a void pointer (8 bytes).  I've shown 
several different approaches that make this change without increasing the 
overall size of the sk_buff struct.

One of the proposals makes use of the existing holes in the third cacheline to 
make the change without any increase in size, misalignment, or cacheline 
changes.  You were concerned that at some point in the future, the hardware 
encapsulation developers *might* want to add another field.

Taking your comments into consideration I just made another proposal which 
preserves the overall size of the sk_buff struct, as well as the 4 byte hole 
in the third cacheline (for possible use by hw encapsulation folks at some 
later date).  It does shift the "dma_cookie" field from the second to the 
third cacheline, but considering the fields already in the third cacheline 
this may be a good thing.

To the best of my knowledge, all of the proposals I've posted this morning do 
not change the size of the sk_buff so the cloned sk_buff 
functionality/performance/etc. should not be affected.  If that is not the 
case, please let me know because I'm currently at a loss (even after re-
reading your email).

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
