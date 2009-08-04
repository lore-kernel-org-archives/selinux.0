Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n74LMtkR003671
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 17:22:55 -0400
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n74LMR1C005172
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 21:22:27 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1 0/2] The Long Lost TUN LSM Hooks
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Tue, 04 Aug 2009 17:21:46 -0400
Message-ID: <20090804211304.10798.65601.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While drivers in general aren't good places for LSM hooks the TUN driver is
a bit different because of how it handles sockets and network traffic.  The
problem lies in the fact that the TUN driver creates a sock structure to use
when sending network traffic but the sock is never put through the same LSM
setup/control as other sock structures on the system which makes enforcing
security on TUN generated traffic difficult for some LSMs.  This patch set
adds three new LSM hooks, all specific to the TUN driver (none of the existing
hooks made sense, trust me we tried), to control and monitor the creating and
attachment of TUN devices.

The necessary support for SELinux is also included in this patch with support
for Smack and TOMOYO absent; although I suspect there will be no changes needed
for either of those LSMs.

--

NOTE: These patches are truly RFC, please let me know how you feel about these
      new hooks.  I've booted a kernel with these changes but I'm having some
      problems today with my Rawhide/KVM test machine so I'm having mixed luck
      testing this - no regressions, but no real TUN testing either.

---

Paul Moore (2):
      selinux: Support for the new TUN LSM hooks
      lsm: Add hooks to the TUN driver


 drivers/net/tun.c                          |   41 ++++++++-------
 include/linux/security.h                   |   34 +++++++++++++
 security/commoncap.c                       |   26 ++++++++++
 security/security.c                        |   18 +++++++
 security/selinux/hooks.c                   |   76 +++++++++++++++++++++++++++-
 security/selinux/include/av_inherit.h      |    1 
 security/selinux/include/av_permissions.h  |   22 ++++++++
 security/selinux/include/class_to_string.h |    1 
 security/selinux/include/flask.h           |    1 
 security/selinux/include/security.h        |    2 +
 security/selinux/selinuxfs.c               |    3 +
 security/selinux/ss/services.c             |    3 +
 12 files changed, 207 insertions(+), 21 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
