Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TNSXrT019906
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 19:28:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TNSUjQ002934
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 23:28:30 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 357DB61AF3
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 09:28:31 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06498-07 for <selinux@tycho.nsa.gov>;
	Thu, 30 Sep 2004 09:28:30 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C1A4961AEF
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 09:28:30 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 2E573B58B1
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 09:28:29 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: apol suggestions
Date: Thu, 30 Sep 2004 09:28:28 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409300928.28618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just done a search to discover what can get read or write access 
to /etc/shadow.  For such a search it would be good if I didn't have to click 
on each of create read write setattr relabelfrom, etc.  I would like to have 
groupings of access such as the following:

read_group: read ioctl relabelfrom execute execute_no_trans

write_group: write append create relabelfrom relabelto ioctl link rename 
setattr unlink

Note that I didn't put getattr in the read group because often getattr access 
is granted just to quiet ls or to satisfy other checks when no other read 
access is granted.  We can't rely on people selecting 10 items correctly from 
a list if performing repetitive operations.

Also is a batch interface to apol planned?  I would like to have 
#!/usr/sbin/apol at the start of scripts...


My search of shadow_t access showed that there are 12 domains granted access 
directly and 9 granted through posession of the "auth" attribute.  Even when 
two lists are so small it's difficult to determine which entries overlap 
(especially when they can't both be fully displayed on the screen at the same 
time).  If the "Type Enforcement Rules Display" box could be made to fill the 
entire screen then it would be a little easier for some analysis tasks.  Also 
if there was some way of displaying the domains that can do the access 
through the auth attribute as well as through direct policy rules in the one 
list then it would solve this entire problem for me.

Another thing, the "Type Enforcement Rules Display" box is sorted by line 
number in policy.conf.  This is usually OK as we try to group things in the 
policy source.  But it would be nice if we could change the ordering to sort 
by source domain or target domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
