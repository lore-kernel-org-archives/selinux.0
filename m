Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14343
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 09:36:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA18611
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:34:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA18607 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:34:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: success story
Date: Wed, 28 Aug 2002 15:35:57 +0200
References: <20020828145606.A4758@lemuria.org>
In-Reply-To: <20020828145606.A4758@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020828133557.831BC8FDA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 14:56, Tom wrote:
> thanks to the incredible work done by everyone involved, especially
> russel coker, I've been able to run avc_toggle for the first time ever
> without making the system come to a screetching halt. even better, sshd
> and apache continued to run just fine (postfix and proftpd didn't, but
> hey, I need something to do tomorrow, too :) ).

Please try my latest policy on http://www.coker.com.au/selinux/policy.tgz 
which will be in my next Debian package.  It has some changes to the Postfix 
policy that might address your problems.  As for proftpd, it should work 
already, please send me the errors off-list.

Also when installing the new policy you'll have to relabel the root file 
system and reboot, the changes are significant.

> I've had a bunch of cron errors, and a few other messages, so I've
> rebooted back into permissive mode to fix this first. should I post the
> audit messages I received here, or somewhere else? this is a woody
> system with russel's packages and policy, but maybe other people are
> interested in the results, too?

I think that I'm the only person who's interested in seeing error messages 
resulting from my policy, especially from the previous version which was 
quite different from the NSA release.  My next version will be very close to 
the CVS tree on Sourceforce when it's released, and I hope that at the time 
of the next NSA release my tree will not have any significant differences 
from the NSA tree.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
