Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA23469
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 17:23:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA17151
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 21:21:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA17147
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 21:21:52 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C466192466
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 07:22:56 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 143608CE4
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 23:22:54 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SRCINSTALLDIR
Date: Sat, 24 Aug 2002 19:44:16 +0200
MIME-Version: 1.0
Message-Id: <20020824212254.143608CE4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The operation of policy/Makefile in the new release does not include the 
policy version number in the source, and thus is based on the assumption that 
a policy.conf file will support multiple versions of the policydb.

This assumption does not hold for past versions, is there any reason that we 
can be sure it will hold for future versions?  If not then I suggest that the 
right thing to do is to have a version number in the policy.conf file name 
(maybe policy.conf.11 or whatever the version is)?

Or do we consider it OK to have a source directory that doesn't contain the 
sources to all the binaries in the binary directory?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
