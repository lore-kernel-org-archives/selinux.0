Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA00168
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 19:09:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA02501
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 23:08:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA02497
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 23:08:40 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A1E2F92466
	for <selinux@tycho.nsa.gov>; Sat, 17 Aug 2002 09:09:39 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id DFD12A19
	for <selinux@tycho.nsa.gov>; Sat, 17 Aug 2002 01:09:31 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: shadow_t
Date: Sat, 17 Aug 2002 01:09:31 +0200
MIME-Version: 1.0
Message-Id: <20020816230931.DFD12A19@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've got shadow_t working correctly with my policy.

I have changed the spasswd.c program to relabel the /etc/passwd and 
/etc/shadow files after running /usr/bin/passwd, and I made a 
file_type_auto_trans() rule to have them default to shadow_t (which 
unfortunately gives a momentary situation where /etc/passwd will be 
unreadable).  It would also be unfortunate if there was a power outage at 
that moment...

So I'm thinking of having a program run from a boot script to fix the type of 
/etc/passwd.

Also I've got vipw and adduser also working with shadow_t...

This isn't ideal, but the code for the chsh/chfn/vipw/etc programs is really 
ugly and I'm afraid of causing more problems than I fix if I change them.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
