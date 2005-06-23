Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NIbYgA029713
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 14:37:35 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NIRjNa006298
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 18:27:45 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506231821.j5NILDqc030401@gotham.columbia.tresys.com>
References: <200506231821.j5NILDqc030401@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 14:25:16 -0400
Message-Id: <1119551117.16753.12.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Regenerating seems easier

...seems harder to me - I'm doing this from a C library,
and I already have written code to delete stuff from a single file.

Running around the filesystem to piece together a new file
will be a pain...

>  and more likely to be correct to me.

...how so?







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
