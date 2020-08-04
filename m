Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C8C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511002086A
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PhY32fey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHDBeE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBeE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:04 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0FC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b2so7742837qvp.9
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=5XGXgUwHt2jixVb6VUVl2u66EYLnPPiFpBq/Tv4sfkM=;
        b=PhY32feyoNJ2PjZSQqaAYd7Cb2DoiaautVrm31j7TEoeVmseXm0zysVRe4fTXQTB5N
         mHRWFFOeLCn3qSrQB31zuTzwRFPSXUT7GWlLHelyQSZDlOIvHGJhCwIhbYtyl2sXzais
         uoYTMKR41O9kWgF3CAdvOS4U7AhiXTwlIOYC6ASkE9Q8vACULp+N8MhsIvBRWiFazwUg
         IRT9IDTCsjFSITYPP+7CuRTLu5tn7Fyu/8395/t/byFFcpoQF+KOA28MEIKSlaj+v3Bg
         uzX3V111AywTvp7JgQhPPBD4TTckM46YuZvEpZmBevzz0VI3PjjOjzgjt4KOjBavs57o
         jSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5XGXgUwHt2jixVb6VUVl2u66EYLnPPiFpBq/Tv4sfkM=;
        b=qZPAJFY8dRx/GG+GlMCbVpnxQxWLBMF/z1MPSKYbtvfDWoo6zDSdz8rHNPk/IiXXRw
         ye2U3Dz3VaCFKcQHBfMZAy26RJi/9vgBPWbbmlEPt8yEjHB5zvuPuJPQPUuF6Dp4P8D1
         5NSL7cv9d+r7O2SwwOJ6K+vkCYdklzapDLSbiHH7l70bVMMJml1V4VjxN3ge/6VMqSN3
         3DdyNnu0ccpmjL3zZpqlPGwpfkqVrjuC30n9zBB1fcVXQ7LTkUMXCzC24UrMVEidMblA
         qCF9eYBDvrUFbihcq6PurjC1+qMx2zEahMVm4oETUseRRVBtP2O7xVTakG5R2xlYnRoJ
         m8Jg==
X-Gm-Message-State: AOAM532lIq/hRraNbXK001cjtbq6se6Kdsu5ztIRMynAedzaK+nuOOhT
        6UyOhNIJ4rbaO39hJZgvq3oxywB1vmwo
X-Google-Smtp-Source: ABdhPJyqxXuwvAISqyirUZLF+JWmJFJNVEh9yAmLVxxF8NHWNAJzXETwznaZ7qkr3qcPqGteG1o7LQ==
X-Received: by 2002:a0c:ea8e:: with SMTP id d14mr19488576qvp.37.1596504843018;
        Mon, 03 Aug 2020 18:34:03 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id f189sm19642200qke.15.2020.08.03.18.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:02 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 07/18] vm_support: fully convert to
 markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:01 -0400
Message-ID: <159650484173.8961.4886081033953945601.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As a warning, the footnotes may not render correctly until all footnotes in
the document have been converted.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/vm_support.md |  135 +++++++++++------------------------------------------
 1 file changed, 27 insertions(+), 108 deletions(-)

diff --git a/src/vm_support.md b/src/vm_support.md
index f072fe3..09321ed 100644
--- a/src/vm_support.md
+++ b/src/vm_support.md
@@ -1,10 +1,9 @@
 # SELinux Virtual Machine Support
 
-SELinux support is available in the KVM/QEMU and Xen virtual machine
-(VM) technologies<a href="#fnv1" class="footnote-ref" id="fnvms1"><strong><sup>1</sup></strong></a>
-(that are discussed in the sections that follow, however the package
-documentation should be read for how these products actually work and how they
-are configured.
+SELinux support is available in the KVM/QEMU and Xen virtual machine (VM)
+technologies[^fn_vms_1] that are discussed in the sections that follow, however
+the package documentation should be read for how these products actually work
+and how they are configured.
 
 Currently the main SELinux support for virtualisation is via *libvirt*
 that is an open-source virtualisation API used to dynamically load guest
@@ -23,8 +22,6 @@ To ensure all dependencies are installed run:
 
 `dnf install libvirt qemu virt-manager`
 
-<br>
-
 ## KVM / QEMU Support
 
 KVM is a kernel loadable module that uses the Linux kernel as a
@@ -51,7 +48,6 @@ configure these and their VM image files.
 QEMU provides the hardware emulation services for the guest
 operating systems. Note that KVM requires CPU virtualisation support.*
 
-
 ## *libvirt* Support
 
 The Svirt project added security hooks into the *libvirt* library that
@@ -65,14 +61,12 @@ that will load and manage the images. The SELinux implementation
 supports four methods of labeling VM images, processes and their
 resources with support from the Reference Policy *modules/services/virt*
 loadable module. To support this labeling, *libvirt* requires an MCS or MLS
-enabled policy as the [**`level`**](security_context.md#security-context)
+enabled policy as the [***level***](security_context.md#security-context)
 entry of the security context is used (*user:role:type:level*).
 
 The link <http://libvirt.org/drvqemu.html#securityselinux> has details
 regarding the QEMU driver and the SELinux confinement modes it supports.
 
-<br>
-
 ## VM Image Labeling
 
 This sections assumes VM images have been generated using the simple
@@ -109,33 +103,12 @@ implemented as follows:
     The following example shows two running VM sessions each having
     different labels:
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>VM Image Name<strong></td>
-<td><strong>Object<strong></td>
-<td><strong>Dynamically assigned security context<strong></td>
-</tr>
-<tr>
-<td rowspan="2"><strong>Dynamic_VM1</strong></td>
-<td><code>process</code></td>
-<td><code>system_u:system_r:svirt_tcg_t:s0:c585,c813</code></td>
-</tr>
-<tr>
-<td><code>file</code></td>
-<td><code>system_u:system_r:svirt_image_t:s0:c585,c813</code></td>
-</tr>
-<tr>
-<td rowspan="2"><strong>Dynamic_VM2</strong></td>
-<td><code>process</code></td>
-<td>s<code>ystem_u:system_r:svirt_tcg_t:s0:c535,c601<code></td>
-</tr>
-<tr>
-<td><code>file</code></td>
-<td><code>system_u:system_r:svirt_image_t:s0:c535,c601</code></td>
-</tr>
-</tbody>
-</table>
+| VM Image    | Object    | Dynamically assigned security context             |
+| ------------| --------- | ------------------------------------------------- |
+| Dynamic_VM1 | *process* | *system_u:system_r:svirt_tcg_t:s0:c585,c813*      |
+|             | *file*    | *system_u:system_r:svirt_image_t:s0:c585,c813*    |
+| Dynamic_VM2 | *process* | *system_u:system_r:svirt_tcg_t:s0:c535,c601*      |
+|             | *file*    | *system_u:system_r:svirt_image_t:s0:c535,c601*    |
 
 The running image *ls -Z* and *ps -eZ* are as follows, and for
 completeness an *ls -Z* is shown when both VMs have been stopped:
@@ -163,8 +136,6 @@ system_u:object_r:virt_image_t:s0 Dynamic_VM1.img
 system_u:object_r:virt_image_t:s0 Dynamic_VM2.img
 ```
 
-<br>
-
 ### Shared Image
 
 If the disk image has been set to shared, then a dynamically allocated
@@ -253,30 +224,12 @@ initialisation process will take place:
     The following example shows each VM having the same file label but
     different process labels:
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>VM Image Name</strong></td>
-<td><strong>Object</strong></td>
-<td><strong>Security context</strong></td>
-</tr>
-<tr>
-<td><strong>Shareable_VM</strong></td>
-<td><code>process</code></td>
-<td><code>system_u:system_r:svirt_tcg_t:s0:c231,c245</code></td>
-</tr>
-<tr>
-<td><strong>Shareable_VM-clone</strong></td>
-<td><code>process</code></td>
-<td><code>system_u:system_r:svirt_tcg_t:s0:c695,c894</code></td>
-</tr>
-<tr>
-<td></td>
-<td><code>file</code></td>
-<td><code>system_u:system_r:svirt_image_t:s0</code></td>
-</tr>
-</tbody>
-</table>
+
+| VM Image           | Object    | Security context                             |
+| -------------------| ----------| -------------------------------------------- |
+| Shareable_VM       | *process* | *system_u:system_r:svirt_tcg_t:s0:c231,c245* |
+| Shareable_VM-clone | *process* | *system_u:system_r:svirt_tcg_t:s0:c695,c894* |
+|                    | *file*    | *system_u:system_r:svirt_image_t:s0*         |
 
 The running image *ls -Z* and *ps -eZ* are as follows and for
 completeness an *ls -Z* is shown when both VMs have been stopped:
@@ -391,35 +344,12 @@ was possible because the 's*etsebool -P virt_transition_userdomain
 on*'* *boolean was set that allows *virtd_t* domain to transition to a
 user domain (e.g. *unconfined_t*).
 
-
-
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>VM Image Name<strong></td>
-<td><strong>Object<strong></td>
-<td><strong>Static security context<strong></td>
-</tr>
-<tr>
-<td rowspan="2"><strong>Static_VM1</strong></td>
-<td><code>process</code></td>
-<td><code>system_u:system_r:svirt_t:s0:c1022,c1023</code></td>
-</tr>
-<tr>
-<td><code>file</code></td>
-<td><code>system_u:system_r:svirt_image_t:s0:c1022,c1023</code></td>
-</tr>
-<tr>
-<td rowspan="2"><strong>Static_VM2</strong></td>
-<td><code>process</code></td>
-<td><code>system_u:system_r:unconfined_t:s0:c11,c22</code></td>
-</tr>
-<tr>
-<td><code>file</code></td>
-<td><code>system_u:system_r:virt_image_t:s0</code></td>
-</tr>
-</tbody>
-</table>
+| VM Image   | Object    | Static security context                            |
+| -----------| --------- | -------------------------------------------------- |
+| Static_VM1 | *process* | *system_u:system_r:svirt_t:s0:c1022,c1023*         |
+|            | *file*    | *system_u:system_r:svirt_image_t:s0:c1022,c1023*   |
+| Static_VM2 | *process* | *system_u:system_r:unconfined_t:s0:c11,c22*        |
+|            | *file*    | *system_u:system_r:virt_image_t:s0*                |
 
 The running image *ls -Z* and *ps -eZ* are as follows, and for
 completeness an *ls -Z* is shown when both VMs have been stopped:
@@ -446,8 +376,6 @@ system_u:object_r:svirt_image_t:s0:c1022,c1023 Static_VM1.img
 system_u:object_r:virt_image_t:s0 Static_VM2.img
 ```
 
-<br>
-
 ## Xen Support
 
 This is not supported by SELinux in the usual way as it is built into
@@ -479,19 +407,10 @@ For reference, the Xen policy supports additional policy language
 statements that defined in the
 [**Xen Statements**](xen_statements.md#xen-statements) section.
 
-<br>
-
-<section class="footnotes">
-<ol>
-<li id="fnv1"><p>KVM (Kernel-based Virtual Machine) and Xen are classed as 'bare metal' hypervisors and they
-rely on other services to manage the overall VM environment. QEMU (Quick Emulator) is an
-emulator that emulates the BIOS and I/O device functionality and can be used standalone or with
-KVM and Xen.<a href="#fnvms1" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
-
-
-<br>
+[^fn_vms_1]: KVM (Kernel-based Virtual Machine) and Xen are classed as 'bare
+metal' hypervisors and they rely on other services to manage the overall VM
+environment. QEMU (Quick Emulator) is an emulator that emulates the BIOS and
+I/O device functionality and can be used standalone or with KVM and Xen.
 
 <!-- %CUTHERE% -->
 

