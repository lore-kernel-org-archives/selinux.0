Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7HJKEwb010230
 for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2017 15:20:14 -0400
Received: by mail-pg0-f51.google.com with SMTP id i12so47748924pgr.3
 for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2017 11:04:42 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: dcashman@android.com, dcashman@google.com, jeffv@google.com,
 jwcart2@tycho.nsa.gov
Date: Thu, 17 Aug 2017 11:04:24 -0700
Message-Id: <20170817180425.141871-1-dcashman@android.com>
Subject: [PATCH 0/1] RFC: Allow for multiple cil declarations.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Cashman <dcashman@google.com>

In Android O, the SELinux policy was split from a monolithic policy
created at build-time for each device into two main components, one
on /system and one on /vendor, which get combined at boot.  This
introduced several new challenges, including the creation of a need
to maintain compatibility between the two policies, i.e. new policy
on the /system image needs to work with the /vendor policy that is
based on the policy it's replacing, and updates to the /vendor policy
need to work with the /system policy.

The ultimate goal of this is to allow updates to /system without
changing /vendor.  Android currently accomplishes this by exporting
'public' policy types that /vendor policy can use. It makes sure that
changes in object labels don't break the /vendor policy by changing all
public types into attributes, copying the public policy into the /vendor
policy and keepign a mapping between public types and the attributes
that are included in the /vendor policy.

This leads to complications, though, when trying to use different /system
images with the same /vendor image: the /vendor policy might rely on a
/system policy to provide a type definition or an attribute definition,
but another, non-customized /system policy might not provide it.

Luckily, CIL statements are often reduced to the minimum amount of
information needed and are generally order-independent.  Type statements,
for instance, are just the type keyword followed by an identifier, and I
believe nothing is lost in allowing them to be repeated.

This patch is a proposal for one way to allow multiple declarations.  At
the moment, android is primarily concerned with types and attributes, but
this could (should!) be extended to many other declaration types.

The proposal here is to modify cil_gen_node() to check to see if the cil_db
supports multiple declarations, and if so, to check whether or not the
repeated symbol is eligible to share the existing, already-stored datum. The
only types considered so far have been CIL_TYPE and CIL_TYPEATTRIBUTE, both
of which intall empty datums during AST building, so they automatically return
true.

Signed-off-by: Dan Cashman <dcashman@android.com>

Dan Cashman (1):
  libsepol: cil: Add ability to redeclare types[attributes]

 libsepol/cil/include/cil/cil.h   |  1 +
 libsepol/cil/src/cil.c           |  5 +++++
 libsepol/cil/src/cil_build_ast.c | 46 ++++++++++++++++++++++++++++++++++------
 libsepol/cil/src/cil_internal.h  |  1 +
 secilc/secilc.c                  |  9 +++++++-
 5 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.14.1.480.gb18f417b89-goog
