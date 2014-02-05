Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s15Gg46C017901
 for <selinux@tycho.nsa.gov>; Wed, 5 Feb 2014 11:42:04 -0500
Received: by mail-wg0-f44.google.com with SMTP id l18so474924wgh.35
 for <selinux@tycho.nsa.gov>; Wed, 05 Feb 2014 08:41:40 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Eric Paris <eparis@parisplace.org>
Subject: Re: SELinux question..
Date: Wed, 05 Feb 2014 11:41:37 -0500
Message-ID: <1513250.uFBmouNNKi@sifl>
In-Reply-To: <CACLa4pvZXRBSOXGnvcfnMWc-ZxcFwZQDjy7gfSDKWCeXiNCJxQ@mail.gmail.com>
References: <CA+55aFyaBZsF7u+Ka=0PRXQyF-vPyejgysoLsPAZdyf6Qn1KdA@mail.gmail.com>
 <52F17412.3010105@schaufler-ca.com>
 <CACLa4pvZXRBSOXGnvcfnMWc-ZxcFwZQDjy7gfSDKWCeXiNCJxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: James Morris <james.l.morris@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LSM List <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

[NOTE: also CC'd the SELinux list]

On Wednesday, February 05, 2014 07:52:50 AM Eric Paris wrote:
> So Casey's comments don't actually make any sense to me at all.  The
> AVC is just a cache of previous results of policy lookups.  The policy
> is fscking huge and looking up a permission takes forever.  that's a
> given, not much we can do about that part.

I didn't quite follow Casey's comments entirely either; the SELinux AVC is a 
different topic than the "secid vs blob" discussion.  As Eric already 
mentioned, the [un]availability of security blobs isn't what is requiring the 
use of the AVC, but rather the size/complexity of the policy.

> Now how well SELinux caches those results can certainly possibly be looked
> at....
> 
> I certainly have no objection to using a u64 for ssid and tsid.
> 
> Paul Moore and I sorta talked and debated about pushing tclass into the
> same u64.  tclass can easily fit in 8 bits (we could fit in 7, but
> that doesn't really do anything).

While I'm a bit nervous about shrinking the SID size, I'm not as nervous about 
shrinking the object class (tclass) size as as look at the current Fedora 
policy shows 83 classes which leaves us quite a bit of headroom.  Also, for 
those who may not be SELinux savvy, object classes are not subject to the 
MCS/MLS expansion/explosion that Stephen mentioned (256 seems "ok" to me).

> So
> 
> struct ssid_tsid_tclass {
>       u64 ssid:28, tsid:28, tclass:8;
> );
> 
> It's clearly doable, and we won't *cough* have any trouble today.
> Sids are created sequentially.  You get one sid per unique context.
> It's 'possible' to already overrid the u32 (and you'll start getting
> ENOMEM to all sorts of things if you do)

Just to be clear on this since I think something may have been lost in 
translation ... It is not possible to *overflow* the SID counter as you will 
start getting ENOMEM and Bad Things will likely happen.  It is also not 
possible to reclaim/revoke SID values as it is very difficult (possible?) to 
ensure the represented subject/object is 100% gone from the system; if you 
reclaim a SID value and the original subject/object still exists you will have 
effectively, and silently, relabeled them (changed their security properties) 
which is another Very Bad Thing. 

> ... Paul is particularly worried that when/if we run up on the new 268M
> unique sids (2^28) someday, years down the line ...

We have already seen things that have caused the policy to grow the numbers of 
labels: increasing MLS/MCS categories and sVirt category combinations moving 
from two to three categories.  It doesn't seem that silly to think that this 
will continue to be a trend; people almost always want more capability and 
they almost always want it sooner than I think.

FWIW, currently available SELinux policies, with a limit of 1024 categories, 
already have the ability to exhaust the 32-bit SID limit.

> ... you/users/people are going to scream and scream when we want those
> couple of bits back.  We'd need to remove tclass from the u64.  Personally
> I'm ok with that.  I'd rather not pay a performance penalty today for what
> we think will be a problem someday down the road...

I suppose it all boils down to how important you feel those last four bits are 
in the SID.  Eric doesn't think they will really be needed in the foreseeable 
future, but as for myself, I think we very well might need them and as a 
result I'm very hesitant to shrink the SID space. 

> Maybe I can try to prototype something.  What patch did you use?  What
> type of performance gains were you able to note?  How did you get your
> perf data?

I'm curious too, especially about these comments:

  "I actually improved code generation on x86-64 noticeably by encoding
   the ssid+tsid in one 64-bit register, which lowers register pressure
   (no frame accesses in avc_has_perm_noaudit()) and makes the avc lookup
   more efficient.

It sounds like at the very least we can do some work to combine the ssid and 
tsid values into a single u64 which would have some benefits without any of 
the too-small-SID-space concerns.  Can you share the perf numbers and the 
patch you used?

-Paul

> On Tue, Feb 4, 2014 at 6:13 PM, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> > On 2/4/2014 2:37 PM, Linus Torvalds wrote:
> >> I'm looking at profiles once more, and (once more) being annoying by
> >> SELinux overheads..
> >> 
> >> One thing strikes me: does the ssid/tsid space need to be a full 32
> >> bit? Right now the indexing is done by <ssid,tsid,tclass>, and that's
> >> a <u32,u32,u16> tuple..
> >> 
> >> I actually improved code generation on x86-64 noticeably by encoding
> >> the ssid+tsid in one 64-bit register, which lowers register pressure
> >> (no frame accesses in avc_has_perm_noaudit()) and makes the avc lookup
> >> more efficient. But it would be even better if the whole tuple could
> >> be encoded that way, ie the 'struct avc_entry' could have just one
> >> 64-bit field that contains <ssid,tsid,tclass>.
> >> 
> >> It could easily be a structure with basically arbitrary bit boundaries,
> >> so
> >> 
> >>    struct ssid_tsid_tclass {
> >>    
> >>       u64 ssid:24, tsid:24, tclass:16;
> >>    
> >>    );
> >> 
> >> would work fine. Or 25/25/14. Or whatever. The high bits of ssid/tsid
> >> don't *seem* to be used in normal setups, but I don't actually know
> >> what the rules are for these things. Do they need to be the full 32
> >> bits? Does tclass need to be 16 bits? Is there some 64-bit packing
> >> that could work?
> >> 
> >> (Ok, so the big cost is actually all the cache misses in avc_lookup(),
> >> and it would be a really big deal if there was some way to perhaps
> >> short-circuit that entirely for the case of "user does directory
> >> lookup permission check for a directory inode". If somebody has a way
> >> to do *that* with SELinux, that would be lovely)
> > 
> > There is no reason that SELinux couldn't use security blob
> > pointers for filesystem objects and tasks instead of avc lookups.
> > The only places that really need secids are in networking code
> > where security has been begrudgenly granted 32 bits and admonished
> > never to come asking for more. If a pointer were available instead
> > (and Paul Moore has proposed more than one way to do that, at least
> > one of which provided superior cache performance over the existing
> > code) the avc could go away altogether.
> > 
> > There are reasons that some developers like the avc mechanism.
> > I will leave the arguments in its favor to them.


-- 
paul moore
www.paul-moore.com
