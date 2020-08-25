Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA5C433EC
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2962071E
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="jXukjAO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHYIiZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:25 -0400
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:21299 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728986AbgHYIiT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:19 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200825083813.MPLC26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344693; 
        bh=JvwxzYr/Vo0koxLkoamrclXNqzAbBWzj4pO8Jtdp/0o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=jXukjAO10bNBjUHLU5uJ0WEUi/FOGg6xOMrDLjASpt4ZhU1qmWFtRZlhen8SM1gwlcNqnuuWJijA7R5H4U6QhBpSGlfpeBK82Ams5+hlxdy2q0yREZ0cHzdGQubU+XtgdrmoP6XHPJRcGYSZ8Rjz4YpGUgO7gMEHRgcdHOPhxFPdHCF48KYzcae3bM0VcxxOyrWprVmLrsZdgTonCL9pl3Np17xfXucRfq5b1srXxNWL7iBbUW/TkVk82GnpH/h1VD20VNXQToa1/fVGA1I6n0GVaMDWFdPwyKp97lOZRRpMdRAk47IV+zCpAUJTX7ovpIM6cNkQJ9f2oX2wEfgyyQ==
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
        id 5ED9B8A70D599E70; Tue, 25 Aug 2020 09:38:13 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 16/18] global_config_files: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:41 +0100
Message-Id: <20200825083743.6508-17-richard_c_haines@btinternet.com>
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
 src/global_config_files.md | 389 +++++++++++++++++++++----------------
 1 file changed, 220 insertions(+), 169 deletions(-)

diff --git a/src/global_config_files.md b/src/global_config_files.md
index 80e557b..7c8132d 100644
--- a/src/global_config_files.md
+++ b/src/global_config_files.md
@@ -1,13 +1,21 @@
 # Global Configuration Files
 
+- [*/etc/selinux/config*](#etcselinuxconfig)
+- [*/etc/selinux/semanage.conf*](#etcselinuxsemanage.conf)
+- [*/etc/selinux/restorecond.conf*](#etcselinuxrestorecond.conf)
+- [*restorecond-user.conf*](#restorecond-user.conf)
+- [*/etc/selinux/newrole_pam.conf*](#etcselinuxnewrole_pam.conf)
+- [*/etc/sestatus.conf*](#etcsestatus.conf)
+- [*/etc/security/sepermit.conf*](#etcsecuritysepermit.conf)
+
 Listed in the sections that follow are the common configuration files
 used by SELinux and are therefore not policy specific. The two most
 important files are:
 
--   */etc/selinux/config* - This defines the policy to be activated and
-    its enforcing mode.
--   */etc/selinux/semanage.conf* - This is used by the SELinux policy
-    configuration subsystem for modular or CIL policies.
+- */etc/selinux/config* - This defines the policy to be activated and
+  its enforcing mode.
+- */etc/selinux/semanage.conf* - This is used by the SELinux policy
+  configuration subsystem for modular or CIL policies.
 
 ## */etc/selinux/config*
 
@@ -26,44 +34,59 @@ AUTORELABEL=0|1
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>SELINUX</td>
-<td><p>This entry can contain one of three values:</p>
-<p><strong>enforcing</strong> - SELinux security policy is enforced.</p>
-<p><strong>permissive</strong> - SELinux logs warnings (see the <a href="auditing.md#auditing-selinux-events"><em><em>Auditing SELinux Events</em></em></a> section) instead of enforcing the policy (i.e. the action is allowed to proceed).</p>
-<p><strong>disabled</strong> - No SELinux policy is loaded.</p>
-<p>Note that this configures the global SELinux enforcement mode. It is still possible to have domains running in permissive mode and/or object managers running as disabled, permissive or enforcing, when the global mode is enforcing or permissive.</p></td>
-</tr>
-<tr>
-<td>SELINUXTYPE</td>
-<td><p>The <strong>policy_name</strong> is used as the directory name where the active policy and its configuration files will be located. The system will then use this information to locate and load the policy contained within this directory structure. </p>
-<p>The policy directory must be located at: </p>
-<p>/etc/selinux</p></td>
-</tr>
-<tr>
-<td>SETLOCALDEFS</td>
-<td><p><strong>Deprecated</strong> This optional field should be set to 0 (or the entry removed) as the policy store management infrastructure (<strong>semanage</strong>(8) / <strong>semodule</strong>(8)) is now used.</p>
-<p>If set to 1, then <strong>init</strong>(8) and <strong>load_policy</strong>(8) will read the local customisation for booleans and users.</p></td>
-</tr>
-<tr>
-<td>REQUIRESEUSERS</td>
-<td><p><strong>Deprecated</strong> This optional field can be used to fail a login if there is no matching or default entry in the <em><em><strong>seusers</strong></em></em> file or if the file is missing.</p>
-<p>It is checked by the <em>libselinux</em> function <strong>getseuserbyname</strong>(3) that is used by SELinux-aware login applications such as <em><strong>PAM</strong>(8)</em>.</p>
-<p>If it is set to 0 or the entry missing:</p>
-<p><strong>getseuserbyname</strong>(3) will return the GNU / Linux user name as the SELinux user. </p>
-<p>If it is set to 1:</p>
-<p><strong>getseuserbyname</strong>(3) will fail.</p></td>
-</tr>
-<tr>
-<td>AUTORELABEL</td>
-<td><p>This is an optional field. If set to '<em>0</em>' and there is a file called <em>.autorelabel</em> in the root directory, then on a reboot, the loader will drop to a shell where a root logon is required. An administrator can then manually relabel the file system.</p>
-<p>If set to '1' or the parameter name is not used (the default) there is no login for manual relabeling, however should the <em>/.autorelabel</em> file exist, then the file system will be automatically relabeled using <em>fixfiles -F restore</em>. </p>
-<p>In both cases the <em>/.autorelabe</em>l file will be removed so relabeling is not done again.</p></td>
-</tr>
-</tbody>
-</table>
+*SELINUX*
+
+This entry can contain one of three values:
+
+- *enforcing* - SELinux security policy is enforced.
+- *permissive* - SELinux logs warnings (see the
+  [**Auditing SELinux Events**](auditing.md#auditing-selinux-events) section)
+  instead of enforcing the policy (i.e. the action is allowed to proceed).
+- *disabled* - No SELinux policy is loaded. Note that this configures
+  the global SELinux enforcement mode. It is still possible to have domains
+  running in permissive mode and/or object managers running as disabled,
+  permissive or enforcing, when the global mode is enforcing or permissive.
+
+*SELINUXTYPE*
+
+The *policy_name* is used as the directory name where the active policy
+and its configuration files will be located. The system will then use this
+information to locate and load the policy contained within this directory
+structure. The policy directory must be located at: */etc/selinux*
+
+*SETLOCALDEFS*
+
+**Deprecated** - This optional field should be set to 0 (or the entry removed)
+as the policy store management infrastructure (***semanage**(8)* /
+***semodule**(8)*) is now used. If set to 1, then ***init**(8)* and
+***load_policy**(8)* will read the local customisation for booleans and users.
+
+*REQUIRESEUSERS*
+
+**Deprecated** - This optional field can be used to fail a login if there is
+no matching or default entry in the *seusers* file or if the file is missing.
+It is checked by the *libselinux* function ***getseuserbyname**(3)* that is
+used by SELinux-aware login applications such as ***PAM**(8)*.
+If it is set to 0 or the entry missing:
+
+- ***getseuserbyname**(3)* will return the GNU / Linux user name as the
+  SELinux user.
+
+If it is set to 1:
+
+- ***getseuserbyname**(3)* will fail.
+
+*AUTORELABEL*
+
+This is an optional field. If set to \'*0*\' and there is a file called
+*.autorelabel* in the root directory, then on a reboot, the loader will drop
+to a shell where a root logon is required. An administrator can then manually
+relabel the file system.
+If set to '1' or the parameter name is not used (the default) there is no
+login for manual relabeling, however should the */.autorelabel* file exist,
+then the file system will be automatically relabeled using *fixfiles -F restore*.
+In both cases the */.autorelabe*l file will be removed so relabeling is not
+done again.
 
 **Example */etc/selinux/config* file contents are:**
 
@@ -139,124 +162,152 @@ args = <arguments>
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>module-store</td>
-<td><p>The method can be one of four options:</p>
-<p>directlibsemanage will write directly to a module store. This is the default value.</p>
-<p>sourcelibsemanage manipulates a source SELinux policy.</p>
-<p>/foo/bar Write via a policy management server, whose named socket is at /foo/bar. The path must begin with a '/'.</p>
-<p>foo.com:4242 Establish a TCP connection to a remote policy management server at foo.com. If there is a colon then the remainder is interpreted as a port number; otherwise default to port 4242.</p></td>
-</tr>
-<tr>
-<td>policy-version</td>
-<td>This optional entry can contain a policy version number, however it is normally commented out as it then defaults to that supported by the system. </td>
-</tr>
-<tr>
-<td>expand-check</td>
-<td><p>This optional entry controls whether hierarchy checking on module expansion is enabled (1) or disabled (0). The default is 0.</p>
-<p>It is also required to detect the presence of policy rules that are to be excluded with <em>neverallow</em> rules.</p></td>
-</tr>
-<tr>
-<td>file-mode</td>
-<td>This optional entry allows the file permissions to be set on runtime policy files. The format is the same as the mode parameter of the chmod command and defaults to 0644 if not present.</td>
-</tr>
-<tr>
-<td>save-previous</td>
-<td>This optional entry controls whether the previous module directory is saved (TRUE) after a successful commit to the policy store. The default is to delete the previous version (FALSE).</td>
-</tr>
-<tr>
-<td>save-linked</td>
-<td><p>This optional entry controls whether the previously linked module is saved (TRUE) after a successful commit to the policy store. Note that this option will create a <em>base.linked</em> file in the module policy store.</p>
-<p>The default is to delete the previous module (FALSE). </p></td>
-</tr>
-<tr>
-<td>disable-genhomedircon</td>
-<td>This optional entry controls whether the embedded genhomedircon function is run when using the <strong>semanage</strong>(8) command. The default is FALSE.</td>
-</tr>
-<tr>
-<td>handle-unknown</td>
-<td><p>This optional entry controls the kernel behaviour for handling permissions defined in the kernel but missing from the policy. </p>
-<p>The options are: allow the permission, reject by not loading the policy or deny the permission. The default is deny.</p>
-<p>Note: to activate any change, the base policy needs to be rebuilt with the <code>semodule -B</code> command.</p></td>
-</tr>
-<tr>
-<td>bzip-blocksize</td>
-<td>This optional entry determines whether the modules are compressed or not with bzip. If the entry is <em>0</em>, then no compression will be used (this is required with tools such as <em>sechecker</em> and <em>apol</em>). This can also be set to a value between <em>1</em> and <em>9</em> that will set the block size used for compression (<em>bzip</em> will multiply this by 100,000, so '<em>9</em>' is faster but uses more memory).</td>
-</tr>
-<tr>
-<td>bzip-small</td>
-<td>When this optional entry is set to <em>TRUE</em> the memory usage is reduced for compression and decompression (the <em>bzip</em> <em>-s</em> or <em>--small</em> option). If <em>FALSE</em> or no entry present, then does not try to reduce memory requirements.</td>
-</tr>
-<tr>
-<td>usepasswd</td>
-<td><p>When this optional entry is set to <em>TRUE</em> <em>semanage</em> will scan all password records for home directories and set up their labels correctly.</p>
-<p>If set to <em>FALSE</em> (the default if no entry present), then only the <em>/home</em> directory will be automatically re-labeled. </p></td>
-</tr>
-<tr>
-<td>ignoredirs</td>
-<td>With a list of directories to ignore (separated by '<em>;</em>') when setting up users home directories. This is used by some distributions to stop labeling <em>/root</em> as a home directory.</td>
-</tr>
-<tr>
-<td>store-root</td>
-<td>Specify an alternative policy store path . The default is "<em>/var/lib/selinux</em>".</td>
-</tr>
-<tr>
-<td>compiler-directory</td>
-<td>Specify an alternate directory that will hold the High Level Language (HLL) to CIL compilers. The default is "<em>/usr/libexec/selinux/hll</em>".</td>
-</tr>
-<tr>
-<td>remove-hll</td>
-<td>When set <em>TRUE</em>, HLL files will be removed after compilation into CIL (Read <em><strong>semanage.conf</strong>(5)</em> for the consequences of removing these files). Default is <em>FALSE</em>. </td>
-</tr>
-<tr>
-<td>ignore-module-cache</td>
-<td>Whether or not to ignore the cache of CIL modules compiled from HLL. The default is <em>false</em>.</td>
-</tr>
-<tr>
-<td>target-platform</td>
-<td>Target platform for generated policy. Default is "<em>selinux</em>", the alternate is "<em>xen</em>".</td>
-</tr>
-<tr>
-<td><p>[verify kernel]</p>
-<p>..</p>
-<p>[end]</p></td>
-<td><p>Start an additional set of entries that can be used to validate the kernel policy with an external application during the build process. There may be multiple <em>[verify kernel]</em> entries.</p>
-<p>The validation process takes place before the policy is allowed to be inserted into the store with a worked example shown in <a href="policy_validation_example.md#appendix-e---policy-validation-example">Policy Validation Example</a></p></td>
-</tr>
-<tr>
-<td><p>[verify module]</p>
-<p>..</p>
-<p>[end]</p></td>
-<td>Start an additional set of entries that can be used to validate each module by an external application during the build process. There may be multiple <em>[verify module]</em> entries.</td>
-</tr>
-<tr>
-<td><p>[verify linked]</p>
-<p>..</p>
-<p>[end]</p></td>
-<td>Start an additional set of entries that can be used to validate module linking by an external application during the build process. There may be multiple <em>[verify linked]</em> entries.</td>
-</tr>
-<tr>
-<td><p>[load_policy]</p>
-<p>..</p>
-<p>[end]</p></td>
-<td>Replace the default load policy application with this new policy loader. Defaults are either: <em>/sbin/load_policy</em> or <em>/usr/sbin/load_policy</em>.</td>
-</tr>
-<tr>
-<td><p>[setfiles]</p>
-<p>..</p>
-<p>[end]</p></td>
-<td>Replace the default <em><strong>setfiles</strong>(8)</em> application with this new <em>setfiles</em>. Defaults are either: <em>/sbin/setfiles</em> or <em>/usr/sbin/setfiles</em>.</td>
-</tr>
-<tr>
-<td><p>[sefcontexts_compile]</p>
-<p>..</p>
-<p>[end]</p></td>
-<td>Replace the default file context build application with this new builder. Defaults are either: <em>/sbin/</em>sefcontexts_compile or <em>/usr/sbin/</em>sefcontexts_compile.</td>
-</tr>
-</tbody>
-</table>
+*module-store*
+
+The method can be one of four options:
+
+1. *directlibsemanage* will write directly to a module store.
+   This is the default value.
+2. *sourcelibsemanage* manipulates a source SELinux policy.
+3. */foo/bar* - Write via a policy management server, whose named socket is
+   at /foo/bar. The path must begin with a '/'.
+4. *foo.com:4242* -  Establish a TCP connection to a remote policy management
+   server at *foo.com*. If there is a colon then the remainder is interpreted
+   as a port number; otherwise default to port 4242.
+
+*policy-version*
+
+This optional entry can contain a policy version number, however it is normally
+commented out as it then defaults to that supported by the system.
+
+*expand-check*
+
+This optional entry controls whether hierarchy checking on module expansion
+is enabled (1) or disabled (0). The default is 0. It is also required to detect
+the presence of policy rules that are to be excluded with *neverallow* rules.
+
+*file-mode*
+
+This optional entry allows the file permissions to be set on runtime policy
+files. The format is the same as the mode parameter of the ***chmod**(1)*
+command and defaults to 0644 if not present.
+
+*save-previous*
+
+This optional entry controls whether the previous module directory is saved
+(TRUE) after a successful commit to the policy store. The default is to delete
+the previous version (FALSE).
+
+*save-linked*
+
+This optional entry controls whether the previously linked module is saved
+(TRUE) after a successful commit to the policy store. Note that this option
+will create a *base.linked* file in the module policy store.
+The default is to delete the previous module (FALSE).
+
+*disable-genhomedircon*
+
+This optional entry controls whether the embedded *genhomedircon* function is
+run when using the ***semanage**(8)* command. The default is FALSE.
+
+*handle-unknown*
+
+This optional entry controls the kernel behaviour for handling permissions
+defined in the kernel but missing from the policy.
+The options are: *allow* the permission, *reject* by not loading the policy
+or *deny* the permission. The default is *deny*.
+Note: to activate any change, the base policy needs to be rebuilt with the
+*semodule -B* command.
+
+*bzip-blocksize*
+
+This optional entry determines whether the modules are compressed or not
+with *bzip*. If the entry is *0*, then no compression will be used (this is
+required with tools such as ***apol**(1)*. This can also be set to a value
+between *1* and *9* that will set the block size used for compression
+(*bzip* will multiply this by 100,000, so '*9*' is faster but uses more memory).
+
+*bzip-small*
+
+When this optional entry is set to *TRUE* the memory usage is reduced for
+compression and decompression (the *bzip* *-s* or *\-\-small* option). If *FALSE*
+or no entry present, then does not try to reduce memory requirements.
+
+*usepasswd*
+
+When this optional entry is set to *TRUE* *semanage* will scan all password
+records for home directories and set up their labels correctly.
+If set to *FALSE* (the default if no entry present), then only the
+*/home* directory will be automatically re-labeled.
+
+*ignoredirs*
+
+With a list of directories to ignore (separated by '*;*') when setting up users
+home directories. This is used by some distributions to stop labeling */root*
+as a home directory.
+
+*store-root*
+
+Specify an alternative policy store path. The default is */var/lib/selinux*.
+
+*compiler-directory*
+
+Specify an alternate directory that will hold the High Level Language (HLL)
+to CIL compilers. The default is */usr/libexec/selinux/hll*.
+
+*remove-hll*
+
+When set *TRUE*, HLL files will be removed after compilation into CIL
+(Read ***semanage.conf**(5)* for the consequences of removing these files).
+Default is *FALSE*.
+
+*ignore-module-cache*
+
+Whether or not to ignore the cache of CIL modules compiled from HLL.
+The default is *false*.
+
+*target-platform*
+
+Target platform for generated policy. Default is *selinux*, the alternate
+is *xen*.
+
+*\[verify kernel\] .. \[end\]*
+
+Start an additional set of entries that can be used to validate the kernel
+policy with an external application during the build process. There may be
+multiple *\[verify kernel\]* entries.
+The validation process takes place before the policy is allowed to be inserted
+into the store with a worked example shown in
+[**Policy Validation Example**](policy_validation_example.md#appendix-e---policy-validation-example)
+
+
+*\[verify module\] .. \[end\]*
+
+Start an additional set of entries that can be used to validate each module
+by an external application during the build process. There may be multiple
+*\[verify module\]* entries.
+
+*\[verify linked\] .. \[end\]*
+
+Start an additional set of entries that can be used to validate module linking
+by an external application during the build process. There may be multiple
+*\[verify linked\]* entries.
+
+*\[load_policy\] .. \[end\]*
+
+Replace the default load policy application with this new policy loader.
+Defaults are either: */sbin/load_policy* or */usr/sbin/load_policy*.
+
+*\[setfiles\] .. \[end\]*
+
+Replace the default ***setfiles**(8)* application with this new *setfiles*.
+Defaults are either: */sbin/setfiles* or */usr/sbin/setfiles*.
+
+*\[sefcontexts_compile\] .. \[end\]*
+
+Replace the default file context build application with this new builder.
+Defaults are either: */sbin/sefcontexts_compile* or
+*/usr/sbin/sefcontexts_compile*
 
 **Example *semanage.config* file contents are:**
 
@@ -279,19 +330,19 @@ by applications with an incorrect security context. The
 ***restorecond**(8)* daemon will then watch for their creation and
 automatically correct their security context to that specified by the
 active policy file context configuration files (located in the
-*/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/files* directory).
+*/etc/selinux/\<SELINUXTYPE\>/contexts/files* directory).
 
 Each line of the file contains the full path of a file or directory.
-Entries that start with a tilde (~) will be expanded to watch for files
-in users home directories (e.g. *~/public\_html* would cause the daemon to
-listen for changes to *public\_html* in all logged on users home
+Entries that start with a tilde \'\~\' will be expanded to watch for files
+in users home directories (e.g. *\~/public_html* would cause the daemon to
+listen for changes to *public_html* in all logged on users home
 directories).
 
-1.  It is possible to run *restorecond* in a user session using
-    the *-u* option (see ***restorecond**(8)*). This requires a
-    *restorecond-user.conf* file to be installed as shown in the examples below.
-2.  The files names and location can be changed if *restorecond* is run
-    with the *-f* option.
+1. It is possible to run *restorecond* in a user session using
+   the *-u* option (see ***restorecond**(8)*). This requires a
+   *restorecond-user.conf* file to be installed as shown in the examples below.
+2. The files names and location can be changed if *restorecond* is run
+   with the *-f* option.
 
 **Example *restorecond.conf* file contents are:**
 
-- 
2.26.2

