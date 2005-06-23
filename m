Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NIHMgA029467
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 14:17:22 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NI7WNa004905
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 18:07:32 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506231737.j5NHbmqc029627@gotham.columbia.tresys.com>
References: <200506231737.j5NHbmqc029627@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 14:05:08 -0400
Message-Id: <1119549909.16753.5.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I think that I missed something - why do you need to know which contexts are
> associated with an app or user?

So that I can get rid of them once the user's removed (userdel).

It seems like I'll just put each user in a separate .fc file
for now... but then if you wanted to remove an app, you'd
have to remove the app's .fc file, and the app's entries
in each user file as well (and any template entries)...
or alternatively you'd have to regenerate everything.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
