Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDB0C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 08:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7116F2078B
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 08:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="rgfEb/pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgIJIsT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:48:19 -0400
Received: from mailomta6-re.btinternet.com ([213.120.69.99]:21506 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729135AbgIJIsP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 04:48:15 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200909133046.DGWR4701.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658246; 
        bh=MWcY4gFODAUErfsa+raLTiCW1t8Xt0IYYYt+upT/xwY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=rgfEb/pr5Ti1MHT4e7TGBEOWrvMmKpBO/YrJVczPG49CbxF2jDNz+vXFxDuZi//cRrw5VsKeH1Fhm0qURRzPwiMYyjwk0pGjFK8slGcxNGI5olM57aVSVGm7l+G1HUkWD7CNfLkviNUs55T7hR6klnyf2S95WlJxwZQFpnVKVin0n2myuRGAB+h+mTMZZ/M8Xq9AKy/IQujTA5dQ2mjpkJkBZqyTJwZ4nVihZhhIGUUr6h1FYvo2lHXnAeTA/z+iEu+wT4q+vFxLPqJ2+kwzParndhnP+8+/El+54kyU92wSKoQLvv/UEnnfj4Ytg3CFFUGr3VydwLgTOdrXU9xsOg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeujeduvdejkeevtddtgfejiedtvefggfekgeehudetjeefffekteelgeefkeevieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeekiedrudehgedrudehgedrudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirdduheegrdduheegrddufeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdr
        khgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134DDB; Wed, 9 Sep 2020 14:30:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 08/22] selinux_cmds: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:25 +0100
Message-Id: <20200909133039.44498-9-richard_c_haines@btinternet.com>
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
 src/selinux_cmds.md | 256 +++++++++++++++++++-------------------------
 1 file changed, 112 insertions(+), 144 deletions(-)

diff --git a/src/selinux_cmds.md b/src/selinux_cmds.md
index 918d4c1..1b68771 100644
--- a/src/selinux_cmds.md
+++ b/src/selinux_cmds.md
@@ -7,150 +7,118 @@ has a page that details all the available tools and commands at:
 
 <https://github.com/SELinuxProject/selinux/wiki/Tools>
 
-<table>
-<tbody>
-<tr style="background-color:#F2F2F2;">
-<td><strong>Command</strong></td>
-<td><strong>Man Page</strong></td>
-<td><strong>Purpose</strong></td>
-</tr>
-<tr>
-<td>audit2allow</td>
-<td>1</td>
-<td>Generates policy allow rules from the audit.log file.</td>
-</tr>
-<tr>
-<td>audit2why</td>
-<td>8</td>
-<td>Describes audit.log messages and why access was denied.</td>
-</tr>
-<tr>
-<td>avcstat</td>
-<td>8</td>
-<td>Displays the AVC statistics.</td>
-</tr>
-<tr>
-<td>chcat</td>
-<td>8</td>
-<td>Change or remove a catergory from a file or user. </td>
-</tr>
-<tr>
-<td>chcon</td>
-<td>1</td>
-<td>Changes the security context of a file.</td>
-</tr>
-<tr>
-<td>checkmodule</td>
-<td>8</td>
-<td>Compiles base and loadable modules from source.</td>
-</tr>
-<tr>
-<td>checkpolicy</td>
-<td>8</td>
-<td>Compiles a monolithic policy from source.</td>
-</tr>
-<tr>
-<td>fixfiles</td>
-<td>8</td>
-<td>Update / correct the security context of for filesystems that use extended attributes.</td>
-</tr>
-<tr>
-<td>genhomedircon</td>
-<td>8</td>
-<td>Generates file configuration entries for users home directories. This command has also been built into <em><strong>semanage</strong>(8)</em>, therefore when using the policy store / loadable modules this does not need to be used.</td>
-</tr>
-<tr>
-<td>getenforce</td>
-<td>1</td>
-<td>Shows the current enforcement state.</td>
-</tr>
-<tr>
-<td>getsebool</td>
-<td>8</td>
-<td>Shows the state of the booleans.</td>
-</tr>
-<tr>
-<td>load_policy</td>
-<td>8</td>
-<td>Loads a new policy into the kernel. Not required when using <em><strong>semanage</strong>(8)</em> / <em><strong>semodule</strong>(8)</em> commands.</td>
-</tr>
-<tr>
-<td>matchpathcon</td>
-<td>8</td>
-<td>Show a files path and security context.</td>
-</tr>
-<tr>
-<td>newrole</td>
-<td>1</td>
-<td>Allows users to change roles - runs a new shell with the new security context.</td>
-</tr>
-<tr>
-<td>restorecon</td>
-<td>8</td>
-<td>Sets the security context on one or more files.</td>
-</tr>
-<tr>
-<td>run_init</td>
-<td>8</td>
-<td>Runs an <em>init</em> script under the correct context.</td>
-</tr>
-<tr>
-<td>runcon</td>
-<td>1</td>
-<td>Runs a command with the specified context.</td>
-</tr>
-<tr>
-<td>selinuxenabled </td>
-<td>1</td>
-<td>Shows whether SELinux is enabled or not.</td>
-</tr>
-<tr>
-<td>semanage</td>
-<td>8</td>
-<td>Used to configure various areas of a policy within a policy store.</td>
-</tr>
-<tr>
-<td>semodule</td>
-<td>8</td>
-<td>Used to manage the installation, upgrading etc. of policy modules.</td>
-</tr>
-<tr>
-<td>semodule_expand</td>
-<td>8</td>
-<td>Manually expand a base policy package into a kernel binary policy file.</td>
-</tr>
-<tr>
-<td>semodule_link </td>
-<td>8</td>
-<td>Manually link a set of module packages.</td>
-</tr>
-<tr>
-<td>semodule_package</td>
-<td>8</td>
-<td>Create a module package with various configuration files (file context etc.)</td>
-</tr>
-<tr>
-<td>sestatus</td>
-<td>8</td>
-<td>Show the current status of SELinux and the loaded policy.</td>
-</tr>
-<tr>
-<td>setenforce</td>
-<td>1</td>
-<td>Sets / unsets enforcement mode.</td>
-</tr>
-<tr>
-<td>setfiles</td>
-<td>8</td>
-<td>Initialise the extended attributes of filesystems.</td>
-</tr>
-<tr>
-<td>setsebool</td>
-<td>8</td>
-<td>Sets the state of a boolean to on or off persistently across reboots or for this session only. </td>
-</tr>
-</tbody>
-</table>
+***audit2allow**(1)*
+
+Generates policy allow rules from an audit log file.
+
+***audit2why**(8)*
+
+Describes audit log messages and why access was denied.
+
+***avcstat**(8)*
+
+Displays the AVC statistics.
+
+***chcat**(8)*
+
+Change or remove a catergory from a file or user.
+
+***chcon**(1)*
+
+Changes the security context of a file.
+
+***checkmodule**(8)*
+
+Compiles base and loadable modules from source.
+
+***checkpolicy**(8)*
+
+Compiles a monolithic policy from source.
+
+***fixfiles**(8)*
+
+Update / correct the security context of for filesystems that use extended
+attributes.
+
+***genhomedircon**(8)*
+
+Generates file configuration entries for users home directories.
+This command has also been built into ***semanage**(8)*, therefore when using
+the policy store / loadable modules this does not need to be used.
+
+***getenforce**(1)*
+
+Shows the current enforcement state.
+
+***getsebool**(8)*
+
+Shows the state of the booleans.
+
+***load_policy**(8)*
+
+Loads a new policy into the kernel. Not required when using ***semanage**(8)* /
+***semodule**(8)* commands.
+
+***matchpathcon**(8)*
+
+Show a files path and security context.
+
+***newrole**(1)*
+
+Allows users to change roles - runs a new shell with the new security context.
+
+***restorecon**(8)*
+
+Sets the security context on one or more files.
+
+***run_init**(8)*
+
+Runs an *init* script under the correct context.
+
+***runcon**(1)*
+
+Runs a command with the specified context.
+
+***selinuxenabled**(1)*
+
+Shows whether SELinux is enabled or not.
+
+***semanage**(8)*
+
+Used to configure various areas of a policy within a policy store.
+
+***semodule**(8)*
+
+Used to manage the installation, upgrading etc. of policy modules.
+
+***semodule_expand**(8)*
+
+Manually expand a base policy package into a kernel binary policy file.
+
+***semodule_link**(8)*
+
+Manually link a set of module packages.
+
+***semodule_package**(8)*
+
+Create a module package with various configuration files (file context etc.)
+
+***sestatus**(8)*
+
+Show the current status of SELinux and the loaded policy.
+
+***setenforce**(1)*
+
+Sets / unsets enforcement mode.
+
+***setfiles**(8)*
+
+Initialise the extended attributes of filesystems.
+
+***setsebool**(8)*
+
+Sets the state of a boolean to on or off persistently across reboots or for
+this session only.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

