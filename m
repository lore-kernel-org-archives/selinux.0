Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA21422
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 23:57:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA20449
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 03:55:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id DAA20445 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 03:55:36 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id D6D8392462
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 13:57:02 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 9C3EA2805
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 05:56:55 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: home directory mangling
Date: Fri, 12 Jul 2002 05:56:55 +0200
MIME-Version: 1.0
Message-Id: <20020712035655.9C3EA2805@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm currently experimenting with a policy for user_home_dir_t for the main 
home directory for the user (with a transition to user_home_t) when they 
create new files or dirs.  Then I have given ssh a transition rule for using 
it's own type for ~/.ssh, so I allow sshd { search getattr } access to the 
user's home dir and read access to ~/.ssh.  This may make it slightly harder 
to extract some confidential info with a cracked sshd, and prevents some 
other programs that have access to the user's files from accessing ~/.ssh.

It's on http://www.coker.com.au/selinux/policy.tgz , please check it out and 
tell me what you think.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
