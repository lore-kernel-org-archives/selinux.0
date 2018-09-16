Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8GHQEQC029538
 for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2018 13:26:16 -0400
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
 James Morris <jmorris@namei.org>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
 john.johansen@canonical.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
 sds@tycho.nsa.gov, linux-fsdevel@vger.kernel.org, adobriyan@gmail.com,
 casey.schaufler@intel.com
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
 <CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3cd46663-e566-5ffc-32a4-00a90cd1346e@schaufler-ca.com>
Date: Sun, 16 Sep 2018 10:25:43 -0700
MIME-Version: 1.0
In-Reply-To: <CAJHCu1+Nja-XqfFKdxu2hDcUBzgvvjcf42yeGnUuVY3wsrZfSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of
 S.A.R.A and Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/16/2018 9:54 AM, Salvatore Mesoraca wrote:
> On Wed, 12 Sep 2018, James Morris <jmorris@namei.org> wrote:
>> Adding the SARA and LandLock authors for review & comment.
>>
>> Salvatore & Mickaël: does this patchset meet your needs for merging to
>> mainline?
> Since the last time I submitted the patch to the ML, it grew a bit: now it needs
> inode's blob stacking (which is already included for Landlock) and
> kern_ipc_perm's
> blob stacking.
> The last one isn't implemented in this patchset, but it isn't
> absolutely necessary.
> I can merge a version of SARA that doesn't need it and than update it
> when possible.
> I can provide the same level of protection without using kern_ipc_perm
> blob, I'm using it
> just to minimize some potential side effects.

Adding kern_ipc_perm is easy. As it looks like there will need to be
a few revisions I will add it to the next set.

>
>> On Tue, 11 Sep 2018, Casey Schaufler wrote:
>>
>>> LSM: Module stacking in support of S.A.R.A and Landlock
>>>
>>> v2: Reduce the patchset to what is required to support
>>>     the proposed S.A.R.A. and LandLock security modules
>>>
>>> The S.A.R.A. security module is intended to be used
>>> in conjunction with other security modules. It requires
>>> state to be maintained for the credential, which
>>> in turn requires a mechanism for sharing the credential
>>> security blob. The module also requires mechanism for
>>> user space manipulation of the credential information,
>>> hence an additional subdirectory in /proc/.../attr.
>>>
>>> The LandLock security module provides user configurable
>>> policy in the secmark mechanism. It requires data in
>>> the credential, file and inode security blobs. For this
>>> to be used along side the existing "major" security
>>> modules mechanism for sharing these blobs is provided.
>>>
>>> A side effect of providing sharing of the crendential
>>> security blob is that the TOMOYO module can be used at
>>> the same time as the other "major" modules.
>>>
>>> The mechanism for configuring which security modules are
>>> enabled has to change when stacking in enabled. Any
>>> module that uses just the security blobs that are shared
>>> can be selected. Additionally, one other "major" module
>>> can be selected.
>>>
>>> The security module stacking issues around networking and
>>> IPC are not addressed here as they are beyond what is
>>> required for TOMOYO, S.A.R.A and LandLock.
>>>
>>> git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saralock
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  Documentation/admin-guide/LSM/index.rst |  23 ++-
>>>  fs/proc/base.c                          |  64 ++++++-
>>>  fs/proc/internal.h                      |   1 +
>>>  include/linux/lsm_hooks.h               |  20 ++-
>>>  include/linux/security.h                |  15 +-
>>>  kernel/cred.c                           |  13 --
>>>  security/Kconfig                        |  92 ++++++++++
>>>  security/apparmor/domain.c              |   2 +-
>>>  security/apparmor/include/cred.h        |  24 ++-
>>>  security/apparmor/include/file.h        |   9 +-
>>>  security/apparmor/include/lib.h         |   4 +
>>>  security/apparmor/lsm.c                 |  53 ++++--
>>>  security/apparmor/task.c                |   6 +-
>>>  security/security.c                     | 293 ++++++++++++++++++++++++++++++--
>>>  security/selinux/hooks.c                | 215 ++++++++---------------
>>>  security/selinux/include/objsec.h       |  37 +++-
>>>  security/selinux/selinuxfs.c            |   5 +-
>>>  security/selinux/xfrm.c                 |   4 +-
>>>  security/smack/smack.h                  |  42 ++++-
>>>  security/smack/smack_access.c           |   4 +-
>>>  security/smack/smack_lsm.c              | 283 +++++++++++-------------------
>>>  security/smack/smackfs.c                |  18 +-
>>>  security/tomoyo/common.h                |  31 +++-
>>>  security/tomoyo/domain.c                |   4 +-
>>>  security/tomoyo/securityfs_if.c         |  15 +-
>>>  security/tomoyo/tomoyo.c                |  57 +++++--
>>>  26 files changed, 899 insertions(+), 435 deletions(-)
>>>
>> --
>> James Morris
>> <jmorris@namei.org>
