Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4H0KtpO027772
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 20:20:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 40mX5d0Cp5z62qT
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 00:20:53 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 40mX5c3VWRz62qK
 for <selinux@tycho.nsa.gov>; Thu, 17 May 2018 00:20:52 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id n18-v6so6059462lfh.10
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 17:20:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <77dbe49f-b0fc-5b58-f8c2-a87db6b00ebc@schaufler-ca.com>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <523afc0b-5bfc-8b95-05ee-450679254a47@tycho.nsa.gov>
 <5716ab22-4d3c-1935-41f1-ba848570ccab@tycho.nsa.gov>
 <eab001ca-10ff-1cfe-9436-805840628784@schaufler-ca.com>
 <5db90fec-7640-73d5-2e96-b4c996b7ae8d@tycho.nsa.gov>
 <ad30d628-ed11-2dd6-6782-3089bf733702@schaufler-ca.com>
 <alpine.LRH.2.21.1805160747300.8368@namei.org>
 <77dbe49f-b0fc-5b58-f8c2-a87db6b00ebc@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 16 May 2018 20:19:49 -0400
Message-ID: <CAHC9VhT9JcADHexQq3qkEZ6JfkPwyw8tD3mD6JUFbwKN+w10=A@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 00/23] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 16, 2018 at 1:42 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 5/15/2018 2:49 PM, James Morris wrote:
>> On Tue, 15 May 2018, Casey Schaufler wrote:
>>
>>> Both SELinux and Smack use netlbl_sock_setattr() in their socket_post_create()
>>> hooks to establish the CIPSO to use if nothing else interferes. An unfortunate
>>> artifact of the Smack "ambient label" implementation is that the default
>>> configuration is going to delete the netlbl attribute for the floor ("_")
>>> label. This will conflict with any value that SELinux sets. :( Smack clearly
>>> needs to have it's use of netlabel revised, and that is work that's going on
>>> in parallel with stacking. That, however, is not an infrastructure issue, it's
>>> an issue with how the two modules use the facilities.
>> Can this kind of problem be prevented at the API level?  i.e. ensure you
>> can't accidentally conflict with another LSM's use of the label here?
>
> What we're seeing isn't an accidental conflict. SELinux and Smack
> use netlabel differently. SELinux uses netlabel the way it and the
> way CIPSO intended, to mark the MLS levels and categories on a
> packet. Smack (ab)uses netlabel to put the Smack label directly on
> the packet. In most cases a SELinux system won't be sending a CIPSO
> header at all, because it won't be using MLS. A Smack system, on
> the other hand, sends a CIPSO header unless the label is the
> "ambient" label. Further, the label transitions for a process using
> both SELinux and Smack will be different. Two system services may
> have different SELinux contexts but the same Smack label.

Also, to clarify things a bit for those who haven't dug too deeply
into the per-packet bits, the label match/conflict is not done using
the individual LSM labels, that would be impossible, it is done using
the netlbl_lsm_secattr values.  The netlbl_lsm_secattr "label" was
always intended to be both LSM and protocol agnostic so it lends
itself better for this type of comparison.

At least that is what Casey and I discussed.  I haven't had a chance
to look at the most recent patches in-depth.

[ASIDE: I was just digging through the patches to look for some of the
networking changes and it appears there is confusion around SELinux's
use of secmark and the NetLabel/IPsec "peer" labels.  As an example,
the term "secmark" should never appear in cipso_ipv4.c; the secmark
labels are completely independent to the peer labels.]

[ASIDE #2: Are you ever comparing the packet labels for
domains/sockets which are setup for destination specific labeling
(NetLabel's "address selector" feature)?  I'm probably missing it, but
I don't see it in the patches.]

> The Smack code clearly needs to be revised. It does a horrible job
> on single-level hosts. It works, but does not take advantage of the
> netlabel facilities well. The ambient label processing is pretty
> kludgey. If the Smack use of netlabel were more in line with the
> SELinux model I expect there would be more cases where they work
> together. But even in the best case, it's going to take some real
> configuration wizardry to get a lot of agreement on packet labeling.

The answer may be to do the label comparison farther down the stack.
What does it matter if the LSMs don't agree on their network labels so
long as the outgoing packets would be labeled the same?  In the
default SELinux and Smack configurations both send unlabeled traffic
(Smack would be using the ambient label by default, yes?) so if we ask
NetLabel to compare the on-wire label vs the LSM label, or the
netlbl_lsm_secattr label, it *should* be okay.

Incoming packets, even labeled ones, *should* work just fine so long
as the NetLabel caching mechanism is avoided (although you *really*
want to use the caching mechanism).  It should be easy enough to add
multiple LSM support to NetLabel's caching mechanism to fix this.

We get a pass on labeled IPsec because it is only used by SELinux.
Thank goodness.  That's a feature that should fade away.

> I'm not saying that API level changes wouldn't be welcome. I would
> be happier if the networking code called security hooks like the
> other subsystems do. I also understand that there are critical
> performance issues that drove the existing implementation, and that
> a call to security_label_packet() in the IP stack could be a hard
> sell.

Honestly, after my last round with the netdev folks, the issue isn't
so much the hooks themselves, but rather the sk_buff and their
insistence on not giving us any more than 32-bits.  Even trading
32-bits for 64 was a no-go despite multiple different alignment
attempts.  It's unfortunate because independent of stacking there are
several use cases we handle poorly today because of this (anyone
looked at packet forwarding for labeled traffic?  have you looked at
forwarding labeled traffic across different protocols?).

Having thought about this on and off for several years now, I think
the only realistic solution may be to repurpose the secmark field as
an index into a larger label store where we can store a more
traditional security blob (stacked or otherwise).  I hold out some
hope that we might be able to do something with skb_shared_info; it's
common across cloned packets, but I don't think that would be a
problem for us.  We might even be able to strike a bargain with the
netdev folks: "I'll trade you 32-bits in sk_buff for a pointer in
skb_shared_info along with the necessary lifecycle hooks." ... fair
warning, that last bit is speculation on my part; I'm guessing they
are slightly (so very slightly) less picky about skb_shared_info but
there is a good chance I'm wrong about that.

-- 
paul moore
www.paul-moore.com
