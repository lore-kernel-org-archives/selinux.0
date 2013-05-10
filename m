Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2P6015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:03 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 00/15] Patches from the Debian packages
Date: Fri, 10 May 2013 14:45:08 +0200
Message-Id: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Please find in the following mails patches that are coming from the debian
packages or that fix issues that were detected using some debian tools.

Most of the patches are fixing build system or manpage formating issues.

An other one is adding handeling of UID_MAX (similar to UID_MIN) in
genhomedircon.

Most of these patches have already been proposed in the past, but have been
lost for some reasons.

Cheers

Laurent Bigonville


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
