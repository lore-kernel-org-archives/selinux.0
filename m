MIME-Version: 1.0
In-Reply-To: <4DDAFB63.8070809@redhat.com>
References: <4DDAFB63.8070809@redhat.com>
Date: Tue, 24 May 2011 22:36:35 +0200
Message-ID: <BANLkTikws-F6MaAAWxMS_mE+0j+N9_a0hA@mail.gmail.com>
Subject: Re: [git] pull selinux tree for 2.6.40
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Eric Paris <eparis@redhat.com>
Cc: jmorris@namei.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric,

> Kohei Kaigai (1):
>      selinux: add type_transition with name extension support for selinuxfs

What is the current status of the patch to support object names that
includes either whitespaces or multibyte-characters?
Format of object names depends on type of userspace object manager,
so the above patch only handles half of the way.

The latest one is here:
http://marc.info/?l=selinux&m=130509897903810

Thanks,

2011/5/24 Eric Paris <eparis@redhat.com>:
> The following changes since commit 12a5a2621b1ee14d32beca35304d7c6076a58815:
>
>  Merge branch 'master' into next (2011-05-19 18:51:57 +1000)
>
> are available in the git repository at:
>
>  git://git.infradead.org/users/eparis/selinux.git master
>
> Andi Kleen (1):
>      SECURITY: Move exec_permission RCU checks into security modules
>
> Eric Paris (19):
>      SELinux: update git tree in MAINTAINERS
>      SELinux: delete debugging printks from filename_trans rule processing
>      SELinux: silence build warning when !CONFIG_BUG
>      SELinux: security_read_policy should take a size_t not ssize_t
>      SELINUX: Make selinux cache VFS RCU walks safe
>      LSM: split LSM_AUDIT_DATA_FS into _PATH and _INODE
>      LSM: separate LSM_AUDIT_DATA_DENTRY from LSM_AUDIT_DATA_PATH
>      SMACK: smack_file_lock can use the struct path
>      SELinux: fix comment to state filename_compute_type takes an objname not a qstr
>      SELinux: rename filename_compute_type argument to *type instead of *con
>      SELinux: skip filename trans rules if ttype does not match parent dir
>      SELinux: calculate and print hashtab stats with a generic function
>      SELinux: generic hashtab entry counter
>      SELinux: put name based create rules in a hashtable
>      SELinux: pass last path component in may_create
>      flex_array: flex_array_prealloc takes a number of elements, not an end
>      flex_arrays: allow zero length flex arrays
>      flex_array: allow 0 length elements
>      SELinux: introduce path_has_perm
>
> Greg Kroah-Hartman (1):
>      SELINUX: add /sys/fs/selinux mount point to put selinuxfs
>
> Harry Ciao (4):
>      SELinux: Add class support to the role_trans structure
>      SELinux: Compute role in newcontext for all classes
>      SELinux: Write class field in role_trans_write.
>      Initialize policydb.process_class eariler.
>
> Kohei Kaigai (1):
>      selinux: add type_transition with name extension support for selinuxfs
>
> Stephen Smalley (1):
>      selinux: Fix regression for Xorg
>
>  Documentation/flexible-arrays.txt   |    4 +-
>  MAINTAINERS                         |    3 +-
>  include/linux/flex_array.h          |    2 +-
>  include/linux/lsm_audit.h           |   11 +-
>  include/linux/security.h            |    2 +-
>  lib/flex_array.c                    |   48 +++++--
>  security/capability.c               |    2 +-
>  security/lsm_audit.c                |   59 +++++---
>  security/security.c                 |    6 +-
>  security/selinux/avc.c              |   36 ++++-
>  security/selinux/hooks.c            |  119 ++++++++++-------
>  security/selinux/include/avc.h      |   18 ++-
>  security/selinux/include/security.h |    9 +-
>  security/selinux/netnode.c          |    1 +
>  security/selinux/selinuxfs.c        |   28 ++++-
>  security/selinux/ss/policydb.c      |  254 +++++++++++++++++++++++------------
>  security/selinux/ss/policydb.h      |   12 ++-
>  security/selinux/ss/services.c      |   74 ++++++-----
>  security/smack/smack.h              |   11 +-
>  security/smack/smack_lsm.c          |   54 +++++---
>  20 files changed, 488 insertions(+), 265 deletions(-)
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>



-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
