Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i725Z8rT009998
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 01:35:08 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i725YZXV006344
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 05:34:35 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 36188C4C096
	for <selinux@tycho.nsa.gov>; Sun,  1 Aug 2004 22:30:48 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 01283-03 for <selinux@tycho.nsa.gov>;
	Sun, 1 Aug 2004 22:30:47 +0200 (CEST)
Received: from wintermute.xmldesign.de (p548031D2.dip.t-dialin.net [84.128.49.210])
	by legolas.drinsama.de (Postfix) with ESMTP id 7D062C4C091
	for <selinux@tycho.nsa.gov>; Sun,  1 Aug 2004 22:30:47 +0200 (CEST)
Received: from [127.0.0.1] (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id D8E7A2340FA
	for <selinux@tycho.nsa.gov>; Sun,  1 Aug 2004 22:30:57 +0200 (CEST)
Subject: Re: user-directory _is_ home directory
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040801143236.GA15949@lkcl.net>
References: <20040801143236.GA15949@lkcl.net>
Content-Type: text/plain
Date: Sun, 01 Aug 2004 22:30:57 +0200
Message-Id: <1091392257.7861.31.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> my question is: does anyone have any recommendations on how to deal
> with /home being a mount point, and also being a user's home directory.

why would you want to do so?

> live with oh, say, restoring it /home/theoneuser instead, and
> creating a symlink as "/MyDocuments" or something stupid?

Make a folder "MyDocuments" in the users home.
All "stupid users file manager" start browsing your files in your home
directory, if you want you can make that /h/o/m/e/o/f/t/h/e/d/e/a/d/
and it is still useable, because the user doesn't see this path.

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
                  Wege entstehen, wenn wir sie gehen.                  V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
