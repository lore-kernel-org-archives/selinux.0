Message-ID: <46BB9B79.2070602@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 18:55:53 -0400 
MIME-Version: 1.0
in-reply-to: <200708091053.33776.paul.moore@hp.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Thursday 09 August 2007 10:09:14 am Darrel Goeddel wrote:
>> Because of the position I am in (needing to find something workable for
>> actual
>> users), I have been trying to get my head aounrd the state of SELinux
>> networking,
>> the ideas that have been talked about in the past, and how we can prevent
>> the
>> SELinux networking infrastructure from resembling a Rube-Goldberg
machine.
>> I'll
>> be presenting some of the problems I perceive along with some very high
>> level
>> ideas early next week.
> 
> Such a tease! ;)

Here's a general high-level idea.  Remember that this is in no way a
proposal
(yet) because I'm not even sure if it makes sense.  It is a very simple
idea,
but it should prove to be flexible enough to handle everything.  I make no
claims as to its workability, or it implementability given the fact that we
should offer some kind of backwards compatibility.  I think this would be
something that one might come up with if they were starting from scratch (I
seriously doubt that the current mechanisms would ever come out of an
intentional up-front design).  It is just a vision of my perfect scenario
(perfect until I figure out that it doesn't do what I need it to do)...
Please try to look at this from a clean slate as well as a retrofit
point-of-view.

picture here: http://home.insightbb.com/~dgoeddel/networking/simple.png
(when commenting, please refrain from belittling my artistic skills)

The high level ideas are (I'll be using sid and context interchangeably,
but I think we can all figure that one out):

- The secmark (lowercase, denoting the secmark field in the skb) will
  always contain the peer's context.  The secmark will begin life as the
  unlabeled sid - we don't know who we are dealing with yet.  If the
  SECMARK (uppercase denoting the SECMARK iptables module) facility find
  a match for the skb, we will replace the secmark with the context
  specified by the matching rule - this is the fallback label, our best
  guess as to who we are dealing with.  In the event of the peer supplying
  context information (complete context via ipsec, mls level via cipso,
  or type information via carrier pigeon), the peer supplied context
  information will be evaluated and verified for some sort of consistency
  if there is more than one source of information.  If the context created
  with consideration of all peer supplied info checks out, that will then
  replace the current secmark value.  That's it for secmark - we now have
  the best idea of who the peer really is in there.

- OK, one more bit about what is in secmark.  For locally generated
  traffic, it is the domain of the process, err... socket.  Still the
  peer context, just from a real reliable source.

- The secmark, and nothing else, will be used for all flow control checks
  as well as the access check at consumption (process reading from the
  socket).  This means that policy represents who we can talk to, not
  what association we can use, or what socket we can recvfrom, or what
  internal label we can read from.  Yes, secmark does it all - yeah :)

- A new SECFILTER iptables module is in place to perform flow control
  checks.  Just as we have used the expressiveness (either fine grained
  or coarse grained - your choice) of iptables to define fallback labels
  for packets based on their attributes, we want to be able to define
  access check based on those attributes.  It is here where we can say
  that only http_client_t can get to port 80 on this machine, or that
  only a secret packet can leave the machine through the eth1 device.
  The SECFILTER mechanism will be able to distinguish controls for
  incoming, outgoing, and forwarded traffic.  In the absence of a
  matching "target context" from SECFILTER, the secmark will be checked
  against the unlabeled context (no SECFILTER - no label).  

- Since the secmark for locally generated traffic is the context of
  the sender and that is preserved as the packet gets bounced back up
  to the local peer, we have labeled localhost.  We can even put flow
  control checks on that to boot!

- getpeeron() will return the value of secmark.  This will be the same
  context that was actually used by the access check and it is the same
  context that considered locally defined fallbacks as well as peer
  supplied information.

so, I think these ideas would:
- provide flow control
- enable loopback labeling
- provide one label instead of three possibly conflicting labels for an
  skb
- streamline, simplify, make sense of access checks regarding skbs
- simplify understanding of what the skb context is - the peer's context
- enable a more reliable, safe, and informative getpeercon result


I'm not sure that any of these ideas are particularly new, but I'm
hoping that this particular combination of previously presented ideas
makes a bit of sense.  I'm sure that I will get tons of useful commentary
to incorporate, and I thank you in advance :)  That's why I wanted to
toss something out there now.

I'm off for a weekend trip, so please don't feel that I am ignoring all
of the scathing criticisms that will be coming tomorrow...  I'll ignore
all of that next week when I return ;)

We'll be working through some prototypes to make sure that the ideas
that we present are at least somewhat feasible - unlike the blue sky
idea presented here (although that'll get prototyped to see if it is
workable - I hope it is).

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
