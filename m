Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUpHc029539
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 466BE4E341
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:48 +0000 (UTC)
Received: from hulk.com (unknown [10.40.2.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6F65189CB
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:47 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Several sepolicy fixes from Fedora
Date: Wed,  3 May 2017 12:30:17 +0200
Message-Id: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

this is set of sepolicy fixes we use in Fedora.

There are basically 2 groups of patches:

1. fixes which was pushed to Fedora few years ago and probably have not been
sent upstream

[PATCH 01/19] policycoreutils/sepolicy: Add documentation for MCS
[PATCH 02/19] sepolicy: Fix spelling mistakes in commands in
[PATCH 03/19] sepolicy: Add manpages for typealiased types
[PATCH 04/19] sepolicy: Move svirt man page out of libvirt into its
[PATCH 05/19] policycoreutils/sepolicy: boolean.png is in help/
[PATCH 06/19] Fix up generation of application policy
[PATCH 07/19] sepolicy: ptrace should be a part of deny_ptrace
[PATCH 08/19] sepolicy: We should be creating _exec interfaces when
[PATCH 09/19] Fix typo in  executable.py template.

2. fixes related to python 3 and the change to SETools 4

[PATCH 10/19] sepolicy: Adapt to new the semodule list output
[PATCH 11/19] sepolicy: Don't return filter(), use [ ] notation
[PATCH 12/19] sepolicy: Simplify policy types detection
[PATCH 13/19] sepolicy/generate.py: Fix string formatting
[PATCH 14/19] policycoreutils/sepolicy: Define our own cmp()
[PATCH 15/19] dbus: Use text streams in selinux_server.py
[PATCH 16/19] sepolicy: setools.*Query wants a list in ruletype
[PATCH 17/19] sepolicy: Fix several issues in 'sepolicy manpage -a'
[PATCH 18/19] sepolicy: info() should provide attributes for a TYPE
[PATCH 19/19] sepolicy/gui: Update text strings to use better gettext
