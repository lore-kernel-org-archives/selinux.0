Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA24424
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 22:56:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA12243
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 02:55:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id CAA12239
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 02:55:50 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DFC5492466
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 12:56:48 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 364C683A
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 04:56:41 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /bin/login
Date: Fri, 16 Aug 2002 04:56:40 +0200
MIME-Version: 1.0
Message-Id: <20020816025641.364C683A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

During the login process we see the following prompts for a non-default 
security context.  Shouldn't the last prompt be "Enter domain" not
"Enter type"?

Do you want to enter a new security context?[n] y

        Enter role  (return for default) [sysadm_r] sysadm_r
        Enter type  (return for default) [sysadm_t]

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
