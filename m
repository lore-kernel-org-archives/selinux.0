Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2TDlVRb002802
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 08:47:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2TDjc66022917
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 13:45:38 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i2TDjKhu022800
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 13:45:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 4AE6061B17
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 23:45:47 +1000 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06380-09 for <selinux@tycho.nsa.gov>;
	Mon, 29 Mar 2004 23:45:46 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id A2ADA61BBE
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 23:45:46 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 246AB2F581
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 23:45:45 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: killall
Date: Tue, 30 Mar 2004 00:45:44 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403292345.44629.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am thinking of extending the SE Linux functionality of killall.  One 
significant feature that it lacks at the moment is to kill all processes of a 
specified context.

The current SE Linux functionality of killall is the ability to kill all 
processes of a specified name with a particular context.  So I can kill every 
copy of "bash" with context "root:user_r:user_t" and avoid killing bash 
scripts run by daemons and shells of administrators.  But I can't kill every 
process run by "root:user_r:user_t" regardless of what they are doing.

I plan to change killall so that you can just run "killall -Z context" to kill 
all processes in a particular context regardless of executable.  Also I am 
thinking of making it possible to specify just an identity or a role.  So I 
could kill all user_r processes, or all process from a particular user 
identity.

Is there any other SE Linux functionality that I should consider at the same 
time?  I think I may have to mostly re-write killall so now is the best time 
to add features.

Also if you have any other ideas for features in killall please let me know.  
It will be a lot easier to implement them now than at any other time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
