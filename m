Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13109
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 16:17:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA11988
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 20:15:50 GMT
Received: from mail.lemuria.org ([213.191.74.130])
	by jazzswing.ncsc.mil  with ESMTP id UAA11980
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 20:15:49 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id 0D0AABB8B
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 22:11:08 +0200 (CEST)
Date: Fri, 19 Apr 2002 22:14:55 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy "bloat" ?
Message-ID: <20020419221455.B12025@lemuria.org>
References: <20020419185507.B11916@lemuria.org> <20020419201154.4F75844F1A@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020419201154.4F75844F1A@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 19, 2002 at 10:11:53PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 19, 2002 at 10:11:53PM +0200, Russell Coker wrote:
> Good plan.  Take what you need from the sample policy and dump the rest.

doing that. I've removed about a third of the files from
domains/program.


> > If so, would it make sense to include a 2nd, "minimal" example policy?
> 
> It does not make sense to have another policy which is the same thing but 
> with a few files removed.

Removing is some work, so I thought for people who'd rather build their
policy from the ground up, a minimal config may be a better starting
place. Just an idea.


> PS  Today I released a new version of my Debian packages.

You are evil. That means I have to update again on monday. :)


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
