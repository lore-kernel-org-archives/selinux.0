Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qATM6fJi029172
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2012 17:06:41 -0500
Subject: [RFC PATCH 0/2] Fix some multiqueue TUN problems
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jasowang@redhat.com
Date: Thu, 29 Nov 2012 17:06:21 -0500
Message-ID: <20121129215724.30020.69464.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A relatively short patchset to fix some problems that have arisen from
the multiqueue TUN work.  I'm sending this a RFC for now as it changes
the LSM TUN interfaces and therefore crosses a few boundaries,
e.g. SELinux, although it does so only in an effort to restore the
original behavior which was lost in the multiqueue conversion.

I'm not particularly enthused with the idea of passing a void** as a
parameter to security_tun_dev_alloc_security() but the alternatives
would be to move the tun_struct out of tun.c or have the LSM interface
return a pointer (which would require us to return a "fake" non-NULL
pointer when the LSM was disabled) ... neither of these seemed like good
alternatives to me.

I've compiled the code and booted it without drama, but I haven't really
stressed it too much so buyer beware at this point.  Comments are always
welcome ...

---

Paul Moore (2):
      tun: correctly report an error in tun_flow_init()
      tun: fix LSM/SELinux labeling of tun/tap devices


 drivers/net/tun.c                 |   16 ++++++++++----
 include/linux/security.h          |   37 ++++++++++++++++++++++-----------
 security/capability.c             |   14 +++++++++---
 security/security.c               |   22 ++++++++++++-------
 security/selinux/hooks.c          |   42 +++++++++++++++++++++++--------------
 security/selinux/include/objsec.h |    4 ++++
 6 files changed, 90 insertions(+), 45 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
