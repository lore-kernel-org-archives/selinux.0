Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAUMJvAh013114
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2012 17:19:57 -0500
Message-ID: <50B930F5.5000705@schaufler-ca.com>
Date: Fri, 30 Nov 2012 14:19:33 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>
CC: SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v9 0/2] LSM: Multiple concurrent LSMs
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v9 0/2] LSM: Multiple concurrent LSMs

The patch is presented in parts due to its size.
The patches are not bisectable.

Version 9 of the patch addresses:

1. Calls to commoncap functions have been pulled
   from the existing LSMs and incorporated into
   the hook handling in security/security.c. In most
   cases they are treated as "fail and bail", as
   that is how they were used in the LSMs. There are
   cases where the existing LSMs wanted the call
   last, and those have been addressed as well.
2. reset_security_ops should now be thread safe.
3. security_capget is an odd duck. SELinux uses it
   as a permission check and AppArmor uses it to
   further restrict a process' capability set. The
   code now handles both use cases, disallowing
   where the LSM wants to do that and peeling out
   capabilities where the LSM wants that.
4. ENOMEM handling in security_getprocattr.

Version 8 of the patch addresses:

1. An error in the indexing in out-of-memory
   error handling in non-macroed alloc hooks.
2. Broken up for size. Not bisectable.

Version 7 of the patch addresses:

1. security/capability.c has been removed and
   all the special case code for when there is
   no LSM hook has been moved to the function
   in security/security.c. There is no longer
   a capability_ops vector.
2. Tetsuo Handa suggested that putting list headers
   into the security_operations structure rather
   than allocating the list elements on the fly
   would reduce the amount of out-of-memory error
   code required. It also makes a lot of the list
   initialization and management easier.
3. Macros are back in security_hook functions by
   reviewer request.
4. The component of the memory leak introduced by
   allocated list entries when calling
   reset_security_ops() is no longer there. The
   Portion created by LSM code remains.

Version 6 of the patch addresses:

1. The array based hook calling loops have been
   replaced by hook lists. The blobs remain array
   based.
2. Hooks are inserted into the lists based on the
   order specified in the security= boot parameter.
   If you really want AppArmor called before Yama
   you can do that. If there is no security=
   parameter it goes back to first come, first
   called.
3. prctl is a special case that assumes a single
   provider for any given option.
4. The security_hook funtions have been un-macroed.
   This should make dealing with special cases
   easier at the cost of code bulk.
5. Hooks from the capability vector are called
   directly rather than getting put on lists.
   This makes the security_reset_ops process
   rational. It also makes it easy to change the
   cap_hook to always getting called.

Version 5 of the patch addresses:

1. Tetsuo Handa pointed out that handling of failures
   alloc hooks was still not correct in v4. The code
   now only calls the free hook for LSMs that have
   had their alloc hook successfully called. The alloc
   hooks have been de-macro-ized, too.
2. Removed the Yama special case. It is no longer
   necessary.

Version 4 of the patch addresses:

1. Removed the conditional CONFIG_SECURITY_COMPOSER.
   This removes the option for LSMs to opt out of the
   multiple concurrent LSM mechanism. It also prevents
   breaking the change into meaningful subsets.
2. Pulled the trivial hooks out of the capability LSM
   as the security_hook calls make calling them unnecessary.
3. Removed register_security as it has nothing to do.
4. Changed the way security_hook calls the LSM specific
   hooks so that the capability hook is only called if
   no other LSM has supplied a hook, rather than looking
   to see if there is a capability hook.
5. Removed security_fixup_ops. The capability LSM only
   contains "real" hooks. Removed security_fixdown_ops
   as well, for the same reason.
6. Simplified security_reset_ops and made it reasonably safe.


Version 3 of the patchset addresses:

1. Improvements to allocations in lsm_read for the
   securityfs lsm interface.
2. A repair to the ordering of an NULL check in
   security_module_enable.
3. Sharing of the inode_getsecurity, inode_setsecurity
   and inode_listsecurity hooks, even thougth there is
   no current contention for them.

Version 2 of the patchset addresses:

1. The lsm_set functions did not handle error cases.
   The on demand allocation has been replaced with a
   more robust scheme within the security_alloc hooks.
   This requires more change in security/security.c
   but has the advantage of being more likely to be
   correct.
2. reset_security_ops() didn't work, causing a panic
   on invocation. That's been fixed. The change is
   somewhat invasive relative to the functionality.
3. Add registration time detection of LSMs that are
   going to use hooks that can't (currently) be shared.

Provide a mechanism for using multiple LSMs on the same
running kernel. This mechanism is not backward compatible.
All LSMs must conform to it.

As David Howells suggested some time back, making Smack and
SELinux available at that same time has proven quite a
challenge. That work has been deferred and that particular
configuration disallowed.

The Smack LSM behavior has been tested. AppArmor, TOMOYO,
Yama and SELinux have been shown to boot, but have not been
functionally tested beyond the lack of obvious error messages
and complaints from kernel debugging facilities. The kernels
have been tested with Ubuntu 12.04 and Fedora 17.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---

 include/linux/lsm.h                 |  172 ++++
 include/linux/security.h            |  218 +++-
 security/Kconfig                    |   64 +-
 security/Makefile                   |    3 +-
 security/apparmor/context.c         |   10 +-
 security/apparmor/domain.c          |   19 +-
 security/apparmor/include/context.h |   13 +-
 security/apparmor/lsm.c             |   66 +-
 security/capability.c               | 1075 -------------------
 security/commoncap.c                |    6 -
 security/inode.c                    |   46 +-
 security/security.c                 | 1944 +++++++++++++++++++++++++++++------
 security/selinux/hooks.c            |  410 ++++----
 security/selinux/include/objsec.h   |    2 +
 security/selinux/include/xfrm.h     |    2 +-
 security/selinux/netlabel.c         |   13 +-
 security/selinux/selinuxfs.c        |    6 +-
 security/selinux/xfrm.c             |    9 +-
 security/smack/smack.h              |   14 +-
 security/smack/smack_access.c       |    2 +-
 security/smack/smack_lsm.c          |  367 +++----
 security/smack/smackfs.c            |   92 +-
 security/tomoyo/common.h            |    6 +-
 security/tomoyo/domain.c            |    2 +-
 security/tomoyo/securityfs_if.c     |    9 +-
 security/tomoyo/tomoyo.c            |   47 +-
 security/yama/Kconfig               |    7 -
 security/yama/yama_lsm.c            |   27 +-
 28 files changed, 2673 insertions(+), 1978 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
