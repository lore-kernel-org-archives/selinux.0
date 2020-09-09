Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644AC433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10BBF205F4
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="aNaieDpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgIJSk3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:40:29 -0400
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:16749 "EHLO
        re-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726899AbgIJSih (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 14:38:37 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20200909133049.LPHW4080.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658249; 
        bh=Wau+/e9lkW4vlEGydTH/sQUvV3HmjL2rq9g1CYbEKnU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=aNaieDpZr7ZNJt0EZdVKssPpvkWTCnflBV2QV0jlyGeavlmkBPoLQwqGylwhLHddH4Hbq6tE0vC7DfXmL/v6hp+BHga/ql1HFzE+0x53KCVuvd0w+YsG3zGSbXX5wK5+BHhchIDvZiOGLC0YfX73Cgy5o9baQ8jq0oOyqslz4T87rKKrtsSGtVaYKDLSmFDir+qYz5+2SyUPqM4JDbgAYMxE/c087jO2ghHC90900qHEgf5v/Zo1+zccbIn7IA3uvrNsm6nzpMyQEEWCQWxgVRP6lGytApPxyKrBV3qhQNqqHAJCSUq3lLnVNw8MTqA20Z0mlTNuTBE5KXVFTZ7gGQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134E3F; Wed, 9 Sep 2020 14:30:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 19/22] vm_support: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:36 +0100
Message-Id: <20200909133039.44498-20-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/vm_support.md | 84 ++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/src/vm_support.md b/src/vm_support.md
index 80d5cd5..a60fe6c 100644
--- a/src/vm_support.md
+++ b/src/vm_support.md
@@ -1,5 +1,13 @@
 # SELinux Virtual Machine Support
 
+- [KVM / QEMU Support](#kvm-qemu-support)
+- [*libvirt* Support](#libvirt-support)
+- [VM Image Labeling](#vm-image-labeling)
+  - [Dynamic Labeling](#dynamic-labeling)
+  - [Shared Image](#shared-image)
+  - [Static Labeling](#static-labeling)
+- [Xen Support](#xen-support)
+
 SELinux support is available in the KVM/QEMU and Xen virtual machine (VM)
 technologies[^fn_vms_1] that are discussed in the sections that follow, however
 the package documentation should be read for how these products actually work
@@ -90,20 +98,20 @@ other (i.e. every time the VM is run a different and unique MCS label
 will be generated to confine each VM to its own domain). This mode is
 implemented as follows:
 
-1.  An initial context for the process is obtained from the
-    */etc/selinux/&lt;SELINUXTYPE&gt;/contexts/virtual_domain_context*
-    file (the default is *system_u:system_r:svirt_tcg_t:s0*).
-2.  An initial context for the image file label is obtained from the
-    */etc/selinux/&lt;SELINUXTYPE&gt;/contexts/virtual_image_context*
-    file. The default is *system_u:system_r:svirt_image_t:s0* that
-    allows read/write of image files.
-3.  When the image is used to start the VM, a random MCS *level* is
-    generated and added to the process context and the image file
-    context. The process and image files are then transitioned to the
-    context by the* libselinux* API calls *setfilecon* and *setexeccon*
-    respectively (see *security_selinux.c* in the *libvirt *source).
-    The following example shows two running VM sessions each having
-    different labels:
+1. An initial context for the process is obtained from the
+   */etc/selinux/\<SELINUXTYPE\>/contexts/virtual_domain_context*
+   file (the default is *system_u:system_r:svirt_tcg_t:s0*).
+2. An initial context for the image file label is obtained from the
+   */etc/selinux/\<SELINUXTYPE\>/contexts/virtual_image_context*
+   file. The default is *system_u:system_r:svirt_image_t:s0* that
+   allows read/write of image files.
+3. When the image is used to start the VM, a random MCS *level* is
+   generated and added to the process context and the image file
+   context. The process and image files are then transitioned to the
+   context by the *libselinux* API calls *setfilecon* and *setexeccon*
+   respectively (see *security_selinux.c* in the *libvirt *source).
+   The following example shows two running VM sessions each having
+   different labels:
 
 | VM Image    | Object    | Dynamically assigned security context             |
 | ------------| --------- | ------------------------------------------------- |
@@ -152,7 +160,7 @@ checking the *Shareable* box as shown in **Figure 19**.
 
 This will set the image (*Shareable_VM.xml*) resource XML
 configuration file located in the */etc/libvirt/qemu* directory
-*&lt;disk&gt;* contents as follows:
+*\<disk\>* contents as follows:
 
 ```
 # /etc/libvirt/qemu/Shareable_VM.xml:
@@ -172,7 +180,7 @@ needs to be cloned and the VM resource name selected was
 
 ![](./images/20-clone.png)
 
-The resource XML file *&lt;disk&gt;* contents generated are shown - note
+The resource XML file *\<disk\>* contents generated are shown - note
 that it has the same *source file* name as the *Shareable_VM.xml* file
 shown above.
 
@@ -191,7 +199,7 @@ shown above.
 With the targeted policy on Fedora the shareable option gave a error when
 the VMs were run as follows:
 
--   **Could not allocate dynamic translator buffer**
+- **Could not allocate dynamic translator buffer**
 
 The audit log contained the following AVC message:
 
@@ -213,19 +221,19 @@ setsebool -P virt_use_execmem on
 Now that the image has been configured as shareable, the following
 initialisation process will take place:
 
-1.  An initial context for the process is obtained from the
-    */etc/selinux/&lt;SELINUXTYPE&gt;/contexts/virtual_domain_context*
-    file (the default is *system_u:system_r:svirt_tcg_t:s0*).
-2.  An initial context for the image file label is obtained from the
-    */etc/selinux/&lt;SELINUXTYPE&gt;/contexts/virtual_image_context*
-    file. The default is *system_u:system_r:svirt_image_t:s0* that
-    allows read/write of image files.
-3.  When the image is used to start the VM a random MCS level is
-    generated and added to the process context (but not the image file).
-    The process is then transitioned to the appropriate context by the*
-    libselinux* API calls *setfilecon* and *setexeccon* respectively.
-    The following example shows each VM having the same file label but
-    different process labels:
+1. An initial context for the process is obtained from the
+   */etc/selinux/\<SELINUXTYPE\>/contexts/virtual_domain_context*
+   file (the default is *system_u:system_r:svirt_tcg_t:s0*).
+2. An initial context for the image file label is obtained from the
+   */etc/selinux/\<SELINUXTYPE\>/contexts/virtual_image_context*
+   file. The default is *system_u:system_r:svirt_image_t:s0* that
+   allows read/write of image files.
+3. When the image is used to start the VM a random MCS level is
+   generated and added to the process context (but not the image file).
+   The process is then transitioned to the appropriate context by the*
+   libselinux* API calls *setfilecon* and *setexeccon* respectively.
+   The following example shows each VM having the same file label but
+   different process labels:
 
 | VM Image           | Object    | Security context                             |
 | -------------------| ----------| -------------------------------------------- |
@@ -273,8 +281,8 @@ need to be relabeled. An example VM configuration follows where the VM
 has been created as *Static_VM1* using the Fedora *targeted* policy in
 enforcing mode (just so all errors are flagged during the build):
 
-1.  To set the required security context requires editing the
-    *Static_VM1* configuration file using ***virsh**(1)* as follows:
+1. To set the required security context requires editing the
+   *Static_VM1* configuration file using ***virsh**(1)* as follows:
 
 ```
 virsh edit Static_VM1
@@ -301,11 +309,11 @@ For this example *svirt_t* has been chosen as it is a valid context
 written to the *Static_VM1.xml* configuration file in
 */etc/libvirt/qemu*.
 
-2.  If the VM is now started an error will be shown as follows:
+2. If the VM is now started an error will be shown as follows:
 
 ![](./images/21-error.png)
 
-**Figure 2.21: Image Start Error**
+**Figure 21: Image Start Error**
 
 This is because the image file label is incorrect as by default
 it is labeled *virt_image_t* when the VM image is built (and
@@ -340,12 +348,12 @@ the same as the process using *chcon* as follows:
 chcon -l s0:c1022,c1023 Static_VM1.img
 ```
 
-3.  Now that the image has been relabeled, the VM can now be started.
+3. Now that the image has been relabeled, the VM can now be started.
 
 The following example shows two static VMs (one is configured for
 *unconfined_t* that is allowed to run under the targeted policy - this
-was possible because the 's*etsebool -P virt_transition_userdomain
-on*'* *boolean was set that allows *virtd_t* domain to transition to a
+was possible because the '*setsebool -P virt_transition_userdomain
+on*' boolean was set that allows *virtd_t* domain to transition to a
 user domain (e.g. *unconfined_t*).
 
 | VM Image   | Object    | Static security context                            |
@@ -383,7 +391,7 @@ system_u:object_r:virt_image_t:s0 Static_VM2.img
 ## Xen Support
 
 This is not supported by SELinux in the usual way as it is built into
-the actual Xen software as a 'Flask/TE' extension[24] for the XSM (Xen
+the actual Xen software as a 'Flask/TE' extension for the XSM (Xen
 Security Module). Also the Xen implementation has its own built-in
 policy (*xen.te*) and supporting definitions for access vectors,
 security classes and initial SIDs for the policy. These Flask/TE
-- 
2.26.2

