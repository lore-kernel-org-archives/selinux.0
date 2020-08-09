Return-Path: <SRS0=Syrn=BT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15151C433DF
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49F22068F
	for <selinux@archiver.kernel.org>; Sun,  9 Aug 2020 16:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="uTUGTYGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHIQWf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:22:35 -0400
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:54491 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbgHIQWd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Aug 2020 12:22:33 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200809162222.MUXS21348.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Sun, 9 Aug 2020 17:22:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596990142; 
        bh=ZMfdXGkrmVeG6o7LCQgvwg8CeYTmpnx6V4GUwIhOFkU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=uTUGTYGq+LOtd5+56PE0BsNPAfUyPZrPUDDvRfdi6llSnovM2rT/nCF8fHVaLM3FpXidcsCd6d6KXrxUdrvyf5YL9u9tj9AAdHFppLpAdfLtfIGfIpqS1kQo77IaWQtyeudm1nFsjfC+1duMMdTXGpqBH5ujpY0re3KjsaBhVDAI8Xnoguw/053+86pjoEqCdiDD/Q/8pytDJMzKaHJvvba6iYX4aiLdMkh+Xv1j8AjpKdeLD1uDDWTB5TsvTDZNQfgmCRzzfpZtlMjVfaP6lA1kG0gyPYjdRytP0SDgTWGD5EqXmrlZZpV33uPb3ZNtUBtm/e1eix/CfiGqUy2lFA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [81.147.56.64]
X-OWM-Source-IP: 81.147.56.64 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrkeeigdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfelleefjedtjeffgeeluddthffgjeekueduleelhfegveehvdelhedtvdegjeeunecuffhomhgrihhnpegtohhmmhhonhgtrhhithgvrhhirghpohhrthgrlhdrohhrghdpshgthhgruhhflhgvrhdqtggrrdgtohhmnecukfhppeekuddrudegjedrheeirdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddugeejrdehiedrieegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgt
        ohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.56.64) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD0B0E4609; Sun, 9 Aug 2020 17:22:22 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-notebook: Convert terminology.md to markdown
Date:   Sun,  9 Aug 2020 17:22:12 +0100
Message-Id: <20200809162212.193739-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/terminology.md | 349 +++++++++++++++++++++++++++++++--------------
 1 file changed, 243 insertions(+), 106 deletions(-)

diff --git a/src/terminology.md b/src/terminology.md
index 77eaade..410eff5 100644
--- a/src/terminology.md
+++ b/src/terminology.md
@@ -1,119 +1,256 @@
 # Abbreviations and Terminology
 
+-   [Abbreviations](#abbreviations)
+-   [Terminology](#terminology)
+
 ## Abbreviations
 
-|         |                                                                                          |
-| ------- | ---------------------------------------------------------------------------------------- |
-| AV      | Access Vector                                                                            |
-| AVC     | Access Vector Cache                                                                      |
-| BLP     | Bell-La Padula                                                                           |
-| CC      | [Common Criteria](http://www.commoncriteriaportal.org/)                                  |
-| CIL     | Common Intermediate Language                                                             |
-| CMW     | Compartmented Mode Workstation                                                           |
-| DAC     | Discretionary Access Control                                                             |
-| FLASK   | Flux Advanced Security Kernel                                                            |
-| Fluke   | Flux kernel Environment                                                                  |
-| Flux    | The Flux Research Group                                                                  |
-| ID      | Identification                                                                           |
-| LSM     | Linux Security Module                                                                    |
-| LAPP    | Linux, Apache, PostgreSQL, PHP / Perl / Python                                           |
-| LSPP    | Labeled Security Protection Profile                                                      |
-| MAC     | Mandatory Access Control                                                                 |
-| MCS     | Multi-Category Security                                                                  |
-| MLS     | Multi-Level Security                                                                     |
-| MMAC    | Middleware Mandatory Access Control                                                      |
-| NSA     | National Security Agency                                                                 |
-| OM      | Object Manager                                                                           |
-| OTA     | over the air                                                                             |
-| PAM     | Pluggable Authentication Module                                                          |
-| RBAC    | Role-based Access Control                                                                |
-| RBACSEP | Role-based Access Control Separation                                                     |
-| rpm     | Red Hat Package Manager                                                                  |
-| SELinux | Security Enhanced Linux                                                                  |
-| SID     | Security Identifier                                                                      |
-| SMACK   | [Simplified Mandatory Access Control Kernel](http://www.schaufler-ca.com/)               |
-| SUID    | Super-user Identifier                                                                    |
-| TE      | Type Enforcement                                                                         |
-| UID     | User Identifier                                                                          |
-| XACE    | X (windows) Access Control Extension                                                     |
+**AV**
+
+Access Vector
+
+**AVC**
+
+Access Vector Cache
+
+**BLP**
+
+Bell-La Padula
+
+**CC**
+
+[Common Criteria](http://www.commoncriteriaportal.org/)
+
+**CIL**
+
+Common Intermediate Language
+
+**CMW**
+
+Compartmented Mode Workstation
+
+**DAC**
+
+Discretionary Access Control
+
+**FLASK**
+
+Flux Advanced Security Kernel
+
+**Fluke**
+
+Flux kernel Environment
+
+**Flux**
+
+The Flux Research Group
+
+**ID**
+
+Identification
+
+**LSM**
+
+Linux Security Module
+
+**LAPP**
+
+Linux, Apache, PostgreSQL, PHP / Perl / Python
+
+**LSPP**
+
+Labeled Security Protection Profile
+
+**MAC**
+
+Mandatory Access Control
+
+**MCS**
+
+Multi-Category Security
+
+**MLS**
+
+Multi-Level Security
+
+**MMAC**
+
+Middleware Mandatory Access Control
+
+**NSA**
+
+National Security Agency
+
+**OM**
+
+Object Manager
+
+**OTA**
+
+over the air
+
+**PAM**
+
+Pluggable Authentication Module
+
+**RBAC**
+
+Role-based Access Control
+
+**RBACSEP**
+
+Role-based Access Control Separation
+
+**rpm**
+
+Red Hat Package Manager
+
+**SELinux**
+
+Security Enhanced Linux
+
+**SID**
+
+Security Identifier
+
+**SMACK**
+
+[Simplified Mandatory Access Control Kernel](http://www.schaufler-ca.com/)
+
+**SUID**
+
+Super-user Identifier
+
+**TE**
+
+Type Enforcement
+
+**UID**
+
+User Identifier
+
+**XACE**
+
+X (windows) Access Control Extension
 
 ## Terminology
 
 These give a brief introduction to the major components that form the
 core SELinux infrastructure.
 
-<table>
-<tbody>
-<tr>
-<td>Access Vector (AV)</td>
-<td>A bit map representing a set of permissions (such as open, read, write).</td>
-</tr>
-<tr>
-<td>Access Vector Cache (AVC)</td>
-<td><p>A component that stores access decisions made by the SELinux <strong>Security Server</strong> for subsequent use by <strong>Object Managers</strong>. This allows previous decisions to be retrieved without the overhead of re-computation.</p>
-<p>Within the core SELinux services there are two <strong>Access Vector Caches</strong>:</p></td>
-</tr>
-<tr>
-<td>Domain</td>
-<td>For SELinux this consists of one or more processes associated to the type component of a <strong>Security Context</strong>. <strong>Type Enforcement</strong> rules declared in Policy describe how the domain will interact with objects (see <strong>Object Class</strong>).</td>
-</tr>
-<tr>
-<td>Linux Security Module (LSM)</td>
-<td><p>A framework that provides hooks into kernel components (such as disk and network services) that can be utilised by security modules (e.g. SELinux and SMACK) to perform access control checks.</p>
-<p>Currently only one LSM module can be loaded, however work is in progress to stack multiple modules).</p></td>
-</tr>
-<tr>
-<td>Mandatory Access Control</td>
-<td>An access control mechanisim enforced by the system. This can be achieved by 'hard-wiring' the operating system and applications (the bad old days - well good for some) or via a policy that conforms to a <strong>Policy</strong>. Examples of policy based MAC are SELinux and SMACK.</td>
-</tr>
-<tr>
-<td>Multi-Level Security (MLS)</td>
-<td>Based on the Bell-La &amp; Padula model (BLP) for confidentiality in that (for example) a process running at a 'Confidential' level can read / write at their current level but only read down levels or write up levels. While still used in this way, it is more commonly used for application separation utilising the Multi-Category Security (MCS) variant.</td>
-</tr>
-<tr>
-<td>Object Class</td>
-<td><p>Describes a resource such as files, sockets or services.</p>
-<p>Each 'class' has relevant permissions associated to it such as read, write or export. This allows access to be enforced on the instantiated object by their <strong>Object Manager</strong>. </p></td>
-</tr>
-<tr>
-<td>Object Manager</td>
-<td><p>Userspace and kernel components that are responsible for the labeling, management (e.g. creation, access, destruction) and enforcement of the objects under their control. <strong>Object Managers</strong> call the <strong>Security Server</strong> for an access decision based on a source and target <strong>Security Context</strong> (or <strong>SID</strong>), an <strong>Object Class</strong> and a set of permissions (or <strong>AV</strong>s). The <strong>Security Server</strong> will base its decision on whether the currently loaded <strong>Policy</strong> will allow or deny access.</p>
-<p>An <strong>Object Manager</strong> may also call the <strong>Security Server</strong> to compute a new <strong>Security Context</strong> or <strong>SID</strong> for an object.</p></td>
-</tr>
-<tr>
-<td>Policy</td>
-<td>A set of rules determining access rights. In SELinux these rules are generally written in a kernel policy language using either <em><strong>m4</strong>(1)</em> macro support (e.g. Reference Policy) or the new CIL language. The <strong>Policy</strong> is then compiled into a binary format for loading into the <strong>Security Server</strong>.</td>
-</tr>
-<tr>
-<td>Role Based Access Control</td>
-<td>SELinux users are associated to one or more roles, each role may then be associated to one or more <strong>Domain</strong> types.</td>
-</tr>
-<tr>
-<td>Role Based Access Control-Seperation</td>
-<td><p>Role-based separation of user home directories. An optional policy tunable is required:</p>
-<p>tunableif enable_rbacsep</p></td>
-</tr>
-<tr>
-<td>Security Server</td>
-<td><p>A sub-system in the Linux kernel that makes access decisions and computes security contexts based on <strong>Policy</strong> on behalf of SELinux-aware applications and Object Managers.</p>
-<p>The<strong> Security Server</strong> does not enforce a decision, it merely states whether the operation is allowed or not according to the <strong>Policy</strong>. It is the SELinux-aware application or <strong>Object Manager</strong> responsibility to enforce the decision.</p></td>
-</tr>
-<tr>
-<td>Security Context</td>
-<td><p>An SELinux <strong>Security Context</strong> is a variable length string that consists of the following mandatory components <em>user:role:type</em> and an optional <em>[:range]</em> component.</p>
-<p>Generally abbreviated to 'context', and sometimes called a 'label'.</p></td>
-</tr>
-<tr>
-<td>Security Identifier (SID)</td>
-<td><p>SIDs are unique opaque integer values mapped by the kernel <strong>Security Server</strong> and userspace AVC that represent a <strong>Security Context</strong>.</p>
-<p>The SIDs generated by the kernel <strong>Security Server</strong> are <em>u32</em> values that are passed via the <strong>Linux Security Module</strong> hooks to/from the kernel <strong>Object Managers</strong>.</p></td>
-</tr>
-<tr>
-<td>Type Enforcement</td>
-<td>SELinux makes use of a specific style of type enforcement (TE) to enforce <strong>Mandatory Access Control</strong>. This is where all subjects and objects have a type identifier associated to them that can then be used to enforce rules laid down by <strong>Policy</strong>.</td>
-</tr>
-</tbody>
-</table>
+**Access Vector (AV)**
+
+A bit map representing a set of permissions (such as open, read, write).
+
+**Access Vector Cache (AVC)**
+
+A component that stores access decisions made by the SELinux **Security Server**
+for subsequent use by **Object Managers**. This allows previous decisions to
+be retrieved without the overhead of re-computation. Within the core SELinux
+services there are two **Access Vector Caches**:
+
+1. A kernel AVC that caches decisions by the **Security Server** on behalf of
+   kernel based object managers.
+2. A userspace AVC built into libselinux that caches decisions when
+   SELinux-aware applications use ***avc_open**(3)* with ***avc_has_perm**(3)*
+   or ***avc_has_perm_noaudit**(3)* function calls. This will save calls to the
+   kernel after the first decision has been made. Note that the preferred
+   option is to use the ***selinux_check_access**(3)* function as this will
+   utilise the userspace AVC as explained in the
+   [**Computing Access Decisions**](computing_access_decisions.md#computing-access-decisions)
+   section.
+
+**Domain**
+
+For SELinux this consists of one or more processes associated to the type
+component of a **Security Context**. **Type Enforcement** rules declared in
+policy describe how the domain will interact with objects (see **Object Class**).
+
+**Linux Security Module (LSM)**
+
+A framework that provides hooks into kernel components (such as disk and
+network services) that can be utilised by security modules (e.g. **SELinux** and
+SMACK) to perform access control checks. Work is in progress to stack multiple
+modules
+
+**Mandatory Access Control**
+
+An access control mechanisim enforced by the system. This can be achieved
+by 'hard-wiring' the operating system and applications or via a policy that
+conforms to a **Policy**. Examples of policy based MAC are **SELinux** and SMACK.
+
+**Multi-Level Security (MLS)**
+
+Based on the Bell-La & Padula model (BLP) for confidentiality in that
+(for example) a process running at a 'Confidential' level can read / write at
+their current level but only read down levels or write up levels. While still
+used in this way, it is more commonly used for application separation
+utilising the Multi-Category Security (MCS) variant.
+
+**Object Class**
+
+Describes a resource such as files, sockets or services. Each 'class' has
+relevant permissions associated to it such as read, write or export.
+This allows access to be enforced on the instantiated object by their
+**Object Manager**.
+
+**Object Manager**
+
+Userspace and kernel components that are responsible for the labeling,
+management (e.g. creation, access, destruction) and enforcement of the objects
+under their control. **Object Managers** call the **Security Server** for an
+access decision based on a source and target **Security Context**
+(or **SID**), an **Object Class** and a set of permissions (or **AV**s).
+The **Security Server** will base its decision on whether the currently loaded
+**Policy** will allow or deny access. An **Object Manager** may also call the
+**Security Server** to compute a new **Security Context** or **SID**
+for an object.
+
+**Policy**
+
+A set of rules determining access rights. In SELinux these rules are generally
+written in a kernel policy language using either ***m4**(1)* macro support
+(e.g. Reference Policy) or the CIL language. The **Policy** is then compiled
+into a binary format for loading into the **Security Server**.
+
+**Role Based Access Control**
+
+SELinux users are associated to one or more roles, each role may then be
+associated to one or more **Domain** types.
+
+**Role Based Access Control-Seperation**
+
+Role-based separation of user home directories. An optional policy tunable is
+required: *tunableif enable_rbacsep*
+
+**Security Server**
+
+A sub-system in the Linux kernel that makes access decisions and computes
+security contexts based on **Policy** on behalf of SELinux-aware applications
+and Object Managers. The **Security Server** does not enforce a decision, it
+merely states whether the operation is allowed or not according to the
+**Policy**. It is the SELinux-aware application or **Object Manager**
+responsibility to enforce the decision.
+
+**Security Context**
+
+An SELinux **Security Context** is a variable length string that consists of
+the following mandatory components *user:role:type* and an optional *[:range]*
+component. Generally abbreviated to 'context', and sometimes called a 'label'.
+
+**Security Identifier (SID)**
+
+SIDs are unique opaque integer values mapped by the kernel **Security Server**
+and userspace AVC that represent a **Security Context**. The SIDs generated
+by the kernel **Security Server** are `u32` values that are passed via the
+**Linux Security Module** hooks to/from the kernel **Object Managers**.
+
+**Type Enforcement**
+
+SELinux makes use of a specific style of type enforcement (TE) to enforce
+**Mandatory Access Control**. This is where all subjects and objects have a
+type identifier associated to them that can then be used to enforce rules
+laid down by **Policy**.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

