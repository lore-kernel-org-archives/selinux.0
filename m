Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA18199
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 08:12:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA07175
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 12:11:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA07171 for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 12:11:35 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EF55D92452
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 22:12:49 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 237B6655
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 14:12:43 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: 2 checkpolicy bugs
Date: Fri, 24 May 2002 13:09:18 +0200
MIME-Version: 1.0
Message-Id: <20020524121244.237B6655@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I don't assign SIDs to any TCP or UDP ports then I get the following 
checkpolicy error:

error in the statement ending on line 31779 (token 'system_u'): parse error

Line 31779 is the following:
lo system_u:object_r:netif_lo_t system_u:object_r:netmsg_lo_t

I consider that there are two bugs in checkpolicy, firstly it doesn't accept 
a valid configuration with no special SIDs assigned to any TCP or UDP ports.  
Secondly it doesn't give me an error message that is any good to inform me of 
this matter.

Currently to work around this matter I've assigned a type for port 1 (tcpmux) 
which is never used.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
