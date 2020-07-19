Return-Path: <SRS0=eLZI=A6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04524C433E0
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F93A207DD
	for <selinux@archiver.kernel.org>; Sun, 19 Jul 2020 18:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="cyLVh46k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGSSR1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSSR0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Jul 2020 14:17:26 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62931C0619D2
        for <selinux@vger.kernel.org>; Sun, 19 Jul 2020 11:17:26 -0700 (PDT)
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 0F4262A1010;
        Sun, 19 Jul 2020 20:17:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 0F4262A1010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595182644;
        bh=DODsMOp4lR85x+B1ov2PsXrJEfVyFzq4R/LMGEPzqoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyLVh46k9g6S054cqJp6gFR/xdwDSLDRlVcg0skLABy977Q1Z6R8NHU5CUkzZ4/hx
         H+7FEGIvdTkoWLbf9Lw6BeaeSSqLZTDE6GYQ/H/IHw+n2qkS8PNCtvlnqndrKShBpO
         Dlt3e8DxzBJTnlrzq08yYAa+yo/9kCoMnUJokdho=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v5] adds CIL policy with makefile
Date:   Sun, 19 Jul 2020 20:17:04 +0200
Message-Id: <20200719181704.1583398-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718104842.1333101-1-dominick.grift@defensec.nl>
References: <20200718104842.1333101-1-dominick.grift@defensec.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This example CIL policy takes a different approach:

1. Leverages CIL
2. Installs using semodule to make it tunable at runtime (but you can obviously also use secilc to build a monolithic version and deploy that)
3. Makes few assumptions about variables
4. Leverages handleunknown allow and declares least required access vectors so that you can pick and choose which access vectors you want to use and ignore the remainder
5. Leverages unlabeled and file ISID and makes no assumptions about any volatile filesystems you may or may not use
6. As small and simple as reasonably possible, heavily documented
7. Modern, Requires SELinux 3.1

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: rename XWAYLAND.md to XSERVER_XWAYLAND.md and cover both Xserver as well as Xwayland
V3: fix typo in XSERVER_XWAYLAND.md and exclude x_contexts altogether
v4: remove XSERVER_XWAYLAND and add the note to README.md, redo README.md and clean up cil-policy.cil
v5: add -F to fixfiles onboot (onboot should probably just imply -F)

 src/cil_overview.md                           |  11 +
 src/notebook-examples/README.md               |   2 +
 src/notebook-examples/cil-policy/Makefile     |  31 ++
 src/notebook-examples/cil-policy/README.md    |  90 ++++
 .../cil-policy/cil-policy.cil                 | 448 ++++++++++++++++++
 5 files changed, 582 insertions(+)
 create mode 100644 src/notebook-examples/cil-policy/Makefile
 create mode 100644 src/notebook-examples/cil-policy/README.md
 create mode 100644 src/notebook-examples/cil-policy/cil-policy.cil

diff --git a/src/cil_overview.md b/src/cil_overview.md
index a05aad5..1403666 100644
--- a/src/cil_overview.md
+++ b/src/cil_overview.md
@@ -135,6 +135,17 @@ Usage: build-sepolicy [-k] [-M] [-c|-p|-s] -d flask_directory -o output_file
 -d    Directory containing the initial_sids, security_classes and access_vectors Flask files.
 -o    The output file that will contain the policy source or header file.
 ```
+There is another CIL policy in the notebook examples called
+"cil-policy" that takes a slightly different approach where the goal
+is to keep the policy as simple as possible. It requires `semodule`,
+Linux 5.7, SELinux 3.1 and can be installed by executing
+`make install`. It leverages some modern SELinux features, most
+notably where the requirement for ordered security classes is lifted.
+With this you are no longer expected to be aware of all the access
+vectors managed by Linux in order to align your security class
+declarations with the order in which they are declared in the kernel.
+A module store is created by `semodule` to give easy access to the
+source and that allows for full control over the policy.
 
 <br>
 
diff --git a/src/notebook-examples/README.md b/src/notebook-examples/README.md
index 488ec6e..1bb611b 100644
--- a/src/notebook-examples/README.md
+++ b/src/notebook-examples/README.md
@@ -2,6 +2,8 @@
 
 This area contains the following directories:
 
+***cil-policy*** - Contains info to build and install simple CIL policy.
+
 ***network*** - Contains CIPSO, CALIPSO and IPSEC examples.
 
 ***selinux-policy*** - Contains info to build simple kernel and CIL policy.
diff --git a/src/notebook-examples/cil-policy/Makefile b/src/notebook-examples/cil-policy/Makefile
new file mode 100644
index 0000000..ec60834
--- /dev/null
+++ b/src/notebook-examples/cil-policy/Makefile
@@ -0,0 +1,31 @@
+# -*- Mode: makefile; indent-tabs-mode: t -*-
+# SPDX-License-Identifier: Unlicense
+
+.PHONY: install
+
+all: install
+
+install:
+	mkdir -p /etc/selinux/cil-policy/{contexts,logins,policy,contexts/files,contexts/users}
+	touch /etc/selinux/cil-policy/contexts/customizable_types
+	touch /etc/selinux/cil-policy/contexts/file_contexts.subs_dist
+	echo -e """<!DOCTYPE busconfig PUBLIC \
+\"-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN\" \
+\n\"http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd\"> \
+\n<busconfig> \
+\n<selinux> \
+\n</selinux> \
+\n</busconfig>""" > /etc/selinux/cil-policy/contexts/dbus_contexts
+	echo "sys.role:sys.isid sys.role:sys.isid" > /etc/selinux/cil-policy/contexts/default_contexts
+	echo "sys.role:sys.isid" > /etc/selinux/cil-policy/contexts/default_type
+	echo "sys.role:sys.isid" > /etc/selinux/cil-policy/contexts/failsafe_context
+	echo -e """cdrom sys.id:sys.role:sys.isid \
+\nfloppy sys.id:sys.role:sys.isid \
+\ndisk sys.id:sys.role:sys.isid""" > /etc/selinux/cil-policy/contexts/files/media
+	echo "privsep_preauth=sys.isid" > /etc/selinux/cil-policy/contexts/openssh_contexts
+	echo "sys.id:sys.role:sys.isid" > /etc/selinux/cil-policy/contexts/removable_context
+	echo "sys.isid" > /etc/selinux/cil-policy/contexts/securetty_types
+	echo "sys.id:sys.role:sys.isid" > /etc/selinux/cil-policy/contexts/virtual_domain_context
+	echo -e """sys.id:sys.role:sys.isid \
+\nsys.id:sys.role:sys.isid""" > /etc/selinux/cil-policy/contexts/virtual_image_context
+	semodule --priority=100 -N -s cil-policy -i cil-policy.cil
diff --git a/src/notebook-examples/cil-policy/README.md b/src/notebook-examples/cil-policy/README.md
new file mode 100644
index 0000000..7097fd7
--- /dev/null
+++ b/src/notebook-examples/cil-policy/README.md
@@ -0,0 +1,90 @@
+# Tiny CIL policy that is mutable at runtime
+
+The purpose of this tiny SELinux policy is to demonstrate what is
+least required to get started, and it can be used as a base for your
+own security policy or just to experiment with. The policy is written
+in Common Intermediate Language and is installed with semodule to
+provide easy access to all aspects at runtime.
+
+A single security context is provided that is associated with
+everything in memory only and to really get started you are expected
+to make an inventory of your filesystems and to enable labeling
+support for your filesystems accordingly before you proceed.
+
+Only eight security classes and two access vector permissions are
+declared. AVC allow rules for these two access vector permissions are
+associated with the single security context to give full access.
+Unknown access vectors are allowed to enable you to pick and choose
+which access vectors to leverage. You can get a list of unknown Linux
+security classes and access vector permissions from `dmesg`, and any
+user space object managers are likely to report unknown access vectors
+using either "USER_AVC" or "USER_SELINUX_ERR" type audit records. You
+are expected to declare any access vectors you require and then to
+associate them accordingly with access vector rules to allow access.
+
+The type-enforcement (TE), as well as identity-based (IBAC) and
+role-based (RBAC) access control security models are enabled. Optional
+security models such as multi-level security can be added with
+relative easy.
+
+Common Intermediate Language is a modern source based policy language
+that together with a module store that can be accessed with `semodule`
+at runtime provides optimal flexibility in your interactions with
+SELinux. It is recommended that you use the `setools` policy analysis
+suite to its full potential to get any information about the state of
+your policy.
+
+The cil-policy addresses some of the intricacies involved with getting
+started without making assumptions about your environment and
+requirements. You are enouraged to leverage CIL to its full potential
+and to keep its documentation handy.
+
+## Getting started
+
+```
+make install
+cat > /etc/selinux/config <<EOF
+SELINUX=enforcing
+SELINUXTYPE=cil-policy
+EOF
+```
+
+If you are switching to cil-policy from another policy then a system
+reboot is not strictly required:
+
+```
+semodule -B
+```
+
+Your first step to actually leverage cil-policy will likely be to
+enable labeling support for at least your non-volatile filesystems
+and to apply labels according to the file context specifications
+defined in the policy.
+
+For example if you use `ext4` filesystems:
+
+```
+echo '(fsuse xattr "ext4" (sys.id sys.role sys.isid ((s0)(s0))))' > myfs.cil
+semodule -i myfs.cil
+fixfiles -F onboot && reboot
+```
+
+To modify the existing cil-policy:
+
+```
+semodule -E cil-policy
+emacs cil-policy.cil
+semodule -X 101 -i cil-policy.cil
+```
+
+Use your favorite text editor to write policy in [Common Intermediate Language](https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/README.md),
+manage it with `semodule`, and analyze it with `setools`.
+
+## Important
+
+If you are using Xserver or Xwayland then the following is required:
+
+```
+echo "(boolean xserver_object_manager false)" > disablexace.cil
+semodule -i disablexace.cil
+```
diff --git a/src/notebook-examples/cil-policy/cil-policy.cil b/src/notebook-examples/cil-policy/cil-policy.cil
new file mode 100644
index 0000000..9289403
--- /dev/null
+++ b/src/notebook-examples/cil-policy/cil-policy.cil
@@ -0,0 +1,448 @@
+;; -*- mode: CIL; fill-column: 79; indent-tabs-mode: nil; -*-
+;; SPDX-License-Identifier: Unlicense
+
+;;
+;; Policy configuration.
+;;
+;; By allowing unknown access vectors we can start with a reduced number
+;; of declared security classes and access vector permissions. Use
+;; `dmesg | grep -i selinux` to see which security classes and access vector
+;; permissions managed by Linux can be leveraged in the policy.
+;;
+
+(handleunknown allow)
+
+;;
+;; Policy configuration.
+;;
+;; Disable the MLS security model support for simplicity, but CIL still
+;; requires us to write our policy with minimal MLS-awareness. Remember that we
+;; can always add full or partial Multi-level security support later.
+;;
+
+(mls false)
+
+;;
+;; Access vector declarations and (un)ordering.
+;;
+;; SELinux requires that the process security class, transition and
+;; dyntransition access vector permissions are declared. CIL requires at least
+;; one declared access vector and access vector rule as well so this is a good
+;; starting point. All security classes can be "unordered" with
+;; Linux 5.7/SELinux 3.1 but we are still required to use the classorder
+;; statement to do so.
+;;
+
+(class process (dyntransition transition))
+(classorder (unordered process))
+
+;;
+;; Access vector declarations and (un)ordering.
+;;
+;; To be able to associate roles with files we leverage defaultrole rules that
+;; require file security classes to be declared. Their associated access vector
+;; permissions are omitted for simplicity and to allow one to pick and choose
+;; permissions that one may want to leverage in the policy.
+;;
+
+(class blk_file ())
+(classorder (unordered blk_file))
+
+(class chr_file ())
+(classorder (unordered chr_file))
+
+(class dir ())
+(classorder (unordered dir))
+
+(class fifo_file ())
+(classorder (unordered fifo_file))
+
+(class file ())
+(classorder (unordered file))
+
+(class lnk_file ())
+(classorder (unordered lnk_file))
+
+(class sock_file ())
+(classorder (unordered sock_file))
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The devnull initial security identifier is used to associate a specified
+;; security context with "fixed" null device objects used to enforce access
+;; control on file operations, for example read.
+;;
+
+(sid devnull)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The file initial security identifier is used to associate a specified
+;; security context with objects that have no label, for example formatted
+;; filesystems that are not labeled.
+;;
+
+(sid file)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The kernel initial security identifier is used to associate a specified
+;; security context with processes that were initialized before SELinux was
+;; initialized, for example kernel threads.
+;;
+
+(sid kernel)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The netif initial security identifier is used to associate a specified
+;; security context with "fixed" network interface objects used to enforce
+;; access control on network operations, for example egress.
+;;
+
+(sid netif)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The netmsg initial security identifier is used to associate a specified
+;; security context with "fixed" network peer objects used to enforce access
+;; control on network operations, for example recv.
+;;
+
+(sid netmsg)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The node initial security identifier is used to associate a specified
+;; security context with "fixed" network node objects used to enforce access
+;; control on network operations, for example node_bind.
+;;
+
+(sid node)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The port initial security identifier is used to associate a specified
+;; security context with "fixed" network port objects used to enforce access
+;; control on network operations, for example name_connect.
+;;
+
+(sid port)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The security initial security identifier is used to associate a specified
+;; security context with "fixed" SELinux objects used to enforce access
+;; control on SELinux operations, for example setenforce.
+;;
+
+(sid security)
+
+;;
+;; Initial security identifier declarations.
+;;
+;; The unlabeled initial security identifier is used to associate a specified
+;; security context with entities that had their security context invalidated,
+;; for example due to modifications to policy at runtime.
+;;
+
+(sid unlabeled)
+
+;;
+;; Initial security identifier declarations (unused).
+;;
+;; The following initial security identifiers are unused but they have to be
+;; declared because they are referenced for required SID ordering next.
+;;
+
+(sid any_socket)
+(sid file_labels)
+(sid fs)
+(sid icmp_socket)
+(sid igmp_packet)
+(sid init)
+(sid kmod)
+(sid policy)
+(sid scmp_packet)
+(sid sysctl)
+(sid sysctl_dev)
+(sid sysctl_fs)
+(sid sysctl_kernel)
+(sid sysctl_modprobe)
+(sid sysctl_net)
+(sid sysctl_net_unix)
+(sid sysctl_vm)
+(sid tcp_socket)
+
+;;
+;; Initial security identifier ordering.
+;;
+;; Even though most initial security identifiers we declared are no longer in
+;; use we still have to retain a very specific order to stay compatible with
+;; the kernel.
+;;
+
+(sidorder
+ (kernel security unlabeled fs file file_labels init any_socket port
+         netif netmsg node igmp_packet icmp_socket tcp_socket sysctl_modprobe
+         sysctl sysctl_fs sysctl_kernel sysctl_net sysctl_net_unix
+         sysctl_vm sysctl_dev kmod policy scmp_packet devnull))
+
+;;
+;; Security identifier declarations.
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The s0 security identifier is associated with the sensitivity attribute in a
+;; security context used to enforce confidentiality with the Multi-level
+;; security model. We only declare one sensitivity for simplicity and to
+;; satisfy CIL.
+;;
+
+(sensitivity s0)
+
+;;
+;; Security identifier declarations.
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The c0 security identifier is associated with the category attribute in a
+;; security context used to enforce compartmentalization with the Multi-level
+;; security model. We only declare one compartment for simplicity and to
+;; satisfy CIL.
+;;
+
+(category c0)
+
+;;
+;; Security identifier declarations.
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The sys.id security identifier is associated with the user attribute in a
+;; security context used to associate with Linux DAC, role and level security
+;; identifiers with the Identity-based access control security model.
+;;
+;; Note that we leverage a simple CIL container identified by "sys" here.
+;;
+
+(block sys (user id))
+
+;;
+;; Security identifier declarations.
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The sys.role security identifier is associated with the role attribute in a
+;; security context used to associate with types with the Role-based
+;; access control security model.
+;;
+;; Note that we insert into the previously defined "sys" CIL container here.
+;;
+
+(in sys (role role))
+
+;;
+;; Security identifier declarations.
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The sys.isid security identifier is associated with the type attribute in a
+;; security context used to enforce integrity with the Type-enforcement
+;; security model.
+;;
+;; Note that we insert into the previously defined "sys" CIL container here.
+;;
+
+(in sys (type isid))
+
+;;
+;; Sensitivity ordering.
+;;
+;; Usually there are multiple sensitivities declared. Sensitivities represent
+;; a hierarchy. Since we only have one sensitivity our sensitivity order is
+;; simple.
+;;
+
+(sensitivityorder (s0))
+
+;;
+;; Category ordering.
+;;
+;; Usually there are multiple categories declared. Categories represent
+;; a hierarchy. Since we only have one category our category order is
+;; simple.
+;;
+
+(categoryorder (c0))
+
+;;
+;; Security identifier authorizations.
+;;
+;; The individually declared security identifiers have to be authorized to
+;; associate to be able to combine into valid security contexts.
+;;
+;; Authorize the s0 sensitivity with c0 category association.
+;;
+
+(sensitivitycategory s0 (range c0 c0))
+
+;;
+;; Security identifier authorizations.
+;;
+;; The individually declared security identifiers have to be authorized to
+;; associate to be able to combine into valid security contexts.
+;;
+;; Authorize the sys.id user with sys.role role association.
+;;
+
+(userrole sys.id sys.role)
+
+;;
+;; Security identifier authorizations.
+;;
+;; The individually declared security identifiers have to be authorized to
+;; associate to be able to combine into valid security contexts.
+;;
+;; Authorize the sys.role role with sys.isid type association.
+;;
+
+(roletype sys.role sys.isid)
+
+;;
+;; Security identifier authorizations.
+;;
+;; The individually declared security identifiers have to be authorized to
+;; associate to be able to combine into valid security contexts.
+;;
+;; Authorize the sys.id user with s0 lavel association.
+;;
+
+(userlevel sys.id (s0))
+
+;;
+;; Security identifier authorizations.
+;;
+;; The individually declared security identifiers have to be authorized to
+;; associate to be able to combine into valid security contexts.
+;;
+;; Authorize the sys.id user with s0-s0:c0.c0 range association.
+;;
+
+(userrange sys.id ((s0)(s0 (range c0 c0))))
+
+;;
+;; Security context specifications.
+;;
+;; Leverage role security identifiers associated with files by specifying that
+;; role identifiers associated with file security classes should be inherited
+;; from the source.
+;;
+
+(defaultrole blk_file source)
+(defaultrole chr_file source)
+(defaultrole dir source)
+(defaultrole fifo_file source)
+(defaultrole file source)
+(defaultrole lnk_file source)
+(defaultrole sock_file source)
+
+;;
+;; Security context specifications.
+;;
+;; Associate our valid security context sys.id:sys.role:sys.isid:s0-s0 with
+;; the used initial security identifiers.
+;;
+
+(sidcontext devnull (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext file (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext kernel (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext netif (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext netmsg (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext node (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext port (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext security (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext unlabeled (sys.id sys.role sys.isid ((s0)(s0))))
+
+;;
+;; Security context specifications
+;;
+;; Associate our valid security context sys.id:sys.role:sys.isid:s0-s0 with
+;; locations on the filesystems so that they can be associated with inodes on
+;; filesystems that support security extended attributes.
+;;
+
+(filecon "/" dir (sys.id sys.role sys.isid ((s0)(s0))))
+(filecon "/.*" any (sys.id sys.role sys.isid ((s0)(s0))))
+
+;;
+;; Access vector rule.
+;;
+;; CIL requires us to specify at least one AVC rule and since we were required
+;; to at least declare the process security class, its dyntransition and
+;; transition access vector permissions, let's add a AVC rule allowing
+;; entities associated with our sys.isid type identifier access to all the
+;; process operations.
+;;
+
+(allow sys.isid self (process (all)))
+
+;;
+;; Tidy some loose ends.
+;;
+;; Address hardcoded references in Red Hat's and Debian's package managers
+;; with the typealiase statement.
+;;
+
+(typealias dpkg_script_t)
+(typealiasactual dpkg_script_t sys.isid)
+
+(typealias rpm_script_t)
+(typealiasactual rpm_script_t sys.isid)
+
+;;
+;; Tidy some loose ends.
+;;
+;; Generate a /etc/selinux/cil-policy/seusers file with a __default__ fall back
+;; entry so that Linux users are associated with the sys.id SELinux
+;; identity and the s0-s0 level.
+;;
+
+(selinuxuserdefault sys.id ((s0)(s0)))
+
+;;
+;; Tidy some loose ends.
+;;
+;; Leverage the userprefix statement to associate valid role identifiers with
+;; files generated by the genhomedircon command.
+;;
+
+(userprefix sys.id sys.role)
+
+;;
+;; Tidy some loose ends.
+;;
+;; At the least /dev and /dev/pts should be assumed to exist and be set up
+;; for labeling so that terminals can be relabeled.
+;;
+
+(fsuse trans "devpts" (sys.id sys.role sys.isid ((s0)(s0))))
+(fsuse trans "devtmpfs" (sys.id sys.role sys.isid ((s0)(s0))))
-- 
2.27.0

