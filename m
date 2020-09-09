Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9884C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 12:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE4520809
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 12:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="fO8RbJ0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgIJMPq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:15:46 -0400
Received: from mailomta28-re.btinternet.com ([213.120.69.121]:54945 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730408AbgIJMNr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 08:13:47 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20200909133048.EKJL29506.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658248; 
        bh=m/xLRItvvIlsfdKfksgXgc3A96SYWY3zUHvq/SS7128=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=fO8RbJ0pPD+i80zvmsKBzog03j2UoQAIMRX/jujr87ZBFhkyd16InI4o0dFcRppVuBNJ0AuC9CDac+EMRmmkQXwfcIkpUCGY6zykzGSjEIwq3UOLg99kIa4WHZjI/OazBFWbJksnTBmGbzWgED8May5K/GDhClS/BXjqy9Hm/zCWpg4vYBGumcgcP6R0fthSut/wsMcrGPFTynJGlWCRecvbTjGidt6n3KVLz7gA578Ww5plmVpBjc0zL0jnJXK26AtzBwIY8YAw0b/Ocky9zOtcKBDAjIJf2bkGhgZZn7Yv2zJ6Bwd6zc3A4uUUXKQtTeiO7Tz5QM1QLpdHh/jEYQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=70/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecugfgrrhhlhicushhprhhinhhgucdljedtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnheptdehheehvdfhfefgffduhffgffeltdehgffghffhudekkefhteekfeduveetieegnecuffhomhgrihhnpehgohhoghhlvggtohguvgdrtghomhenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdp
        rhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 70
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134E24; Wed, 9 Sep 2020 14:30:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 15/22] types_of_policy: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:32 +0100
Message-Id: <20200909133039.44498-16-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/types_of_policy.md | 359 +++++++++++++++++++++--------------------
 1 file changed, 184 insertions(+), 175 deletions(-)

diff --git a/src/types_of_policy.md b/src/types_of_policy.md
index a55fdd0..b9ae190 100644
--- a/src/types_of_policy.md
+++ b/src/types_of_policy.md
@@ -1,32 +1,42 @@
 # Types of SELinux Policy
 
+- [Reference Policy](#reference-policy)
+- [Policy Functionality Based on Name or Type](#policy-functionality-based-on-name-or-type)
+- [Custom Policy](#custom-policy)
+- [Monolithic Policy](#monolithic-policy)
+- [Loadable Module Policy](#loadable-module-policy)
+  - [Optional Policy](#optional-policy)
+- [Conditional Policy](#conditional-policy)
+- [Binary Policy](#binary-policy)
+- [Policy Versions](#policy-versions)
+
 This section describes the different type of policy descriptions and
 versions that can be found within SELinux.
 
 The type of SELinux policy can described in a number of ways:
 
-1.  Source code - These can be described as:
-    [**Reference Policy**](types_of_policy.md#reference-policy) or
-    [**Custom**](types_of_policy.md#custom-policy).
-    They are generally written using
-    [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language),
-    [**Reference Policy Support Macros**](reference_policy.md#reference-policy-support-macros),
-    or using [**CIL**](cil_overview.md#cil-overview)
-2.  They can also be classified as: [**Monolithic**](types_of_policy.md#monolithic-policy),
-    [**Base Module or Loadable Module**](types_of_policy.md#reference-policy).
-3.  Policies can also be described by the
-    [**type of policy functionality**](types_of_policy.md#policy-functionality-based-on-name-or-type) they
-    provide such as: targeted, mls, mcs, standard, strict or minimum.
-4.  Classified using language statements - These can be described as
-    [**Modular, Optional**](types_of_policy.md#reference-policy) or
-    [**Conditional**](types_of_policy.md#conditional-policy).
-5.  Binary or Kernel policy. These are the compiled policy used by the kernel.
-6.  Classification can also be on the '[**policy version**](types_of_policy.md#policy-versions)'
-    used (examples are version 22, 23 and 24).
-7.  Policy can also be generated depending on the target platform of
-    either 'selinux' (the default) or 'xen' (see the SELinux policy
-    generation tools ***checkpolicy**(8)*, ***secilc**(8)* and ***semanage**(8)*
-    *target_platform* options).
+1. Source code - These can be described as:
+   [**Reference Policy**](types_of_policy.md#reference-policy) or
+   [**Custom**](types_of_policy.md#custom-policy).
+   They are generally written using
+   [**Kernel Policy Language**](kernel_policy_language.md#kernel-policy-language),
+   [**Reference Policy Support Macros**](reference_policy.md#reference-policy-support-macros),
+   or using [**CIL**](cil_overview.md#cil-overview)
+2. They can also be classified as: [**Monolithic**](types_of_policy.md#monolithic-policy),
+   [**Base Module or Loadable Module**](types_of_policy.md#reference-policy).
+3. Policies can also be described by the
+   [**type of policy functionality**](types_of_policy.md#policy-functionality-based-on-name-or-type) they
+   provide such as: targeted, mls, mcs, standard, strict or minimum.
+4. Classified using language statements - These can be described as
+   [**Modular, Optional**](types_of_policy.md#reference-policy) or
+   [**Conditional**](types_of_policy.md#conditional-policy).
+5. Binary or Kernel policy. These are the compiled policy used by the kernel.
+6. Classification can also be on the '[**policy version**](types_of_policy.md#policy-versions)'
+   used (examples are version 22, 23 and 24).
+7. Policy can also be generated depending on the target platform of
+   either 'selinux' (the default) or 'xen' (see the SELinux policy
+   generation tools ***checkpolicy**(8)*, ***secilc**(8)* and ***semanage**(8)*
+   *target_platform* options).
 
 As can be seen the description of a policy can vary depending on the
 context.
@@ -61,30 +71,32 @@ Generally a policy is installed with a given name such as *targeted*,
 *mls*, *refpolicy* or *minimum* that attempts to describes its
 functionality. This name then becomes the entry in:
 
-1.  The directory pointing to the policy location (e.g. if the name is
-    *targeted*, then the policy will be installed in
-    */etc/selinux/targeted*).
-2.  The *SELINUXTYPE* entry in the */etc/selinux/config* file when it is
-    the active policy (e.g. if the name is *targeted*, then a
-    *SELINUXTYPE=targeted* entry would be in the */etc/selinux/config*
-    file).
+1. The directory pointing to the policy location (e.g. if the name is
+   *targeted*, then the policy will be installed in
+   */etc/selinux/targeted*).
+2. The *SELINUXTYPE* entry in the */etc/selinux/config* file when it is
+   the active policy (e.g. if the name is *targeted*, then a
+   *SELINUXTYPE=targeted* entry would be in the */etc/selinux/config*
+   file).
 
 This is how the reference policies distributed with Fedora are named,
 where:
--   minimum - supports a minimal set of confined daemons within their own
-    domains. The remainder run in the unconfined_t space. Red Hat
-    pre-configure MCS support within this policy.
--   targeted - supports a greater number of confined daemons and can also
-    confine other areas and users. Red Hat pre-configure MCS support within
-    this policy.
--   mls - supports server based MLS systems.
+
+- minimum - supports a minimal set of confined daemons within their own
+  domains. The remainder run in the unconfined_t space. Red Hat
+  pre-configure MCS support within this policy.
+- targeted - supports a greater number of confined daemons and can also
+  confine other areas and users. Red Hat pre-configure MCS support within
+  this policy.
+- mls - supports server based MLS systems.
 
 The Reference Policy also has a *TYPE* description that describes the
 type of policy being built by the build process, these are:
--   standard - supports confined daemons and can also confine other areas
-    and users.
--   mcs - As standard but supports MCS labels.
--   mls - supports server based MLS systems.
+
+- standard - supports confined daemons and can also confine other areas
+  and users.
+- mcs - As standard but supports MCS labels.
+- mls - supports server based MLS systems.
 
 The *NAME* and *TYPE* entries are defined in the reference policy
 *build.conf* file that is described in the Reference Policy
@@ -95,14 +107,14 @@ section.
 
 This generally refers to a policy source that is either:
 
-1.  A customised version of the Reference Policy (i.e. not the standard
-    distribution version e.g. Red Hat policies).
-2.  A policy that has been built using policy language statements
-    (CIL or Kernel) to build a specific policy such as the basic policy built
-    in the Notebook *notebook-examples/selinux-policy* there are following
-    policies:
--   [**Kernel Policy Language**](./notebook-examples/selinux-policy/kernel/kern-nb-policy.txt)
--   [**CIL Policy Language**](./notebook-examples/selinux-policy/cil/cil-nb-policy.txt)
+1. A customised version of the Reference Policy (i.e. not the standard
+   distribution version e.g. Red Hat policies).
+2. A policy that has been built using policy language statements
+   (CIL or Kernel) to build a specific policy such as the basic policy built
+   in the Notebook *notebook-examples/selinux-policy* there are following
+   policies:
+   - [**Kernel Policy Language**](./notebook-examples/selinux-policy/kernel/kern-nb-policy.txt)
+   - [**CIL Policy Language**](./notebook-examples/selinux-policy/cil/cil-nb-policy.txt)
 
 These examples were built using the Notebook 'build-sepolicy' command that is
 described in
@@ -140,12 +152,12 @@ but ftp is not used, then that module could be unloaded).
 
 There are number of components that form the infrastructure:
 
-1.  Policy source code that is constructed for a modular policy with a
-    base module and optional loadable modules.
-2.  Utilities to compile and link modules and place them into a 'policy
-    store'.
-3.  Utilities to manage the modules and associated configuration files
-    within the 'policy store'.
+1. Policy source code that is constructed for a modular policy with a
+   base module and optional loadable modules.
+2. Utilities to compile and link modules and place them into a 'policy
+   store'.
+3. Utilities to manage the modules and associated configuration files
+   within the 'policy store'.
 
 [**Figure 2: High Level SELinux Architecture**](core_components.md#core-selinux-components)
 shows these components along the top of the diagram. The files contained in
@@ -196,9 +208,9 @@ section.
 
 This is also know as the kernel policy and is the policy file that is
 loaded into the kernel and is located at
-/etc/selinux/&lt;SELINUXTYPE&gt;/policy/policy.&lt;version&gt;. Where
-*&lt;SELINUXTYPE&gt;* is the policy name specified in the SELinux
-configuration file /etc/selinux/config and &lt;version&gt; is the
+/etc/selinux/\<SELINUXTYPE\>/policy/policy.\<version\>. Where
+*\<SELINUXTYPE\>* is the policy name specified in the SELinux
+configuration file /etc/selinux/config and \<version\> is the
 SELinux [**policy version**](#policy-versions).
 
 The binary policy can be built from source files supplied by the
@@ -245,124 +257,121 @@ Max kernel policy version:      32
 
 ```
 
-**Table 1: Policy version descriptions** describes the different versions, although note
-that there is also another version that applies to the modular policy,
-however the main policy database version is the one that is generally
-quoted (some SELinux utilities give both version numbers).
-
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>policy db Version</strong></td>
-<td><strong>modular db Version</strong></td>
-<td><strong>Description</strong></td>
-</tr>
-<tr>
-<td>15</td>
-<td>4</td>
-<td>The base version when SELinux was merged into the kernel.</td>
-</tr>
-<tr>
-<td>16</td>
-<td>-</td>
-<td>Added <a href="#conditional-policy"><em>Conditional Policy</em></a> support (the bool feature).</td>
-</tr>
-<tr>
-<td>17</td>
-<td>-</td>
-<td>Added support for IPv6.</td>
-</tr>
-<tr>
-<td>18</td>
-<td>-</td>
-<td>Added Netlink support.</td>
-</tr>
-<tr>
-<td>19</td>
-<td>5</td>
-<td>Added MLS support, plus the <code>validatetrans</code> Statement.</td>
-</tr>
-<tr>
-<td>20</td>
-<td>-</td>
-<td>Reduced the size of the access vector table.</td>
-</tr>
-<tr>
-<td>21</td>
-<td>6</td>
-<td>Added support for the MLS <code>range_transition</code> Statement.</td>
-</tr>
-<tr>
-<td>22</td>
-<td>7</td>
-<td>Added <code>policycap</code> Statement that allows various kernel options to be enabled as described in the <a href="policy_config_statements.md#policy-configuration-statements">Policy Configuration Statements</a> section.</td>
-</tr>
-<tr>
-<td>23</td>
-<td>8</td>
-<td>Added support for the <code>permissive</code> statement. This allows a domain to run in permissive mode while the others are still confined (instead of the all or nothing set by the <em>SELINUX</em> entry in the <em>/etc/selinux/config</em> file).</td>
-</tr>
-<tr>
-<td>24</td>
-<td>9 / 10</td>
-<td>Add support for the <code>typebounds</code> statement. This was added to support a hierarchical relationship between two domains in multi-threaded web servers as described in "<a href="http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf">A secure web application platform powered by SELinux</a>".</td>
-</tr>
-<tr>
-<td>25</td>
-<td>11</td>
-<td>Add support for file name transition in the <code>type_transition</code> rule. Requires kernel 2.6.39 minimum.</td>
-</tr>
-<tr>
-<td>26</td>
-<td>12/13</td>
-<td><p>Add support for a class parameter in the <code>role_transition</code> rule.</p>
-<p>Add support for the <code>attribute_role</code> and <code>roleattribute</code> statements.</p>
-<p>These require kernel 2.6.39 minimum.</p></td>
-</tr>
-<tr>
-<td>-</td>
-<td>14</td>
-<td>Separate tunables.</td>
-</tr>
-<tr>
-<td>27</td>
-<td>15</td>
-<td>Support setting object defaults for the user, role and range components when computing a new context. Requires kernel 3.5 minimum.</td>
-</tr>
-<tr>
-<td>28</td>
-<td>16</td>
-<td>Support setting object defaults for the type component when computing a new context. Requires kernel 3.5 minimum.</td>
-</tr>
-<tr>
-<td>29</td>
-<td>17</td>
-<td>Support attribute names within constraints. This allows attributes as well as the types to be retrieved from a kernel policy to assist <em><strong>audit2allow</strong>(8)</em> etc. to determine what attribute needs to be updated. Note that the attribute does not determine the constraint outcome, it is still the list of types associated to the constraint. Requires kernel 3.14 minimum.</td>
-</tr>
-<tr>
-<td>30</td>
-<td>18</td>
-<td><p>For the '<em>selinux</em>' target platform adds new '<code>xperm</code>' rules as explained in the <a href="xperm_rules.md#extended-access-vector-rules">Extended Access Vector Rules</a> section. This is to support 'ioctl whitelisting' as explained in the <a href="xperm_rules.md#ioctl-operation-rules">ioctl Operation Rules</a> section. Requires kernel 4.3 minimum. For modular support, requires libsepol 2.7 minimum.</p></td>
-</tr>
-<tr>
-<td>30</td>
-<td></td>
-<td>For the '<code>xen</code>' target platform support the <code>devicetreecon</code> statement and also expand the existing I/O memory range to 64 bits as explained in the <a href="xen_statements.md#xen-statements">Xen Statements</a> section.</td>
-</tr>
-<tr>
-<td>31</td>
-<td>19</td>
-<td>InfiniBand (IB) partition key (Pkey) and IB end port object labeling that requires kernel 4.13 minimum.  See the <a href="infiniband_statements.md#infiniband-labeling-statements">InfiniBand Labeling Statements section.</a></td>
-</tr>
-<tr>
-<td>32</td>
-<td>20</td>
-<td>Specify <code>glblub</code> as a <code>default_range</code> default and the computed transition will be the intersection of the MLS range of the two contexts. See <code>default_range</code> for details. Requires kernel 5.5 minimum. See the <a href="default_rules.md#default_range">Default Rules section.</a></td>
-</tr>
-</tbody>
-</table>
-
-**Table 1: Policy version descriptions**
+The following table describes the features added for each policy version and
+its corresponding modular policy version. When these features are implemented
+there may also be functionality added to the kernel, libselinux and/or libsepol.
+If known, these version requirements are also listed.
+
+**Policy: 15 Module: 4**
+
+The base version when SELinux was merged into the kernel.
+
+**Policy: 16**
+
+Added [**Conditional Policy**](#conditional-policy) support (the bool feature).
+
+**Policy: 17**
+
+Added support for IPv6.
+
+**Policy: 18**
+
+Added Netlink support.
+
+**Policy: 19 Module: 5**
+
+Added MLS support, plus the *validatetrans* Statement.
+
+**Policy: 20**
+
+Reduced the size of the access vector table.
+
+**Policy: 21 Module: 6**
+
+Added support for the MLS *range_transition* Statement.
+
+**Policy: 22 Module: 7**
+
+Added *policycap* Statement that allows various kernel options to be
+enabled as described in the
+[**Policy Configuration Statements**](policy_config_statements.md#policy-configuration-statements)
+section.
+
+**Policy: 23 Module: 8**
+
+Added support for the *permissive* statement. This allows a domain to run
+in permissive mode while the others are still confined (instead of the all
+or nothing set by the *SELINUX* entry in the */etc/selinux/config* file).
+
+**Policy: 24 Module: 9 / 10**
+
+Add support for the *typebounds* statement. This was added to support a
+hierarchical relationship between two domains in multi-threaded web servers
+as described in
+[**A secure web application platform powered by SELinux**](http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf).
+
+**Policy: 25 Module: 11**
+
+Add support for file name transition in the *type_transition* rule.
+Requires kernel 2.6.39 minimum.
+
+**Policy: 26 Module: 12 / 13**
+
+Add support for a class parameter in the *role_transition* rule and
+support for the *attribute_role* and *roleattribute* statements.
+These require kernel 2.6.39 minimum.
+
+**Module: 14**
+
+Separate tunables.
+
+**Policy: 27 Module: 15**
+
+Support setting object defaults for the user, role and range components
+when computing a new context. Requires kernel 3.5 minimum.
+
+**Policy: 28 Module: 16**
+
+Support setting object defaults for the type component when computing a
+new context. Requires kernel 3.5 minimum.
+
+**Policy: 29 Module: 17**
+
+Support attribute names within constraints. This allows attributes as well
+as the types to be retrieved from a kernel policy to assist
+***audit2allow**(8)* etc. to determine what attribute needs to be updated.
+Note that the attribute does not determine the constraint outcome, it is
+still the list of types associated to the constraint.
+Requires kernel 3.14 minimum.
+
+**Policy: 30 Module: 18**
+
+For the *selinux* target platform adds new *xperm* rules as explained in the
+[**Extended Access Vector Rules**](xperm_rules.md#extended-access-vector-rules)
+section. This is to support 'ioctl whitelisting' as explained in the
+[***ioctl* Operation Rules**](xperm_rules.md#ioctl-operation-rules) section.
+Requires kernel 4.3 minimum.
+For modular policy support requires libsepol 2.7 minimum.
+
+**Policy: 30**
+
+For the '*xen*' target platform support the *devicetreecon* statement and
+also expand the existing I/O memory range to 64 bits as explained in the
+[**Xen Statements**](xen_statements.md#xen-statements) section.
+
+**Policy: 31 Module: 19**
+
+Add InfiniBand (IB) partition key (Pkey) and IB end port object labeling
+as explained in the
+[**InfiniBand Labeling Statements**](infiniband_statements.md#infiniband-labeling-statements)
+section. Requires kernel 4.13 minimum.
+
+**Policy: 32 Module: 20**
+
+Specify *glblub* as a *default_range* default and the computed transition
+will be the intersection of the MLS range of the two contexts.
+See the [**default_range**](default_rules.md#default_range) for details.
+Requires kernel 5.5 minimum.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

