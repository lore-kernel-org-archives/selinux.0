Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096D3C2D0E3
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 04:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A44221E7
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 04:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="nTdlCGvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgIKEUU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:20:20 -0400
Received: from mailomta10-re.btinternet.com ([213.120.69.103]:47789 "EHLO
        re-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725283AbgIKEUO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 00:20:14 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20200909133044.EKJE29506.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658244; 
        bh=/c8dSZRaLWZ0f3YXhNykkte2gzQZ5rl20pV20UhPUlQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=nTdlCGvTyEk1AXIJ8xMH/VZ/jFCtIHWjgBQwVeIDb37VnXq5vXv80nlsROALkCS+tIdi/msOTyMTHfpUiQwrKbjBThJegkuZ4OH03ZU5jqRXENsOtO1PIgz9wZ/tNgvckh0PC/bSJOxEa6pDTk0AUFVpk/CzJ9sjpJ2ar96xMY0gQxup1hbEHAhGN0dI2TucJ21em2N682jLRV1wkMygfA66WIU55FIGo1jifSRCD3dXAQ1JWwJcSBlQw1d/RCrkXu1FmCwQyKiyKecP+1gyNqtwLTBnnZDQi5VenWKfP8pxt0gNcVYt+CSZl+wITX9mKWV6lDFF2ik7iH/M6BBr3w==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134DAB; Wed, 9 Sep 2020 14:30:44 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 04/22] policy_config_files: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:21 +0100
Message-Id: <20200909133039.44498-5-richard_c_haines@btinternet.com>
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
 src/policy_config_files.md | 442 ++++++++++++++++++-------------------
 1 file changed, 220 insertions(+), 222 deletions(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index e7fab1e..9ad9b42 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -1,36 +1,36 @@
 # Policy Configuration Files
 
--   [setrans.conf](#setrans.conf)
--   [*secolor.conf*](#secolor.conf)
--   [*policy/policy.\<ver\>*](#policypolicy.ver)
--   [*contexts/customizable_types*](#contextscustomizable_types)
--   [*contexts/default_contexts*](#contextsdefault_contexts)
--   [*contexts/dbus_contexts*](#contextsdbus_contexts)
--   [*contexts/default_type*](#contextsdefault_type)
--   [*contexts/failsafe_context*](#contextsfailsafe_context)
--   [*contexts/initrc_context*](#contextsinitrc_context)
--   [*contexts/lxc_contexts*](#contextslxc_contexts)
--   [*contexts/netfilter_contexts* - Obsolete](#contextsnetfilter_contexts---obsolete)
--   [*contexts/openrc_contexts*](#contextsopenrc_contexts)
--   [*contexts/openssh_contexts*](#contextsopenssh_contexts)
--   [*contexts/removable_context*](#contextsremovable_context)
--   [*contexts/sepgsql_contexts*](#contextssepgsql_contexts)
--   [*contexts/snapperd_contexts*](#contextssnapperd_contexts)
--   [*contexts/securetty_types*](#contextssecuretty_types)
--   [*contexts/systemd_contexts*](#contextssystemd_contexts)
--   [*contexts/userhelper_context*](#contextsuserhelper_context)
--   [*contexts/virtual_domain_context*](#contextsvirtual_domain_context)
--   [*contexts/virtual_image_context*](#contextsvirtual_image_context)
--   [*contexts/x_contexts*](#contextsx_contexts)
--   [*contexts/files/file_contexts*](#contextsfilesfile_contexts)
--   [*contexts/files/file_contexts.local*](#contextsfilesfile_contexts.local)
--   [*contexts/files/file_contexts.homedirs*](#contextsfilesfile_contexts.homedirs)
--   [*contexts/files/file_contexts.subs*](#contextsfilesfile_contexts.subs)
--   [*contexts/files/file_contexts.subs_dist*](#contextsfilesfile_contexts.subs_dist)
--   [*contexts/files/media*](#contextsfilesmedia)
--   [*contexts/users/[seuser_id]*](#contextsusersseuser_id)
--   [*logins/\<linuxuser_id\>*](#loginslinuxuser_id)
--   [*users/local.users*](#userslocal.users)
+- [setrans.conf](#setrans.conf)
+- [*secolor.conf*](#secolor.conf)
+- [*policy/policy.\<ver\>*](#policypolicy.ver)
+- [*contexts/customizable_types*](#contextscustomizable_types)
+- [*contexts/default_contexts*](#contextsdefault_contexts)
+- [*contexts/dbus_contexts*](#contextsdbus_contexts)
+- [*contexts/default_type*](#contextsdefault_type)
+- [*contexts/failsafe_context*](#contextsfailsafe_context)
+- [*contexts/initrc_context*](#contextsinitrc_context)
+- [*contexts/lxc_contexts*](#contextslxc_contexts)
+- [*contexts/netfilter_contexts* - Obsolete](#contextsnetfilter_contexts---obsolete)
+- [*contexts/openrc_contexts*](#contextsopenrc_contexts)
+- [*contexts/openssh_contexts*](#contextsopenssh_contexts)
+- [*contexts/removable_context*](#contextsremovable_context)
+- [*contexts/sepgsql_contexts*](#contextssepgsql_contexts)
+- [*contexts/snapperd_contexts*](#contextssnapperd_contexts)
+- [*contexts/securetty_types*](#contextssecuretty_types)
+- [*contexts/systemd_contexts*](#contextssystemd_contexts)
+- [*contexts/userhelper_context*](#contextsuserhelper_context)
+- [*contexts/virtual_domain_context*](#contextsvirtual_domain_context)
+- [*contexts/virtual_image_context*](#contextsvirtual_image_context)
+- [*contexts/x_contexts*](#contextsx_contexts)
+- [*contexts/files/file_contexts*](#contextsfilesfile_contexts)
+- [*contexts/files/file_contexts.local*](#contextsfilesfile_contexts.local)
+- [*contexts/files/file_contexts.homedirs*](#contextsfilesfile_contexts.homedirs)
+- [*contexts/files/file_contexts.subs*](#contextsfilesfile_contexts.subs)
+- [*contexts/files/file_contexts.subs_dist*](#contextsfilesfile_contexts.subs_dist)
+- [*contexts/files/media*](#contextsfilesmedia)
+- [*contexts/users/[seuser_id]*](#contextsusersseuser_id)
+- [*logins/\<linuxuser_id\>*](#loginslinuxuser_id)
+- [*users/local.users*](#userslocal.users)
 
 Each file discussed in this section is relative to the policy name as
 follows:
@@ -52,16 +52,16 @@ For example the simple
 described in the Notebook examples could run at init 3 (i.e. no X-Windows)
 and only require the following configuration files:
 
--   *seusers* - For login programs.
--   *policy/policy.\<ver\>* - The binary policy loaded into the kernel.
--   *context/files/file_contexts* - To allow the filesystem to be relabeled.
+- *seusers* - For login programs.
+- *policy/policy.\<ver\>* - The binary policy loaded into the kernel.
+- *context/files/file_contexts* - To allow the filesystem to be relabeled.
 
 If the simple policy is to run at init 5, (i.e. with X-Windows) then an
 additional two files are required:
 
--   *context/dbus_contexts* - To allow the dbus messaging service to run under
-    SELinux.
--   *context/x_contexts* - To allow the X-Windows service to run under SELinux.
+- *context/dbus_contexts* - To allow the dbus messaging service to run under
+  SELinux.
+- *context/x_contexts* - To allow the X-Windows service to run under SELinux.
 
 ## *seusers*
 
@@ -70,19 +70,16 @@ The ***seusers**(5)* file is used by login programs (normally via the
 *user* / *passwd* files) to SELinux users (defined in the policy). A
 typical login sequence would be:
 
--   Using the GNU / Linux *user_id*, lookup the *seuser_id* from this
-    file. If an entry cannot be found, then use the *__default__*
-    entry.
--   To determine the remaining context to be used as the security
-    context, read the
-    [*contexts/users/[seuser_id]*](#contextsusersseuser_id)
-    file. If this file is not present, then:
--   Check for a default context in the
-    [*contexts/default_contexts*](#contextsdefault_contexts)
-    file. If no default context is found, then:
--   Read the
-    [*contexts/failsafe_context*](#contextsfailsafe_context) file
-    to allow a fail safe context to be set.
+- Using the GNU / Linux *user_id*, lookup the *seuser_id* from this
+  file. If an entry cannot be found, then use the *\_\_default\_\_* entry.
+- To determine the remaining context to be used as the security
+  context, read the [*contexts/users/[seuser_id]*](#contextsusersseuser_id)
+  file. If this file is not present, then:
+- Check for a default context in the
+  [*contexts/default_contexts*](#contextsdefault_contexts) file. If no default
+  context is found, then:
+- Read the [*contexts/failsafe_context*](#contextsfailsafe_context) file
+  to allow a fail safe context to be set.
 
 Note: The *system_u* user is defined in this file, however there must be
 **no** *system_u* Linux user configured on the system.
@@ -104,8 +101,8 @@ __default__:user_u:s0-s0
 
 **Supporting libselinux API functions are:**
 
--   ***getseuser**(3)*
--   ***getseuserbyname**(3)*
+- ***getseuser**(3)*
+- ***getseuserbyname**(3)*
 
 ## *booleans*
 ## *booleans.local*
@@ -120,10 +117,10 @@ file section.
 
 For systems that do use these files:
 
--   ***security_set_boolean_list**(3)* - Writes a *boolean.local* file if
-    flag *permanent* = '*1*'.
--   ***security_load_booleans**(3)* - Will look for a *booleans* or
-    *booleans.local* file here unless a specific path is specified.
+- ***security_set_boolean_list**(3)* - Writes a *boolean.local* file if
+  flag *permanent* = '*1*'.
+- ***security_load_booleans**(3)* - Will look for a *booleans* or
+  *booleans.local* file here unless a specific path is specified.
 
 Both files have the same format and contain one or more boolean names.
 
@@ -137,12 +134,12 @@ boolean_name value
 
 *boolean_name*
 
--   The name of the boolean.
+- The name of the boolean.
 
 *value*
 
--   The default setting for the boolean that can be one of the following:
-    -  *true* | *false* | *1* | *0*
+- The default setting for the boolean that can be one of the following:
+  -  *true* | *false* | *1* | *0*
 
 Note that if *SETLOCALDEFS* is set in the SELinux
 [*/etc/selinux/config*](global_config_files.md#etcselinuxconfig) file, then
@@ -172,11 +169,11 @@ policy_bool_name new_name
 
 *policy_bool_name*
 
--   The policy boolean name.
+- The policy boolean name.
 
 *new_name*
 
--   The new boolean name.
+- The new boolean name.
 
 **Example:**
 
@@ -195,10 +192,10 @@ the name will be looked up and if using the *new_name*, then the
 
 Supporting libselinux API functions are:
 
--   ***selinux_booleans_subs_path**(3)*
--   ***selinux_booleans_sub**(3)*
--   ***security_get_boolean_names**(3)*
--   ***security_set_boolean**(3)*
+- ***selinux_booleans_subs_path**(3)*
+- ***selinux_booleans_sub**(3)*
+- ***security_get_boolean_names**(3)*
+- ***security_set_boolean**(3)*
 
 ## *setrans.conf*
 
@@ -254,9 +251,10 @@ Include=/etc/selinux/mls/setrans.d/constraints.conf
 ```
 
 Supporting libselinux API functions are:
--   ***selinux_translations_path**(3)*
--   ***selinux_raw_to_trans_context**(3)*
--   ***selinux_trans_to_raw_context**(3)*
+
+- ***selinux_translations_path**(3)*
+- ***selinux_raw_to_trans_context**(3)*
+- ***selinux_trans_to_raw_context**(3)*
 
 ## *secolor.conf*
 
@@ -278,39 +276,39 @@ context_component string fg_color_name bg_color_name
 
 *color*
 
--   The color keyword.
+- The color keyword.
 
 *color_name*
 
--   A descriptive name for the colour (e.g. *red*).
+- A descriptive name for the colour (e.g. *red*).
 
 *color_mask*
 
--   A colour mask starting with a hash '*#*' that describes the RGB colours
-    with black being *#000000* and white being *#ffffff*.
+- A colour mask starting with a hash '*#*' that describes the RGB colours
+  with black being *#000000* and white being *#ffffff*.
 
 *context_component*
 
--   The colour translation supports different colours on the context string
-    components (*user*, *role*, *type* and *range*). Each component is on a
-    separate line.
+- The colour translation supports different colours on the context string
+  components (*user*, *role*, *type* and *range*). Each component is on a
+  separate line.
 
 *string*
 
--   This is the *context_component* string that will be matched with the
-    *raw* context component passed by ***selinux_raw_context_to_color**(3)*.
-    A wildcard '*\**' may be used to match any undefined *string* for the
-    *user*, *role* and *type* *context_component* entries only.
+- This is the *context_component* string that will be matched with the
+  *raw* context component passed by ***selinux_raw_context_to_color**(3)*.
+  A wildcard '*\**' may be used to match any undefined *string* for the
+  *user*, *role* and *type* *context_component* entries only.
 
 *fg_color_name*
 
--   The *color_name* string that will be used as the foreground colour.
-    A *color_mask* may also be used.
+- The *color_name* string that will be used as the foreground colour.
+  A *color_mask* may also be used.
 
 *bg_color_name*
 
--   The *color_name* string that will be used as the background colour.
-    A *color_mask* may also be used.</p></td>
+- The *color_name* string that will be used as the background colour.
+  A *color_mask* may also be used.
 
 **Example file contents:**
 
@@ -337,10 +335,10 @@ range s15:c0.c1023 = black yellow
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_colors_path**(3)*
--   ***selinux_raw_context_to_color**(3)* - this call returns the foreground
-    and background colours of the context string as the specified RGB 'colour'
-    hex digits as follows:
+- ***selinux_colors_path**(3)*
+- ***selinux_raw_context_to_color**(3)* - this call returns the foreground
+  and background colours of the context string as the specified RGB 'colour'
+  hex digits as follows:
 
 ```
 user : role : type : range
@@ -380,9 +378,9 @@ type
 
 *type*
 
--   The type defined in the policy that needs to excluded from relabeling.
-    An example is when a file has been purposely relabeled with a different
-    type to allow an application to work.
+- The type defined in the policy that needs to excluded from relabeling.
+  An example is when a file has been purposely relabeled with a different
+  type to allow an application to work.
 
 **Example file contents:**
 
@@ -397,9 +395,9 @@ sysadm_untrusted_content_tmp_t
 
 **Supporting libselinux API functions are:**
 
--   ***is_context_customizable**(3)*
--   ***selinux_customizable_types_path**(3)*
--   ***selinux_context_path**(3)*
+- ***is_context_customizable**(3)*
+- ***selinux_customizable_types_path**(3)*
+- ***selinux_context_path**(3)*
 
 ## *contexts/default_contexts*
 
@@ -407,14 +405,14 @@ The ***default_contexts**(5)* file is used by SELinux-aware applications
 that need to set a security context for user processes (generally the
 login applications) where:
 
-1.  The GNU / Linux user identity should be known by the application.
-2.  If a login application, then the SELinux user (seuser), would have
-    been determined as described in the [*seusers*](#seusers) file
-    section.
-3.  The login applications will check the
-    [*contexts/users/[seuser_id]*](#contextsusersseuser_id) file
-    first and if no valid entry, will then look in the *[seuser_id]*
-    file for a default context to use.
+1. The GNU / Linux user identity should be known by the application.
+2. If a login application, then the SELinux user (seuser), would have
+   been determined as described in the [*seusers*](#seusers) file
+   section.
+3. The login applications will check the
+   [*contexts/users/[seuser_id]*](#contextsusersseuser_id) file
+   first and if no valid entry, will then look in the *[seuser_id]*
+   file for a default context to use.
 
 **The file format is as follows:**
 
@@ -426,12 +424,12 @@ role:type[:range] role:type[:range] ...
 
 *role:type[:range]*
 
--   The file contains one or more lines that consist of *role:type[:range]*
-    pairs (including the MLS / MCS *level* or *range* if applicable).
-    -  The entry at the start of a new line corresponds to the partial
-       *role:type[:range]* context of (generally) the login application.
-    -  The other *role:type[:range]* entries on that line represent an ordered
-       list of valid contexts that may be used to set the users context.
+- The file contains one or more lines that consist of *role:type[:range]*
+  pairs (including the MLS / MCS *level* or *range* if applicable).
+- The entry at the start of a new line corresponds to the partial
+  *role:type[:range]* context of (generally) the login application.
+- The other *role:type[:range]* entries on that line represent an ordered
+  list of valid contexts that may be used to set the users context.
 
 **Example file contents:**
 
@@ -449,16 +447,16 @@ system_r:xdm_t:s0 user_r:user_t:s0
 Note that the *contexts/users/[seuser_id]* file is also read by some of
 these functions.
 
--   ***selinux_contexts_path**(3)*
--   ***selinux_default_context_path**(3)*
--   ***get_default_context**(3)*
--   ***get_ordered_context_list**(3)*
--   ***get_ordered_context_list_with_level**(3)*
--   ***get_default_context_with_level**(3)*
--   ***get_default_context_with_role**(3)*
--   ***get_default_context_with_rolelevel**(3)*
--   ***query_user_context**(3)*
--   ***manual_user_enter_context**(3)*
+- ***selinux_contexts_path**(3)*
+- ***selinux_default_context_path**(3)*
+- ***get_default_context**(3)*
+- ***get_ordered_context_list**(3)*
+- ***get_ordered_context_list_with_level**(3)*
+- ***get_default_context_with_level**(3)*
+- ***get_default_context_with_role**(3)*
+- ***get_default_context_with_rolelevel**(3)*
+- ***query_user_context**(3)*
+- ***manual_user_enter_context**(3)*
 
 An example use in this Notebook (to get over a small feature) is that
 when the initial **basic policy** was built, no default_contexts file
@@ -511,7 +509,7 @@ information at:
 
 **Supporting libselinux API function is:**
 
--   ***selinux_context_path**(3)*
+- ***selinux_context_path**(3)*
 
 ## *contexts/default_type*
 
@@ -528,8 +526,8 @@ role:type
 
 *role:type*
 
--   The file contains one or more lines that consist of *role:type* entries.
-    There should be one line for each role defined within the policy.
+- The file contains one or more lines that consist of *role:type* entries.
+  There should be one line for each role defined within the policy.
 
 **Example file contents:**
 
@@ -544,8 +542,8 @@ user_r:user_t
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_default_type_path**(3)*
--   ***get_default_type**(3)*
+- ***selinux_default_type_path**(3)*
+- ***get_default_type**(3)*
 
 ## *contexts/failsafe_context*
 
@@ -563,8 +561,8 @@ role:type[:range]
 
 *role:type[:range]*
 
--   A single line that has a valid context to allow an administrator access
-    to the system, including the MLS / MCS *level* or *range* if applicable.
+- A single line that has a valid context to allow an administrator access
+  to the system, including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -576,14 +574,14 @@ sysadm_r:sysadm_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_failsafe_context_path**(3)*
--   ***get_default_context**(3)*
--   ***get_default_context_with_role**(3)*
--   ***get_default_context_with_level**(3)*
--   ***get_default_context_with_rolelevel**(3)*
--   ***get_ordered_context_list**(3)*
--   ***get_ordered_context_list_with_level**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_failsafe_context_path**(3)*
+- ***get_default_context**(3)*
+- ***get_default_context_with_role**(3)*
+- ***get_default_context_with_level**(3)*
+- ***get_default_context_with_rolelevel**(3)*
+- ***get_ordered_context_list**(3)*
+- ***get_ordered_context_list_with_level**(3)*
 
 ## *contexts/initrc_context*
 
@@ -601,8 +599,8 @@ user:role:type[:range]
 
 *user:role:type[:range]*
 
--   The file contains one line that consists of a security context,
-    including the MLS / MCS *level* or *range* if applicable.
+- The file contains one line that consists of a security context,
+  including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -615,7 +613,7 @@ system_u:system_r:initrc_t:s0-s15:c0.c255
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
+- ***selinux_context_path**(3)*
 
 ## *contexts/lxc_contexts*
 
@@ -634,24 +632,24 @@ content = "security_context"
 
 *process*
 
--   A single *process* entry that contains the lxc domain security context,
-    including the MLS / MCS *level* or *range* if applicable.
+- A single *process* entry that contains the lxc domain security context,
+  including the MLS / MCS *level* or *range* if applicable.
 
 *file*
 
--   A single *file* entry that contains the lxc file security context,
-    including the MLS / MCS *level* or *range* if applicable.</td>
+- A single *file* entry that contains the lxc file security context,
+  including the MLS / MCS *level* or *range* if applicable.
 
 *content*
 
--   A single *content* entry that contains the lxc content security context,
-    including the MLS / MCS *level* or *range* if applicable.</td>
+- A single *content* entry that contains the lxc content security context,
+  including the MLS / MCS *level* or *range* if applicable.
 
 *sandbox_kvm_process*
 
 *sandbox_lxc_process*
 
--   These entries may be present and contain the security context.
+- These entries may be present and contain the security context.
 
 **Example file contents:**
 
@@ -667,8 +665,8 @@ sandbox_lxc_process = "system_u:system_r:container_t:s0"
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_lxc_context_path**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_lxc_context_path**(3)*
 
 ## *contexts/netfilter_contexts* - Obsolete
 
@@ -677,8 +675,8 @@ matching of network packets - Never been used.
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_netfilter_context_path**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_netfilter_context_path**(3)*
 
 ## *contexts/openrc_contexts*
 
@@ -690,8 +688,8 @@ matching of network packets - Never been used.
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_openrc_contexts_path**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_openrc_contexts_path**(3)*
 
 ## *contexts/openssh_contexts*
 
@@ -707,8 +705,8 @@ privsep_preauth=sshd_net_t
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_openssh_contexts_path**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_openssh_contexts_path**(3)*
 
 ## *contexts/removable_context*
 
@@ -726,8 +724,8 @@ user:role:type[:range]
 
 *user:role:type[:range]*
 
--   The file contains one line that consists of a security context,
-    including the MLS / MCS *level* or *range* if applicable.
+- The file contains one line that consists of a security context,
+  including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -737,7 +735,7 @@ system_u:object_r:removable_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_removable_context_path**(3)*
+- ***selinux_removable_context_path**(3)*
 
 ## *contexts/sepgsql_contexts*
 
@@ -754,20 +752,20 @@ object_type object_name context
 
 *object_type*
 
--   This is the string representation of the object type.
+- This is the string representation of the object type.
 
 *object_name*
 
--   These are the object names of the specific database objects.
-    The entry can contain '*\**' for wildcard matching or '*?*' for
-    substitution. Note that if the '*\**' is used, then be aware that the order
-    of entries in the file is important. The '*\**' on its own is used to ensure
-    a default fallback context is assigned and should be the last entry in the
-    *object_type* block.
+- These are the object names of the specific database objects.
+  The entry can contain '*\**' for wildcard matching or '*?*' for
+  substitution. Note that if the '*\**' is used, then be aware that the order
+  of entries in the file is important. The '*\**' on its own is used to ensure
+  a default fallback context is assigned and should be the last entry in the
+  *object_type* block.
 
 *context*
 
--   The security *context* that will be applied to the object.
+- The security *context* that will be applied to the object.
 
 **Example file contents:**
 
@@ -792,8 +790,8 @@ snapperd_data = system_u:object_r:snapperd_data_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_snapperd_contexts_path**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_snapperd_contexts_path**(3)*
 
 ## *contexts/securetty_types*
 
@@ -810,7 +808,7 @@ type
 
 *type*
 
--   Zero or more type entries that are defined in the policy for tty devices.
+- Zero or more type entries that are defined in the policy for tty devices.
 
 **Example file contents:**
 
@@ -822,7 +820,7 @@ staff_tty_device_t
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_securetty_types_path**(3)*
+- ***selinux_securetty_types_path**(3)*
 
 ## *contexts/systemd_contexts*
 
@@ -838,13 +836,13 @@ service_class = security_context
 
 *service_class*
 
--   One or more entries that relate to the ***systemd**(1)* service (e.g.
-    runtime, transient).
+- One or more entries that relate to the ***systemd**(1)* service (e.g.
+  runtime, transient).
 
 *security_context*
 
--   The security context, including the MLS / MCS *level* or *range* if
-    applicable of the service to be run.
+- The security context, including the MLS / MCS *level* or *range* if
+  applicable of the service to be run.
 
 **Example file contents:**
 
@@ -854,8 +852,8 @@ runtime=system_u:object_r:systemd_runtime_unit_file_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
--   ***selinux_systemd_contexts_path**(3)*
+- ***selinux_context_path**(3)*
+- ***selinux_systemd_contexts_path**(3)*
 
 ## *contexts/userhelper_context*
 
@@ -872,8 +870,8 @@ security_context
 
 *security_context*
 
--   The file contains one line that consists of a full security context,
-    including the MLS / MCS *level* or *range* if applicable.
+- The file contains one line that consists of a full security context,
+  including the MLS / MCS *level* or *range* if applicable.
 
 **Example file contents:**
 
@@ -883,7 +881,7 @@ system_u:sysadm_r:sysadm_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_context_path**(3)*
+- ***selinux_context_path**(3)*
 
 ## *contexts/virtual_domain_context*
 
@@ -902,7 +900,7 @@ system_u:system_r:svirt_tcg_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_virtual_domain_context_path**(3)*
+- ***selinux_virtual_domain_context_path**(3)*
 
 ## *contexts/virtual_image_context*
 
@@ -921,7 +919,7 @@ system_u:object_r:virt_content_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_virtual_image_context_path**(3)*
+- ***selinux_virtual_image_context_path**(3)*
 
 ## *contexts/x_contexts*
 
@@ -943,32 +941,32 @@ selection      PRIMARY	   system_u:object_r:clipboard_xselection_t:s0
 
 *object_type*
 
--   These are types of object supported and valid entries are: *client*,
-    *property*, *poly_property*, *extension*, *selection*, *poly_selection*
-    and *events*.
+- These are types of object supported and valid entries are: *client*,
+  *property*, *poly_property*, *extension*, *selection*, *poly_selection*
+  and *events*.
 
 *object_name*
 
--   These are the object names of the specific X-server resource such as
-    *PRIMARY*, *CUT_BUFFER0* etc. They are generally defined in the X-server
-    source code (*protocol.txt* and *BuiltInAtoms* in the *dix* directory of
-    the *xorg-server* source package). This can contain '*\**' for 'any'
-    or '*?*' for 'substitute' (see the *CUT_BUFFER?* entry where the '*?*'
-    would be substituted for a number between 0 and 7 that represents the
-    number of these buffers).
+- These are the object names of the specific X-server resource such as
+  *PRIMARY*, *CUT_BUFFER0* etc. They are generally defined in the X-server
+  source code (*protocol.txt* and *BuiltInAtoms* in the *dix* directory of
+  the *xorg-server* source package). This can contain '*\**' for 'any'
+  or '*?*' for 'substitute' (see the *CUT_BUFFER?* entry where the '*?*'
+  would be substituted for a number between 0 and 7 that represents the
+  number of these buffers).
 
 *context*
 
--   This is the security context that will be applied to the object.
-    For MLS/MCS systems there would be the additional MLS label.
+- This is the security context that will be applied to the object.
+  For MLS/MCS systems there would be the additional MLS label.
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_x_context_path**(3)*
--   ***selabel_open**(3)*
--   ***selabel_close**(3)*
--   ***selabel_lookup**(3)*
--   ***selabel_stats**(3)*
+- ***selinux_x_context_path**(3)*
+- ***selabel_open**(3)*
+- ***selabel_close**(3)*
+- ***selabel_lookup**(3)*
+- ***selabel_stats**(3)*
 
 ## *contexts/files/file_contexts*
 
@@ -996,11 +994,11 @@ compatible regular expression (PCRE) internal format.
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_file_context_path**(3)*
--   ***selabel_open**(3)*
--   ***selabel_close**(3)*
--   ***selabel_lookup**(3)*
--   ***selabel_stats**(3)*
+- ***selinux_file_context_path**(3)*
+- ***selabel_open**(3)*
+- ***selabel_close**(3)*
+- ***selabel_lookup**(3)*
+- ***selabel_stats**(3)*
 
 ## *contexts/files/file_contexts.local*
 
@@ -1011,7 +1009,7 @@ file section to allow locally defined files to be labeled correctly. The
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_file_context_local_path**(3)*
+- ***selinux_file_context_local_path**(3)*
 
 ## *contexts/files/file_contexts.homedirs*
 
@@ -1034,8 +1032,8 @@ Perl compatible regular expression (PCRE) internal format.
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_file_context_homedir_path**(3)*
--   ***selinux_homedir_context_path**(3)*
+- ***selinux_file_context_homedir_path**(3)*
+- ***selinux_homedir_context_path**(3)*
 
 ## *contexts/files/file_contexts.subs*
 ## *contexts/files/file_contexts.subs_dist*
@@ -1062,11 +1060,11 @@ with */var/www*, with the final result being:
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_file_context_subs_path**(3)*
--   ***selinux_file_context_subs_dist_path**(3)*
--   ***selabel_lookup**(3)*
--   ***matchpathcon**(3)* (deprecated)
--   ***matchpathcon_index**(3)* (deprecated)
+- ***selinux_file_context_subs_path**(3)*
+- ***selinux_file_context_subs_dist_path**(3)*
+- ***selabel_lookup**(3)*
+- ***matchpathcon**(3)* (deprecated)
+- ***matchpathcon_index**(3)* (deprecated)
 
 ## *contexts/files/media*
 
@@ -1085,12 +1083,12 @@ media_id file_context
 
 *media_id*
 
--   The media identifier (those known are: cdrom, floppy, disk and usb).
+- The media identifier (those known are: cdrom, floppy, disk and usb).
 
 *file_context*
 
--   The context to be used for the device. Note that it does not have the
-    MLS / MCS level).
+- The context to be used for the device. Note that it does not have the
+  MLS / MCS level).
 
 **Example file contents:**
 
@@ -1102,7 +1100,7 @@ disk system_u:object_r:fixed_disk_device_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_media_context_path**(3)*
+- ***selinux_media_context_path**(3)*
 
 ## *contexts/users/[seuser_id]*
 
@@ -1131,15 +1129,15 @@ system_r:init_t:s0		unconfined_r:unconfined_t:s0
 
 **Supporting libselinux API functions are:**
 
--   ***selinux_user_contexts_path**(3)*
--   ***selinux_users_path**(3)*
--   ***selinux_usersconf_path**(3)*
--   ***get_default_context**(3)*
--   ***get_default_context_with_role**(3)*
--   ***get_default_context_with_level**(3)*
--   ***get_default_context_with_rolelevel**(3)*
--   ***get_ordered_context_list**(3)*
--   ***get_ordered_context_list_with_level**(3)*
+- ***selinux_user_contexts_path**(3)*
+- ***selinux_users_path**(3)*
+- ***selinux_usersconf_path**(3)*
+- ***get_default_context**(3)*
+- ***get_default_context_with_role**(3)*
+- ***get_default_context_with_level**(3)*
+- ***get_default_context_with_rolelevel**(3)*
+- ***get_ordered_context_list**(3)*
+- ***get_ordered_context_list_with_level**(3)*
 
 ## *logins/\<linuxuser_id\>*
 
@@ -1168,11 +1166,11 @@ service_name:seuser_id:level
 
 *service_name*
 
--   The name of the service.
+- The name of the service.
 
 *seuser_id*
 
--   The SELinux user name.
+- The SELinux user name.
 
 *level*
 
@@ -1188,7 +1186,7 @@ another_service:unconfined_u:s0
 
 **Supporting libselinux API functions are:**
 
--   ***getseuser**(3)*
+- ***getseuser**(3)*
 
 ## *users/local.users*
 
-- 
2.26.2

