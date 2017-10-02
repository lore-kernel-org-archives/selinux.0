From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  2 Oct 2017 11:58:15 -0400
Message-Id: <20171002155825.28620-1-sds@tycho.nsa.gov>
Subject: [RFC 00/10] Introduce a SELinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I normally wouldn't post these patches at this stage of development,
but several people have requested them, so here they are.  Note that
they are very incomplete and unsafe and should not be used on any
production systems.  The first four patches should actually be safe,
since they merely lay the groundwork of enabling selinux state to be
namespaced, but the rest are not; specific known issues with each of them
are noted in the patch descriptions.  It isn't until the next to last patch
that the facility is even exposed to userspace, and that patch description
explains sample usage (as well as summarizing known issues).  I am
intentionally only sending this to the selinux list at the moment
because I don't think it is ready for wider consumption and expect much
of it to change or be completely replaced.  I had some other patches in
the works as well, but they were lost in a recent hardware failure so it
will take some time to recover those.

Motivating use cases for a SELinux namespace include:
1. Enabling one to apply SELinux confinement within a container on
a host that is itself using SELinux to enforce container isolation
and confinement to host resources (svirt).  For example, one might wish
to isolate multiple services running within a container, or to
enforce a W^X policy for a service running within a container.
Today one is forced to treat the entire container as a single
context and from within the container it appears that SELinux
is disabled.

2. Supporting the ChromeOS use case of running an Android SELinux
container when the host itself is not using SELinux.  My impression
is that the ChromeOS developers first tried hacking support for
a per-pid-namespace SELinux enforcing mode into the kernel, and then
later resorted to essentially running the ChromeOS processes in
an unconfined or permissive domain while running the Android
processes in their usual contexts; I don't know how this could have
passed Android CTS however since the full policy would have been
exposed to the Android instance via the single selinuxfs instance.

3. Running multiple Android instances on a single host, each with
their own SELinux policy and enforcing mode, as in the Cells/Cellrox
virtual smartphone platform.

4. Running Fedora or other SELinux-enabled systems with SELinux
confinement enabled in containers on non-SELinux hosts.

It should be noted that in their current form, these patches do not
yet support any of these use cases.

You can also find these patches in the following tree:
https://github.com/stephensmalley/selinux-kernel/tree/selinuxns

Use at your own risk.  Enjoy!

Stephen Smalley (10):
  selinux: introduce a selinux namespace
  selinux: support multiple selinuxfs instances
  selinux: move the AVC into the selinux namespace
  netns,selinux: create the selinux netlink socket per network namespace
  selinux: support per-task/cred selinux namespace
  selinux: introduce cred_selinux_ns() and use it
  selinux: support per-namespace inode security structures
  selinux: support per-namespace superblock security structures
  selinux: add a selinuxfs interface to unshare selinux namespace
  selinuxfs: restrict write operations to the same selinux namespace

 include/net/net_namespace.h            |    3 +
 security/selinux/avc.c                 |  290 ++++----
 security/selinux/hooks.c               |  884 ++++++++++++++++++-------
 security/selinux/ibpkey.c              |    3 +-
 security/selinux/include/avc.h         |   38 +-
 security/selinux/include/avc_ss.h      |    9 +-
 security/selinux/include/classmap.h    |    3 +-
 security/selinux/include/conditional.h |   11 +-
 security/selinux/include/objsec.h      |   18 +-
 security/selinux/include/security.h    |  231 +++++--
 security/selinux/netif.c               |    2 +-
 security/selinux/netlabel.c            |   14 +-
 security/selinux/netlink.c             |   31 +-
 security/selinux/netnode.c             |    4 +-
 security/selinux/netport.c             |    2 +-
 security/selinux/selinuxfs.c           |  627 ++++++++++++------
 security/selinux/ss/avtab.c            |    9 +-
 security/selinux/ss/avtab.h            |    3 -
 security/selinux/ss/ebitmap.c          |    7 +-
 security/selinux/ss/ebitmap.h          |    3 -
 security/selinux/ss/hashtab.c          |    8 +-
 security/selinux/ss/hashtab.h          |    4 -
 security/selinux/ss/mls.c              |   72 +-
 security/selinux/ss/mls.h              |   38 +-
 security/selinux/ss/services.c         | 1126 ++++++++++++++++++--------------
 security/selinux/ss/services.h         |   23 +-
 security/selinux/ss/status.c           |   47 +-
 security/selinux/xfrm.c                |   23 +-
 28 files changed, 2289 insertions(+), 1244 deletions(-)

-- 
2.9.5
