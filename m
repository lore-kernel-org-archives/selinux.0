Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA18612
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 18:24:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA06246
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 23:23:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA06242
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 23:23:17 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4CC7092452
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 10:24:37 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id C7B9E22AE8
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 00:24:28 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: multiple programs with the same file (sendmail)
Date: Tue, 26 Mar 2002 00:24:28 +0100
MIME-Version: 1.0
Message-Id: <20020325232428.C7B9E22AE8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What should we do when several programs may provide the same file?

The best example of this is /usr/sbin/sendmail which is provided by most 
(all?) mail servers (including of course sendmail).

For sendmail it needs to be in a domain that can do virtually everything.  
For postfix it just talks to other postfix processes and needs little 
permissions, for other mail servers the needs may vary.

We could have a sendmail_exec_t and then have different .te files define 
different permissions related to it which makes things good for 
file_contexts, but will give undesired results if you have the configuration 
for multiple mail servers in the domains/program directory.

Having different configlets for file_contexts (in the way it will be done in 
the next version) makes it feasible to change the type of the file and leave 
the policy files for multiple mail servers in place.

Which is the "right" way to do this?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
