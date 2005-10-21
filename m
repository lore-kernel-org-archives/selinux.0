Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9L4GvNs009463
	for <selinux@tycho.nsa.gov>; Fri, 21 Oct 2005 00:16:57 -0400 (EDT)
Received: from mail21.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9L4DZ5h003463
	for <selinux@tycho.nsa.gov>; Fri, 21 Oct 2005 04:13:35 GMT
Date: Fri, 21 Oct 2005 00:13:56 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Russell Coker <russell@coker.com.au>
cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS context?
In-Reply-To: <200510211252.18124.russell@coker.com.au>
Message-ID: <Pine.LNX.4.63.0510210011040.4922@excalibur.intercode>
References: <200510152027.59150.russell@coker.com.au> <200510182133.56086.russell@coker.com.au>
 <1129731662.2375.164.camel@moss-spartans.epoch.ncsc.mil>
 <200510211252.18124.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Oct 2005, Russell Coker wrote:

> OK, it's a pity that we have the same character used for delimiting fields 
> within the identity:role:domain part and also for separating the level and 
> categories (with a possibility of two of them if we have categories in both 
> the low and high levels).

It's probably not entirely too late at this stage to change this to 
something like:

foo_u:foo_r:foo_t:s0+c0,c1-s1+c0,c1,c2



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
