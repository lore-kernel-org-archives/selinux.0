Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14646
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 12:53:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA20874
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 16:52:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA20864
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 16:52:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id D515692469
	for <selinux@tycho.nsa.gov>; Thu,  1 Aug 2002 02:53:25 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 839241FC
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2002 18:53:15 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ssh policy
Date: Wed, 31 Jul 2002 18:53:15 +0200
MIME-Version: 1.0
Message-Id: <20020731165315.839241FC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've put a new archive of my SE Linux policy on 
http://www.coker.com.au/selinux/policy.tgz (no debs yet because I'm still 
experimenting with it).

The major change I've just made is merging ssh.te and sshd.te.  The reason 
for this is that they both require access to ~/.ssh, this means that to 
support one without the other makes the policy more complex but delivers 
little benefit.  There are few people who want to run ssh without sshd (or 
the other way around).  Also I believe that having the files separate will 
result in someone deciding that they don't want ssh and removing ssh.te but 
not /usr/bin/ssh!  This would result in /usr/bin/ssh running in user_t thus 
being marginally less secure.

While these issues are both minor, I think it's enough reason for us as 
policy developers to save ourselves the extra effort and merge the files.

Also it's just occurred to me that I should create a new domain for 
ssh-keygen to give an automatic transition of key files 
{identity,id_rsa,id_dsa}{,.pub} to a type that can't be read by sshd.  I had 
previously thought of just using a different type for the identity, id_dsa, 
and id_rsa files, but I realised that sshd has no cause to read the .pub 
files (although I don't think there's any real need to deny read access 
either).


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
