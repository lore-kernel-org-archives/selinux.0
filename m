Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22022
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 14:09:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA18132
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 18:08:58 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA18126
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 18:08:56 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 52CE292466
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 04:09:48 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 3719C854
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 20:09:40 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy file management
Date: Thu, 15 Aug 2002 20:09:39 +0200
MIME-Version: 1.0
Message-Id: <20020815180940.3719C854@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently in the SE policy files we have a number of dependencies between .te 
files, and in my tree I am getting some conflicts.

What we need is a good way of choosing which ones to install.

I am considering the following for the start of a .te file, with postfix.te 
as an example:
#DESC Postfix mail server
#DEPENDS mta.te
#CONFLICTS mail-server
#PROVIDES mail-server

So postfix.te depends on mta.te (it won't be offered if you don't have 
mta.te), it conflicts with other mail-server policy (IE qmail.te and 
sendmail.te).

What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
