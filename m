Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2CLNvRb004175
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 16:23:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2CLNu0F007023
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 21:23:56 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i2CLNugZ007003 for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 21:23:56 GMT
Subject: Re: policy booleans
From: Karl MacMillan <kmacmillan@tresys.com>
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200403040226.55513.russell@coker.com.au>
References: <200403040226.55513.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1079126613.8603.22.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 16:23:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-03 at 10:26, Russell Coker wrote:
> Would it be possible for booleans to apply to things other than allow 
> statements?
> 
> I would like to have booleans determining which domains are allowed in a role, 
> and which role transitions are permitted.

[This is an old message - I realized that I never replied]

This would certainly be possible and I think that this would be a useful
extension to the conditional policy work, but it wasn't part of our
original design spec (especially since role transitions were still
deprecated at that point). It is possible that we will find time to do
this in the next few months, but I can't commit to anything. I think
that Steve was also considering taking this on, but I'll let him reply
if he has any specific plans to implement this.

Thanks,

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
