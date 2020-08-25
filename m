Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A22AC433E5
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341A520706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="QJ7XtE51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHYIiS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:18 -0400
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:23248 "EHLO
        sa-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgHYIiQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:16 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20200825083812.IOUU26396.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344692; 
        bh=QC+svJEAdzLwdQSNt57fEKYeJFgYUGtdD+UBOXyr2J0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=QJ7XtE51QpPpbxWEUj/MTGQ/rBtb8k+uDaibvc1nS6tdfoord794FSQ4NALfnMx5sttS3yv2a/H7SC0UfCBPZ1EveAqSpUiygUipixFtX2GNHybgHqf86ppEMuQqcn8bTBHy7yeoO+YPiGkWEOgApEJNOrp/iIxi1ZVuxKSBWH5/E8S4i8wkYP29idYNKIarMoQSMISK8m1QRY65sKJ523V7TB+GTiVKz/UZ8UL5rH9rO6Qp+wJAUqZpRjB6NsWs4ccwrKJsLUqkBPqP/PHpMyoEjpIPLXwg62yKKwv4e3+IKeVzoiLY725Wdcz/gFS7a45mhIDYzRI9i568YZ1EWw==
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
        id 5ED9B8A70D599E55; Tue, 25 Aug 2020 09:38:12 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 14/18] domain_object_transitions: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:39 +0100
Message-Id: <20200825083743.6508-15-richard_c_haines@btinternet.com>
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
 src/domain_object_transitions.md | 121 ++++++++++++++++---------------
 1 file changed, 62 insertions(+), 59 deletions(-)

diff --git a/src/domain_object_transitions.md b/src/domain_object_transitions.md
index 030d866..f897c3b 100644
--- a/src/domain_object_transitions.md
+++ b/src/domain_object_transitions.md
@@ -1,9 +1,13 @@
 # Domain and Object Transitions
 
+- [Domain Transition](#domain-transition)
+  - [Type Enforcement Rules](#type-enforcement-rules)
+- [Object Transition](#object-transition)
+
 This section discusses the *type_transition* statement that is used to:
 
-1.  Transition a process from one domain to another (a domain transition).
-2.  Transition an object from one type to another (an object transition).
+- Transition a process from one domain to another (a domain transition).
+- Transition an object from one type to another (an object transition).
 
 These transitions can also be achieved using the **libselinux** API
 functions for SELinux-aware applications.
@@ -14,19 +18,19 @@ A domain transition is where a process in one domain starts a new
 process in another domain under a different security context. There are
 two ways a process can define a domain transition:
 
-1.  Using a *type_transition* statement, where the ***exec**(2)* system call
-    will automatically perform a domain transition for programs that are not
-    themselves SELinux-aware. This is the most common method and would
-    be in the form of the following statement:
+- Using a *type_transition* statement, where the ***exec**(2)* system call
+  will automatically perform a domain transition for programs that are not
+  themselves SELinux-aware. This is the most common method and would
+  be in the form of the following statement:
 
 ```
 type_transition unconfined_t secure_services_exec_t : process ext_gateway_t;
 ```
 
-1.  SELinux-aware applications can specify the domain of the new process
-    using the **libselinux** API call ***setexeccon**(3)*. To achieve
-    this the SELinux-aware application must also have the setexec
-    permission, for example:
+- SELinux-aware applications can specify the domain of the new process
+  using the **libselinux** API call ***setexeccon**(3)*. To achieve
+  this the SELinux-aware application must also have the setexec
+  permission, for example:
 
 ```
 allow crond_t self:process setexec;
@@ -35,12 +39,12 @@ allow crond_t self:process setexec;
 However, before any domain transition can take place the policy must
 specify that:
 
-1.  The source *domain* has permission to *transition* into the target
-    domain.
-2.  The application binary file needs to be *executable* in the source
-    domain.
-3.  The application binary file needs an *entry point* into the target
-    domain.
+1. The source *domain* has permission to *transition* into the target
+   domain.
+2. The application binary file needs to be *executable* in the source
+   domain.
+3. The application binary file needs an *entry point* into the target
+   domain.
 
 The following is a *type_transition* statement taken an example
 loadable module message filter *ext_gateway.conf* that will be used to explain
@@ -59,27 +63,26 @@ the *unconfined_t* domain (the source domain) executes a file labeled
 transition from the *unconfined_t* domain to the *ext_gateway_t* domain).
 
 However as stated above, to be able to *transition* to the
-*ext_gateway_t* domain, the following minimum permissions must be
-granted in the policy using *allow* rules, where (note that the
-bullet numbers correspond to the numbers shown in **Figure 7: Domain Transition**:
+*ext_gateway_t* domain, the following minimum permissions must be granted in
+the policy using *allow* rules, where (the bullet numbers correspond to those
+in **Figure 7: Domain Transition**):
 
-1.  The *domain* needs permission to *transition* into the
-    *ext_gateway_t* (target) domain:
+**(1)** The *domain* needs permission to *transition* into the *ext_gateway_t*
+(target) domain:
 
 ```
 allow unconfined_t ext_gateway_t : process transition;
 ```
 
-2.  The executable file needs to be *executable* in the *unconfined_t*
-    (source) domain, and therefore also requires that the file is
-    readable:
+**(2)** The executable file needs to be *executable* in the *unconfined_t*
+(source) domain, and therefore also requires that the file is readable:
 
 ```
 allow unconfined_t secure_services_exec_t : file { execute read getattr };
 ```
 
-3.  The executable file needs an *entry point* into the
-    *ext_gateway_t* (target) domain:
+**(3)** The executable file needs an *entry point* into the *ext_gateway_t*
+(target) domain:
 
 ```
 allow ext_gateway_t secure_services_exec_t : file entrypoint;
@@ -94,7 +97,7 @@ SELinux enabled kernel.
 ![](./images/7-domain-transition.png)
 
 **Figure 7: Domain Transition** - *Where the secure_server is executed
-within the *unconfined_t* domain and then transitioned to the *ext_gateway_t*
+within the unconfined_t domain and then transitioned to the ext_gateway_t
 domain.*
 
 ### Type Enforcement Rules
@@ -164,10 +167,10 @@ target domains), that breaks the type enforcement rule.
 
 It was decided to resolve this by:
 
-1.  Keeping the *type_transition* rule for the 'default' type of
-    *ext_gateway_t* and allow the secure server process to be exec'd
-    from *unconfined_t* as shown in **Figure 7: Domain Transition**, by simply
-    running the command from the prompt as follows:
+- Keeping the *type_transition* rule for the 'default' type of
+  *ext_gateway_t* and allow the secure server process to be exec'd
+  from *unconfined_t* as shown in **Figure 7: Domain Transition**, by simply
+  running the command from the prompt as follows:
 
 ```
 # Run the external gateway 'secure server' application on port 9999 and
@@ -176,9 +179,9 @@ It was decided to resolve this by:
 secure_server 99999
 ```
 
-1.  Use the SELinux ***runcon**(1)* command to ensure that the internal
-    gateway runs in the correct domain by running runcon from the prompt
-    as follows:
+- Use the SELinux ***runcon**(1)* command to ensure that the internal
+  gateway runs in the correct domain by running *runcon* from the prompt
+  as follows:
 
 ```
 # Run the internal gateway 'secure server' application on port 1111 and
@@ -189,34 +192,34 @@ runcon -t int_gateway_t -r message_filter_r secure_server 1111
 # Note: The role is required as a role transition is defined in the policy.
 ```
 
-The runcon command makes use of a number of **libselinux** API
+The ***runcon**(1)* command makes use of a number of **libselinux** API
 functions to check the current context and set up the new context (for
 example ***getfilecon**(3)* is used to get the executable files context
 and ***setexeccon**(3)* is used to set the new process context). If all
 contexts are correct, then the ***execvp**(2)* system call is executed
 that exec's the secure_server application with the argument of '1111'
 into the *int_gateway_t* domain with the *message_filter_r* role. The
-runcon source can be found in the coreutils package.
+*runcon* source can be found in the coreutils package.
 
 Other ways to resolve this issue are:
 
-1.  Use the runcon command for both gateways to transition to their
-    respective domains. The *type_transition* statements are therefore
-    not required.
-2.  Use different names for the secure server executable files and
-    ensure they have a different type (i.e. instead of
-    *secure_service_exec_t* label the external gateway
-    *ext_gateway_exec_t* and the internal gateway
-    *int_gateway_exec_t*. This would involve making a copy of the
-    application binary (which has already been done as part of the
-    **module testing** by calling the server 'server' and labeling it
-    *unconfined_t* and then making a copy called secure_server and
-    labeling it *secure_services_exec_t*).
-3.  Implement the policy using the Reference Policy utilising the
-    template interface principles discussed in the
-    [**template**](reference_policy.md#template-macro) section.
-
-It was decided to use runcon as it demonstrates the command usage better
+1. Use the *runcon* command for both gateways to transition to their
+   respective domains. The *type_transition* statements are therefore
+   not required.
+2. Use different names for the secure server executable files and
+   ensure they have a different type (i.e. instead of
+   *secure_service_exec_t* label the external gateway
+   *ext_gateway_exec_t* and the internal gateway
+   *int_gateway_exec_t*. This would involve making a copy of the
+   application binary (which has already been done as part of the
+   **module testing** by calling the server 'server' and labeling it
+   *unconfined_t* and then making a copy called secure_server and
+   labeling it *secure_services_exec_t*).
+3. Implement the policy using the Reference Policy utilising the
+   template interface principles discussed in the
+   [**template**](reference_policy.md#template-macro) section.
+
+It was decided to use *runcon* as it demonstrates the command usage better
 than reading the man pages.
 
 ## Object Transition
@@ -230,7 +233,7 @@ automatically using a *type_transition* statement as follows:
 type_transition ext_gateway_t in_queue_t:file in_file_t;
 ```
 
-The following details an object transition used in n example
+The following details an object transition used in an example
 *ext_gateway.conf* loadable module where by default, files would be labeled
 *in_queue_t* when created by the gateway application as this is the label
 attached to the parent directory as shown:
@@ -261,21 +264,21 @@ However as stated above to be able to create the file, the following
 minimum permissions need to be granted in the policy using *allow*
 rules, where:
 
-1.  The source domain needs permission to *add file entries into the
-    directory*:
+- The source domain needs permission to *add file entries into the
+  directory*:
 
 ```
 allow ext_gateway_t in_queue_t : dir { write search add_name };
 ```
 
-2.  The source domain needs permission to *create file entries*:
+- The source domain needs permission to *create file entries*:
 
 ```
 allow ext_gateway_t in_file_t : file { write create getattr };
 ```
 
-3.  The policy can then ensure (via the SELinux kernel services) that
-    files created in the *in_queue* are relabeled:
+- The policy can then ensure (via the SELinux kernel services) that
+  files created in the *in_queue* are relabeled:
 
 ```
 type_transition ext_gateway_t in_queue_t : file in_file_t;
-- 
2.26.2

