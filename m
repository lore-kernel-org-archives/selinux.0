Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ONxmsJ021412
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 19:59:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ONw4Zt012239
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 23:58:04 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h8ONw0M3012236
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 23:58:00 GMT
Date: Thu, 25 Sep 2003 10:00:45 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: "Inger, Slav (S.B.)" <vinger@ford.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Sample SELinux policy that's equivalent to standard root?
Message-ID: <20030925000045.GB14203@snoopy.apana.org.au>
References: <F5441DDE18FFD9418974338018C522B718BDAB@na1fcm61.dearborn.ford.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F5441DDE18FFD9418974338018C522B718BDAB@na1fcm61.dearborn.ford.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 23, 2003 at 05:16:27PM -0400, Inger, Slav (S.B.) wrote:
> I hope this is the right mailing list to ask this question.  Here's my
> setup:  a freshly compiled Linux 2.6.0-test3-selinux1, using a default
> policy supplied in selinux-usr/policy.  What I would like to do is,
> instead of starting with the most restrictive mode and easing my way
> to less restrictive, I'd like to start with a relaxed root access
> policy (i.e. start with root as "God" even in enforced mode, as is the
> case with standard Linux) and tighten up from there.  So my question
> is, does anyone know where I could get the configs for a policy with
> root rights equivalent to that on a standard Linux system?  TIA.

Essientially the simplist and least restrictive policy would be:

- all process run with the one domain
- all files, sockets, have the one type
- this one domain is allowed full access to this one type with
any operation.

Yes, this would be simple, but I don't think it is what you want.

I think you would end up "reinventing the wheel" and creating a
policy very similar to Russell's.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
