Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA27164
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 18:25:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA07725
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 22:23:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA07721 for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 22:23:53 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 21E6292467
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 08:25:13 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 3521A7D72
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 00:25:06 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: Bug#153238: newrole: should be able to run any command, not just shell
Date: Wed, 24 Jul 2002 00:25:05 +0200
MIME-Version: 1.0
Message-Id: <20020723222506.3521A7D72@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following seems like a reasonable request.  I was thinking of having the 
args be interpreted as before, but with a "-c command" before the "--" to 
specify the name of an alternate shell (or other program) which is to be run.

Of course if you try and run a program that's not permitted as an entry-point 
then it won't do much good (which is part of the reason for only allowing the 
shell to be run I guess).

Date: Wed, 17 Jul 2002 11:44:08 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Debian Bug Tracking System <submit@bugs.debian.org>

Package: selinux
Version: 2002070313-2
Severity: wishlist

It should be possible to say something like

newrole -r sysadm_r -- su -

Yes, you can do this instead:

newrole -r sysadm_r -- -c su -

but that introduces the complexity of running a new
shell that isn't even really required.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
