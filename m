Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA15453
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 10:09:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA01743
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 14:07:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA01734 for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 14:07:24 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C523992469
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 00:08:56 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id C47FD125E
	for <selinux@tycho.nsa.gov>; Fri,  9 Aug 2002 16:08:48 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy_scan.l
Date: Fri, 9 Aug 2002 16:08:48 +0200
MIME-Version: 1.0
Message-Id: <20020809140848.C47FD125E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch got into my tree somehow, I think it's due to a 
difference between a quick "this should fix it" email from Steve and the 
corresponding fix that was committed into the CVS.

Steve, if this is good then could you please update the CVS, if not then 
please let me know and I'll remove it from my tree.

--- selinux-small-2002070313.orig/module/checkpolicy/policy_scan.l
+++ selinux-small-2002070313/module/checkpolicy/policy_scan.l
@@ -130,7 +130,7 @@
 T1                             { return(T1); }
 t2 |
 T2                             { return(T2); }
-"/"({letter}|{digit}|_|"."|"/")*       { return(PATH); }
+"/"({letter}|{digit}|_|"."|"-"|"/")*   { return(PATH); }
 {letter}({letter}|{digit}|_)*  { return(IDENTIFIER); }
 {digit}{digit}*                 { return(NUMBER); }
 #[^\n]*                         { /* delete comments */ }

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
