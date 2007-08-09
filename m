From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 18:35:06 -0400
Cc: selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20070807141415.525577324@hp.com> <200708091048.41932.paul.moore@hp.com> <1186675306.6916.564.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1186675306.6916.564.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708091835.06746.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 9 2007 12:01:46 pm Stephen Smalley wrote:
> On Thu, 2007-08-09 at 10:48 -0400, Paul Moore wrote:
> > On Thursday 09 August 2007 9:54:23 am Stephen Smalley wrote:
> > > On Thu, 2007-08-09 at 09:29 -0400, Paul Moore wrote:
> > If we adopt the revised SECMARK/iptables method then this is no
> > guaranteed to be the case.  With the added flexibility/granularity of
> > iptables we could arrive in a situation where a single IP address/host
> > could take on multiple different labels based on the type of connection. 
> > Maybe this is what you want, but it is a departure from what we do today
> > as well as what I've heard has been done in the past.  Then again, just
> > because we've always done it this way doesn't mean it's the best
> > solution.
>
> My preference would be to have it assigned a single default/fallback
> label based on iptables, and then overridden after a permission check if
> labeled networking is in use.  No other mutations.
>
> > > >  * Convert the external labeling protocols to make use of the SECMARK
> > > > secid field in the sk_buff struct.  The advantage to NetLabel and
> > > > explicit labeling protocols is really marginal but this should be a
> > > > huge win for labeled IPsec.
> > >
> > > I'm not so sure it is so marginal for netlabel - being able to use a
> > > field from the skb (once initially set for the packet) instead of
> > > inspecting the payload should be a win.
> > >
> > >From a functionality standpoint it is marginal for explicitly labeled
> > > packets
> >
> > because you already have the label as part of the packet's
> > header/payload; that is what I was referring to.  I agree there are some
> > obvious performance advantages if you have to look at the label twice.
>
> Propagation/preservation of the label throughout also gets simpler and
> more reliable, and possibly goes beyond what you can do today.

Um, okay ... what are you trying to sell me here ;)  I never said this 
particular point is good/bad, just that I don't see this single point as 
reason enough to go through with the changes you are proposing (from a 
NetLabel point of view).

> How do you deal with ICMP replies currently?

For CIPSO they are labeled based on the packet which caused the ICMP message 
to be generated as dictated by the draft.

> > > > As you stated above, there are some obvious advantages here including
> > > > "free" loopback labeling, easier implementation of general iptables
> > > > forwarding controls in the future, as well as some general
> > > > implementation cleanups in the existing code.  If we did decide to go
> > > > this route, I think I would prefer to keep a fallback/static labeling
> > > > mechanism similar to what is being done in this patchset, with the
> > > > obvious change being made to utilize the new SECMARK secid value. 
> > > > We've seen all of the issues that come to light when we start to make
> > > > use of iptables to set labels on packets and not all of them have
> > > > elegant solutions; one could even argue this is one of the reasons
> > > > SECMARK as an internal label has failed to achieve much use.
> > >
> > > You'll have to elaborate on that one; defining an iptables rule to
> > > apply a fallback label seems much more general and expressive than the
> > > netlabelctl approach.
> >
> > See my comments above about the difference in getpeercon() behavior. 
> > There are also implementation issues regarding the use of iptables, the
> > "flush all" case being a good example.  Yes, there have been solutions
> > tossed around but nothing concrete.  There is also the ongoing debate
> > about how to properly generate iptables rules in policy, without a good
> > solution here anything we do that uses iptables to label packets is going
> > to have a hard time getting adopted by users.
>
> We don't generate netlabelctl configuration or ipsec configuration from
> policy, so this isn't really different.  Ultimately, you'd have some
> front-end tool that lets you configure labeled networking, including
> selection of mechanism (NetLabel/CIPSO or NetLabel/other or labeled
> IPSEC), selection of appropriate settings for that mechanism, and
> fallbacks (via secmark).

Doesn't this hit at some of the same arguments you had against this patchset 
regarding configuration at the start of this thread.

> Separate table would likely be useful.

Yes, probably even a requirement to help preserve the sanity of the admins.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
