Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6PIMst5017938
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2013 14:22:56 -0400
Message-ID: <51F16CFB.6040603@schaufler-ca.com>
Date: Thu, 25 Jul 2013 11:22:51 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>
CC: John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v14 0/6] LSM: Multiple concurrent LSMs
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v14 0/6] LSM: Multiple concurrent LSMs

Version 14 of this patchset is based on v3.10.
It required significant change from version 13 due to changes
in the audit code. It came out cleaner, especially in the changes
to NetLabel. This version supports all existing LSMs running
together at the same time. The combinations tested most completely
are:

    apparmor,tomoyo,smack,yama  - Ubuntu
    apparmor,selinux,smack,yama - Fedora

I have been unable to figure out how to configure SELinux on
Ubuntu and TOMOYO on Fedora. That's the only reason the list
does not include all five LSMs at once. Combining LSMs that
use networking is tricky, but can be done. There are changes
coming from AppArmor that might make it even trickier, but
that's a problem for the future.


Change the infrastructure for Linux Security Modules (LSM)s from a
single vector of hook handlers to a list based method for handling
multiple concurrent modules. All combinations of existing LSMs
are supported.

The "security=" boot option takes a comma separated list of LSMs,
registering them in the order presented. The LSM hooks will be
executed in the order registered. Hooks that return errors are
not short circuited. All hooks are called even if one of the LSM
hooks fails. The result returned will be that of the last LSM
hook that failed.

All behavior from security/capability.c has been moved into
the hook handling.  The security/commoncap functions used
to get called from the LSM specific code. The handling of the
capability functions has been moved out of the LSMs and into the
hook handling.

A level of indirection has been introduced in the handling of
security blobs. LSMs no longer access ->security fields directly,
instead they use an abstraction provided by lsm_[gs]et field
functions.

The notion that "the security context" can be represented as a
single u32 "secid" does not scale to the case where multiple LSMs
want to provide "the security context". The XFRM and secmark
facilities appear unlikely to ever allow for more than the existing
32 bit values. The NetLabel scheme might possibly be used to
represent more than one labeling scheme (CIPSO does allow for
multiple tags) although there is no plan to do so at this time.
The SO_PEERSEC scheme is capable of providing information from
multiple LSMs. Auditing can deal with multiple secids.

The NetLabel, XFRM and secmark facilities are restricted to use
by one LSM at a time. The SO_PEERSEC facility can provide information
from multiple LSMs, but existing user space tools don't understand
that. The default behavior is to assign each of these facilities
to the first registered LSM that uses them. They can be configured
for use by any of the LSMs that provide hooks for them. SO_PEERSEC
can be configured to provide information from all of the LSMs that
provide hooks.

The /proc/*/attr interfaces are given to one LSM. This can be
done by setting CONFIG_SECURITY_PRESENT. Additional interfaces
have been created in /proc/*/attr so that each LSM has its own
named interfaces. The name of the presenting LSM can be read from
/sys/kernel/security/present. The list of LSMs being used can be
read from /sys/kernel/security/lsm.

A "security context" may now contrain information processed by
more than one LSM. The proper form of a security context identifies
the information it contains by LSM:

    smack='Pop'selinux='system_u:object_r:etc_r:s0'

A security context without the LSM identifying lsm='<text>' gets
passed through to all of the LSMs that use a security context. This
maintains compatability in the case where there is only one LSM
using the security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 Documentation/security/LSM.txt                     |   56 +-
 drivers/usb/core/devio.c                           |   13 +-
 fs/proc/base.c                                     |   36 +-
 fs/sysfs/dir.c                                     |    3 +-
 fs/sysfs/inode.c                                   |   12 +-
 fs/sysfs/sysfs.h                                   |    7 +-
 fs/xattr.c                                         |    8 +-
 include/linux/cred.h                               |    4 +-
 include/linux/lsm.h                                |  300 +++
 include/linux/lsm_audit.h                          |    9 +-
 include/linux/sched.h                              |    2 +-
 include/linux/security.h                           |  580 ++++--
 include/net/af_unix.h                              |    5 +-
 include/net/netlabel.h                             |   15 +-
 include/net/scm.h                                  |   11 +-
 include/net/xfrm.h                                 |    9 +-
 kernel/audit.c                                     |   55 +-
 kernel/audit.h                                     |    9 +-
 kernel/auditfilter.c                               |    4 +-
 kernel/auditsc.c                                   |   53 +-
 kernel/cred.c                                      |   17 +-
 kernel/signal.c                                    |    7 +-
 net/ipv4/cipso_ipv4.c                              |    9 +-
 net/ipv4/ip_sockglue.c                             |    8 +-
 .../netfilter/nf_conntrack_l3proto_ipv4_compat.c   |    8 +-
 net/netfilter/nf_conntrack_netlink.c               |   13 +-
 net/netfilter/nf_conntrack_standalone.c            |    8 +-
 net/netfilter/xt_SECMARK.c                         |   13 +-
 net/netlabel/netlabel_kapi.c                       |   47 +-
 net/netlabel/netlabel_unlabeled.c                  |   57 +-
 net/netlabel/netlabel_user.c                       |   10 +-
 net/netlabel/netlabel_user.h                       |    1 +
 net/unix/af_unix.c                                 |   14 +-
 net/xfrm/xfrm_user.c                               |   33 +-
 security/Kconfig                                   |  226 ++-
 security/Makefile                                  |    3 +-
 security/apparmor/context.c                        |   10 +-
 security/apparmor/domain.c                         |   12 +-
 security/apparmor/include/apparmor.h               |    3 +
 security/apparmor/include/context.h                |    9 +-
 security/apparmor/lsm.c                            |   64 +-
 security/capability.c                              | 1106 -----------
 security/commoncap.c                               |    6 -
 security/inode.c                                   |   77 +-
 security/integrity/ima/ima.h                       |    4 +-
 security/integrity/ima/ima_policy.c                |    6 +-
 security/security.c                                | 2082
+++++++++++++++++---
 security/selinux/hooks.c                           |  431 ++--
 security/selinux/include/objsec.h                  |    1 +
 security/selinux/include/xfrm.h                    |    2 +-
 security/selinux/netlabel.c                        |   46 +-
 security/selinux/selinuxfs.c                       |    7 +-
 security/selinux/ss/services.c                     |    5 +-
 security/selinux/xfrm.c                            |    9 +-
 security/smack/smack.h                             |    7 +-
 security/smack/smack_access.c                      |    2 +-
 security/smack/smack_lsm.c                         |  338 ++--
 security/smack/smackfs.c                           |   26 +-
 security/tomoyo/common.h                           |    6 +-
 security/tomoyo/domain.c                           |    2 +-
 security/tomoyo/securityfs_if.c                    |    7 +-
 security/tomoyo/tomoyo.c                           |   34 +-
 security/yama/Kconfig                              |    7 -
 security/yama/yama_lsm.c                           |   33 +-
 64 files changed, 3679 insertions(+), 2328 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
