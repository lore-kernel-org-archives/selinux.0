Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA21945
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 12:27:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA26716
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 16:25:58 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA26712 for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 16:25:56 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: fingerd policy
Date: Sat, 10 Aug 2002 18:27:20 +0200
MIME-Version: 1.0
Message-Id: <20020810162721.5BD8850B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated my fingerd policy and put it on my web site in 
http://www.coker.com.au/selinux/policy.tgz .

It now works properly (unlike the previous policy).  Also I added a new type 
declaration for fingerd logs.  So if the fingerd wants to write to a log file 
in the user's home directory it can do so under a different type (and not 
have write access to the user's other files).

For ideal functionality we would have a different type for .plan etc to 
prevent fingerd from accessing other files.  However having such a type would 
be a real PITA for the user to manage, and I expect that most important files 
would be in subdirectories under the home directory (and therefore denied to 
fingerd_t because it can't search user_home_t:dir only user_home_dir_t:dir).

I still need to create a new type for ~/Maildir to allow fingerd to check for 
new mail, but that requires too many other changes, I'll do it later.  So 
I've put in an auditdeny rule to stop my logs filling up with messages about 
fingerd trying to check my mail.

That reminds me, I think that my cfingerd code for checking Maildir and 
.qmail files (as distributed in the standard Debian package) is buggy, 
someone should probably work on that...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
