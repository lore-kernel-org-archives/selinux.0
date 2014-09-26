Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8QKpJ5r030750
 for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2014 16:51:19 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.18
Date: Fri, 26 Sep 2014 16:51:21 -0400
Message-ID: <6423750.9WFoIKOal0@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

I haven't seen a response to my mail yesterday about the linux-security tree 
and v3.16, but considering where we are at in relation to the v3.18 merge 
window I figured it best to send the SELinux pull request now.

As should be obvious, and in keeping with recent history, the SELinux next 
branch is based on v3.16 so it doesn't apply cleanly on top of the current 
linux-security next branch.  I fully expect that bringing the linux-security 
branch up to v3.16 should result in a clean merge.

Anyway, on to the SELinux v3.18 patches: there are a few minor cleanup 
patches, a better "fix" for bounded transitions and NNP/NOSUID, and some 
bugfixes pertaining to the netfilter hooks and network namespaces.  Nothing I 
would consider major or contentious.

The patches pass the SELinux testsuite without problem.

Enjoy,
-Paul

---
The following changes since commit aa9e0de81b5b257f6dae48efe2ed5f255f066497:

  Merge tag 'v3.16' into next (2014-08-05 15:44:22 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to 4093a8443941d7021c7f747474a87a56cf666270:

  selinux: normalize audit log formatting (2014-09-22 17:02:10 -0400)

----------------------------------------------------------------
Jiri Pirko (1):
      selinux: register nf hooks with single nf_register_hooks call

Paul Moore (2):
      selinux: fix a problem with IPv6 traffic denials in
               selinux_ip_postroute()
      selinux: make the netif cache namespace aware

Richard Guy Briggs (2):
      selinux: cleanup error reporting in selinux_nlmsg_perm()
      selinux: normalize audit log formatting

Stephen Smalley (1):
      selinux: Permit bounded transitions under NO_NEW_PRIVS or NOSUID.

 security/selinux/hooks.c          | 135 +++++++++++++++++++++---------------
 security/selinux/include/netif.h  |   4 +-
 security/selinux/include/objsec.h |   2 +
 security/selinux/netif.c          |  43 ++++++------                           
 security/selinux/ss/services.c    |  14 ++--                                   
 5 files changed, 115 insertions(+), 83 deletions(-)  

-- 
paul moore
security and virtualization @ redhat
