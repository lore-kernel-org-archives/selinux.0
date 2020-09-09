Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7096C433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C48F20770
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="cX357jGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIJIqf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:46:35 -0400
Received: from mailomta10-re.btinternet.com ([213.120.69.103]:56989 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729990AbgIJIqS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 04:46:18 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200909133044.LPHK4080.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658244; 
        bh=b3ipCmpFZs1a3Q+0vsJFLIGzCrl1GikbcDNEI0LxSB4=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=cX357jGJyCb+z9NY1GS3QlbeCF6IATi1HoedzU2nM684Y3m3/aHQfy/3JbfjUv3oVumcFcUnvdzswqHOJUP3L7c138w0oW8HbWNU2EAulzG222zo8ExmZ6v3iBbB2hAhYHlU7mShNzKxwWvA8P028FCBjRxgsc6NNoRUlX5aG10JnzGzu9Zg6/H8nbReODI8n9YNwmAepDeljrY1BrF/D2TB47HUHrGaHGYCMtgLeFuOFC1ggGxf+Z9y7X61PUjJA3BjCz1o/mgjF6tZuSNvmq8zMcJ6/LetOovhwzW6XEfXWSKVe77fJla0QMaAmEwZ/V0DAcY4WrSWeOpiaXOsRA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfekgffghffgleekgfellefftedvhfejveehhfekkefgvdehueetgfffffelkedtnecukfhppeekiedrudehgedrudehgedrudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134D91; Wed, 9 Sep 2020 14:30:44 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 03/22] object_classes_permissions: : Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:20 +0100
Message-Id: <20200909133039.44498-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/object_classes_permissions.md | 299 +++++++++++++++---------------
 1 file changed, 151 insertions(+), 148 deletions(-)

diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index c51d36b..fa16024 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -3,137 +3,137 @@
 - [Introduction](#introduction)
   - [Defining Object Classes and Permissions](#defining-object-classes-and-permissions)
 - [Kernel Object Classes and Permissions](#kernel-object-classes-and-permissions)
-   - [Common Permissions](#common-permissions)
-      - [Common File Permissions](#common-file-permissions)
-      - [Common Socket Permissions](#common-socket-permissions)
-      - [Common IPC Permissions](#common-ipc-permissions)
-      - [Common Capability Permissions](#common-capability-permissions)
-      - [Common Capability2 Permissions](#common-capability2-permissions)
-      - [Common Database Permissions](#common-database-permissions)
-      - [Common X_Device Permissions](#common-x_device-permissions)
-   - [File Object Classes](#file-object-classes)
-      - [*filesystem*](#filesystem)
-      - [*dir*](#dir)
-      - [*file*](#file)
-      - [*lnk_file*](#lnk_file)
-      - [*chr_file*](#chr_file)
-      - [*blk_file*](#blk_file)
-      - [*sock_file*](#sock_file)
-      - [*fifo_file*](#fifo_file)
-      - [*fd*](#fd)
-   - [Network Object Classes](#network-object-classes)
-      - [*node*](#node)
-      - [*netif*](#netif)
-      - [*socket*](#socket)
-      - [*tcp_socket*](#tcp_socket)
-      - [*udp_socket*](#udp_socket)
-      - [*rawip_socket*](#rawip_socket)
-      - [*packet_socket*](#packet_socket)
-      - [*unix_stream_socket*](#unix_stream_socket)
-      - [*unix_dgram_socket*](#unix_dgram_socket)
-      - [*tun_socket*](#tun_socket)
-   - [IPSec Network Object Classes](#ipsec-network-object-classes)
-      - [*association*](#association)
-      - [*key_socket*](#key_socket)
-      - [*netlink_xfrm_socket*](#netlink_xfrm_socket)
-   - [Netlink Object Classes](#netlink-object-classes)
-      - [*netlink_socket*](#netlink_socket)
-      - [*netlink_route_socket*](#netlink_route_socket)
-      - [*netlink_firewall_socket* (Deprecated)](#netlink_firewall_socket-deprecated)
-      - [*netlink_tcpdiag_socket*](#netlink_tcpdiag_socket)
-      - [*netlink_nflog_socket*](#netlink_nflog_socket)
-      - [*netlink_selinux_socket*](#netlink_selinux_socket)
-      - [*netlink_audit_socket*](#netlink_audit_socket)
-      - [*netlink_ip6fw_socket* (Deprecated)](#netlink_ip6fw_socket-deprecated)
-      - [*netlink_dnrt_socket*](#netlink_dnrt_socket)
-      - [*netlink_kobject_uevent_socket*](#netlink_kobject_uevent_socket)
-      - [*netlink_iscsi_socket*](#netlink_iscsi_socket)
-      - [*netlink_fib_lookup_socket*](#netlink_fib_lookup_socket)
-      - [*netlink_connector_socket*](#netlink_connector_socket)
-      - [*netlink_netfilter_socket*](#netlink_netfilter_socket)
-      - [*netlink_generic_socket*](#netlink_generic_socket)
-      - [*netlink_scsitransport_socket*](#netlink_scsitransport_socket)
-      - [*netlink_rdma_socket*](#netlink_rdma_socket)
-      - [*netlink_crypto_socket*](#netlink_crypto_socket)
-   - [Miscellaneous Network Object Classes](#miscellaneous-network-object-classes)
-      - [*peer*](#peer)
-      - [*packet*](#packet)
-      - [*appletalk_socket*](#appletalk_socket)
-      - [*dccp_socket*](#dccp_socket)
-   - [Sockets via *extended_socket_class*](#sockets-via-extended_socket_class)
-      - [*sctp_socket*](#sctp_socket)
-      - [*icmp_socket*](#icmp_socket)
-      - [Miscellaneous Extended Socket Classes](#miscellaneous-extended-socket-classes)
-   - [BPF Object Class](#bpf-object-class)
-      - [*bpf*](#bpf)
-   - [Performance Event Object Class](#performance-event-object-class)
-      - [*perf_event*](#perf_event)
-   - [Lockdown Object Class](#lockdown-object-class)
-      - [*lockdown*](#lockdown)
-   - [IPC Object Classes](#ipc-object-classes)
-      - [*ipc* (Deprecated)](#ipc-deprecated)
-      - [*sem*](#sem)
-      - [*msgq*](#msgq)
-      - [*msg*](#msg)
-      - [*shm*](#shm)
-   - [Process Object Class](#process-object-class)
-      - [*process*](#process)
-      - [*process2*](#process2)
-   - [Security Object Class](#security-object-class)
-      - [*security*](#security)
-   - [System Operation Object Class](#system-operation-object-class)
-      - [*system*](#system)
-   - [Miscellaneous Kernel Object Classes](#miscellaneous-kernel-object-classes)
-      - [*kernel_service*](#kernel_service)
-      - [*key*](#key)
-      - [*memprotect*](#memprotect)
-      - [*binder*](#binder)
-   - [Capability Object Classes](#capability-object-classes)
-      - [*capability*](#capability)
-      - [*capability2*](#capability2)
-      - [*cap_userns*](#cap_userns)
-      - [*cap2_userns*](#cap2_userns)
-   - [InfiniBand Object Classes](#infiniband-object-classes)
-      - [*infiniband_pkey*](#infiniband_pkey)
-      - [*infiniband_endport*](#infiniband_endport)
+  - [Common Permissions](#common-permissions)
+    - [Common File Permissions](#common-file-permissions)
+    - [Common Socket Permissions](#common-socket-permissions)
+    - [Common IPC Permissions](#common-ipc-permissions)
+    - [Common Capability Permissions](#common-capability-permissions)
+    - [Common Capability2 Permissions](#common-capability2-permissions)
+    - [Common Database Permissions](#common-database-permissions)
+    - [Common X_Device Permissions](#common-x_device-permissions)
+  - [File Object Classes](#file-object-classes)
+    - [*filesystem*](#filesystem)
+    - [*dir*](#dir)
+    - [*file*](#file)
+    - [*lnk_file*](#lnk_file)
+    - [*chr_file*](#chr_file)
+    - [*blk_file*](#blk_file)
+    - [*sock_file*](#sock_file)
+    - [*fifo_file*](#fifo_file)
+    - [*fd*](#fd)
+  - [Network Object Classes](#network-object-classes)
+    - [*node*](#node)
+    - [*netif*](#netif)
+    - [*socket*](#socket)
+    - [*tcp_socket*](#tcp_socket)
+    - [*udp_socket*](#udp_socket)
+    - [*rawip_socket*](#rawip_socket)
+    - [*packet_socket*](#packet_socket)
+    - [*unix_stream_socket*](#unix_stream_socket)
+    - [*unix_dgram_socket*](#unix_dgram_socket)
+    - [*tun_socket*](#tun_socket)
+  - [IPSec Network Object Classes](#ipsec-network-object-classes)
+    - [*association*](#association)
+    - [*key_socket*](#key_socket)
+    - [*netlink_xfrm_socket*](#netlink_xfrm_socket)
+  - [Netlink Object Classes](#netlink-object-classes)
+    - [*netlink_socket*](#netlink_socket)
+    - [*netlink_route_socket*](#netlink_route_socket)
+    - [*netlink_firewall_socket* (Deprecated)](#netlink_firewall_socket-deprecated)
+    - [*netlink_tcpdiag_socket*](#netlink_tcpdiag_socket)
+    - [*netlink_nflog_socket*](#netlink_nflog_socket)
+    - [*netlink_selinux_socket*](#netlink_selinux_socket)
+    - [*netlink_audit_socket*](#netlink_audit_socket)
+    - [*netlink_ip6fw_socket* (Deprecated)](#netlink_ip6fw_socket-deprecated)
+    - [*netlink_dnrt_socket*](#netlink_dnrt_socket)
+    - [*netlink_kobject_uevent_socket*](#netlink_kobject_uevent_socket)
+    - [*netlink_iscsi_socket*](#netlink_iscsi_socket)
+    - [*netlink_fib_lookup_socket*](#netlink_fib_lookup_socket)
+    - [*netlink_connector_socket*](#netlink_connector_socket)
+    - [*netlink_netfilter_socket*](#netlink_netfilter_socket)
+    - [*netlink_generic_socket*](#netlink_generic_socket)
+    - [*netlink_scsitransport_socket*](#netlink_scsitransport_socket)
+    - [*netlink_rdma_socket*](#netlink_rdma_socket)
+    - [*netlink_crypto_socket*](#netlink_crypto_socket)
+  - [Miscellaneous Network Object Classes](#miscellaneous-network-object-classes)
+    - [*peer*](#peer)
+    - [*packet*](#packet)
+    - [*appletalk_socket*](#appletalk_socket)
+    - [*dccp_socket*](#dccp_socket)
+  - [Sockets via *extended_socket_class*](#sockets-via-extended_socket_class)
+    - [*sctp_socket*](#sctp_socket)
+    - [*icmp_socket*](#icmp_socket)
+    - [Miscellaneous Extended Socket Classes](#miscellaneous-extended-socket-classes)
+  - [BPF Object Class](#bpf-object-class)
+    - [*bpf*](#bpf)
+  - [Performance Event Object Class](#performance-event-object-class)
+    - [*perf_event*](#perf_event)
+  - [Lockdown Object Class](#lockdown-object-class)
+    - [*lockdown*](#lockdown)
+  - [IPC Object Classes](#ipc-object-classes)
+    - [*ipc* (Deprecated)](#ipc-deprecated)
+    - [*sem*](#sem)
+    - [*msgq*](#msgq)
+    - [*msg*](#msg)
+    - [*shm*](#shm)
+  - [Process Object Class](#process-object-class)
+    - [*process*](#process)
+    - [*process2*](#process2)
+  - [Security Object Class](#security-object-class)
+    - [*security*](#security)
+  - [System Operation Object Class](#system-operation-object-class)
+    - [*system*](#system)
+  - [Miscellaneous Kernel Object Classes](#miscellaneous-kernel-object-classes)
+    - [*kernel_service*](#kernel_service)
+    - [*key*](#key)
+    - [*memprotect*](#memprotect)
+    - [*binder*](#binder)
+  - [Capability Object Classes](#capability-object-classes)
+    - [*capability*](#capability)
+    - [*capability2*](#capability2)
+    - [*cap_userns*](#cap_userns)
+    - [*cap2_userns*](#cap2_userns)
+  - [InfiniBand Object Classes](#infiniband-object-classes)
+    - [*infiniband_pkey*](#infiniband_pkey)
+    - [*infiniband_endport*](#infiniband_endport)
 - [Userspace Object Classes](#userspace-object-classes)
-   - [X Windows Object Classes](#x-windows-object-classes)
-      - [*x_drawable*](#x_drawable)
-      - [*x_screen*](#x_screen)
-      - [*x_gc*](#x_gc)
-      - [*x_font*](#x_font)
-      - [*x_colormap*](#x_colormap)
-      - [*x_property*](#x_property)
-      - [*x_selection*](#x_selection)
-      - [*x_cursor*](#x_cursor)
-      - [*x_client*](#x_client)
-      - [*x_device*](#x_device)
-      - [*x_server*](#x_server)
-      - [*x_extension*](#x_extension)
-      - [*x_resource*](#x_resource)
-      - [*x_event*](#x_event)
-      - [*x_synthetic_event*](#x_synthetic_event)
-      - [*x_application_data*](#x_application_data)
-      - [*x_pointer*](#x_pointer)
-      - [*x_keyboard*](#x_keyboard)
-   - [Database Object Classes](#database-object-classes)
-      - [*db_database*](#db_database)
-      - [*db_table*](#db_table)
-      - [*db_schema*](#db_schema)
-      - [*db_procedure*](#db_procedure)
-      - [*db_column*](#db_column)
-      - [*db_tuple*](#db_tuple)
-      - [*db_blob*](#db_blob)
-      - [*db_view*](#db_view)
-      - [*db_sequence*](#db_sequence)
-      - [*db_language*](#db_language)
-   - [Miscellaneous Userspace Object Classes](#miscellaneous-userspace-object-classes)
-      - [*passwd*](#passwd)
-      - [*nscd*](#nscd)
-      - [*dbus*](#dbus)
-      - [*context*](#context)
-      - [*service*](#service)
-      - [*proxy*](#proxy)
+  - [X Windows Object Classes](#x-windows-object-classes)
+    - [*x_drawable*](#x_drawable)
+    - [*x_screen*](#x_screen)
+    - [*x_gc*](#x_gc)
+    - [*x_font*](#x_font)
+    - [*x_colormap*](#x_colormap)
+    - [*x_property*](#x_property)
+    - [*x_selection*](#x_selection)
+    - [*x_cursor*](#x_cursor)
+    - [*x_client*](#x_client)
+    - [*x_device*](#x_device)
+    - [*x_server*](#x_server)
+    - [*x_extension*](#x_extension)
+    - [*x_resource*](#x_resource)
+    - [*x_event*](#x_event)
+    - [*x_synthetic_event*](#x_synthetic_event)
+    - [*x_application_data*](#x_application_data)
+    - [*x_pointer*](#x_pointer)
+    - [*x_keyboard*](#x_keyboard)
+  - [Database Object Classes](#database-object-classes)
+    - [*db_database*](#db_database)
+    - [*db_table*](#db_table)
+    - [*db_schema*](#db_schema)
+    - [*db_procedure*](#db_procedure)
+    - [*db_column*](#db_column)
+    - [*db_tuple*](#db_tuple)
+    - [*db_blob*](#db_blob)
+    - [*db_view*](#db_view)
+    - [*db_sequence*](#db_sequence)
+    - [*db_language*](#db_language)
+  - [Miscellaneous Userspace Object Classes](#miscellaneous-userspace-object-classes)
+    - [*passwd*](#passwd)
+    - [*nscd*](#nscd)
+    - [*dbus*](#dbus)
+    - [*context*](#context)
+    - [*service*](#service)
+    - [*proxy*](#proxy)
 
 ## Introduction
 
@@ -141,7 +141,8 @@ This section contains a list of object classes and their associated
 permissions that have been taken from the Fedora policy sources. There
 are also additional entries for Xen. The Android specific classes and
 permissions are shown in the
-[**Security Enhancements for Android**](seandroid.md#security-enhancements-for-android) section.
+[**Security Enhancements for Android**](seandroid.md#security-enhancements-for-android)
+section.
 
 The SElinux Testsuite has tests that exercise a number of these object
 classes/permissions and is a useful reference:
@@ -153,23 +154,28 @@ used in the standard Linux function calls (such as 'create a socket' or
 
 *relabelfrom*
 
-- Used on most objects to allow the objects security context to be changed from the current type.
+- Used on most objects to allow the objects security context to be changed from
+  the current type.
 
 *relabelto*
 
-- Used on most objects to allow the objects security context to be changed to the new type.
+- Used on most objects to allow the objects security context to be changed to
+  the new type.
 
 *entrypoint*
 
-- Used for files to indicate that they can be used as an entry point into a domain via a domain transition.
+- Used for files to indicate that they can be used as an entry point into a
+  domain via a domain transition.
 
 *execute_no_trans*
 
-- Used for files to indicate that they can be used as an entry point into the calling domain (i.e. does not require a domain transition).
+- Used for files to indicate that they can be used as an entry point into the
+  calling domain (i.e. does not require a domain transition).
 
 *execmod*
 
-Generally used for files to indicate that they can execute the modified file in memory.
+- Generally used for files to indicate that they can execute the modified file
+  in memory.
 
 Where possible the specific object class permissions are explained,
 however for some permissions it is difficult to determine what they are
@@ -189,10 +195,10 @@ Note: In theory a policy could be defined with no classes or permissions
 then set the *handle_unknown* flag when building the policy to *allow*
 (***checkpolicy**(8)* and ***secilc**(8)*
 *[-U handle-unknown (allow,deny,reject)]*). However:
--   CIL requires at least one class to be defined.
--   The *process* class with its *transition* and *dyntransition* permissions
-    are still required for default labeling behaviors, role and range
-    transitions in older policy versions.
+- CIL requires at least one class to be defined.
+- The *process* class with its *transition* and *dyntransition* permissions
+  are still required for default labeling behaviors, role and range
+  transitions in older policy versions.
 
 The [**Object Class and Permission Statements**](class_permission_statements.md#object-class-and-permission-statements)
 section specifies how these are defined within the Kernel Policy Language,
@@ -465,7 +471,6 @@ inherited by a number of object classes.
 - msgq - Send message to message queue.
 - sem  - Change semaphore value.
 
-
 ### Common Capability Permissions
 
 **Permission** - 32 permissions - Text from */usr/include/linux/capability.h*
@@ -843,7 +848,6 @@ A mounted *filesystem*
 
 ### *dir*
 
-
 A Directory
 
 **Permissions** - Inherit 25
@@ -1125,7 +1129,7 @@ IPSec security association
 *polmatch*
 
 - Match IPSec Security Policy Database (SPD) context (-ctx) entries to an
-  SELinux domain (contained in the Security Association Database (SAD) .
+  SELinux domain (contained in the Security Association Database (SAD)).
 
 *recvfrom*
 
@@ -1169,7 +1173,7 @@ IPSec key management. Protocol: *PF_KEY* Family Type: All
 
 ## Netlink Object Classes
 
-Netlink sockets communicate between userspace and the kernel – also see
+Netlink sockets communicate between userspace and the kernel - also see
 ***netlink**(7)*.
 
 ### *netlink_socket*
@@ -2913,7 +2917,6 @@ Manage a database view.
 
 - Allows the expansion of a 'view'.
 
-
 ### *db_sequence*
 
 A sequential number generator.
@@ -3090,11 +3093,11 @@ Manage ***systemd**(1)* services.
 
 *reload*
 
-- Restart systemd services.
+- Restart *systemd* services.
 
 *start*
 
-- Start systemd services.
+- Start *systemd* services.
 
 *status*
 
@@ -3102,7 +3105,7 @@ Manage ***systemd**(1)* services.
 
 *stop*
 
-- Stop systemd services.
+- Stop *systemd* services.
 
 ### *proxy*
 
-- 
2.26.2

