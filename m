Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5EDlcrT018271
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 09:47:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5EDlW0G004715
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 13:47:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5E4FE61C9C
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 23:47:28 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16573-06 for <selinux@tycho.nsa.gov>;
	Mon, 14 Jun 2004 23:47:28 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EECF761C7F
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 23:47:27 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 85213B57DB
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 23:47:20 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: apache tunables
Date: Mon, 14 Jun 2004 23:47:19 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200406142347.19825.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that the following are good candidates for Apache tunables:

Whether to have system cgi-bin scripts.

Whether to have user cgi-bin scripts.

Whether to have user cgi-bin script read access to regular files in user home 
directory.

Whether to have user cgi-bin script read/write access to regular files in user 
home directory.

Whether to allow httpd_t and cgi-bin scripts to connect to databases and LDAP 
servers (for both PHP and cgi-bin access).  Should we have one tunable for 
everything or one for each database?  One for everything is a lot easier to 
manage as we don't want to ask 1000 questions of the user.

Maybe allow some of these cgi-bin options on a per-user basis, EG allow 
httpd_dba_script_t access to databases but not httpd_user_script_t.  This 
will require more fancy M4 programming.

A more controversial issue is whether user cgi-bin script runs as user_t (or 
whichever userdomain is appropriate) instead of a special script domain, not 
something we really want to support, but the users will be happy.  NB for the 
targetted policy, if we have Apache as a target then user cgi-bin scripts 
would be run as unconfined_t if this option is selected.  :(

A bad option that we need to have is to run system cgi-bin scripts as sysadm_t 
or unconfined_t.


Are there any other possible tunables I missed?


Anther Apache related issue is testing of cgi-bin scripts, what domain should 
we run them in for testing?  Currently we default to having a 
domain_auto_trans() rule to run the script in the same domain regardless of 
whether it's started by the user or by Apache.  The problem is that when 
started by the user it can't access a pty device (otherwise the script when 
started by Apache could use character stuffing to take over a live user 
session if the script is buggy).  /dev/tty access is allowed but the script 
would need stdin/stdout/stderr redirected to that (and I'm not sure it's safe 
when /dev/tty maps to the /dev/pty entry for a live user session).  Maybe the 
correct solution to this is to have a program similar in concept to run_init 
for testing user cgi-bin scripts.  If it allowed simulating the Apache 
environment (passing parameters etc) then it could be well accepted by the 
users.  There's probably some program out there which does everything that's 
needed apart from the SE Linux stuff which can be modified to do what we want 
(using /dev/tty is not the right thing for a cgi-bin script to do anyway).

Finally there's the issue of non-sysadm administration of daemons.  I have 
been talking about doing this for quite a long time, and Apache might be a 
good first test case.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
