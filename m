Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0SD1KDu029808
	for <selinux@tycho.nsa.gov>; Sat, 28 Jan 2012 08:01:21 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0SD1IUt018506
	for <selinux@tycho.nsa.gov>; Sat, 28 Jan 2012 13:01:19 GMT
Received: from xev.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EE577180ED
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2012 00:01:03 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: restorecon -R default
Date: Sun, 29 Jan 2012 00:01:10 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201201290001.10792.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.youtube.com/watch?v=ZThVfm3JXdM

A few years ago Paul Wayper gave an excellent introductory lecture about SE 
Linux (see the above URL).  He notes that he habitually uses -R for restorecon 
every time.

It seems to me that the case where -R is not desired will be extremely rare.  
It seems most uncommon that someone will have a directory with the wrong 
label, a subdirectory tree that is either too big to scan quickly (and which 
is known to have the correct labels) or which has labels which by design don't 
match the file contexts.

Therefore I think we should make the common case be the default and require 
that anyone who doesn't want that functionality specifically request it.  
chcon uses the -h flag for changing the context of a sym-link instead of the 
target, that might be a reasonable option to use for consistency.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
