Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA13041
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 17:46:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA15890
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 22:45:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA15865 for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 22:45:53 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 334A692443
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 09:46:52 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id A12F922B0
	for <selinux@tycho.nsa.gov>; Mon, 18 Mar 2002 23:46:43 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: file_contexts
Date: Mon, 18 Mar 2002 23:46:43 +0100
MIME-Version: 1.0
Message-Id: <20020318224643.A12F922B0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently with the sample policy the type definition for all exec_t domains 
is in the files that define all policy for the program in question.

The setfiles program will abort if any type specified in file_contexts is not 
defined.

I think that the reasonable use of the sample domains/programs/*.te files is 
to remove the ones that don't apply to your system.

After removing unwanted *.te files and loading the policy I then can't run 
setfiles.

To solve this problem I am thinking of modifying the setfiles program to make 
it silently (unless in verbose mode) ignore any lines that refer to a type 
that's not in policy.  So for example if I remove the policy file for ppp 
then after running setfiles /usr/sbin/pppd will have sbin_t instead of 
pppd_exec_t.

What do you think?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
