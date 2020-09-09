Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83FC43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 20:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C4D221E3
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 20:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="ItVywOaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgIJU6f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:58:35 -0400
Received: from mailomta28-re.btinternet.com ([213.120.69.121]:53250 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbgIJU51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 16:57:27 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-040.btinternet.com with ESMTP
          id <20200909133046.UFHJ10362.re-prd-fep-040.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658246; 
        bh=YOdsWTFlwrLM266uakaEjj9lU2lAlvZU/OkQNECuCzY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=ItVywOaClUU3EK0MfcDjWfCeklmNGI5mSuD6GJLa85TYjMZv1IgqXrT834QPgZb5FACrYxxLwkyR7qh9bgqzoFIPMixgNr3HdKTFC6FuwPsvIFCsgztu+XKnULEPPWkRrBCDAWlT74gfCxzk6BtLssUBQb40CSdo3pwluYey9YH8mn2ymg1/Opzn2gCWJsPS7epfQNQPDoTwNLhgd22r3CLjvWjNW34A2qFiyXg8nlEdLJtiaKymcgBaScAke/qqtNRkSMn6a8ry8JjXOhPunEWqkvnrx6Ukm+s3SLJ/Q8FMXnnGHQ+AhqClWRfBNo7qJ1lSwdjDf+c5KHVAWrVKjg==
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
        id 5ED9C2FD10134DD1; Wed, 9 Sep 2020 14:30:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 07/22] security_context: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:24 +0100
Message-Id: <20200909133039.44498-8-richard_c_haines@btinternet.com>
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
 src/security_context.md | 83 ++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/src/security_context.md b/src/security_context.md
index 3ca93a2..cb0fc4a 100644
--- a/src/security_context.md
+++ b/src/security_context.md
@@ -20,47 +20,50 @@ user:role:type[:range]
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>user</code></td>
-<td>The SELinux user identity. This can be associated to one or more roles that the SELinux user is allowed to use.</td>
-</tr>
-<tr>
-<td><code>role</code></td>
-<td>The SELinux role. This can be associated to one or more types the SELinux user is allowed to access.</td>
-</tr>
-<tr>
-<td><code>type</code></td>
-<td><p>When a type is associated with a process, it defines what processes (or domains) the SELinux user (the subject) can access.</p>
-<p>When a type is associated with an object, it defines what access permissions the SELinux user has to that object.</p></td>
-</tr>
-<tr>
-<td><code>range</code></td>
-<td><p>This field can also be know as a <em>level</em> and is only present if the policy supports MCS or MLS. The entry can consist of:
-<p>A single security level that contains a sensitivity level and zero or more categories (e.g. s0, s1:c0, s7:c10.c15).</p>
-<p>A range that consists of two security levels (a low and high) separated by a hyphen (e.g. s0 - s15:c0.c1023).</p>
-<p>These components are discussed in the <a href="mls_mcs.md#security-levels">Security Levels</a> section.</p></td>
-</tr>
-</tbody>
-</table>
+*user*
+
+- The SELinux user identity. This can be associated to one or more roles
+  that the SELinux user is allowed to use.
+
+*role*
+
+- The SELinux role. This can be associated to one or more types the SELinux
+  user is allowed to access.
+
+*type*
+
+- When a type is associated with a process, it defines what processes
+  (or domains) the SELinux user (the subject) can access.
+  When a type is associated with an object, it defines what access
+  permissions the SELinux user has to that object.
+
+*range*
+
+- This field can also be know as a *level* and is only present if the policy
+  supports MCS or MLS. The entry can consist of:
+  - A single security level that contains a sensitivity level and zero
+    or more categories (e.g. *s0*, *s1:c0*, *s7:c10.c15*).
+  - A range that consists of two security levels (a low and high) separated
+   by a hyphen (e.g. *s0 - s15:c0.c1023*).
+- These components are discussed in the
+  [**Security Levels**]( mls_mcs.md#security-levels) section.
 
 However note that:
 
-1.  Access decisions regarding a subject make use of all the components
-    of the **security context**.
-2.  Access decisions regarding an object make use of the components as
-    follows:
-    1.  the user is either set to a special user called system_u or it
-        is set to the SELinux user id of the creating process. It is
-        possible to add constraints on users within policy based on
-        their object class (an example of this is the Reference Policy
-        UBAC (User Based Access Control) option.
-    2.  the role is generally set to a special SELinux internal role of
-        'object_r`, although policy version 26 with kernel 2.6.39 and
-        above do support role transitions on any object class. It is
-        then possible to add constraints on the role within policy
-        based on their object class.
+1. Access decisions regarding a subject make use of all the components
+   of the **security context**.
+2. Access decisions regarding an object make use of the components as
+   follows:
+    1. the user is either set to a special user called *system_u*[^fn_sc_1]
+       or it is set to the SELinux user id of the creating process. It is
+       possible to add constraints on users within policy based on
+       their object class (an example of this is the Reference Policy
+       UBAC (User Based Access Control) option.
+    2. the role is generally set to a special SELinux internal role of
+       *object_r*, although policy version 26 with kernel 2.6.39 and
+       above do support role transitions on any object class. It is
+       then possible to add constraints on the role within policy
+       based on their object class.
 
 The [**Computing Security Contexts**](computing_security_contexts.md#computing-security-contexts)
 section decribes how SELinux computes the security context components based
@@ -116,6 +119,10 @@ unconfined_u:object_r:out_file_t Message-11
 # (see the process example above). The role remained as object_r.
 ```
 
+[^fn_sc_1]: The user *system_u* name is not mandatory, it is used to signify
+a special user in the Reference Policy. It is also used in some SELinux
+utilities.
+
 <!-- %CUTHERE% -->
 
 ---
-- 
2.26.2

