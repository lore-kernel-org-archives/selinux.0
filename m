Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2S4wiDo023009
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 23:58:45 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2S4w01g012677
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 04:58:00 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
In-Reply-To: <1111985855.1514.70.camel@cobra.ivg2.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 00:03:32 -0500
Message-Id: <1111986213.1514.77.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay that was an unfinished email - sorry for my stupidity - I was 
editing it and changing things and clicked send by mistake.

The problem is accurately described (in the first part of the email) and
what I was getting to - I'm trying to imagine how desktop apps can be
confined properly in the future (and right now, for that matter). How
will they interoperate and share data?

I was thinking of a ~/downloads folder with a shared context, but 
this makes sense for apps that download stuff. In the future if desktop
apps are confined (say openoffice, abiword) this becomes a more generic
problem.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
