Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r39DXI53028213
	for <selinux@tycho.nsa.gov>; Tue, 9 Apr 2013 09:33:18 -0400
From: Paul Moore <pmoore@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org, mvadkert@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tcp: assign the sock correctly to an outgoing SYNACK packet
Date: Tue, 09 Apr 2013 09:33:12 -0400
Message-ID: <2395284.jDbTT1hSWe@sifl>
In-Reply-To: <28452040.xEi3pLPik0@sifl>
References: <3505145.vfXt1x4t0P@sifl> <51636DEB.5000308@schaufler-ca.com> <28452040.xEi3pLPik0@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 09, 2013 09:19:30 AM Paul Moore wrote:
> On Monday, April 08, 2013 06:24:59 PM Casey Schaufler wrote:
> > On 4/8/2013 6:09 PM, Eric Dumazet wrote:
> > > On Mon, 2013-04-08 at 17:59 -0700, Casey Schaufler wrote:
> > >> I don't see that with adding 4 bytes. Again, I'm willing to be
> > >> educated if I'm wrong.
> > > 
> > > Feel free to add 4 bytes without having the 'align to 8 bytes' problem
> > > on 64 bit arches. Show us your patch.
> > 
> > Recall that it's replacing an existing 4 byte value with an 8 byte value.
> > My compiler days were quite short and long ago, but it would seem that
> > an 8 byte value ought not have an 'align to 8 bytes' problem.
> > 
> > Again, I'm willing to be educated.
> 
> Armed with a cup of coffee I took a look at the sk_buff structure this
> morning with the pahole tool and using the current sk_buff if we turn on
> all the #ifdefs here is what I see on x86_64:
> 
> struct sk_buff {

...

>         /* size: 280, cachelines: 5, members: 62 */
>         /* sum members: 270, holes: 3, sum holes: 10 */
>         /* bit holes: 1, sum bit holes: 6 bits */
>         /* last cacheline: 24 bytes */
> };
> 
> It looks like there some holes we might be able to capitalize on.  If we
> remove "secmark" (we can handle it inside a security blob) and move
> "protocol" to after the flags2 bit field we can make an aligned 8 byte hold
> for a security blob before "destructor".  According to pahole the structure
> size stays the same and the only field which moves to a different cacheline
> is "dma_cookie" which moves from cacheline 2 to 3.  Here is the pahole
> output:
> 
> struct sk_buff_test {

...

>         /* size: 280, cachelines: 5, members: 62 */
>         /* sum members: 274, holes: 3, sum holes: 6 */
>         /* bit holes: 1, sum bit holes: 6 bits */
>         /* last cacheline: 24 bytes */
> };
> 
> As Casey already mentioned, if this isn't acceptable please help me
> understand why.

For the sake of completeness I also checked out the changes when compiled for 
32 bit and it was very much the same; same structure size and in the 32 bit 
case no field movement from one cacheline to another.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
