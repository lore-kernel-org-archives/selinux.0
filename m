Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i09BKbRb029059
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 06:20:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i09BJXxr015298
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 11:19:33 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i09BJSYc015282
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 11:19:32 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 34F8261B06
	for <selinux@tycho.nsa.gov>; Fri,  9 Jan 2004 22:19:04 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 09048-07 for <selinux@tycho.nsa.gov>;
	Fri, 9 Jan 2004 22:19:03 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id DA94761B05
	for <selinux@tycho.nsa.gov>; Fri,  9 Jan 2004 22:19:03 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CB763924F5
	for <selinux@tycho.nsa.gov>; Fri,  9 Jan 2004 22:19:02 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1546EB59C0
	for <selinux@tycho.nsa.gov>; Fri,  9 Jan 2004 22:18:49 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: aliases
Date: Fri, 9 Jan 2004 22:18:47 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401092218.47912.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe that we need a minor change in the policy language to deal with 
aliases.

The current setup requires that all aliases be specified on the type 
declaration line.  One significant problem with this is that if a type is 
declared by a macro there is no way to add aliases to it.  Because of this we 
have at various times had aliases specified in macros when they weren't 
needed for 95% of the cases.

I believe that a declaration of the form is necessary:
typealias foo_t aliases { bar_t baz_t };

That would mean that I could do:

var_run_domain(foo)
typealias foo_var_run_t alias var_run_foo_t;

Instead of having the current alias in the var_run_domain() macro.  Of course 
it's no big deal for the var_run_domain() macro (and I'll remove the alias 
from my tree because it's been there too long anyway).  But there are other 
situations which are more difficult to manage (such as renaming netscape to 
mozilla).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
