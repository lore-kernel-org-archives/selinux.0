Return-Path: <SRS0=pOJ2=A7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782FC433DF
	for <selinux@archiver.kernel.org>; Mon, 20 Jul 2020 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1ED1208E4
	for <selinux@archiver.kernel.org>; Mon, 20 Jul 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="Nqse+4JB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGTHp3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTHp3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jul 2020 03:45:29 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAE00C061794
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2020 00:45:28 -0700 (PDT)
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id DBE0B2A1007;
        Mon, 20 Jul 2020 09:45:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl DBE0B2A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595231127;
        bh=5f76SqoyomCc4SIsSq1BZLOvZugyopHLu64pnJsIggU=;
        h=From:To:Cc:Subject:Date:From;
        b=Nqse+4JBDvOZyDgjylv2B2c6YXO6z4upZ00p+ZmKiF/wbW5ikx0YXA+kWtK/UIC5d
         6Oy+5rjn1dzDzhQKdjhMiB/zkgmSjh+nUaGca9xcJ+zOH7d8g/aE5ekOO7TQ/MFUGE
         ED0kCBv7cWBkB15fTDL11hyNVdZNh3Rh3ufk3JUU=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] object_classes_permissions: describe bpf and perfmon capabilities
Date:   Mon, 20 Jul 2020 09:45:15 +0200
Message-Id: <20200720074515.1687720-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These capabilities were introduced with Linux 5.8
The ipc security class is deprecated (kind of at least)
Fix a typo in net_broadcast

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/object_classes_permissions.md | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index 1b183bb..498d872 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -421,7 +421,7 @@ inherited by a number of object classes.
 <td>Allows opening of raw sockets and packet sockets.</td>
 </tr>
 <tr>
-<td>netbroadcast</td>
+<td>net_broadcast</td>
 <td>Grant network broadcasting and listening to incoming multicasts.</td>
 </tr>
 <tr>
@@ -496,13 +496,18 @@ inherited by a number of object classes.
 <tbody>
 <tr>
 <td style="background-color:#F2F2F2;"><strong>Permissions</strong></td>
-<td style="background-color:#F2F2F2;">Description (6 permissions)</td>
+<td style="background-color:#F2F2F2;">Description (8 permissions)</td>
 </tr>
 <tr>
 <td>audit_read</td>
 <td>Allow reading audits logs.</td>
 </tr>
 <tr>
+<td>bpf</td>
+<td><p>Create maps, do other <em>sys_bpf()</em> commands and load 'SK_REUSEPORT' progs.</p>
+<p>Note that loading tracing programs also requires 'CAP_PERFMON' and that loading networking programs also requires 'CAP_NET_ADMIN'.</p></td>
+</tr>
+<tr>
 <td>block_suspend</td>
 <td>Prevent system suspends (was <em>epollwakeup</em>)</td>
 </tr>
@@ -516,6 +521,11 @@ inherited by a number of object classes.
 <td>Allow MAC policy to be overridden. (not used)</td>
 </tr>
 <tr>
+<tr>
+<td>perfmon</td>
+<td>Allow system performance monitoring and observability operations.</td>
+</tr>
+<tr>
 <td>syslog</td>
 <td>Allow configuration of kernel <em>syslog</em> (<em>printk</em> behaviour).</td>
 </tr>
@@ -2015,7 +2025,7 @@ implementation.
 
 ## IPC Object Classes
 
-### `ipc`
+### `ipc` (Deprecated)
 
 <table>
 <tbody>
@@ -2600,11 +2610,11 @@ Note that while this is defined as a kernel object class, the userspace
 </tr>
 <tr>
 <td style="background-color:#F2F2F2;"><strong>Permissions</strong></td>
-<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 6 permissions)</td>
+<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 8 permissions)</td>
 </tr>
 <tr>
 <td style="background-color:#F2F2F2;"><a href="#common-capability2-permissions"><strong>Common Capability2 Permissions<strong></td>
-<td style="background-color:#F2F2F2;">audit_read, block_suspend, mac_admin, mac_override, syslog, wake_alarm</td>
+<td style="background-color:#F2F2F2;">audit_read, bpf, block_suspend, mac_admin, mac_override, perfmon, syslog, wake_alarm</td>
 </tr>
 </tbody>
 </table>
@@ -2638,11 +2648,11 @@ Note that while this is defined as a kernel object class, the userspace
 </tr>
 <tr>
 <td style="background-color:#F2F2F2;"><strong>Permissions</strong></td>
-<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 6 permissions)</td>
+<td style="background-color:#F2F2F2;"><strong>Description</strong> (Inherit 8 permissions)</td>
 </tr>
 <tr>
 <td style="background-color:#F2F2F2;"><a href="#common-capability2-permissions"><strong>Common Capability2 Permissions<strong></td>
-<td style="background-color:#F2F2F2;">audit_read, block_suspend, mac_admin, mac_override, syslog, wake_alarm</td>
+<td style="background-color:#F2F2F2;">audit_read, bpf, block_suspend, mac_admin, mac_override, perfmon, syslog, wake_alarm</td>
 </tr>
 </tbody>
 </table>
-- 
2.27.0

