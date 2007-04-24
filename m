Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OAUngK001846
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 06:30:49 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OAUi3M009853
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 10:30:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Xavier Toth" <txtoth@gmail.com>
Subject: Re: directory polyinstantiation failure
Date: Tue, 24 Apr 2007 20:06:50 +1100
Cc: "Michael C Thompson" <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com> <46252BB5.1070407@us.ibm.com> <cadfc0e40704180959i4aad6211r6b66d1433c69a1ee@mail.gmail.com>
In-Reply-To: <cadfc0e40704180959i4aad6211r6b66d1433c69a1ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200704241906.55645.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 19 April 2007 02:59, "Xavier Toth" <txtoth@gmail.com> wrote:
> Why if getexeccon fails doesn't it make sense to polyinstantiate based
> on context/level? Why not call getcon lf getexeccon fails and use that
> context instead of switching the method?

That depends on the aim of the PI.

If the aim is merely to isolate the session from other sessions then it's 
probably OK to skip the things that don't change (although this optimisation 
doesn't seem to give any benefit).

If the aim is to give each session a PI directory that matches it's context 
such that any other session which is established with the same context will 
have the same directory then all items have to be used.

Also while on the topic, we need an option to do PI based on the GID as well 
(this was requested on a few occasions when I gave talks about it).  So we 
could have configuration options to specify a list of items to use, the full 
SE Linux context, the MLS/MCS level, the role, the Linux UID, and the Linux 
GID.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
