Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i840XjrT011530
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 20:33:46 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i840XiUQ005995
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 00:33:45 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 33827C4C09A
	for <selinux@tycho.nsa.gov>; Sat,  4 Sep 2004 02:33:45 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 11537-06 for <selinux@tycho.nsa.gov>;
	Sat, 4 Sep 2004 02:33:44 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD9E4F7B2.dip.t-dialin.net [217.228.247.178])
	by legolas.drinsama.de (Postfix) with ESMTP id 3FD0BC4C08E
	for <selinux@tycho.nsa.gov>; Sat,  4 Sep 2004 02:33:44 +0200 (CEST)
Received: from [127.0.0.1] (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 51098234095
	for <selinux@tycho.nsa.gov>; Sat,  4 Sep 2004 02:33:42 +0200 (CEST)
Subject: Re: [idea] file contexts "alternate" keyword
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040903205348.GA4084@lkcl.net>
References: <20040903165723.GA31857@lkcl.net>
	 <1094240841.29689.6.camel@wintermute.xmldesign.de>
	 <20040903205348.GA4084@lkcl.net>
Content-Type: text/plain
Date: Sat, 04 Sep 2004 02:33:41 +0200
Message-Id: <1094258021.29689.32.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

But this brings me to a different issue:
How about allowing multiple contexts for file_contexts?
Like the first hit being the default context, subsequent hits being
additional contexts that will not be *CHANGED* by setfiles?

Let's say i'm running a web server, my standard http files have a non-
executable context. When i install a cgi i chcon it manually to
an executable context (having a different role than the web server
and the necessary rights to do so).
Then the web server can execute my cgi.
Well, until i run setfiles, which might have been told to reset the
context to the non-executable type.

Or is there some nicer way to achieve this?

BTW: is there some trick to edit files in vim without having them change
their context to the directory default?
I have a couple of scripts in /usr/local/sbin with extra contexts,
whenever i change one i need to relabel it again afterwards.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
       The best things in life are free: Friendship and Love.       //\
              Denken ist oft schwerer, als man denkt.               V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
