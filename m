Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA775C433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1C2074D
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Lsf9W3ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgHYIiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:13 -0400
Received: from mailomta7-sa.btinternet.com ([213.120.69.13]:34784 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgHYIiM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:12 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20200825083808.JHDG4195.sa-prd-fep-049.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344688; 
        bh=iNMO/xxmNkqwN2Gxa1/mYOprgi+wK92MvaSCyczuomg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Lsf9W3yat5sBVKpFhPQLYIta12pgiSuLW35ZvgtnHPfaWvcw/kZtinCMCDD7W6iY2Xexj+5lzb5Ij3WDRXGfaMWDaNb4/53R8yEUwFtT0mqxqhbGsBQz/UfBQcZbB+VEZ3gI0oAZmCE+7EibCX8BP9s8wIeAwVUbRBJSSWccbJcjFcBM2jPA4H0wg27cG5CnF1qQJ/9jTrR2zI1Zfdi5nFt8HjQ7Fjmu8fEGZ5kXWnmu/CzGmX4aKamBcC6aQujLXGVy3B2YuNxP2zVUqjxqFr8jPA0VMkgery+2EF6ZXTVA2I2Xvs6k2FgpyNJQFbDZrDHbvHOK36Q1sVxVRpoQ0Q==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599D7B; Tue, 25 Aug 2020 09:38:08 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 02/18] auditing: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:27 +0100
Message-Id: <20200825083743.6508-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/auditing.md | 300 ++++++++++++++++++++++--------------------------
 1 file changed, 135 insertions(+), 165 deletions(-)

diff --git a/src/auditing.md b/src/auditing.md
index 8272e02..8812db6 100644
--- a/src/auditing.md
+++ b/src/auditing.md
@@ -1,179 +1,149 @@
 # Auditing SELinux Events
 
+- [AVC Audit Events](#avc-audit-events)
+  - [Example Audit Events](#example-audit-events)
+- [General SELinux Audit Events](#general-selinux-audit-events)
+
 For SELinux there are two main types of audit event:
 
-1.  **AVC Audit Events** - These are generated by the AVC subsystem as a
-    result of access denials, or where specific events have requested an
-    audit message (i.e. where an *auditallow* rule has been used in
-    the policy).
-2.  **SELinux-aware Application Events** - These are generated by the
-    SELinux kernel services and SELinux-aware applications for events
-    such as system errors, initialisation, policy load, changing boolean
-    states, setting of enforcing / permissive mode, relabeling etc.
+1. **AVC Audit Events** - These are generated by the AVC subsystem as a
+   result of access denials, or where specific events have requested an
+   audit message (i.e. where an *auditallow* rule has been used in
+   the policy).
+2. **SELinux-aware Application Events** - These are generated by the
+   SELinux kernel services and SELinux-aware applications for events
+   such as system errors, initialisation, policy load, changing boolean
+   states, setting of enforcing / permissive mode, relabeling etc.
 
 The audit and event messages are generally stored in one of the
 following logs (in F-27 anyway):
 
-1.  The SELinux kernel boot events are logged in the */var/log/dmesg* log.
-2.  The system log */var/log/messages* contains messages generated by
-    SELinux before the audit daemon has been loaded.
-3.  The audit log */var/log/audit/audit.log* contains events that take
-    place after the audit daemon has been loaded. The AVC audit messages
-    of interest are described in the [AVC Audit Events](#avc-audit-events)
-    section with others described in the
-    [General SELinux Audit Events](#general-selinux-audit-events)
-    section. Fedora uses the audit framework **auditd**(8) as standard.
+1. The SELinux kernel boot events are logged in the */var/log/dmesg* log.
+2. The system log */var/log/messages* contains messages generated by
+   SELinux before the audit daemon has been loaded.
+3. The audit log */var/log/audit/audit.log* contains events that take
+   place after the audit daemon has been loaded. The AVC audit messages
+   of interest are described in the [AVC Audit Events](#avc-audit-events)
+   section with others described in the
+   [General SELinux Audit Events](#general-selinux-audit-events)
+   section. Fedora uses the audit framework ***auditd**(8)* as standard.
 
 Notes:
 
-1.  It is not mandatory for SELinux-aware applications to audit events
-    or even log them in the audit log. The decision is made by the
-    application designer.
-2.  The format of audit messages do not need to conform to any format,
-    however where possible applications should use the
-    ***audit_log_user_avc_message**(3)* function with a suitably
-    formatted message if using ***auditd**(8)*. The type of audit events
-    possible are defined in the *include/libaudit.h* and
-    *include/linux/audit.h* files.
-3.  Those libselinux library functions that output messages do so to
-    *stderr* by default, however this can be changed by calling
-    ***selinux_set_callback**(3)* and specifying an alternative log
-    handler.
+1. It is not mandatory for SELinux-aware applications to audit events
+   or even log them in the audit log. The decision is made by the
+   application designer.
+2. The format of audit messages do not need to conform to any format,
+   however where possible applications should use the
+   ***audit_log_user_avc_message**(3)* function with a suitably
+   formatted message if using ***auditd**(8)*. The type of audit events
+   possible are defined in the *include/libaudit.h* and
+   *include/linux/audit.h* files.
+3. Those libselinux library functions that output messages do so to
+   *stderr* by default, however this can be changed by calling
+   ***selinux_set_callback**(3)* and specifying an alternative log handler.
 
 ## AVC Audit Events
 
-**Table 1** describes the general format of AVC audit
-messages in the audit.log when access has been denied or an audit event
-has been specifically requested. Other types of events are shown in the
-section that follows.
-
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Keyword<strong></td>
-<td><strong>Description<strong></td>
-</tr>
-<tr>
-<td>type</td>
-<td><p>For SELinux AVC events this can be:</p>
-<p>type=AVC - for kernel events</p>
-<p>type=USER_AVC - for user-space object manager events</p>
-<p>Note that once the AVC event has been logged, another event with type=SYSCALL may follow that contains further information regarding the event. </p>
-<p>The AVC event can always be tied to the relevant SYSCALL event as they have the same serial_number in the msg=audit(time:serial_number) field as shown in the following example:</p>
-<p><strong>type=AVC</strong> msg=audit(1243332701.744<strong>:101</strong>): avc: denied { getattr } for pid=2714 comm="ls" path="/usr/lib/locale/locale-archive" dev=dm-0 ino=353593 scontext=system_u:object_r:unlabeled_t:s0 tcontext=system_u:object_r:locale_t:s0 tclass=file</p>
-<p><strong>type=SYSCALL</strong> msg=audit(1243332701.744<strong>:101</strong>): arch=40000003 syscall=197 success=yes exit=0 a0=3 a1=553ac0 a2=552ff4 a3=bfc5eab0 items=0 ppid=2671 pid=2714 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=1 comm="ls" <em>exe="/bin/ls</em>" subj=system_u:object_r:unlabeled_t:s0 key=(null)</p></td>
-</tr>
-<tr>
-<td>msg</td>
-<td>This will contain the audit keyword with a reference number (e.g. msg=audit(1243332701.744:101))</td>
-</tr>
-<tr>
-<td>avc</td>
-<td><p>This will be either denied when access has been denied or granted when an <em><em>auditallow</em><em> rule</em></em> has been defined by the policy.</p>
-<p>The entries that follow the *avc=* field depend on what type of event is being audited. Those shown below are generated by the kernel AVC audit function, however the user space AVC audit function will return fields relevant to the application being managed by their Object Manager.</p></td>
-</tr>
-<tr>
-<td>pid</td>
-<td rowspan="2">If a task, then log the process id (pid) and the name of the executable file (comm).</td>
-</tr>
-<tr>
-<td>comm</td>
-</tr>
-<tr>
-<td>capability</td>
-<td>If a capability event then log the identifier.</td>
-</tr>
-<tr>
-<td>path</td>
-<td rowspan="4">If a File System event then log the relevant information. Note that the name field may not always be present.</td>
-</tr>
-<tr>
-<td>name</td>
-</tr>
-<tr>
-<td>dev</td>
-</tr>
-<tr>
-<td>ino</td>
-</tr>
-<tr>
-<td>laddr</td>
-<td rowspan="4">If a Socket event then log the Source / Destination addresses and ports for IP4 or IP6 sockets (AF_INET).</td>
-</tr>
-<tr>
-<td>lport</td>
-</tr>
-<tr>
-<td>faddr</td>
-</tr>
-<tr>
-<td>fport</td>
-</tr>
-<tr>
-<td>path</td>
-<td>If a File Socket event then log the path (AF_UNIX).</td>
-</tr>
-<tr>
-<td>saddr</td>
-<td rowspan="5"><p>If a Network event then log the Source / Destination addresses and ports with the network interface for IP4 or IP6 networks (AF_INET).</p></td>
-</tr>
-<tr>
-<td>src</td>
-</tr>
-<tr>
-<td>daddr</td>
-</tr>
-<tr>
-<td>dest</td>
-</tr>
-<tr>
-<td>netif</td>
-</tr>
-<tr>
-<td>sauid</td>
-<td rowspan="3">IPSec security association identifiers</td>
-</tr>
-<tr>
-<td>hostname</td>
-</tr>
-<tr>
-<td>addr</td>
-</tr>
-<tr>
-<td>resid</td>
-<td rowspan="2">X-Windows resource ID and type.</td>
-</tr>
-<tr>
-<td>restype</td>
-</tr>
-<tr>
-<td>scontext</td>
-<td>The security context of the source or subject.</td>
-</tr>
-<tr>
-<td>tcontext</td>
-<td>The security context of the target or object.</td>
-</tr>
-<tr>
-<td>tclass</td>
-<td>The object class of the target or object.</td>
-</tr>
-<tr>
-<td>permissive</td>
-<td>Keyword introduced in Linux 4.17 to indicate whether the event
-was denied or granted due to global or per-domain permissive
-mode.</td>
-</tr>
-</tbody>
-</table>
-
-**Table 1: AVC Audit Message Description**
-
-Example *audit.log* denied and granted events are shown in the following
-examples:
-
-This is an example **denied** message - note that there are two
-`type=AVC` calls, but only one corresponding `type=SYSCALL` entry.
+The **AVC Audit Message Keyword Descriptions** table describes the general
+format of AVC audit messages in the *audit.log* when access has been denied
+or an audit event has been specifically requested. Other types of events are
+shown in the section that follows.
+
+**AVC Audit Message Keyword Descriptions:**
+
+*type*
+
+- For SELinux AVC events this can be:
+  - *type=AVC* - for kernel events.
+  - *type=USER_AVC* - for user-space object manager events.
+- Note that once the AVC event has been logged, another event with
+  *type=SYSCALL* may follow that contains further information regarding the
+  event.
+- The AVC event can always be tied to the relevant *SYSCALL* event as they
+  have the same *serial_number* in the *msg=audit(time:serial_number)* field
+  as shown in the following example:
+  - ***type=AVC*** *msg=audit(1243332701.744:***101***): avc: denied { getattr }
+    for pid=2714 comm="ls" path="/usr/lib/locale/locale-archive" dev=dm-0
+    ino=353593 scontext=system_u:object_r:unlabeled_t:s0
+    tcontext=system_u:object_r:locale_t:s0 tclass=file*
+  - ***type=SYSCALL*** *msg=audit(1243332701.744:***101***): arch=40000003
+    syscall=197 success=yes exit=0 a0=3 a1=553ac0 a2=552ff4 a3=bfc5eab0
+    items=0 ppid=2671 pid=2714 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0
+    egid=0 sgid=0 fsgid=0 tty=pts1 ses=1 comm="ls" exe="/bin/ls"
+    subj=system_u:object_r:unlabeled_t:s0 key=(null)*
+
+*msg*
+
+- This will contain the audit keyword with a reference number
+  (e.g. *msg=audit(1243332701.744:101)*)
+
+*avc*
+
+- This will be either denied when access has been denied or granted when an
+  *auditallow* rule has been defined by the policy.
+- The entries that follow the *avc=* field depend on what type of event is
+  being audited. Those shown below are generated by the kernel AVC audit
+  function, however the user space AVC audit function will return fields
+  relevant to the application being managed by their Object Manager.
+
+*pid* and *comm*
+
+- If a task, then log the process id (*pid*) and the name of the executable
+  file (*comm*).
+
+*capability*
+
+- If a capability event then log the identifier.
+
+*path*, *name*, *dev* and *ino*
+
+- If a File System event then log the relevant information. Note that the
+  *name* field may not always be present.
+
+*laddr*, *lport*, *faddr* and *fport*
+
+- If a Socket event then log the Source / Destination addresses and ports
+  for IPv4 or IPv6 sockets (*AF_INET*).
+
+*path*
+
+- If a File Socket event then log the path (*AF_UNIX*).
+
+*saddr*, *src*, *daddr*, *dest* and *netif*
+
+- If a Network event then log the Source / Destination addresses and ports
+  with the network interface for IPv4 or IPv6 networks (*AF_INET*).
+
+*sauid*, *hostname* and *addr*
+
+- IPSec security association identifiers.
+
+*resid* and *restype*
+
+- X-Windows resource ID and type.
+
+*scontext*
+
+- The security context of the source or subject.
+
+*tcontext*
+
+- The security context of the target or object.
+
+*tclass*
+
+- The object class of the target or object.
+
+*permissive*
+
+- Keyword introduced in Linux 4.17 to indicate whether the event
+  was denied or granted due to global or per-domain permissive mode.
+
+### Example Audit Events
+
+This is an example ***denied*** message - note that there are two
+***type=AVC*** calls, but only one corresponding ***type=SYSCALL*** entry.
 
 ```
 type=AVC msg=audit(1242575005.122:101): avc: denied { rename } for
@@ -196,7 +166,7 @@ exe="/usr/bin/canberra-gtk-play"
 subj=test_u:staff_r:oddjob_mkhomedir_t:s0 key=(null)
 ```
 
-These are example X-Windows object manager audit message:
+These are example X-Windows object manager audit messages:
 
 ```
 type=USER_AVC msg=audit(1267534171.023:18): user pid=1169 uid=0
@@ -211,7 +181,7 @@ type=USER_AVC msg=audit(1267534395.930:19): user pid=1169 uid=0
 auid=4294967295 ses=4294967295
 subj=system_u:unconfined_r:unconfined_t msg='avc: denied { read } for
 request=SELinux:SELinuxGetClientContext comm=X-setest resid=3c00001
-restype=&lt;unknown&gt;
+restype=<unknown>
 scontext=unconfined_u:unconfined_r:x_select_paste_t
 tcontext=unconfined_u:unconfined_r:unconfined_t tclass=x_resource :
 exe="/usr/bin/Xorg" sauid=0 hostname=? addr=? terminal=?'
@@ -357,7 +327,7 @@ perms=ioctl,read,write,getattr,lock,append,open
 ```
 
 These were generated by the kernel security server when an SELinux-aware
-application was trying to use ***setcon***(3) to create a new thread. To
+application was trying to use ***setcon**(3)* to create a new thread. To
 fix this a *typebounds* statement is required in the policy.
 
 ```
-- 
2.26.2

