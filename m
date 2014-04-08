Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s38ErbOi031990
 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2014 10:53:37 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov, setools-bugs@tresys.com
Subject: [PATCH 0/4] APOL Enhancements to support additional policy features
Date: Tue,  8 Apr 2014 15:52:58 +0100
Message-Id: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

These four patches will update setools-3.3.8.tar.bz2 available from
http://oss.tresys.com/projects/setools/wiki/download

I know this is not being fully supported but as I use APOL frequently
I thought I would update it to support the latest policy version 29 (I
could be the only user!!!). Tested on latest Fedora 20 x86_64

The enhancements and bug fixes are listed below. All patches should be
applied to setools-3.3.8 and then built as follows:

  autoreconf -i -s
  ./configure
  make
  make install

This will put the binaries in /usr/local/bin, data files in
/usr/local/share/setool-3.3, and libraries in /usr/local/lib.
Assuming that /usr/local/bin is in your $PATH and /usr/local/lib in
$LD_LIBRARY_PATH everything should now work.

PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib

APOL enhancements and bug fixes
-------------------------------
* Add permissive type and typebound support to Types tab.
* Add new Constraints tab to search all constraint statements.
* Add new Bounds tab to search for userbound, rolebound and
  typebound statements.
* Add new policy capabilities tab.
* Add filename type_transition support on TE Rules tab.
* Add new Default Object tab to support defaultuser, defaultrole,
  defaulttype and defaultrange rules.
* Add new Namespaces tab to list CIL namespaces. This will also
  show any users, roles, types, classes, booleans, sensitivities
  and categories declared in each namespace. A global namespace is
  automatically generated (GLOBAL-NS).
* Update Query/Policy Summary page to show the number of new
  rules added plus the policy handle_unknown flag.
* Fixed File Contexts tab to stop hang when building the fc
  index when broken links/files found (libsefs). Also fixes indexcon util.
* Fixed Booleans tab to display CIL namespace booleans.
* Updated apol_help.txt to reflect the changes made plus how to
  load the running policy.

Richard Haines (4):
  setools: APOL Add constraints and filename transition support
  setools: APOL Add support for permissive types, polcaps, handle_unknown
  setools: APOL Add type, user, role bounds support
  setools: APOL Add default_objects and CIL policy namespaces tabs

 ChangeLog                                   |   26 +
 apol/Makefile.am                            |    5 +
 apol/apol_help.txt                          |   90 +-
 apol/bounds_tab.tcl                         |  433 ++++++++
 apol/cond_bools_tab.tcl                     |   12 +-
 apol/constraints_tab.tcl                    | 1589 +++++++++++++++++++++++++++
 apol/default_objects_tab.tcl                |  370 +++++++
 apol/initial_sids_tab.tcl                   |    2 +-
 apol/namespaces_tab.tcl                     |  206 ++++
 apol/polcap_tab.tcl                         |   73 ++
 apol/terules_tab.tcl                        |  201 +++-
 apol/top.tcl                                |  213 +++-
 apol/types_tab.tcl                          |   77 +-
 libapol/include/apol/Makefile.am            |    2 +
 libapol/include/apol/bounds-query.h         |  177 +++
 libapol/include/apol/default-object-query.h |   78 ++
 libapol/include/apol/ftrule-query.h         |   14 +-
 libapol/include/apol/policy-query.h         |    2 +
 libapol/include/apol/policy.h               |    9 +
 libapol/src/Makefile.am                     |    2 +
 libapol/src/bounds-query.c                  |  216 ++++
 libapol/src/default-object-query.c          |   87 ++
 libapol/src/ftrule-query.c                  |    4 +-
 libapol/src/libapol.map                     |    4 +
 libapol/src/policy-query-internal.h         |   19 +
 libapol/src/policy-query.c                  |   23 +
 libapol/src/policy.c                        |    9 +
 libapol/swig/apol.i                         |  311 ++++++
 libqpol/include/qpol/Makefile.am            |    2 +
 libqpol/include/qpol/bounds_query.h         |  162 +++
 libqpol/include/qpol/default_object_query.h |  113 ++
 libqpol/include/qpol/policy.h               |   24 +-
 libqpol/src/Makefile.am                     |    2 +
 libqpol/src/bounds_query.c                  |  332 ++++++
 libqpol/src/constraint_query.c              |    9 +-
 libqpol/src/default_object_query.c          |  290 +++++
 libqpol/src/libqpol.map                     |    5 +
 libqpol/src/policy.c                        |   68 ++
 libqpol/swig/qpol.i                         |  372 ++++++-
 libsefs/src/db.cc                           |    9 +-
 libsefs/src/new_ftw.c                       |    6 +-
 41 files changed, 5620 insertions(+), 28 deletions(-)
 create mode 100644 apol/bounds_tab.tcl
 create mode 100644 apol/constraints_tab.tcl
 create mode 100644 apol/default_objects_tab.tcl
 create mode 100644 apol/namespaces_tab.tcl
 create mode 100644 apol/polcap_tab.tcl
 create mode 100644 libapol/include/apol/bounds-query.h
 create mode 100644 libapol/include/apol/default-object-query.h
 create mode 100644 libapol/src/bounds-query.c
 create mode 100644 libapol/src/default-object-query.c
 create mode 100644 libqpol/include/qpol/bounds_query.h
 create mode 100644 libqpol/include/qpol/default_object_query.h
 create mode 100644 libqpol/src/bounds_query.c
 create mode 100644 libqpol/src/default_object_query.c

-- 
1.9.0
