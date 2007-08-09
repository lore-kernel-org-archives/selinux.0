From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 16:17:52 -0400
Cc: Joe Nall <joe@nall.com>, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, Eric Paris <eparis@parisplace.org>
References: <46BB6F5F.3010202@trustedcs.com>
In-Reply-To: <46BB6F5F.3010202@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708091617.53465.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, August 9 2007 3:47:43 pm Darrel Goeddel wrote:
> Joe Nall wrote:
> > On Aug 9, 2007, at 11:42 AM, Darrel Goeddel wrote:
> >>  (why couldn't this have all waited a bit...)
> >
> > Paul is addressing a real need. Like many things that really need
> > doing and take time, multiple people are simultaneously working on it.
> >
> > I installed the netlabel patches and have tested them with good
> > results in MLS/permissive at a few levels (s0, s2:c0.c253,
> > s2:c0.c253). More testing to follow.
> >
> > netlabelctl unlbl add interface:eth0 address:10.211.55.8/32
> > label:user_u:object_r:user_t:s2:c0.c253
> >
> > /netlabelctl unlbl list
> > accept:on
> > interface:eth0,address:
> > 192.168.20.253/32,label:"user_u:object_r:user_t:s0"
> > interface:eth0,address:
> > 10.211.55.8/32,label:"user_u:object_r:user_t:s2:c0.c253"
> >
> > getpeercon() returned 'user_u:object_r:user_t:C O N F I D E N T I A L'
> >
> > for a connection from 10.211.55.8.
> >
> > This is a big improvement in linux labeled networking functionality.
>
> As described in an earlier email, from my not-yet-full grasp on the patch,
> this is a vulnerability waiting to happen in the event of using netlabel
> fallback contexts alongside labeled ipsec.  That is not an improvement.
> If there were consistency checks between the various forms of external
> labels, this would not be an issue and the functionality would indeed
> be an improvement.  Again, I do not have a test case, but Paul's response
> to my query about getpeercon returning a netlabel modified version of
> the xfrm label seemed to validate my concern.

This is more of a general issue between NetLabel and labeled IPsec, it is not 
specific to the fallback approach.  For better or worse, this particular 
problem is not new.

If the powers that be decide to redefine SECMARK and move forward with that 
approach then we can fix the issue with the new design.  If we want to fix it 
in the status quo we could probably do something like this ... (simple patch 
to describe a basic fix to the problem, not necessarily complete or even 
compile tested).

Index: linux-2.6_extlbl-fix/security/selinux/hooks.c
===================================================================
--- linux-2.6_extlbl-fix.orig/security/selinux/hooks.c
+++ linux-2.6_extlbl-fix/security/selinux/hooks.c
@@ -3152,7 +3152,14 @@ static void selinux_skb_extlbl_sid(struc
                                          SECINITSID_NETMSG : xfrm_sid),
                                         &nlbl_sid) != 0)
                nlbl_sid = SECSID_NULL;
-       *sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
+
+       if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL &&
+           nlbl_sid != xfrm_sid)
+               *sid = SECSID_NULL;
+       else if (nlbl_sid != SECSID_NULL)
+               *sid = nlbl_sid;
+       else
+               *sid = xfrm_sid;
 }

It's likely we would want/need a bit more, but I don't believe it's a 
difficult problem to fix with the current approach.  In fact, regardless of 
what we chose to do in the future, unless we can do it probably is a good 
idea to fix in in the current design as well.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
