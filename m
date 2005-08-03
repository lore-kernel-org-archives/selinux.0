Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j73H55gA006841
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2005 13:05:05 -0400 (EDT)
Received: from storix.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j73GwF8l014877
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2005 16:58:15 GMT
Received: from rich (65.106.88.139.ptr.us.xo.net [65.106.88.139])
	by storix.com (Postfix) with ESMTP id CFA9415790
	for <selinux@tycho.nsa.gov>; Wed,  3 Aug 2005 10:00:01 -0700 (PDT)
Subject: restoring file attributes
From: rich turner <rich@storix.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 03 Aug 2005 10:01:27 -0700
Message-Id: <1123088488.4481.51.camel@rich>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i am performing a bare-metal restore of system that previously was
selinux-enabled and enforcing. after restoring all of the files on the
system using tar, i need to reset all of the file security contexts
(because tar does not backup or restore extended filesystem attributes).
that leads me to a few questions.

Note: eventhough i am testing with fedora core 4, i am not assuming i
will always be using fc4.

1. i plan to use setfiles to apply extended attributes to files.
however, setfiles requires that i supply the spec_file to use when
applying the attributes. is there a consistent way that i can determine
which spec_file is being used on a running system?

2. is /etc/selinux/config specific to fc4, or can i expect this same
file with the same format on all uses of selinux on linux?

3. on a selinux-enabled and enforcing system, is there a way to know
what SELINUXTYPE is being used? targeted, strict, etc.

4. are "targeted" and "strict" names used by fc4, or will they be
consistent on other distributions?

thanks for any help

rich turner


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
