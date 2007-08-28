Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SI2MGH026685
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 14:02:22 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SI2KFZ020393
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 18:02:21 GMT
Message-ID: <D709A20F2164C84E8B7014B0301F5EF852144C@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Darrel Goeddel <sedgoeddel@gmail.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris
	 <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 14:02:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I am assuming that the *_socket checks used by netlabel would be 
> checking against the new peer label that is in (at least 
> near) the skb, 
> is that right?  If so, the *_socket checks also take care of the peer 
> label coming from loopback.  This would be a bit of a policy change 

I doubt it since NetLabel currently already uses the xfrm label,
if available, as the base sid.

> since the *_socket checks now apply to domains (not just the 
> base type 
> from the initial sid) since the loopback traffic goes through 
> the same 
> checks.  I at least hope we don't add another, separate, 
> check for the 
> loopback case...
> 
> That was just one idea, but I definitely think the 
> unification should be 
> a goal of this exercise.
> 
> -- 
> 
> Darrel
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
