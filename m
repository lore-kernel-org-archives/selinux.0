Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m519jUvM012009
	for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2008 05:45:30 -0400
Received: from ladon.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m519jTYo023391
	for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2008 09:45:29 GMT
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: Recent problems recompiling libsemanage with new libustr (1.0.4)
In-Reply-To: <874p8dy1se.fsf@anzu.internal.golden-gryphon.com>
References: <1212028257.5316.7.camel@defiant.pebenito.net>
References: <874p8dy1se.fsf@anzu.internal.golden-gryphon.com>
Date: Sun, 01 Jun 2008 04:34:19 -0500
Message-ID: <87wsl9wlb8.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        I should know better to send out such mails at 4am. Mea culpa. I
 had forgotten to remove th -z defs from the loader command line; since
 failing to do so on Debian result sin th failure you saw before.

        Sorry for all the noise.

        manoj
-- 
You know you are getting old when you think you should drive the speed
limit. E.A. Gilliam
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
