Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j17MbA53023754
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 17:37:11 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Best way to label a filesystem for another system
Date: Mon, 7 Feb 2005 14:37:10 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B036A31B3@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the answers in the previous emails.  I am understanding more
:)

So at the moment it does NOT sound like that the tools are really in
place in order to develop for an embedded system.  Feel free to correct
me if I am wrong.

In particular being able to generate a read-only file system which
contains correctly labelled files.  I get the impression that if I label
them on my host system and then use that to generate a filesystem image
that I should run fixfiles when I first bring it up.  But this is not
possible if I am using a read only file system.  It would be preferable
if the host development system does NOT need to have the same SE Linux
process as the target system.

Any ideas on the best way to proceed in this direction?  We are not sure
but we think we will have a read-only file system that we would like SE
Linux labels applied to.  We will also use a read-write file system,
though we haven't figured out which one to use since JFFS2 does not
support xattr.

As far as how to proceed, if there are ideas on what should be modified
in the userspace utilities, we could look into working on that.

Thanks,
John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
