Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA23917
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 06:43:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA03834
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 10:42:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA03830
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 10:42:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 323B792457
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 20:43:46 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id E156A2413
	for <selinux@tycho.nsa.gov>; Tue, 16 Apr 2002 12:43:38 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: idea for run_init
Date: Tue, 16 Apr 2002 12:43:38 +0200
MIME-Version: 1.0
Message-Id: <20020416104338.E156A2413@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently I have a need for run_init type functionality with three different 
SIDs for apt-get, dselect, and dpkg for Debian packaging.

I currently have my own program in my "selinux" Debian packages to change SID 
in addition to the regular run_init program.

My program expects it's argv[0] to be "se_%s" where the %s is the name of the 
program to run, then after authentication it will run the program %s with the 
SID expressed in /etc/security/%s_context.

So for example "se_apt-get install dpkg" will get the same result as
"apt-get install dpkg" would on a non-SE system, and it will be run under the 
SID specified in /etc/security/apt-get_context, which is 
system_u:system_r:apt_t.

What do you think of this so far?


I could merge the functionality of my program into run_init, is this a good 
idea?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
