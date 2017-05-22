Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MD8oLa011891
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 09:08:50 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v3 0/9] SELinux user space support for Infiniband RDMA
Date: Mon, 22 May 2017 16:08:22 +0300
Message-Id: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Infiniband applications access HW from user-space -- traffic is generated
directly by HW, bypassing the kernel. Consequently, Infiniband Partitions,
which are associated directly with HW transport endpoints, are a natural
choice for enforcing granular mandatory access control for Infiniband. QPs
may only send or receives packets tagged with the corresponding partition
key (PKey). The PKey is not a cryptographic key; it's a 16 bit number
identifying the partition.

Every Infiniband fabric is controlled by a central Subnet Manager (SM).
The SM provisions the partitions by assigning each port with the
partitions it can access. In addition, the SM tags each port with a subnet
prefix, which identifies the subnet. Determining which users are allowed
to access which partition keys on a given subnet forms an effective policy
for isolating users on the fabric. Any application that attempts to send
traffic on a given subnet is automatically subject to the policy,
regardless of which device and port it uses. SM software configures the
subnet through a privileged Subnet Management Interface (SMI), which is
presented by each Infiniband port. Thus, the SMI must also be controlled
to prevent unauthorized changes to fabric configuration and partitioning. 

To support access control for IB partitions and subnet management,
security contexts must be provided for two new types of objects - PKeys
and IB end ports.

A PKey label consists of a subnet prefix and a range of PKey values and is
similar to the labeling mechanism for netports. Each Infiniband port can
reside on a different subnet. So labeling the PKey values for specific
subnet prefixes provides the user maximum flexibility, as PKey values may
be determined independently for different subnets. There is a single
access vector for PKeys called "access".

An Infiniband port is labeled by device name and port number. There is a
single access vector for IB end ports called "manage_subnet".

This series adds support for parsing the new labeling mechanisms and
generating the policy. It also adds support for runtime labling of PKeys
and IB end ports via semanage.

This series is quite large, but most of the code is very similar to
existing code for the other *con labels.

Example label syntax:
ibpkeycon fe80:: 0xFFFF gen_context(system_u:object_r:default_ibpkey_t,s0)
ibpkeycon fe80:: 0-0x10 gen_context(system_u:object_r:public_ibpkey_t,s0)

ibendportcon mlx5_0 1 gen_context(system_u:object_r:opensm_ibendport_t,s0)

Example semanage commands:
semanage ibpkey -l
semanage ibpkey -a -t default_ibpkey_t -x fe80:: 0x8FFF
semanage ibpkey -D

semanage ibendport -l
semanage ibendport -a -t opensm_ibendport_t -z mlx4_0 2
semanage ibenpdort -d -z mlx4_0 2

---
v1:
- Fixed seobject ibpkey delete all name bug (pkey vs ibpkey).

Stephen Smalley:
- Always use s6_addr vs s6_addr32, remove DARWIN #ifdefs.
- Removed unused parameters from new sepol_*_sid functions.
- Got rid of variable length subnet prefix handling, it never varied. 

James Carter:
- Add kernel_to_cil and kernel_to_conf implementations for new OCONs.

Jason Zaman:
- Use SETools directly to query types by attribute in seobject.py.


- See individual patches for more detailed changes.

v2:
- Rebased over Stephens MOD_VERSION change.

Stephen Smalley:
- Bound check new ocontext fields
- Only store 8 bytes of subnet prefix in binary policy
- Make it so semanage doesn't crash if ipbkey_type or ibendport_type are
  undefined.
- Don't define INET6_ADDRLEN, use sizeof(struct in6_addr)

James Carter:
- Sort new ocontexts in kernel_to_common.c

- Additional smaller changes noted in specific patches.

v3:
Stephen Smalley:
- Store subnet prefix as uint64_t vs char* in ibpkey record and key types.

Daniel Jurgens (9):
  checkpolicy: Add support for ibpkeycon labels
  libsepol: Add ibpkey ocontext handling
  libsepol: Add Infiniband Pkey handling to CIL
  checkpolicy: Add support for ibendportcon labels
  libsepol: Add ibendport ocontext handling
  libsepol: Add IB end port handling to CIL
  semanage: Update semanage to allow runtime labeling of Infiniband
    Pkeys
  semanage: Update semanage to allow runtime labeling of ibendports
  semanage: Update man pages for infiniband

 checkpolicy/checkpolicy.c                        |  47 +++
 checkpolicy/policy_define.c                      | 187 +++++++++
 checkpolicy/policy_define.h                      |   2 +
 checkpolicy/policy_parse.y                       |  27 +-
 checkpolicy/policy_scan.l                        |   5 +
 libsemanage/include/semanage/ibendport_record.h  |  62 +++
 libsemanage/include/semanage/ibendports_local.h  |  36 ++
 libsemanage/include/semanage/ibendports_policy.h |  28 ++
 libsemanage/include/semanage/ibpkey_record.h     |  72 ++++
 libsemanage/include/semanage/ibpkeys_local.h     |  36 ++
 libsemanage/include/semanage/ibpkeys_policy.h    |  28 ++
 libsemanage/include/semanage/semanage.h          |   6 +
 libsemanage/src/direct_api.c                     |  57 ++-
 libsemanage/src/handle.h                         |  50 ++-
 libsemanage/src/ibendport_internal.h             |  48 +++
 libsemanage/src/ibendport_record.c               | 154 +++++++
 libsemanage/src/ibendports_file.c                | 157 +++++++
 libsemanage/src/ibendports_local.c               | 153 +++++++
 libsemanage/src/ibendports_policy.c              |  55 +++
 libsemanage/src/ibendports_policydb.c            |  62 +++
 libsemanage/src/ibpkey_internal.h                |  52 +++
 libsemanage/src/ibpkey_record.c                  | 182 +++++++++
 libsemanage/src/ibpkeys_file.c                   | 181 +++++++++
 libsemanage/src/ibpkeys_local.c                  | 164 ++++++++
 libsemanage/src/ibpkeys_policy.c                 |  52 +++
 libsemanage/src/ibpkeys_policydb.c               |  62 +++
 libsemanage/src/libsemanage.map                  |   2 +
 libsemanage/src/policy_components.c              |   9 +-
 libsemanage/src/semanage_store.c                 |   2 +
 libsemanage/src/semanage_store.h                 |   2 +
 libsemanage/src/semanageswig.i                   |   6 +
 libsemanage/src/semanageswig_python.i            |  86 ++++
 libsemanage/utils/semanage_migrate_store         |   4 +-
 libsepol/cil/src/cil.c                           |  37 ++
 libsepol/cil/src/cil_binary.c                    |  68 ++++
 libsepol/cil/src/cil_binary.h                    |  24 ++
 libsepol/cil/src/cil_build_ast.c                 | 151 +++++++
 libsepol/cil/src/cil_build_ast.h                 |   4 +
 libsepol/cil/src/cil_copy_ast.c                  |  51 +++
 libsepol/cil/src/cil_copy_ast.h                  |   1 +
 libsepol/cil/src/cil_flavor.h                    |   2 +
 libsepol/cil/src/cil_internal.h                  |  20 +
 libsepol/cil/src/cil_policy.c                    |  31 ++
 libsepol/cil/src/cil_post.c                      |  87 ++++
 libsepol/cil/src/cil_post.h                      |   2 +
 libsepol/cil/src/cil_reset_ast.c                 |  19 +
 libsepol/cil/src/cil_resolve_ast.c               |  55 +++
 libsepol/cil/src/cil_resolve_ast.h               |   2 +
 libsepol/cil/src/cil_tree.c                      |  29 +-
 libsepol/cil/src/cil_verify.c                    |  46 +++
 libsepol/include/sepol/ibendport_record.h        |  68 ++++
 libsepol/include/sepol/ibendports.h              |  45 +++
 libsepol/include/sepol/ibpkey_record.h           |  75 ++++
 libsepol/include/sepol/ibpkeys.h                 |  44 ++
 libsepol/include/sepol/policydb/policydb.h       |  37 +-
 libsepol/include/sepol/policydb/services.h       |  16 +
 libsepol/include/sepol/sepol.h                   |   4 +
 libsepol/src/expand.c                            |  15 +
 libsepol/src/ibendport_internal.h                |  18 +
 libsepol/src/ibendport_record.c                  | 298 ++++++++++++++
 libsepol/src/ibendports.c                        | 255 ++++++++++++
 libsepol/src/ibpkey_internal.h                   |  21 +
 libsepol/src/ibpkey_record.c                     | 379 +++++++++++++++++
 libsepol/src/ibpkeys.c                           | 251 ++++++++++++
 libsepol/src/kernel_to_cil.c                     | 104 +++++
 libsepol/src/kernel_to_common.c                  |  37 ++
 libsepol/src/kernel_to_conf.c                    | 104 +++++
 libsepol/src/libsepol.map.in                     |   2 +
 libsepol/src/module_to_cil.c                     |  55 +++
 libsepol/src/policydb.c                          |  59 ++-
 libsepol/src/services.c                          |  74 ++++
 libsepol/src/write.c                             |  30 ++
 python/semanage/semanage                         | 116 +++++-
 python/semanage/semanage-ibendport.8             |  66 +++
 python/semanage/semanage-ibpkey.8                |  66 +++
 python/semanage/semanage.8                       |  16 +-
 python/semanage/seobject.py                      | 494 +++++++++++++++++++++++
 77 files changed, 5418 insertions(+), 36 deletions(-)
 create mode 100644 libsemanage/include/semanage/ibendport_record.h
 create mode 100644 libsemanage/include/semanage/ibendports_local.h
 create mode 100644 libsemanage/include/semanage/ibendports_policy.h
 create mode 100644 libsemanage/include/semanage/ibpkey_record.h
 create mode 100644 libsemanage/include/semanage/ibpkeys_local.h
 create mode 100644 libsemanage/include/semanage/ibpkeys_policy.h
 create mode 100644 libsemanage/src/ibendport_internal.h
 create mode 100644 libsemanage/src/ibendport_record.c
 create mode 100644 libsemanage/src/ibendports_file.c
 create mode 100644 libsemanage/src/ibendports_local.c
 create mode 100644 libsemanage/src/ibendports_policy.c
 create mode 100644 libsemanage/src/ibendports_policydb.c
 create mode 100644 libsemanage/src/ibpkey_internal.h
 create mode 100644 libsemanage/src/ibpkey_record.c
 create mode 100644 libsemanage/src/ibpkeys_file.c
 create mode 100644 libsemanage/src/ibpkeys_local.c
 create mode 100644 libsemanage/src/ibpkeys_policy.c
 create mode 100644 libsemanage/src/ibpkeys_policydb.c
 create mode 100644 libsepol/include/sepol/ibendport_record.h
 create mode 100644 libsepol/include/sepol/ibendports.h
 create mode 100644 libsepol/include/sepol/ibpkey_record.h
 create mode 100644 libsepol/include/sepol/ibpkeys.h
 create mode 100644 libsepol/src/ibendport_internal.h
 create mode 100644 libsepol/src/ibendport_record.c
 create mode 100644 libsepol/src/ibendports.c
 create mode 100644 libsepol/src/ibpkey_internal.h
 create mode 100644 libsepol/src/ibpkey_record.c
 create mode 100644 libsepol/src/ibpkeys.c
 create mode 100644 python/semanage/semanage-ibendport.8
 create mode 100644 python/semanage/semanage-ibpkey.8

-- 
2.12.2
