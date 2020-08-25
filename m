Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18964C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F652075B
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="REpx97+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgHYIiT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:19 -0400
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:34229 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728543AbgHYIiP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:15 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200825083810.LXZC4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344690; 
        bh=MscxKCRu5e6f/Y6erVfiJFdf4IKu1/9yRWC6PTtnlkY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=REpx97+Kq8382H6mGf0iBIRFn8EzV1YcvdDVUQpLEIcVdz+eQOHjgvMnlDaXj7i77FLcMkNiv6+qlkGxjszlyINYpr7NQWs0lJLxzfbxlpyeLsfndcLwNIRd2AzcUrfins+iAyh/9WXtcdyCQ18qpXujG9CaG7jAPj7vnAt2S9P7BrObsIxdQECKA6wxffJirradIsd0ak2L/OdQlw/OQnnMIMoW6zjS4hwA1Td+iiT9dzSCizHhMAZrgtuVfRlcoyivdAL+6WCvcOBMeOvWVsLpGqWW8MhNJMOHgVXeW8zumV2ffm3hlTf/569IeNvx8sHqXXqn2/ifJwDWoXeeBw==
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
        id 5ED9B8A70D599DF2; Tue, 25 Aug 2020 09:38:10 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 10/18] configuration_files: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:35 +0100
Message-Id: <20200825083743.6508-11-richard_c_haines@btinternet.com>
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
 src/configuration_files.md | 74 ++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/src/configuration_files.md b/src/configuration_files.md
index 3515f1b..0d48d09 100644
--- a/src/configuration_files.md
+++ b/src/configuration_files.md
@@ -1,5 +1,9 @@
 # SELinux Configuration Files
 
+- [The Policy Store](#the-policy-store)
+  - [The priority Option](#the-priority-option)
+- [Converting policy packages to CIL](#converting-policy-packages-to-cil)
+
 This section explains each SELinux configuration file with its format,
 example content and where applicable, any supporting SELinux commands or
 **libselinux** library API functions.
@@ -10,34 +14,34 @@ adding the man page section (e.g. ***semanage.config**(5)*).
 This Notebook classifies the types of configuration file used in SELinux
 as follows:
 
-1.  [**Global Configuration files**](global_config_files.md#global-configuration-files) that
-    affect the active policy and their supporting SELinux-aware
-    applications, utilities or commands. This Notebook will only refer
-    to the commonly used configuration files.
-2.  [**Policy Store Configuration Files**](policy_store_config_files.md#policy-store-configuration-files)
-    that are managed by the **semanage**(8) and **semodule**(8) commands. These
-    are used to build the majority of the
-    [Policy Configuration Files](policy_config_files.md#policy-configuration-files)
-    and should NOT be edited as together they describe the overall 'policy' configuration.
-3.  [**Policy Configuration Files**](policy_config_files.md) used by an active
-    (run time) policy/system. Note that there can be multiple policy
-    configurations on a system (e.g. */etc/selinux/targeted* and
-    */etc/selinux/mls*), however only one can be the active policy.
-4.  [**SELinux Filesystem files - Table 6: SELinux filesystem Information**](lsm_selinux.md#selinux-filesystem) located under the */sys/fs/selinux*
-    directory and reflect the current configuration of SELinux for the active
-    policy. This area is used
-    extensively by the libselinux library for userspace object managers and
-    other SELinux-aware applications. These files and directories should not
-    be updated by users (the majority are read only anyway), however
-    they can be read to check various configuration parameters and
-    viewing the currently loaded policy using tools such as
-    ***apol**(1)* (e.g. *apol /sys/fs/selinux/policy*).
+1. [**Global Configuration files**](global_config_files.md#global-configuration-files) that
+   affect the active policy and their supporting SELinux-aware
+   applications, utilities or commands. This Notebook will only refer
+   to the commonly used configuration files.
+2. [**Policy Store Configuration Files**](policy_store_config_files.md#policy-store-configuration-files)
+   that are managed by the **semanage**(8) and **semodule**(8) commands. These
+   are used to build the majority of the
+   [Policy Configuration Files](policy_config_files.md#policy-configuration-files)
+   and should NOT be edited as together they describe the overall 'policy' configuration.
+3. [**Policy Configuration Files**](policy_config_files.md) used by an active
+   (run time) policy/system. Note that there can be multiple policy
+   configurations on a system (e.g. */etc/selinux/targeted* and
+   */etc/selinux/mls*), however only one can be the active policy.
+4. [**SELinux Filesystem files - Table 6: SELinux filesystem Information**](lsm_selinux.md#selinux-filesystem)
+   located under the */sys/fs/selinux* directory and reflect the current
+   configuration of SELinux for the active policy. This area is used
+   extensively by the libselinux library for userspace object managers and
+   other SELinux-aware applications. These files and directories should not
+   be updated by users (the majority are read only anyway), however
+   they can be read to check various configuration parameters and
+   viewing the currently loaded policy using tools such as
+   ***apol**(1)* (e.g. *apol /sys/fs/selinux/policy*).
 
 ## The Policy Store
 
 Version 2.7 of *libsemanage*, *libsepol*, and *policycoreutils* had the
-policy module store has moved from */etc/selinux/&lt;SELINUXTYPE&gt;/modules*
-to */var/lib/selinux/&lt;SELINUXTYPE&gt;*.
+policy module store has moved from */etc/selinux/\<SELINUXTYPE\>/modules*
+to */var/lib/selinux/\<SELINUXTYPE\>*.
 
 This new infrastructure now makes it possible to build policies containing a
 mixture of Reference Policy modules, kernel policy language modules and
@@ -83,12 +87,12 @@ int_gateway
 The ***semodule**(8)* command now has a number of new options, with the
 most significant being:
 
-1.  Setting module priorities (*-X | --priority*), this is discussed in
-    [The priority Option](#the-priority-option) section.
-2.  Listing modules (*--list-modules=full | standard*). The 'f*ull*'
-    option shows all the available modules with their priority and
-    policy format. The '*standard*' option will only show the highest
-    priority, enabled modules.
+1. Setting module priorities (*-X | \-\-priority*), this is discussed in
+   [The priority Option](#the-priority-option) section.
+2. Listing modules (*\-\-list-modules=full | standard*). The '*full*'
+   option shows all the available modules with their priority and
+   policy format. The '*standard*' option will only show the highest
+   priority, enabled modules.
 
 ### The priority Option
 
@@ -105,7 +109,7 @@ semodule --priority 400 --install custom/apache.pp
 
 Both apache modules are installed in the policy store as 'apache', but
 only the custom apache module is included in the final kernel binary.
-The distribution apache module is ignored. The *--list-modules* options
+The distribution apache module is ignored. The *\-\-list-modules* options
 can be used to show these:
 
 ```
@@ -137,15 +141,15 @@ new distribution policy.
 
 This does require that policy managers adopt some kind of scheme for who
 uses what priority. No strict guidelines currently exist, however the
-value used by the *semanage\_migrate\_store* script is *--priority 100*
+value used by the *semanage\_migrate\_store* script is *\-\-priority 100*
 as this is assumed to be migrating a distribution. If a value is not
-provided, *semodule* will use a default of *--priority 400* as it is
+provided, *semodule* will use a default of *\-\-priority 400* as it is
 assumed to be a locally customised policy.
 
 When *semodule* builds a lower priority module when a higher priority is
 already available, the following message will be given: "*A higher
-priority &lt;name&gt; module exists at priority &lt;999&gt; and will
-override the module currently being installed at priority &lt;111&gt;*".
+priority \<name\> module exists at priority \<999\> and will
+override the module currently being installed at priority \<111\>*".
 
 ## Converting policy packages to CIL
 
-- 
2.26.2

