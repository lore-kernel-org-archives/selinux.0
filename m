Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9RDj7DY009783
	for <selinux@tycho.nsa.gov>; Sun, 27 Oct 2013 09:45:07 -0400
Date: Sun, 27 Oct 2013 14:43:37 +0100
From: Laurent Bigonville <bigon@debian.org>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Subject: avc_has_perm() returns -1 even when SELinux is in permissive mode
Message-ID: <20131027144337.5b89c5a8@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

After some debugging on Debian to figure out why D-Bus why denying
messages between my user session and policykit with SELinux in
permissive mode, eparis pointed me that Fedora has a patch for this in
the avc_has_perm() function.

The patch[0] itself seems pretty trivial and I was wondering if it (or
something similar) could be merged in the upstream codebase.

But, if I'm not wrong, this patch makes avc_has_perm() and
avc_has_perm_noaudit() have different behavior when the machine is
running in permissive mode, shouldn't this be tested in the
avc_has_perm_noaudit() function instead?

my 2¢,

Laurent Bigonville

[0]
http://pkgs.fedoraproject.org/cgit/libselinux.git/tree/libselinux-rhat.patch#n704


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
