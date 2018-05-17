Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H15mYn031413
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 21:05:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID06.oob.disa.mil (Postfix) with SMTP id 40mY5Q2mVGz2DblY
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:05:46 +0000 (UTC)
Received: from USFB3CPA04_EEMSG_MP26.eemsg.mil (unknown [192.168.16.21])
 by USFBF3ID06.oob.disa.mil (Postfix) with ESMTP id 40mY5P6WFZz2DblW
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 01:05:45 +0000 (UTC)
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <523afc0b-5bfc-8b95-05ee-450679254a47@tycho.nsa.gov>
 <5716ab22-4d3c-1935-41f1-ba848570ccab@tycho.nsa.gov>
 <eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
 <5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
 <ad30d628-ed11-2dd6-6782-3089bf733702@schaufler-ca.com>
 <alpine.LRH.2.21.1805160747300.8368@namei.org>
 <77dbe49f-b0fc-5b58-f8c2-a87db6b00ebc@schaufler-ca.com>
 <CAHC9VhT9JcADHexQq3qkEZ6JfkPwyw8tD3mD6JUFbwKN+w10=A@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2d45fbe7-ed2b-8e84-39cc-27b94ac0a33c@schaufler-ca.com>
Date: Wed, 16 May 2018 18:05:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT9JcADHexQq3qkEZ6JfkPwyw8tD3mD6JUFbwKN+w10=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/16/2018 5:19 PM, Paul Moore wrote:
> On Wed, May 16, 2018 at 1:42 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/15/2018 2:49 PM, James Morris wrote:
>>> On Tue, 15 May 2018, Casey Schaufler wrote:
>>>
>>>> Both SELinux and Smack use netlbl_sock_setattr() in their socket_post_create()
>>>> hooks to establish the CIPSO to use if nothing else interferes. An unfortunate
>>>> artifact of the Smack "ambient label" implementation is that the default
>>>> configuration is going to delete the netlbl attribute for the floor ("_")
>>>> label. This will conflict with any value that SELinux sets. :( Smack clearly
>>>> needs to have it's use of netlabel revised, and that is work that's going on
>>>> in parallel with stacking. That, however, is not an infrastructure issue, it's
>>>> an issue with how the two modules use the facilities.
>>> Can this kind of problem be prevented at the API level?  i.e. ensure you
>>> can't accidentally conflict with another LSM's use of the label here?
>> What we're seeing isn't an accidental conflict. SELinux and Smack
>> use netlabel differently. SELinux uses netlabel the way it and the
>> way CIPSO intended, to mark the MLS levels and categories on a
>> packet. Smack (ab)uses netlabel to put the Smack label directly on
>> the packet. In most cases a SELinux system won't be sending a CIPSO
>> header at all, because it won't be using MLS. A Smack system, on
>> the other hand, sends a CIPSO header unless the label is the
>> "ambient" label. Further, the label transitions for a process using
>> both SELinux and Smack will be different. Two system services may
>> have different SELinux contexts but the same Smack label.
> Also, to clarify things a bit for those who haven't dug too deeply
> into the per-packet bits, the label match/conflict is not done using
> the individual LSM labels, that would be impossible, it is done using
> the netlbl_lsm_secattr values.  The netlbl_lsm_secattr "label" was
> always intended to be both LSM and protocol agnostic so it lends
> itself better for this type of comparison.

Paul is correct. What goes into the netlbl_ls_secattr *is* comparable
across modules, and that's what this patch set uses.

> At least that is what Casey and I discussed.  I haven't had a chance
> to look at the most recent patches in-depth.
>
> [ASIDE: I was just digging through the patches to look for some of the
> networking changes and it appears there is confusion around SELinux's
> use of secmark and the NetLabel/IPsec "peer" labels.  As an example,
> the term "secmark" should never appear in cipso_ipv4.c; the secmark
> labels are completely independent to the peer labels.]

... And in the end it doesn't. There is an intermediate patch that
uses the secids.secmark, but at that point it's a union. It could
just as well use secids.smack or secids.selinux.

> [ASIDE #2: Are you ever comparing the packet labels for
> domains/sockets which are setup for destination specific labeling
> (NetLabel's "address selector" feature)?  I'm probably missing it, but
> I don't see it in the patches.]

Smack doesn't use the address selector properly, and hence
the situation will never arise. When I do get a fix in for Smack
to use address selectors properly I plan to address that case.
It is more likely to result in a useful system than the current code.

>> The Smack code clearly needs to be revised. It does a horrible job
>> on single-level hosts. It works, but does not take advantage of the
>> netlabel facilities well. The ambient label processing is pretty
>> kludgey. If the Smack use of netlabel were more in line with the
>> SELinux model I expect there would be more cases where they work
>> together. But even in the best case, it's going to take some real
>> configuration wizardry to get a lot of agreement on packet labeling.
> The answer may be to do the label comparison farther down the stack.

That would require storing multiple netlbl_ls_secattr in sockets, on
interfaces, etc. I'm not saying that would necessarily be bad, but I
expect some people would be concerned.

> What does it matter if the LSMs don't agree on their network labels so
> long as the outgoing packets would be labeled the same?

I agree. The trick is holding onto enough information to make the call.
The netlabel code is currently set up to squirrel away the option header
so that it can be snapped up and used when the packet is being put together.
With multiple sources of possible options, creating the option header has
to be deferred until packet assembly time. That is going to have
performance impact and require some significant data and code change.
Not impossible, but harder to justify for the somewhat obscure use case.

> In the
> default SELinux and Smack configurations both send unlabeled traffic
> (Smack would be using the ambient label by default, yes?) so if we ask
> NetLabel to compare the on-wire label vs the LSM label, or the
> netlbl_lsm_secattr label, it *should* be okay.

The comparison has to happen when we know about whether the label is
coming from the socket, the interface or the host. Or, as it's done now,
when the socket is created. It's really all about managing multiple
netlbl_ls_secattr values, which the existing netlabel code isn't set
up for. Doable, I expect. 

> Incoming packets, even labeled ones, *should* work just fine so long
> as the NetLabel caching mechanism is avoided (although you *really*
> want to use the caching mechanism).  It should be easy enough to add
> multiple LSM support to NetLabel's caching mechanism to fix this.

Yes, I expect you're right.

> We get a pass on labeled IPsec because it is only used by SELinux.
> Thank goodness.  That's a feature that should fade away.

Agreed!

>> I'm not saying that API level changes wouldn't be welcome. I would
>> be happier if the networking code called security hooks like the
>> other subsystems do. I also understand that there are critical
>> performance issues that drove the existing implementation, and that
>> a call to security_label_packet() in the IP stack could be a hard
>> sell.
> Honestly, after my last round with the netdev folks, the issue isn't
> so much the hooks themselves, but rather the sk_buff and their
> insistence on not giving us any more than 32-bits.  

Yes. My attempts to stuff multiple secids into a single u32 have
taught me much.

> Even trading
> 32-bits for 64 was a no-go despite multiple different alignment
> attempts.  It's unfortunate because independent of stacking there are
> several use cases we handle poorly today because of this (anyone
> looked at packet forwarding for labeled traffic?  have you looked at
> forwarding labeled traffic across different protocols?).

I confess to having fallen short of these important issues.

> Having thought about this on and off for several years now, I think
> the only realistic solution may be to repurpose the secmark field as
> an index into a larger label store where we can store a more
> traditional security blob (stacked or otherwise).  

I would of course defer to those wiser and/or more clever than I,
but all my attempts to do this have ended in tears. There are too
many places where you have to allocate a new association where you
either shouldn't or just can't.

> I hold out some
> hope that we might be able to do something with skb_shared_info; it's
> common across cloned packets, but I don't think that would be a
> problem for us.  We might even be able to strike a bargain with the
> netdev folks: "I'll trade you 32-bits in sk_buff for a pointer in
> skb_shared_info along with the necessary lifecycle hooks." ... fair
> warning, that last bit is speculation on my part; I'm guessing they
> are slightly (so very slightly) less picky about skb_shared_info but
> there is a good chance I'm wrong about that.

We can hope. I have tried to err on the side of "don't piss off dev-net".
On the side of "don't piss off Paul Moore", too.

I am of course willing to consider changes that will improve the way
modules can cooperate with using netlabel. I don't see that what I've
presented is the way it'll end up. I hope I've demonstrated that it's
neither being ignored nor impossible.
