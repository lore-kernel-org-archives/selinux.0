Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9BE17rT006015
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 10:01:07 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9BE12WH023823
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 14:01:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 1B1D1C4C088
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 16:01:03 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 32619-06 for <selinux@tycho.nsa.gov>;
	Mon, 11 Oct 2004 16:01:02 +0200 (CEST)
Received: from wintermute.xmldesign.de (p50801E76.dip.t-dialin.net [80.128.30.118])
	by legolas.drinsama.de (Postfix) with ESMTP id AD1F7C4C084
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 16:01:01 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 1A860234058
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 16:01:01 +0200 (CEST)
Subject: Re: Asterisk on SELinux
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1097499317.16758.40.camel@wintermute.xmldesign.de>
References: <1097499317.16758.40.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 11 Oct 2004 16:01:00 +0200
Message-Id: <1097503260.21250.11.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> Unfortunately, while asterisk does now start (as root only, not as
> non-root-user... not sure why, but i think the user/group setup isn't
> right yet... how do i change a unix users primary group in selinux?)
> my test SIP call didn't get properly accepted.

Some log files had wrong permissions. Now asterisk works and i can call
it using SIP. The echo test is fine, as is the AIX test to a remote
site.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
          Die Stärke eines Menschen kann man daran messen,          V_/_
              wie er mit seinen Schwächen fertig wird!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
