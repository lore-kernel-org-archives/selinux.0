Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA27343
	for <selinux@tycho.nsa.gov>; Fri, 2 Aug 2002 10:11:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA18625
	for <selinux@tycho.nsa.gov>; Fri, 2 Aug 2002 14:09:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA18621 for <selinux@tycho.nsa.gov>; Fri, 2 Aug 2002 14:09:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 835CD9246A
	for <selinux@tycho.nsa.gov>; Sat,  3 Aug 2002 00:10:58 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id EA7A3166A
	for <selinux@tycho.nsa.gov>; Fri,  2 Aug 2002 16:10:49 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: symlinks under /tmp
Date: Fri, 2 Aug 2002 16:10:49 +0200
MIME-Version: 1.0
Message-Id: <20020802141049.EA7A3166A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the past there have been numerous security problems due to hostile users 
creating symlinks under /tmp pointing to important files such as /etc/shadow.
They have included tricks for programs running as root that blindly use a 
fixed name for a tmp file, and race conditions for programs that are slightly 
better written.

To solve this OpenWall prohibits the creation of symlinks under /tmp pointing 
to files you don't own.

SE Linux doesn't work that way so we need a different solution to this 
problem.  I have experimented with removing the sysadmfile attribute from 
user_tmp_t and then giving the sysadm_t domain access to do everything to 
directories and files that have the tmpfile attribute but to do everything 
but read lnk_file objects with that attribute.

This works but prevents "ls -l" from displaying the target of the link.

I am now thinking of creating a sysadm_ls_t domain that can read all lnk_file 
objects, getattr on everything, and search every directory (but write 
nothing).

What do you think?

Also I noticed that the patch to ls doesn't use lstat_secure() so the 
operation of "ls --context symlink" is vastly different from "ls -l symlink". 
 I'll change that in my tree.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
