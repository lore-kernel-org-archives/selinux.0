Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3KCrvRb013090
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 08:53:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3KCrumw014868
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 12:53:56 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i3KCrt4w014673 for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2004 12:53:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Peter Gervai <grin@tolna.net>
Subject: Re: exim4 policy
Date: Tue, 20 Apr 2004 22:52:31 +1000
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <20040420105900.GS7634@narya.grin.hu>
In-Reply-To: <20040420105900.GS7634@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404202252.31448.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Apr 2004 20:59, Peter Gervai <grin@tolna.net> wrote:
> Is there a working exim4 policy somewhere? It was posted on the list, got
> some comments, and the thread seem to have died away. It seem not to be a
> part of the distribution.

For the most desirable support of Exim we need some minor changes to the way 
it works.  I have spoken to the author about this and he has a positive 
attitude towards this, all that is necessary is for me (or someone else) to 
write some patches, test them, and send them to him.

Once we get Exim working the way we desire doing the policy will be easy.

What we want is to have different parts of Exim running in different domains.  
Exim is comprised of a single program that performs multiple tasks, but it 
re-exec's itself for each task.  I think that the best way to do this is to 
have (for non-SE systems) multiple hard links to the main executable and have 
it use different names for each exec call.  This just takes up a few extra 
directory entries on a non-SE system and has no noticeable overhead.

For a SE system we could have small wrapper programs (a few K in size - they 
would provide little overhead) that just exec the main executable.  So when a 
new Exim task is launched it would exec the appropriate name which would 
trigger a domain transition, that new domain would then execute the main 
program to do the work.

This way Exim itself need know nothing about SE Linux, but we can get all the 
functionality we want.

I believe that this would probably be acceptable to the author.  In a month or 
so I may have time to code this.  If someone else makes an appropriate patch 
to Exim I'll write the SE Linux policy immediately.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
