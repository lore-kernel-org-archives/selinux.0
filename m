Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7AHSewa003215
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 13:28:40 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7AHThIu014155
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 17:29:43 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v2 0/2] New LSM hooks for the TUN driver
To: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Mon, 10 Aug 2009 13:28:37 -0400
Message-ID: <20090810172238.7946.34247.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Second draft of the new TUN driver LSM hooks, thanks to everyone who sent
comments, especially Serge Hallyn and Eric Paris.  Nothing substantial has
changed in this version with respect to the hooks, just lots of little
changes to cleanup the patches and ensure they build on various different
configurations.  I still need to do more testing but barring any issues this
should be the code that I sign-off for inclusion.

In the meantime I've populated the lblnet-2.6_next tree with these patches so
feel free to pull from there if you want to play with the code.

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_next

---

Paul Moore (2):
      selinux: Support for the new TUN LSM hooks
      lsm: Add hooks to the TUN driver


 drivers/net/tun.c                          |   22 +++++++---
 include/linux/security.h                   |   31 ++++++++++++++
 security/capability.c                      |   19 +++++++++
 security/security.c                        |   18 ++++++++
 security/selinux/hooks.c                   |   60 +++++++++++++++++++++++++++-
 security/selinux/include/av_inherit.h      |    1 
 security/selinux/include/av_permissions.h  |   22 ++++++++++
 security/selinux/include/class_to_string.h |    1 
 security/selinux/include/flask.h           |    1 
 9 files changed, 166 insertions(+), 9 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
