Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h58BCII4010682
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 07:12:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h58BBRss017864
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 11:11:27 GMT
Received: from unicorn.lemuria.org (c145145.adsl.hansenet.de [213.39.145.145])
	by jazzswing.ncsc.mil  with ESMTP id h58BBQhY017861
	for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2003 11:11:26 GMT
Date: Sun, 8 Jun 2003 13:09:15 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: policy changes and versioning
Message-ID: <20030608130914.A19172@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've loaded Russell's new policy (June 6) to my notebook today, and
needless to say it breaks all sorts of stuff. I was expecting that, but
it nevertheless brought me to think about policy management.

I know many people here are working on policies. Carsten is doing SuSE
stuff, Russell, Brian and me work on Debian policies and the Gentoo
people do their own as well.

May I suggest that we set up a repository with proper version control
where we are able to work from a common trunk and branch only as far as
necessary, including the ability to feed back changes? Also, it might
be about time to set up a "stable" and an "unstable" branch.

I know that many changes get lost because they aren't submitted to the
right people, in the proper way, or whatever. I'm afraid we are wasting
a lot of work on policy changes due to inefficiency.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
