Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13879
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 07:35:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA01698
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 11:34:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA01694 for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 11:34:05 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1298092461
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 21:35:27 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 040AA5B8
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 13:35:20 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new macro in users.te
Date: Thu, 20 Jun 2002 13:35:19 +0200
MIME-Version: 1.0
Message-Id: <20020620113520.040AA5B8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In my policy tree I have the following in users.te:

define(`in_user_role', `
role user_r types $1;
#role second_user_r types $1;
')

Then I replace this:
role user_r types foo_t;
with this:
in_user_role(foo_t)

I want to have multiple user roles that each have their own primary domain, 
but can change to other domains within their role, but can't access the 
primary domain for other roles.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
