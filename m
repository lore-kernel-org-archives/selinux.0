From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <sedgoeddel@gmail.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 15:36:18 -0400
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521408@HAVOC.tcs-sec.com> <46D45DB9.2040003@gmail.com>
In-Reply-To: <46D45DB9.2040003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281536.18358.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 28 2007 1:39:05 pm Darrel Goeddel wrote:
> Venkat Yekkirala wrote:
> >> -----Original Message-----
> >> From: Paul Moore [mailto:paul.moore@hp.com]
> >>
> >> I agree that having a default, flow control "catch
> >> all"/unlabeled_t check is a
> >> good idea and preserved the SELinux philosophy but doing so
> >> without breaking
> >> the flow of packets in/out/through a system with old policy
> >> is not an easy
> >> task.  At some point in the future, if we want to reconcile
> >> all of the peer
> >> label access checks to a single object class, we'll probably
> >> need to do
> >> something similar to the compat_net (compat_net_peer?) flag.
> >
> > We could actually do this as part of this, correct (unless I
> > missed any one's objections elsewhere).
>
> I agree  - bring it on.  We're unifying the on-the-wire labeling
> mechanism by making sure that they agree if more than one is use.  That
> is a good start.  I'd really like to continue on here and get the
> unified access check so we don't have to do netlabel style and labeled
> ipsec style peer access checks.

Me too.  I was originally talking about the possibility of finding a clever 
backwards compatible way to do flow control, however, I'm not sure it's worth 
the work and we should just include all of the flow control and revised peer 
label access checks into one patchset that makes use of compat_net_peer.

> The target context for both the 
> association checks and the *_socket (netlabel) checks will be the same.
>   Why not just drop the association checks since the *idea* is now
> covered in the *_socket checks?

I agree, the association checks made sense at one point, they don't anymore.  
However, we should probably run this by the policy guys (are any of you 
listening to this thread?) before we get to far - I can't imagine they would 
object.

> I am assuming that the *_socket checks used by netlabel would be
> checking against the new peer label that is in (at least near) the skb,
> is that right?  If so, the *_socket checks also take care of the peer
> label coming from loopback.  This would be a bit of a policy change
> since the *_socket checks now apply to domains (not just the base type
> from the initial sid) since the loopback traffic goes through the same
> checks.  I at least hope we don't add another, separate, check for the
> loopback case...
>
> That was just one idea, but I definitely think the unification should be
> a goal of this exercise.

My goal is that for packets being locally consumed we have _one_ access check 
(not including flow controls checks or netfilter label checks) which would be 
similar to the following:

 allow socket_t peer_label_t:peer recv;

Regardless of how the peer label was provided (labeled IPsec, remote CIPSO 
host, fallback peer label, loopback, etc.)  The advantages to doing this are 
many and I'm struggling to find a drawback.

Also, as an added bonus, if we manage to pull this off, I think we should be 
able to successfully solve that nagging world peace problem ;)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
