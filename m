Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SHdF2B024059
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 13:39:15 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SHd9FZ014800
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 17:39:09 GMT
Received: by wr-out-0506.google.com with SMTP id c8so1184226wra
        for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 10:39:09 -0700 (PDT)
Message-ID: <46D45DB9.2040003@gmail.com>
Date: Tue, 28 Aug 2007 12:39:05 -0500
From: Darrel Goeddel <sedgoeddel@gmail.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <D709A20F2164C84E8B7014B0301F5EF8521408@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521408@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>> -----Original Message-----
>> From: Paul Moore [mailto:paul.moore@hp.com]
 >>
>> I agree that having a default, flow control "catch 
>> all"/unlabeled_t check is a 
>> good idea and preserved the SELinux philosophy but doing so 
>> without breaking 
>> the flow of packets in/out/through a system with old policy 
>> is not an easy 
>> task.  At some point in the future, if we want to reconcile 
>> all of the peer 
>> label access checks to a single object class, we'll probably 
>> need to do 
>> something similar to the compat_net (compat_net_peer?) flag.  
> 
> We could actually do this as part of this, correct (unless I
> missed any one's objections elsewhere).

I agree  - bring it on.  We're unifying the on-the-wire labeling 
mechanism by making sure that they agree if more than one is use.  That 
is a good start.  I'd really like to continue on here and get the 
unified access check so we don't have to do netlabel style and labeled 
ipsec style peer access checks.  The target context for both the 
association checks and the *_socket (netlabel) checks will be the same. 
  Why not just drop the association checks since the *idea* is now 
covered in the *_socket checks?

I am assuming that the *_socket checks used by netlabel would be 
checking against the new peer label that is in (at least near) the skb, 
is that right?  If so, the *_socket checks also take care of the peer 
label coming from loopback.  This would be a bit of a policy change 
since the *_socket checks now apply to domains (not just the base type 
from the initial sid) since the loopback traffic goes through the same 
checks.  I at least hope we don't add another, separate, check for the 
loopback case...

That was just one idea, but I definitely think the unification should be 
a goal of this exercise.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
