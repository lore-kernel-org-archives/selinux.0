Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA09197
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 17:10:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA02244
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 22:08:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA02235
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 22:08:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 12D5992454
	for <selinux@tycho.nsa.gov>; Fri,  8 Mar 2002 09:09:49 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id EA8AD22B27
	for <selinux@tycho.nsa.gov>; Thu,  7 Mar 2002 23:09:37 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: security_context_to_sid
Date: Thu, 7 Mar 2002 18:51:37 +0100
MIME-Version: 1.0
Message-Id: <20020307220937.EA8AD22B27@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The man page for security_context_to_sid() documents the second parameter as 
being of type "__u32 *scontext_len" when it is really "__u32 scontext_len".

Also could the type of the first parameter be changed to "const 
security_context_t"?  The kernel and library code is not writing to the data 
that is pointed to, and from the design of it I don't think it ever will.  I 
would like this (and other similar functions) to use const wherever possible 
so that I can use const in my code, and the code that calls my code, etc.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
