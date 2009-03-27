Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RLAQOf004955
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 17:10:26 -0400
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RLAPfp007633
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 21:10:25 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 0/6] Labeled networking patches for 2.6.30
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: netdev@vger.kernel.org, casey@schaufler-ca.com,
        etienne.basset@numericable.fr
Date: Fri, 27 Mar 2009 17:10:20 -0400
Message-ID: <20090327205520.17777.32557.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset wraps up all the new labeled networking bits for 2.6.30.  This
is mostly a fixup/cleanup release with the main focus being to correct the
TCP labeling of both SELinux and Smack; expect some of this to get backported
to the -stable trees but there will need to be a bit of rework first so it
may take a few weeks for that to happen.  Other than the TCP issue there is a
new Smack feature to configure CIPSO aware hosts in "/smack/netlabel" which
should make the host/network label configuration much more flexible.  The last
change is to get rid of the security_socket_post_accept() hook which isn't
currently being used by anything in-tree and seems to act as a magnet for
bad ideas; if things change we can always add it back later.

The two Smack related patches, "Add a new -CIPSO option ..." and "Cleanup the
Smack/NetLabel code ..." were ACK'd by Casey but had to be modified slightly
today to address a last minute kernel oops and a minor merge collision with
patches already in the security-testing-2.6 tree.  I imagine when Casey sees
this he will ACK them again but I removed his ACK in the meantime since the
patches did change, however slightly.

I did run yesterday's patches (without the kernel oops fix) against Linus' tree
from yesterday on my test systems without problem but I'm having a problem
getting a clean kernel build using Linus' current tree so I'm unable to do a
sanity check at present.  That said, I am able to build the relevant code
sections/modules without issue and am fairly confident there should not be any
issues.

---

Etienne Basset (1):
      smack: Add a new '-CIPSO' option to the network address label configuration

Paul Moore (5):
      netlabel: Cleanup the Smack/NetLabel code to fix incoming TCP connections
      lsm: Remove the socket_post_accept() hook
      selinux: Remove the "compat_net" compatibility code
      netlabel: Label incoming TCP connections correctly in SELinux
      lsm: Relocate the IPv4 security_inet_conn_request() hooks


 Documentation/Smack.txt                    |   42 ++++
 Documentation/feature-removal-schedule.txt |   11 -
 Documentation/kernel-parameters.txt        |    9 -
 include/linux/security.h                   |   13 -
 include/net/cipso_ipv4.h                   |   17 ++
 include/net/netlabel.h                     |   17 ++
 net/ipv4/cipso_ipv4.c                      |  130 ++++++++++++-
 net/ipv4/syncookies.c                      |    9 +
 net/ipv4/tcp_ipv4.c                        |    7 -
 net/netlabel/netlabel_kapi.c               |  165 +++++++++++++++--
 net/socket.c                               |    2 
 security/capability.c                      |    5 -
 security/security.c                        |    5 -
 security/selinux/hooks.c                   |  207 ++-------------------
 security/selinux/include/netlabel.h        |   27 +--
 security/selinux/netlabel.c                |  186 +++++--------------
 security/selinux/selinuxfs.c               |   68 -------
 security/smack/smack.h                     |    4 
 security/smack/smack_access.c              |    3 
 security/smack/smack_lsm.c                 |  271 ++++++++++++++++------------
 security/smack/smackfs.c                   |   38 +++-
 21 files changed, 618 insertions(+), 618 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
