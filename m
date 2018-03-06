Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26MS9FN015939
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 17:28:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 3zwrxw51Hsz1pG0p
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 22:27:48 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 3zwrxw3VLCz1pG0l
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 22:27:48 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: netdev@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Date: Tue, 06 Mar 2018 17:27:44 -0500
Message-ID: <152037526427.18953.14013300464173153064.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] net: don't unnecessarily load kernel modules in dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Starting with v4.16-rc1 we've been seeing a higher than usual number
of requests for the kernel to load networking modules, even on events
which shouldn't trigger a module load (e.g. ioctl(TCGETS)).  Stephen
Smalley suggested the problem may lie in commit 44c02a2c3dc5
("dev_ioctl(): move copyin/copyout to callers") which moves changes
the network dev_ioctl() function to always call dev_load(),
regardless of the requested ioctl.

This patch moves the dev_load() calls back into the individual ioctls
while preserving the rest of the original patch.

Reported-by: Dominick Grift <dac.override@gmail.com>
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/core/dev_ioctl.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 0ab1af04296c..a04e1e88bf3a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -402,8 +402,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	if (colon)
 		*colon = 0;
 
-	dev_load(net, ifr->ifr_name);
-
 	/*
 	 *	See which interface the caller is talking about.
 	 */
@@ -423,6 +421,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	case SIOCGIFMAP:
 	case SIOCGIFINDEX:
 	case SIOCGIFTXQLEN:
+		dev_load(net, ifr->ifr_name);
 		rcu_read_lock();
 		ret = dev_ifsioc_locked(net, ifr, cmd);
 		rcu_read_unlock();
@@ -431,6 +430,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 		return ret;
 
 	case SIOCETHTOOL:
+		dev_load(net, ifr->ifr_name);
 		rtnl_lock();
 		ret = dev_ethtool(net, ifr);
 		rtnl_unlock();
@@ -447,6 +447,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSIFNAME:
+		dev_load(net, ifr->ifr_name);
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		rtnl_lock();
@@ -494,6 +495,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 		/* fall through */
 	case SIOCBONDSLAVEINFOQUERY:
 	case SIOCBONDINFOQUERY:
+		dev_load(net, ifr->ifr_name);
 		rtnl_lock();
 		ret = dev_ifsioc(net, ifr, cmd);
 		rtnl_unlock();
@@ -518,6 +520,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 		    cmd == SIOCGHWTSTAMP ||
 		    (cmd >= SIOCDEVPRIVATE &&
 		     cmd <= SIOCDEVPRIVATE + 15)) {
+			dev_load(net, ifr->ifr_name);
 			rtnl_lock();
 			ret = dev_ifsioc(net, ifr, cmd);
 			rtnl_unlock();
