Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28803
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 10:12:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA02414
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 14:11:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA02405
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 14:11:01 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A8BAC92452
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 00:14:01 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id D30153D4A
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:12:55 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: dealing with file SIDs in packages
Date: Mon, 29 Apr 2002 16:12:55 +0200
MIME-Version: 1.0
Message-Id: <20020429141255.D30153D4A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In my Debian package "selinux" I have a sample policy for setfiles.  This 
causes setfiles to be run in a different domain with appropriate permissions 
to read every directory on the system and change the context of every file.

The initial problem I had was that replacing the "selinux" package would 
replace a copy of the file with a new copy in the default context (which 
didn't work).

So here is my solution:
I put the following code in the preinst script of "selinux":
if [ ! -f /usr/sbin/setfiles.old ]; then
  mv /usr/sbin/setfiles /usr/sbin/setfiles.old
fi

Then I put the following code in /etc/dpkg/postinst.d/selinux:

#!/bin/sh

SETFILES=/usr/sbin/setfiles
if [ -x /usr/sbin/setfiles.old ]; then
  SETFILES=/usr/sbin/setfiles.old
fi
dpkg -L $1 | grep ... | $SETFILES -s /etc/selinux/file_contexts/file_contexts
if [ -x /usr/sbin/setfiles.old -a "$1" = "selinux" ]; then
  rm /usr/sbin/setfiles.old
fi

The /etc/dpkg/postinst.d/* scripts are run by my hacked version of dpkg after 
the package is installed, but before the postinst script from the package is 
run.  $1 is the name of the package that is being installed.

The old file is only removed if we are installing the "selinux" package, so 
if the preinst scripts from several packages are run before the postinsts of 
them are run then we won't remove the old file until the new one has the 
correct context.

Hope this helps people doing RPM packages or other packaging...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
