Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA02759
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 20:20:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA11886
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 00:18:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA11882 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 00:18:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 69C839246C
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 10:20:08 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 9644D411
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 02:20:00 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: experimental new policy for mail
Date: Tue, 13 Aug 2002 02:20:00 +0200
MIME-Version: 1.0
Message-Id: <20020813002000.9644D411@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have made some significant changes to the email macros in my policy tree 
and put an archive on http://www.coker.com.au/selinux/policy.tgz for you to 
play with.

It adds a new file mta.te to define everything that's common to all mail 
servers (so now postfix.te doesn't depend on sendmail.te).  I've also added 
some new attributes as part of this and made some significant changes to the 
mail policy.

This policy needs lots more testing before I release it in a Debian package 
but is looking promising so far.  The end result will be a much cleaner mail 
policy that is much easier to expand.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
