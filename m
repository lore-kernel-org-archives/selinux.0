Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r39GBxDT010863
	for <selinux@tycho.nsa.gov>; Tue, 9 Apr 2013 12:11:59 -0400
Message-ID: <51643DCD.3000306@schaufler-ca.com>
Date: Tue, 09 Apr 2013 09:11:57 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: Paul Moore <pmoore@redhat.com>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org, mvadkert@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] tcp: assign the sock correctly to an outgoing SYNACK
 packet
References: <3505145.vfXt1x4t0P@sifl> <7718638.lBZi8geXkP@sifl>  <1365520026.3887.139.camel@edumazet-glaptop> <5235720.yJLYRg7eit@sifl> <1365521576.3887.147.camel@edumazet-glaptop>
In-Reply-To: <1365521576.3887.147.camel@edumazet-glaptop>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/9/2013 8:32 AM, Eric Dumazet wrote:
> On Tue, 2013-04-09 at 11:17 -0400, Paul Moore wrote:
>
>> The "blob" is a void pointer, so 8 bytes.  We're talking about removing the 
>> "secmark" field (4 bytes) and adding a void pointer (8 bytes).  I've shown 
>> several different approaches that make this change without increasing the 
>> overall size of the sk_buff struct.
> You want to use 4 extra bytes in sk_buff.

So far, so good.

> You'll have to show us why we
> close the way for other valid uses of the current holes.

We have what looks to us like a very legitimate
use for a 4 byte hole, we have that use defined,
and we have it today. In fact, we've had it for the
last five years. The 4 byte secmark (instead of an
8 byte blob pointer) has impacted design choices
since the LSM broke out of the SELinux monopoly.
Not having a blob *will* negatively impact the
forthcoming multiple concurrent LSM support. That
is not hypothetical, that is concrete and very
much a problem.

> I have no idea why its needed, and why it can't be solved in another
> way.

Ah, let's see if I can't help there.

We have two LSMs today and a third on the way that
potentially want to use the secmark. SELinux uses the
secmark, Smack may pick it up for IPv6 support in the
not to distant future, and AppArmor appears to be
considering it as well.

Each of these LSMs uses (or will use) a 4 byte secid
to represent the security information about a process
or other relevant entity. This is what gets put into
the secmark. The secid maps to the real security information.

If I have two LSMs, say SELinux and AppArmor, I have a
real problem. I have 8 bytes of data and a 4 byte
secmark. If I have SELinux, Smack and AppArmor I have
12 bytes to stuff into a 4 byte bag. To top it off,
these are already indirect references to the security
data, not pointers to the data. What I have to try to
do is fit 3 pointers into 4 bytes. Not good.

If we replace secmark with secblob, I don't have to
use the secid indirection if there is only one LSM.
If there are multiple LSMs the secblob contains a
pointer to a master blob, and it's still faster than
the secmark indirection.

The alternative is to restrict the use of secmarks to
one LSM and let all the others figure out some other
method for communicating the security information.
I don't see that as a great choice.

> It looks like _I_ have to do your work. Sorry, I have no more time to
> spend on this topic. You'll have to convince David, not me.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
