Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4CKeFgA028748
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2005 16:40:15 -0400 (EDT)
Received: from web31604.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4CKbUmf012360
	for <selinux@tycho.nsa.gov>; Thu, 12 May 2005 20:37:30 GMT
Message-ID: <20050512203716.29136.qmail@web31604.mail.mud.yahoo.com>
Date: Thu, 12 May 2005 13:37:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Busted by constraints.
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> But nothing prevents you from creating a simple tool
> linked against
> libsepol that takes an avc denial and determines
> which part of the
> policy caused it.

I seriously doubt this would be a "simple" tool.
Two months after the event are you absolutely sure
you are going to have all the information you need
to reconstruct the policy and file system context
that was in force at the time of a particular
access attempt?

One of the first MLS systems (System V/MLS)
did reconstructive audit. The experience of
that system lead all of the Unix vendors after
to use schemes that created individual records
that include all interesting information.

I disagree with your assessment that it's easier
to do this is user space after the fact than in
the kernel as the action happens.


Casey Schaufler
casey@schaufler-ca.com


		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
