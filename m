From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 10:48:41 -0400
Cc: selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070807141415.525577324@hp.com> <200708090929.16906.paul.moore@hp.com> <1186667663.6916.464.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1186667663.6916.464.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708091048.41932.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 09 August 2007 9:54:23 am Stephen Smalley wrote:
> On Thu, 2007-08-09 at 09:29 -0400, Paul Moore wrote:
> > On Thursday 09 August 2007 8:42:43 am Stephen Smalley wrote:
> > I'm also a little confused about your concern over this new feature being
> > NetLabel-centric?  I guess I don't understand how that is a problem,
> > further explanation might help ...
>
> We want a fallback mechanism that is agnostic to the labeled networking
> mechanism.  netlabel may be a "framework" but only for a particular
> subset of such mechanisms, i.e. explicit packet labeling.  Putting
> functionality into it that should also apply to xfrm labeling is wrong.

I guess this is always going to be a bit of a religious argument then, as I 
tend to think of this feature as a static external label and implementing 
this feature as part of an existing external labeling system/framework makes 
the most sense to me.  Regardless, it's probably best to focus on the other 
issues in this thread, namely what to do with SECMARK, first as that will 
have a huge impact on this topic.

> > I understand your concern regarding the additional configuration.  While
> > netlabelctl and netlabel_tools are not new, they may be new to users who
> > want to make use of this new feature.  On an older thread Josh and I had
> > a bit of a discussion regarding this and while we never really arrived at
> > a magic solution we did talk about integrating some, or all, of the
> > netlabelctl functionality into semanage.  This wouldn't be that difficult
> > as most of the "intelligence" in netlabelctl is already in a separate
> > library; adding that library to semanage should not be that difficult. 
> > Would that help ease your configuration concerns?
>
> I don't care what we call the userland tool; it is still using
> netlabel-specific interfaces and infrastructure.

> And re-inventing the secmark wheel.

Well, only if you redefine SECMARK to a greater scope that what it is used for 
today.  Granted, both this new static/fallback label feature use IP header 
information to derive a packet label but that's about the only similarity I 
see here.  If we do decide to redefine SECMARK then you'll be correct, no 
need for this patchset.

> > > The only reason to not use secmark today for a fallback mechanism is
> > > the current separation between 'internal' and 'external' labels.  But I
> > > don't believe that separation is necessary or useful, and secmark today
> > > is effectively unused.  The original usage scenario for it simply
> > > hasn't materialized.
> > >
> > > Meanwhile, getting secmark employed, not only as a mechanism for
> > > assigning default labels (via iptables rules) but also as a seamless
> > > way of propagating labels with socket buffers would solve a lot of our
> > > current limitations.  We'd get loopback labeling for free, flexible and
> > > generic fallback labeling, forwarding controls would become
> > > straightforward, and PEERSEC/SCM_SECURITY becomes much simpler.
> > > NetLabel would benefit from it as well.  There are alternative
> > > implementation approaches, but none as clean and efficient and
> > > reliable. There was a reason we put a sid in the sk_buff in the
> > > original SELinux implementations (prior to Linux 2.6 merge).
> > >
> > > I've had some initial discussions with James, and he seemed open to
> > > revisiting this notion, so I think we need to take another look.
> >
> > I still think merging the two types of packet labels, "internal"
> > and "external" is a mistake; I stated my reasoning a few times before so
> > I will save people following this thread from reading it again.
>
> No one is using the "internal" labels AFAIK, and conceptually, I don't
> see a security goal that you would enforce that way that isn't more
> cleanly expressed (and more useful) in terms of "external" label.

Okay, so let's get rid of the "internal" label.

> > However, I agree that packet labeling is in a "weird" state right now and
> > there is a lot of room for improvement.  Bearing in mind your comments
> > that SECMARK is effectively unused due to lack of demand and that having
> > two types of packet labels is not helpful I wonder if the following would
> > a worthwhile effort:
> >
> >  * Do away with internal label concept completely, but leave the SECMARK
> >    secid field in the sk_buff struct.  This includes removing the SECMARK
> >    related MAC checks on incoming traffic, whether we bring back
> > compat_net or not is not important.
>
> Agree with the first part, but not the second.  The secmark packet
> checks are actually what we want, with some modification.  IOW, we want
> a unified set of checks independent of labeled networking mechanism so
> that we can have coherent policy.

Looking again at what I typed, I realized I worded it very poorly.  What I 
mean was that we should remove the iptables/SECMARK hooks so that the 
iptables bits no longer set the label of a packet, i.e. remove the internal 
labeling as we know it today.

> And while we do away with any 
> separate notion of "internal" vs "external", we'd still use iptables
> secmark rules to define and apply the fallback labels - that is more
> expressive and generic than your approach.

My main concern with this goes back to the failed secid-reconciliation 
efforts; the key problem here has to do with the behavior of getpeercon().  
As it stands right now, in the case of of a UNIX domain socket we return the 
label of the domain on the other end, the same with network sockets.  The 
current proposed static/fallback mechanism is intentionally coarse grained 
with the granularity limit being a single IP address/host.  My reasoning 
being that if the other host is not able or willing to send labeled traffic 
we should treat it as a single label host.  This seems to mesh well with what 
has been done in the past.

If we adopt the revised SECMARK/iptables method then this is no guaranteed to 
be the case.  With the added flexibility/granularity of iptables we could 
arrive in a situation where a single IP address/host could take on multiple 
different labels based on the type of connection.  Maybe this is what you 
want, but it is a departure from what we do today as well as what I've heard 
has been done in the past.  Then again, just because we've always done it 
this way doesn't mean it's the best solution.

> >  * Convert the external labeling protocols to make use of the SECMARK
> > secid field in the sk_buff struct.  The advantage to NetLabel and
> > explicit labeling protocols is really marginal but this should be a huge
> > win for labeled IPsec.
>
> I'm not so sure it is so marginal for netlabel - being able to use a
> field from the skb (once initially set for the packet) instead of
> inspecting the payload should be a win.

>From a functionality standpoint it is marginal for explicitly labeled packets 
because you already have the label as part of the packet's header/payload; 
that is what I was referring to.  I agree there are some obvious performance 
advantages if you have to look at the label twice.

> > As you stated above, there are some obvious advantages here including
> > "free" loopback labeling, easier implementation of general iptables
> > forwarding controls in the future, as well as some general implementation
> > cleanups in the existing code.  If we did decide to go this route, I
> > think I would prefer to keep a fallback/static labeling mechanism similar
> > to what is being done in this patchset, with the obvious change being
> > made to utilize the new SECMARK secid value.  We've seen all of the
> > issues that come to light when we start to make use of iptables to set
> > labels on packets and not all of them have elegant solutions; one could
> > even argue this is one of the reasons SECMARK as an internal label has
> > failed to achieve much use.
>
> You'll have to elaborate on that one; defining an iptables rule to apply
> a fallback label seems much more general and expressive than the
> netlabelctl approach.

See my comments above about the difference in getpeercon() behavior.  There 
are also implementation issues regarding the use of iptables, the "flush all" 
case being a good example.  Yes, there have been solutions tossed around but 
nothing concrete.  There is also the ongoing debate about how to properly 
generate iptables rules in policy, without a good solution here anything we 
do that uses iptables to label packets is going to have a hard time getting 
adopted by users.

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
