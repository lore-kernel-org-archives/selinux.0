Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C8C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4520C2071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="IFphhl//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHYIi0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:26 -0400
Received: from mailomta17-sa.btinternet.com ([213.120.69.23]:51193 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgHYIiU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:20 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200825083813.LXZL4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344694; 
        bh=1f6uZZsp9WA0ydx+zF6ICacFeydHydUeq270gc+y1Tw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=IFphhl//TTLf9qGrKP7dUCyhg5IQ4qi5KnswmJspR7F2rNP6CzbX3evs8sDzVT/OIKTFoZjEATrzVF5q0/aFH8NWUEq4D6+akzSrh2cqzp40CzKeEFk/ZYpdrJ/6sek6lZykNPZ7fkm09hwzIEqUczmMoogUNbH5Fh15Av1oU+5arzv0+lXFATHHZYL46etsWu/n+alQdO7RxjVNlHgrrw9OJJhKUBmm22+NPRf/ZJ36KRleyPpdwQboJ6bJpV1l4na2cdmTn5fBvo9Uzd9AGqu/dOpBNNUA41jq9UL4MBL670sugDiba9RhySD7cYSfHxsuAsipsmt6cCQM3XQXFA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepledtffekgfevgeffkeehhedvleeljeejgffhvdeigfffgfefleevveetteduvddunecuffhomhgrihhnpeigrdhorhhgpdhsvghlihhnuhigphhrohhjvggtthdrohhrghenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphht
        thhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599E7D; Tue, 25 Aug 2020 09:38:13 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 17/18] implementing_seaware_apps: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:42 +0100
Message-Id: <20200825083743.6508-18-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/implementing_seaware_apps.md | 218 +++++++++++++++----------------
 1 file changed, 109 insertions(+), 109 deletions(-)

diff --git a/src/implementing_seaware_apps.md b/src/implementing_seaware_apps.md
index 13020c9..ee38258 100644
--- a/src/implementing_seaware_apps.md
+++ b/src/implementing_seaware_apps.md
@@ -1,5 +1,10 @@
 # Implementing SELinux-aware Applications
 
+- [Implementing SELinux-aware Applications](#implementing-selinux-aware-applications)
+- [Implementing Object Managers](#implementing-object-managers)
+- [Reference Policy Changes](#reference-policy-changes)
+- [Adding New Object Classes and Permissions](#adding-new-object-classes-and-permissions)
+
 The following definitions attempt to explain the difference between the
 two types of userspace SELinux application (however the distinction can
 get 'blurred'):
@@ -13,22 +18,21 @@ object manager as an SELinux-aware application.
 
 **Object Manager** - Object Managers are a specialised form of
 SELinux-aware application that are responsible for the labeling,
-management and enforcement<a href="#fni1" class="footnote-ref" id="fnisa1"><sup>1</sup></a>
-of the objects under their control.
+management and enforcement[^fn_isa_1] of the objects under their control.
 
 Generally the userspace Object Manager forms part of an application that
 can be configured out should the base Linux OS not support SELinux.
 
 Example userspace Object Managers are:
 
--   X-SELinux is an optional X-Windows extension responsible for
-    labeling and enforcement of X-Windows objects.
--   Dbus has an optional Object Manager built if SELinux is defined in
-    the Linux build. This is responsible for the labeling and
-    enforcement of Dbus objects.
--   SE-PostgreSQL is an optional extension for PostgreSQL that is
-    responsible for the labeling and enforcement of PostgreSQL database
-    and supporting objects.
+- X-SELinux is an optional X-Windows extension responsible for
+  labeling and enforcement of X-Windows objects.
+- Dbus has an optional Object Manager built if SELinux is defined in
+  the Linux build. This is responsible for the labeling and
+  enforcement of Dbus objects.
+- SE-PostgreSQL is an optional extension for PostgreSQL that is
+  responsible for the labeling and enforcement of PostgreSQL database
+  and supporting objects.
 
 Therefore the basic distinction is that Object Managers manage their
 defined objects on behalf of an application, whereas general
@@ -45,7 +49,7 @@ developing SELinux-aware applications and object managers using
 1.  Determine the security objectives and requirements.
 2.  Because these applications manage labeling and access control, they
     need to be trusted.
-3.  Where possible use the libselinux *\*_raw* functions as they avoid
+3.  Where possible use the libselinux *\*\_raw* functions as they avoid
     the overhead of translating the context to/from the readable format
     (unless of course there is a requirement for a readable context -
     see ***mcstransd**(8)*).
@@ -65,7 +69,7 @@ developing SELinux-aware applications and object managers using
 8.  Do not use class IDs directly, use
     ***string_to_security_class**(3)* that will take the class string
     defined in the policy and return the class ID/value. Always check
-    the value is &gt; 0. If *0*, then signifies that the class is
+    the value is \> 0. If *0*, then signifies that the class is
     unknown and the **deny_unknown** flag setting in the policy will
     determine the outcome of any decision - see
     ***security_deny_unknown**(3)*.
@@ -99,59 +103,60 @@ developing SELinux-aware applications and object managers using
 To implement object managers for applications, an understanding of the
 application is essential, because as a minimum:
 
--   What object types and their permissions are required.
--   Where in the code object instances are created.
--   Where access controls need to be applied.
+- What object types and their permissions are required.
+- Where in the code object instances are created.
+- Where access controls need to be applied.
 
 While this section cannot help with those points, here are some notes to
 help during the design phase:
 
-1.  Determine what objects are required and the access controls
-    (permissions) that need to be applied.
-2.  Does SELinux already have some of these object classes and
-    permissions defined. For standard Linux OS objects such as files,
-    then these would be available. If so, the object manager should
-    remap them with ***selinux_set_mapping**(3)* so only those
-    required are available.
+1. Determine what objects are required and the access controls
+   (permissions) that need to be applied.
+2. Does SELinux already have some of these object classes and
+   permissions defined. For standard Linux OS objects such as files,
+   then these would be available. If so, the object manager should
+   remap them with ***selinux_set_mapping**(3)* so only those
+   required are available.
 
 However, do not try to reuse a current object that may be similar to the
 requirements, it will cause confusion at some stage. Always generate new
 classes/permissions.
 
-1.  If the application has APIs or functions that integrate with other
-    applications or scripts, then as part of the object manager
-    implementation these may need to support the use of security
-    contexts (examples are X-Windows and SE-PostgreSQL that provide
-    functions for other applications to use). Therefore if required,
-    provide common functions that can be used to label the objects.
-2.  Determine how the initial objects will be labeled. For example will
-    a configuration file be required for default labels, if so how will
-    this be introduced into the SELinux userspace build. Examples of
-    these are the X-Windows (***selabel_x**(5)*), SE-PostgreSQL
-    (***selabel_db**(3)*), and file context series of files
-    (***selabel_file**(5)*).
-3.  Will the labeling need to be persistent across policy and system
-    reloads or not. X-Windows is an example of a non-persistent, and
-    SE-PostgreSQL is an example of a persistent object manager.
-4.  Will support for the standard audit log or its own be required (the
-    *libselinux* functions default to *stderr*). Use
-    ***selinux_set_callback**(3)* to manage logging services.
-5.  Decide whether an AVC cache is required or not. If the object
-    manager handles high volumes of requests then an AVC will be
-    required.
-6.  Will the object manager need to do additional processing when policy
-    or enforcement changes are detected. This could be clearing any
-    caches or resetting variables etc.. If so, then
-    ***selinux_set_callback**(3)* will be used to set up these
-    functions. These events are detected via the ***netlink**(7)*
-    services, see ***avc_open**(3)* and ***avc_netlink_open**(3)* for
-    the various options available.
-7.  If possible implement a service like XACE for the application, and
-    use it to interface with the applications SELinux object manager.
-    The XACE interface acts like the LSM which supports SELinux as well
-    as other providers such as SMACK. The XACE interface is defined in
-    the [**X Access Control Extension Specification**](http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf), and for reference, the SE-PostgreSQL service also implements a similar
-    interface.
+1. If the application has APIs or functions that integrate with other
+   applications or scripts, then as part of the object manager
+   implementation these may need to support the use of security
+   contexts (examples are X-Windows and SE-PostgreSQL that provide
+   functions for other applications to use). Therefore if required,
+   provide common functions that can be used to label the objects.
+2. Determine how the initial objects will be labeled. For example will
+   a configuration file be required for default labels, if so how will
+   this be introduced into the SELinux userspace build. Examples of
+   these are the X-Windows (***selabel_x**(5)*), SE-PostgreSQL
+   (***selabel_db**(3)*), and file context series of files
+   (***selabel_file**(5)*).
+3. Will the labeling need to be persistent across policy and system
+   reloads or not. X-Windows is an example of a non-persistent, and
+   SE-PostgreSQL is an example of a persistent object manager.
+4. Will support for the standard audit log or its own be required (the
+   *libselinux* functions default to *stderr*). Use
+   ***selinux_set_callback**(3)* to manage logging services.
+5. Decide whether an AVC cache is required or not. If the object
+   manager handles high volumes of requests then an AVC will be
+   required.
+6. Will the object manager need to do additional processing when policy
+   or enforcement changes are detected. This could be clearing any
+   caches or resetting variables etc.. If so, then
+   ***selinux_set_callback**(3)* will be used to set up these
+   functions. These events are detected via the ***netlink**(7)*
+   services, see ***avc_open**(3)* and ***avc_netlink_open**(3)* for
+   the various options available.
+7. If possible implement a service like XACE for the application, and
+   use it to interface with the applications SELinux object manager.
+   The XACE interface acts like the LSM which supports SELinux as well
+   as other providers such as SMACK. The XACE interface is defined in the
+   [**X Access Control Extension Specification**](http://www.x.org/releases/X11R7.5/doc/security/XACE-Spec.pdf),
+   and for reference, the SE-PostgreSQL service also implements a similar
+   interface.
 
 ## Reference Policy Changes
 
@@ -163,37 +168,36 @@ Policy source can be obtained from:
 
 The main points to note when adding to the Reference Policy are:
 
-1.  Create sample Reference Policy policy modules (*\*.te*, *\*.if* and
-    *\*.fc* module files) that provide rules for managing the new objects as
-    described in the [**The Reference Policy**](reference_policy.md#the-reference-policy) section.
--   The SE-PostgreSQL modules provide an example, see the
-    *./refpolicy/policy/modules/services/postgresql.* files in the
-    Reference Policy source.
-
-2.  Create any new policy classes and permissions for the Reference
-    Policy, these will need to be built into the base module as
-    described in the
-    [Adding New Object Classes and Permissions](#adding-new-object-classes-and-permissions)
-    section.
+1. Create sample Reference Policy policy modules (*\*.te*, *\*.if* and
+   *\*.fc* module files) that provide rules for managing the new objects as
+   described in the [**The Reference Policy**](reference_policy.md#the-reference-policy) section.
+   - The SE-PostgreSQL modules provide an example, see the
+     *./refpolicy/policy/modules/services/postgresql.* files in the
+     Reference Policy source.
+2. Create any new policy classes and permissions for the Reference
+   Policy, these will need to be built into the base module as
+   described in the
+   [Adding New Object Classes and Permissions](#adding-new-object-classes-and-permissions)
+   section.
 
 Note, that if no new object classes, permissions or constraints are
 being added to the policy, then the Reference Policy source code does
 not require modification, and supplying the module files (*\*.te*,
 *\*.if* and *\*.fc*) should suffice.
 
-1.  Create any constraints required as these need to be built into the
-    base module of the Reference Policy. They are added to the
-    *./refpolicy/policy/constraints*, *mcs* and *mls* files. Again the
-    SE-PostgreSQL entries in these files give examples (find the
-    *db_\** class entries).
-2.  Create any SELinux configuration files (context, user etc.) that
-    need to be added to the policy at build time.
-3.  Either produce an updated Reference Policy source or module patch,
-    depending on whether new classes/constraints have been added. Note
-    that by default a new module will be generated as a 'module', if it
-    is required that the module is in the base (unusual), then add an
-    entry ***&lt;required val="true"&gt;*** to the start of the
-    interface file as shown below:
+1. Create any constraints required as these need to be built into the
+   base module of the Reference Policy. They are added to the
+   *./refpolicy/policy/constraints*, *mcs* and *mls* files. Again the
+   SE-PostgreSQL entries in these files give examples (find the
+   *db_\** class entries).
+2. Create any SELinux configuration files (context, user etc.) that
+   need to be added to the policy at build time.
+3. Either produce an updated Reference Policy source or module patch,
+   depending on whether new classes/constraints have been added. Note
+   that by default a new module will be generated as a 'module', if it
+   is required that the module is in the base (unusual), then add an
+   entry ***\<required val="true"\>*** to the start of the
+   interface file as shown below:
 
 ```
 # <summary>
@@ -258,40 +262,36 @@ be declared using the *class*, *classpermission*, and *classorder* statements.
 
 For reference, <http://selinuxproject.org/page/Adding_New_Permissions>
 describes how new kernel object classes and permissions are added to the
-system and is summarised as follows for kernels &gt;= 2.6.33 that use
+system and is summarised as follows for kernels \>= 2.6.33 that use
 dynamic class/perm discovery:
 
-1.  Edit *security/selinux/include/classmap.h* in the kernel tree and
-    add the required definition. This will define the class and/or
-    permission for use in the kernel; the corresponding symbol
-    definitions will be automatically generated during the kernel build.
-    If not defined in the policy, then the class and/or permission will
-    be handled in accordance with the policy's *handle_unknown*
-    definition, which can be reject (refuse to load the policy), deny
-    (deny the undefined class/permission), or allow (allow the undefined
-    class/permission). *handle_unknown* is set to allow in Fedora
-    policies.
-2.  Edit *refpolicy/policy/flask/security_classes* and/or
-    *access_vectors* in the refpolicy tree and add your definition.
-    This will define the class and permission for use in the policy.
-    These are generally added to the class and/or permission at the end
-    of the existing list of classes or permissions for that class for
-    backward compatibility with older kernels. The class and/or
-    permission definition in policy need not line up with the definition
-    in the kernel's classmap, as the values will be dynamically mapped
-    by the kernel. Then add allow rules as appropriate to the policy for
-    the new permissions.
-
-<section class="footnotes">
-<ol>
-<li id="fni1"><p>The SELinux security server does not enforce a decision, it merely
+1. Edit *security/selinux/include/classmap.h* in the kernel tree and
+   add the required definition. This will define the class and/or
+   permission for use in the kernel; the corresponding symbol
+   definitions will be automatically generated during the kernel build.
+   If not defined in the policy, then the class and/or permission will
+   be handled in accordance with the policy's *handle_unknown*
+   definition, which can be reject (refuse to load the policy), deny
+   (deny the undefined class/permission), or allow (allow the undefined
+   class/permission). *handle_unknown* is set to allow in Fedora
+   policies.
+2. Edit *refpolicy/policy/flask/security_classes* and/or
+   *access_vectors* in the refpolicy tree and add your definition.
+   This will define the class and permission for use in the policy.
+   These are generally added to the class and/or permission at the end
+   of the existing list of classes or permissions for that class for
+   backward compatibility with older kernels. The class and/or
+   permission definition in policy need not line up with the definition
+   in the kernel's classmap, as the values will be dynamically mapped
+   by the kernel. Then add allow rules as appropriate to the policy for
+   the new permissions.
+
+[^fn_isa_1]: The SELinux security server does not enforce a decision, it merely
 states whether the operation is allowed or not according to the policy.
 It is the object manager that enforces the decision of the policy /
 security server, therefore an object manager must be trusted. This is
 also true of labeling, the object manager ensures that labels are
-applied to their objects as defined by policy.<a href="#fnisa1" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+applied to their objects as defined by policy.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

