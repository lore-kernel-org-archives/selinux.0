Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD4DC433DF
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 10:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DE320884
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 10:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="nvacw9oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgGPKJZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgGPKJY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 06:09:24 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64584C061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 03:09:23 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 811A52A0018;
        Thu, 16 Jul 2020 12:09:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 811A52A0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594894160;
        bh=WG86cLYVvb4BxJde7z9xlfTgs1DBWwF/815Ng+cmkao=;
        h=From:To:Cc:Subject:Date:From;
        b=nvacw9oZQwWtJtszfRqWXOnJf6Rpse+dJG/mrg33y3hgQYlZpM0XOsMPd/iuTjN1/
         Pow0F79Xo6DCUK3D+mXGe8jJZAP3QJBttEQv6m7W5Kht/xmA/hcGE/ybO39yjJJ8TE
         A4lY0Dsk8eGVxyKEvHdd4t7xxEyIBHgm834Fy5W4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] adds CIL policy with makefile
Date:   Thu, 16 Jul 2020 12:08:51 +0200
Message-Id: <20200716100851.944055-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
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
 src/cil_overview.md                           |  11 +
 src/notebook-examples/README.md               |   2 +
 src/notebook-examples/cil-policy/Makefile     |  36 ++
 src/notebook-examples/cil-policy/README.md    |  71 +++
 src/notebook-examples/cil-policy/XWAYLAND.md  |   7 +
 .../cil-policy/cil-policy.cil                 | 445 ++++++++++++++++++
 6 files changed, 572 insertions(+)
 create mode 100644 src/notebook-examples/cil-policy/Makefile
 create mode 100644 src/notebook-examples/cil-policy/README.md
 create mode 100644 src/notebook-examples/cil-policy/XWAYLAND.md
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
index 0000000..7e6e7cb
--- /dev/null
+++ b/src/notebook-examples/cil-policy/Makefile
@@ -0,0 +1,36 @@
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
+	echo -e """Section \"Module\" \
+\nSubSection \"extmod\" \
+\nOption \"SELinux mode disabled\" \
+\nEndSubSection \
+\nEndSection""" > /etc/selinux/cil-policy/contexts/x_contexts
+	semodule --priority=100 -N -s cil-policy -i cil-policy.cil
diff --git a/src/notebook-examples/cil-policy/README.md b/src/notebook-examples/cil-policy/README.md
new file mode 100644
index 0000000..a3c9b56
--- /dev/null
+++ b/src/notebook-examples/cil-policy/README.md
@@ -0,0 +1,71 @@
+# CIL policy from scratch that is mutable at runtime
+
+This example demonstrates an alternative approach to implementing a
+first iteration of a CIL policy from scratch. The main idea is to
+create a policy that is as small as reasonably possible, and to
+install that by using `semodule`. This will provide you with bare
+miminums to get you started in enforcing mode.
+
+To achieve this there are two key features leveraged. The
+`handleunknown` statement, the `unlabeled` and `file` initial
+security identifiers. By allowing unknown access vectors by default we
+can reduce the amount of classes and access vector permission
+declarations needed to get started. This was only recently made
+possible by lifting the requirement to order classes. Requiring
+classes to be ordered implies that the classes are declared, thus it
+requires that you know what classes are managed by Linux. Now we only
+have to be aware of, and declare, a small number of classes and a few
+permissions to get started. All the remaining unknown access vectors
+will be reported to us by SELinux via the kernel ring buffer, it is
+just a matter of looking at `dmesg` to see which access vectors are
+managed by Linux but are unknown to the policy, and then to address
+those in the policy as we go along. You can generally pick and choose
+which access vectors you want to use to achieve your access control
+requirements and you can imply ignore any access vectors that you do
+not need.
+
+The `unlabeled` initial security identifier is used to associate a
+specified context with entities that have their existing context
+invalidated. The `file` initial security identifier is used to
+associate a context with objects that have no labels. This
+functionality can be taken advantage of to reduce the work needed to
+get a working first iteration of the policy that we can then build
+upon. Initial security identifier associated contexts are associated
+with entities in memory. This means that effectively we do not have
+to worry about persistent labels in our first iteration. We can
+address labeling requirements as a first next step to get going.
+
+By using `semodule` we create a module store that we can use to
+manage policy at runtime and all the source policy is
+readily accessible through the store. Some changes might require
+reboot in some scenarios. You can effectively switch to cil-policy at
+runtime in enforcing mode if your system was already enforcing a
+policy before. Otherwise you might have to reboot to load initial
+policy.
+
+This repository comes with a heavily commented CIL module and a make
+file that addresses installation. The make file does make some
+assumptions that are relatively safe but if something breaks, you get
+to keep the pieces. This example requires Linux 5.7 and SELinux 3.1
+because it omits initial sid context specifications for unused
+initial security identifiers.
+
+## Switching to cil-policy from a another policy
+
+1. make install
+2. sed -i 's/SELINUXTYPE=.*/SELINUXTYPE=cil-policy/' /etc/selinux/config
+3. semodule -B
+
+Your first step to actually leverage cil-policy will likely be to
+enable labeling support for your non-volatile filesystems, and to
+apply labels according to the file context specifications defined in
+the policy.
+
+For example if you use `ext4` filesystems:
+
+1. echo '(fsuse xattr "ext4" (sys.id sys.role sys.isid ((s0)(s0))))' > myfs.cil
+2. semodule -i myfs.cil
+3. fixfiles onboot && reboot
+
+Use your favorite text editor to write policy in [Common Intermediate Language](https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/README.md),
+manage it with `semodule`, and analyze it with `setools`.
diff --git a/src/notebook-examples/cil-policy/XWAYLAND.md b/src/notebook-examples/cil-policy/XWAYLAND.md
new file mode 100644
index 0000000..322576d
--- /dev/null
+++ b/src/notebook-examples/cil-policy/XWAYLAND.md
@@ -0,0 +1,7 @@
+# Xwayland considerations
+
+In the scenario where you are still using Xwayland there are some
+special considerations:
+
+1. cp /etc/selinux/cil-policy/contexts/x_contexts /etc/X11/xorg.conf.d/90-selinux.conf
+2. echo "(boolean xserver_object_manager false)" > myxwaylandhack.cil && semodule -i myxwaylandhack.cil
diff --git a/src/notebook-examples/cil-policy/cil-policy.cil b/src/notebook-examples/cil-policy/cil-policy.cil
new file mode 100644
index 0000000..c36eb4b
--- /dev/null
+++ b/src/notebook-examples/cil-policy/cil-policy.cil
@@ -0,0 +1,445 @@
+;; -*- mode: CIL; fill-column: 79; indent-tabs-mode: nil; -*-
+;; SPDX-License-Identifier: Unlicense
+
+;;
+;; Policy configuration:
+;;
+;; By allowing unknown access vectors we can start with a reduced number
+;; of declared classes and access vectors. Use `dmesg | grep -i selinux` to
+;; see which kernel classes and access vectors should be addressed in the
+;; policy as you go along.
+;;
+
+(handleunknown allow)
+
+;;
+;; Policy configuration:
+;;
+;; We'll disable the MLS security model support for simplicity, but CIL still
+;; requires us to write our policy with minimal MLS-awareness. Remember, we can
+;; alway's add full or partial MLS support later. This is just to get started.
+;;
+
+(mls false)
+
+;;
+;; Access vector declarations and (un)ordering:
+;;
+;; SELinux requires that the process security class, transition and
+;; dyntransition access vector permissions are declared. CIL requires at least
+;; one declared access vector and avc rule as well so this is a good starting
+;; point. All security classes can be "unordered" with Linux 5.7/SELinux 3.1.
+;;
+
+(class process (dyntransition transition))
+(classorder (unordered process))
+
+;;
+;; Access vector declarations and (un)ordering:
+;;
+;; To be able to associate roles with files, we need defaultrole rules that
+;; require file classes to be declared. For now we'll omit their associated
+;; access vector permissions for simplicity (get them from `dmesg | grep -i selinux`)
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
+;; Initial security identifier declarations:
+;;
+;; The kernel isid is used to associate a specified context with processes
+;; that were initialized before SELinux was initialized (mainly kernel threads).
+;;
+
+(sid kernel)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The security isid is used to associate a specified context with "fixed"
+;; SELinux "objects" used to enforce access control on SELinux operations
+;; (for example setenforce, setbool etc).
+;;
+
+(sid security)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The port isid is used to associate a specified context with "fixed"
+;; network port "objects" used to enforce access control on network
+;; operations (for example name_connect, name_bind etc).
+;;
+
+(sid port)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The netif isid is used to associate a specified context with "fixed"
+;; network interface "objects" used to enforce access control on network
+;; operations (for example egress, ingress etc).
+;;
+
+(sid netif)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The netmsg isid is used to associate a specified context with "fixed"
+;; network peer "objects" used to enforce access control on network
+;; operations (for example recv).
+;;
+
+(sid netmsg)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The node isid is used to associate a specified context with "fixed"
+;; network node "objects" used to enforce access control on network
+;; operations (for example node_bind etc).
+;;
+
+(sid node)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The devnull isid is used to associate a specified context with "fixed"
+;; null device "objects" used to enforce access control on file
+;; operations (for example read, write etc).
+;;
+
+(sid devnull)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The file isid is used to associate a specified context with objects
+;; that have no label (for example formatted filesystems that are not labeled).
+;;
+
+(sid file)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The unlabeled isid is used to associate a specified context with entities
+;; that had their security context invalidated (mainly due to modifications to
+;; policy at runtime).
+;;
+
+(sid unlabeled)
+
+;;
+;; Initial security identifier declarations:
+;;
+;; The following initial security identifiers are unused but are required
+;; for "sid ordering"
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
+;; Initial security identifier ordering:
+;;
+;; Even though most initial security identifiers we declared are no longer in
+;; use, we still have to retain a very specific order to stay compatible with
+;; the kernel. This is certainly one of those things that make policy writing
+;; seem like some sort of black magic and hopefully some day we can lift the
+;; requirement to order initial sids in a specific way.
+;;
+
+(sidorder
+ (kernel security unlabeled fs file file_labels init any_socket port
+         netif netmsg node igmp_packet icmp_socket tcp_socket sysctl_modprobe
+         sysctl sysctl_fs sysctl_kernel sysctl_net sysctl_net_unix
+         sysctl_vm sysctl_dev kmod policy scmp_packet devnull))
+
+;;
+;; Security identifier declarations
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The s0 security identifier is associated with sensitivity attribute in a
+;; security context used to enforce confidentiality with the Multi level
+;; security model. (we only declare one sensitivity for simplicity and to
+;; satisfy CIL.
+;;
+
+(sensitivity s0)
+
+;;
+;; Security identifier declarations
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The c0 security identifier is associated with category attribute in a
+;; security context used to enforce compartmentalization with the Multi level
+;; security model. (we only declare one compartment for simplicity and to
+;; satisfy CIL.
+;;
+
+(category c0)
+
+;;
+;; Security identifier declarations
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The sys.id security identifier is associated with user attribute in a
+;; security context used to associate with Linux DAC and role and level security
+;; identifiers with the Identity-based access control security model.
+;;
+;; Note that we leverage a simple CIL "sys" "container" here
+;;
+
+(block sys (user id))
+
+;;
+;; Security identifier declarations
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The sys.role security identifier is associated with role attribute in a
+;; security context used to associate with types with the Role-based
+;; access control security model.
+;;
+;; Note that we insert into the previously defined CIL "sys" "container" here
+;;
+
+(in sys (role role))
+
+;;
+;; Security identifier declarations
+;;
+;; Security contexts are identifiers that are combinations of security
+;; attribute and security identifier key value pairs corresponding to security
+;; models.
+;;
+;; The sys.isid security identifier is associated with type attribute in a
+;; security context used to enforce integrity with the Type-enforcement
+;; security model.
+;;
+;; Note that we insert into the previously defined CIL "sys" "container" here
+;;
+
+(in sys (type isid))
+
+;;
+;; Sensitivity ordering:
+;;
+;; Usually there are multiple sensitivities declared. Sensitivities represent
+;; a hierarchy. Since we only have one sensitivity our sensitivity order is
+;; simple.
+;;
+
+(sensitivityorder (s0))
+
+;;
+;; Category ordering:
+;;
+;; Usually there are multiple categories declared. Categories represent
+;; a hierarchy. Since we only have one category our category order is
+;; simple.
+;;
+
+(categoryorder (c0))
+
+;;
+;; Security identifier authorisations
+;;
+;; The individually declared security identifiers need to be authorized to
+;; associate to be able to define valid security contexts.
+;;
+;; Authorize the s0 sensitivity with c0 category association
+;;
+
+(sensitivitycategory s0 (range c0 c0))
+
+;;
+;; Security identifier authorisations
+;;
+;; The individually declared security identifiers need to be authorized to
+;; associate to be able to define valid security contexts.
+;;
+;; Authorize the sys.id user with sys.role role association
+;;
+
+(userrole sys.id sys.role)
+
+;;
+;; Security identifier authorisations
+;;
+;; The individually declared security identifiers need to be authorized to
+;; associate to be able to define valid security contexts.
+;;
+;; Authorize the sys.role role with sys.isid type association
+;;
+
+(roletype sys.role sys.isid)
+
+;;
+;; Security identifier authorisations
+;;
+;; The individually declared security identifiers need to be authorized to
+;; associate to be able to define valid security contexts.
+;;
+;; Authorize the sys.id user with s0 lavel association
+;;
+
+(userlevel sys.id (s0))
+
+;;
+;; Security identifier authorisations
+;;
+;; The individually declared security identifiers need to be authorized to
+;; associate to be able to define valid security contexts.
+;;
+;; Authorize the sys.id user with s0-s0:c0.c0 range association
+;;
+
+(userrange sys.id ((s0)(s0 (range c0 c0))))
+
+;;
+;; Security context specifications:
+;;
+;; We will change the default role behavior to inherit the role from the source
+;; instead of the target, as this allows us to leverage roles associated with
+;; files.
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
+;; Security context specifications
+;;
+;; Now that we have a valid security context: sys.id:sys.role:sys.isid:s0-s0,
+;; associate it with the used initial sids.
+;;
+
+(sidcontext kernel (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext security (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext port (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext netif (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext netmsg (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext node (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext devnull (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext file (sys.id sys.role sys.isid ((s0)(s0))))
+(sidcontext unlabeled (sys.id sys.role sys.isid ((s0)(s0))))
+
+;;
+;; Security context specifications
+;;
+;; Now that we have a valid security context: sys.id:sys.role:sys.isid:s0-s0,
+;; associate it with locations on the filesystems so that they can be
+;; associated with inodes on filesystems that support extended security
+;; attributes.
+;;
+
+(filecon "/" dir (sys.id sys.role sys.isid ((s0)(s0))))
+(filecon "/.*" any (sys.id sys.role sys.isid ((s0)(s0))))
+
+;;
+;; AVC rule
+;;
+;; CIL requires us to specify at least one AVC rule Since we were required
+;; to at least declare the process security class and its dyntransition and
+;; transition access vector permissions. lets just add a AVC rule allowing
+;; entities associated with our sys.isid type identifier access to all process
+;; access vectors.
+;;
+
+(allow sys.isid self (process (all)))
+
+;;
+;; Tidy some loose ends
+;;
+;; Addressing a hard coded reference to a rpm_script_t type identifier in RPM
+;; using typealiases to our sys.isid type so that RPM does not get confused.
+
+(typealias rpm_script_t)
+(typealiasactual rpm_script_t sys.isid)
+
+(typealias dpkg_script_t)
+(typealiasactual dpkg_script_t sys.isid)
+
+;;
+;; Tidy some loose ends
+;;
+;; Generate a /etc/selinux/cil-policy/seusers file with a __default__ fall back
+;; entry so that Linux users with be associated with the sys.id SELinux
+;; identity and s0-s0 level.
+;;
+
+(selinuxuserdefault sys.id ((s0)(s0)))
+
+;;
+;; Tidy some loose ends
+;;
+;; We are associating valid roles with files. The userprefix statement was
+;; recycled to allow us to tell genhomedircon what roles to associate with
+;; SELinux identities associated with custmizable files (mainly /home/user)
+;;
+
+(userprefix sys.id sys.role)
+
+;;
+;; Tidy some loose ends
+;;
+;; At the least /dev and /dev/pts need to be set up for labeling for sudo
+;;
+
+(fsuse trans "devtmpfs" (sys.id sys.role sys.isid ((s0)(s0))))
+(fsuse trans "devpts" (sys.id sys.role sys.isid ((s0)(s0))))
-- 
2.27.0

