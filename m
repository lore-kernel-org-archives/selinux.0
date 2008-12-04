Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB4KKp0s001862
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2008 15:20:51 -0500
Received: from moss-saturn.epoch.ncsc.mil (moss-saturn [144.51.25.128])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB4KKpYV004654
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2008 15:20:51 -0500
Received: from moss-saturn.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-saturn.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id mB4KIADQ009538
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2008 15:18:10 -0500
Received: (from dpquigl@localhost)
	by moss-saturn.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id mB4KIASw009536
	for selinux@tycho.nsa.gov; Thu, 4 Dec 2008 15:18:10 -0500
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [RFC] Provide a method for detecting labeling support on a file system.
Date: Thu,  4 Dec 2008 15:18:07 -0500
Message-Id: <1228421890-9467-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is the first attempt at a patchset to allow user space programs to easily
detect if a mount supports labeling. The first patch condenses the existing
flag fields in the super block security struct into the flags field and fixes
the existing code to make use of the condensed field. The second patch adds
handling for a new mount option called supports_labeling. If this is passed in
to the mount command it is ignored by the security server, however the string
is added to the output of /proc/mounts to indicate labeling support. The last
patch makes the genfs labeling behavior behave like context mounts. Currently
instead of returning EOPNOTSUPP for attempts to set a label on a genfs
filesystem it may also fail based on permission check potentially confusing
the user.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
