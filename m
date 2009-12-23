From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 00/13] RFC libsemanage move to var, enable/disable module, and priority support
Date: Wed, 23 Dec 2009 18:25:47 -0500
Message-Id: <1261610760-4724-1-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Our motivations for this patchset are to:

* Move the semanage store - the portion of the SELinux configuration
  managed by libsemanage - to a more appropriate location in the
  filesystem. The current location - in /etc - is designated for
  administrator controlled configuration and is sometimes mounted
  read-only. By storing binary, program managed data in /etc libsemanage
  breaks administrator expectations. 

* Enable the overriding of modules in the module store without require
  the original modules to removed or modified. This allows
  administrators to customize the policy more fully while allowing the
  distribution provided policies to be left unmodified and continue to
  be updated by the package manager.

* Provide the ability for an administrator to disable a module without
  removing or overriding that module.

[Move to /var/lib/selinux]

Move the libsemanage private store
from /etc/selinux/<policy type>/modules
to   /var/lib/selinux/<policy type>

The benefits of this are:

* Permits the use of a read-only /etc.

* Conforms to the Filesystem Hierarchy Standard.

An additional change in layout structure moves the temporary space for
the active policy to an external temporary space. This has the benefit
of permitting source control management to be used on the private
policy.

[Module Priorities]

Module priorities modify libsemanage and the module store to allow
multiple modules with the same name to exist with different priorities.
Only the highest priority module is used to create the final system
policy. The addition of module priorities enables the modification of
the system policy without modifying individual modules. For example, it
allows an administrator to add his own policy module for apache,
completely replacing the distribution provided module, without changing
or removing the distribution policy. This has several benefits:

* Distribution provided policy package updates proceed normally - the
  distribution policy is inserted but the administrator provided policy
  remains active.

* Multiple levels allows distributors, 3rd party applications, system
  management tools (e.g., puppet), and local administrators to all make
  changes without conflicting.

* Semanage modifications of policy (e.g., port labeling) will be able to
  use high priority modules in the future to override defaults (requires
  the CIL[1] language changes).

[Enable/Disable Modules]

Modules gain an enabled / disabled status. Enabled modules are used by
semanage when building the active policy, and disabled modules are
ignored. The main benefit of this is that modules can be disabled
without out removing them from the store.

[Patchset Breakdown]

The patchset is broken down as follows:

Bug fixes:

libsemanage: fix type in tests makefile -o -> -O

Move the libsemanage store to /var/lib/selinux:

semanage: move permissive module creation to /tmp
libsemanage: move the module store to /var/lib/selinux
libsemanage: split final files into /var/lib/selinux/tmp
libsemanage: update unit tests for move to /var/lib/selinux

Implement support for the new libsemanage store layout:

libsemanage: add default priority to semanage_handle_t
libsemanage: augment semanage_module_info_t and provide semanage_module_key_t
libsemanage: get/set module info and enabled status
libsemanage: provide function to get new base module path
libsemanage: provide function to get new base module path
libsemanage: installing/upgrading/removing modules via info and key

Provide private headers for upstream tools to use:

libsemanage: new private api for unstable functions

Extend semodule to support enable/disable, priorities, and detailed listings:

semodule: add priority, enabled, and extended listing

Migration script for moving the libsemanage store:

semanage store migration script

Thanks for you feedback!

Caleb

[1] CIL RFC: http://marc.info/?l=selinux&m=124759244409438&w=2

Caleb Case (13):
  libsemanage: fix typo in tests makefile -o -> -O
  semanage: move permissive module creation to /tmp
  libsemanage: move the module store to /var/lib/selinux
  libsemanage: split final files into /var/lib/selinux/tmp
  libsemanage: update unit tests for move to /var/lib/selinux
  libsemanage: add default priority to semanage_handle_t
  libsemanage: augment semanage_module_info_t and provide
    semanage_module_key_t
  libsemanage: get/set module info and enabled status
  libsemanage: provide function to get new base module path
  libsemanage: installing/upgrading/removing modules via info and key
  libsemanage: new private api for unstable functions
  semodule: add priority, enabled, and extended listing
  semanage store migration script

 libsemanage/include/Makefile                     |    3 +
 libsemanage/include/semanage/private/handle.h    |   31 +
 libsemanage/include/semanage/private/modules.h   |  281 ++++
 libsemanage/include/semanage/private/semanage.h  |   26 +
 libsemanage/src/boolean_internal.h               |    4 +-
 libsemanage/src/booleans_file.c                  |    7 +-
 libsemanage/src/booleans_policydb.c              |    6 +-
 libsemanage/src/database_file.c                  |   45 +-
 libsemanage/src/database_file.h                  |    3 +-
 libsemanage/src/database_policydb.c              |   37 +-
 libsemanage/src/database_policydb.h              |    3 +-
 libsemanage/src/direct_api.c                     | 1652 +++++++++++++++++++---
 libsemanage/src/fcontext_internal.h              |    3 +-
 libsemanage/src/fcontexts_file.c                 |    7 +-
 libsemanage/src/genhomedircon.c                  |    3 +-
 libsemanage/src/handle.c                         |   23 +
 libsemanage/src/handle.h                         |    3 +
 libsemanage/src/handle_internal.h                |    1 +
 libsemanage/src/iface_internal.h                 |    4 +-
 libsemanage/src/interfaces_file.c                |    7 +-
 libsemanage/src/interfaces_policydb.c            |    6 +-
 libsemanage/src/libsemanage.map                  |   26 +
 libsemanage/src/module_internal.h                |   21 +
 libsemanage/src/modules.c                        |  999 +++++++++++++-
 libsemanage/src/modules.h                        |   76 +-
 libsemanage/src/node_internal.h                  |    4 +-
 libsemanage/src/nodes_file.c                     |    7 +-
 libsemanage/src/nodes_policydb.c                 |    6 +-
 libsemanage/src/policy.h                         |   36 +
 libsemanage/src/port_internal.h                  |    4 +-
 libsemanage/src/ports_file.c                     |    7 +-
 libsemanage/src/ports_policydb.c                 |    6 +-
 libsemanage/src/semanage_store.c                 |  794 ++++++++---
 libsemanage/src/semanage_store.h                 |   47 +-
 libsemanage/src/seuser_internal.h                |    4 +-
 libsemanage/src/seusers_file.c                   |    7 +-
 libsemanage/src/user_internal.h                  |    6 +-
 libsemanage/src/users_base_file.c                |    7 +-
 libsemanage/src/users_base_policydb.c            |    6 +-
 libsemanage/src/users_extra_file.c               |    7 +-
 libsemanage/tests/Makefile                       |    2 +-
 libsemanage/tests/test_semanage_store.c          |   34 +-
 libsemanage/utils/semanage_migrate_etc_to_var.py |  301 ++++
 policycoreutils/semanage/seobject.py             |   15 +-
 policycoreutils/semodule/semodule.8              |   25 +-
 policycoreutils/semodule/semodule.c              |  242 +++-
 46 files changed, 4267 insertions(+), 577 deletions(-)
 create mode 100644 libsemanage/include/semanage/private/handle.h
 create mode 100644 libsemanage/include/semanage/private/modules.h
 create mode 100644 libsemanage/include/semanage/private/semanage.h
 create mode 100755 libsemanage/utils/semanage_migrate_etc_to_var.py


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
