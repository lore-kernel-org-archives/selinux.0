Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21573
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 08:20:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08868
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 12:19:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA08864
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 12:19:50 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 875B792467
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 22:20:35 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 6B5C7265
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 14:20:38 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: fileutils
Date: Sat, 27 Jul 2002 14:20:38 +0200
MIME-Version: 1.0
Message-Id: <20020727122038.6B5C7265@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've put a new version of fileutils on 
http://www.coker.com.au/selinux/fileutils/ .  It is based on the latest 
version of fileutils, and I've made a few changes.  I made cp and mv not try 
to preserve the context unless you specify it with -c for either program (cp 
also takes --preserve=context).

Also I updated the man page auto-generation to generate a manpage for 
chcon(1).

One final thing, I think that copy_s() in copy.c should be changed to use 
open_secure() instead of just calling the regular function.  If we really 
want the context set on copy then the current setup allows for a race 
condition where a large file could potentially be read by an unauthorised 
process while it's being copied.  Also could there be situations in which the 
user has permission to create a file in a particular type via open_secure() 
but not have permissions to change it to that type later?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
