Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9RE2Tbg004788
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 10:02:31 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9RE0uEB021894
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 14:00:56 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: User object manager context location
Date: Fri, 27 Oct 2006 10:02:25 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885145F7@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With more object managers showing up (eg., Gconf, policy server, X) I
think we need to make a decision about how the object labeling files are
kept and managed. As of right now semanage cannot manage any object
labeling files for userspace object managers and I'm not sure that it
should.

Also, where should the files go, these are private resources of the
object manager that libselinux doesn't know how to parse, the contexts
directory is (IMHO) a resource of libselinux so it should understand
files there, on the other hand the object labeling files would be policy
specific so they need to be handled in such a way that policy changes
don't break the object manager.

We've brought up the idea of a generic section in policy packages for
this sort of thing but I'm not sure if this is appropriate, once again
because there will basically be random files with random formats in an
selinux directory, these should probably be considered configuration
files for the object manager and not selinux but I'm not sure, the issue
feels very fuzzy. Chris disagrees with me adamently and believes the
files should go into the contexts directory and be included in policy
packages, I'm very unsure of this though.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
