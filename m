Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14703
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 12:55:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA20963
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 16:54:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA20959
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 16:54:39 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sshd mods
Date: Wed, 31 Jul 2002 18:55:18 +0200
Cc: matthew@debian.org
MIME-Version: 1.0
Message-Id: <20020731165519.087D01FC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the current sshd on SE Linux a compromised sshd can't directly run 
"/bin/rm", but it can run "sh -c rm -rf /home/user".

I think that we could probably benefit from a wrapper program that ssh would 
run.  This wrapper would perhaps have a configuration method somewhat similar 
to sudo to determine what programs ssh could run and what parameters can be 
passed to them.  Then we could deny sshd access to change domain/role and 
only allow this wrapper to do that, then sshd would only be able to execute 
the wrapper (and hopefully the vast majority of ssh exploits would then be 
unable to affect us).

This should also benefit non-SE users, the ability to limit in detail what a 
user can do with an ssh account is something that many people have been 
asking for.  Having it implemented by a separate wrapper program (that will 
hopefully be well audited and unlikely to contain bugs) will also give 
advantages for security systems other than SE Linux (any MAC system should 
benefit greatly from this).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
