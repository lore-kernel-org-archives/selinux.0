Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6EM5DHa015047
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 18:05:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6EM4DnJ010991
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:04:13 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6EM4Chr010976
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:04:12 GMT
Subject: Re: enforcement and initrds
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200307150733.30170.russell@coker.com.au>
References: <1058151822.9620.25.camel@columbia>
	 <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil>
	 <1058214662.19392.31.camel@columbia>
	 <200307150733.30170.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1058220094.22969.1.camel@columbia>
Mime-Version: 1.0
Date: 14 Jul 2003 18:01:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-07-14 at 17:33, Russell Coker wrote:

> You could compile with DEVELOP=y and use policy that prevents turning it off 
> which is almost as good (anyone who can load a policy that allows turning it 
> off can load a policy that permits everything).

True enough.

> Last time I did this it worked OK, SE Linux loaded the policy as part of the 
> mount process.

In 2.5 that doesn't happen anymore, which I think is good.  Hardcoding
stuff like /etc/security inside Linux is just a bad idea.  But we have
to figure out exactly how the initrd should work.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
