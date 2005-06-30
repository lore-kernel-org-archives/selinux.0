Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U0vQgA018245
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 20:57:27 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U0trdE015151
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 00:55:54 GMT
Date: Thu, 30 Jun 2005 02:05:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ron Kuris <rk@unify.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, gyurdiev@redhat.com,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
Message-ID: <20050630010526.GE8415@lkcl.net>
References: <20050629165658.82487.qmail@web31609.mail.mud.yahoo.com> <42C2DC80.8070904@unify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42C2DC80.8070904@unify.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 10:38:08AM -0700, Ron Kuris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Casey Schaufler wrote:
> 
> | I say amen to points 1-3. I add ...
> |
> | 4) A derived policy set will only tell you what the programs do,
> | not what they are intended to do. Should I leave doors unlocked
> | because burglers attempt to use them? If no burgler tries my door
> | for a year does that mean having a lock on my door is unnecessary?
> 
> I think the logic here is backwards.  

 yep.  selinux is "MAC".

> a year, then that door is a candidate for becoming a wall instead of a
> door.  Otherwise, you end up in a maze of twisty passages, where
> nobody knows what doors are needed and why.  Fewer doors means less
> memory also, which can be important for embedded systems.
> 
> I think this wish-list item doesn't tell you what you can remove from
> a policy.  However, it might tell you which rules are candidates to be
> changed to a "deny" rule (or lack of an "allow" rule really).  

 absolutely.

 that was the intent.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
