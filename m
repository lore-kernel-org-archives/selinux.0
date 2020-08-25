Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4FC433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDEC20706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="S0UOd6sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgHYIiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:13 -0400
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:34663 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgHYIiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:11 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200825083807.GKNX3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344687; 
        bh=K5ZcZQGcI0EbTFBF4DcaOF0uGgrB91qDpkJQfAP19UE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=S0UOd6sOzKWP9bJ1+4qf2dxeQC7l9K/f6xbH4M4Hpqyk+YXImj8onmfQv9WOptwMpI6aOrwZWWBI/4VJEy1oR5hHJta7v3Vdlu6Z39ufKCDV0sQl/Z9krmq26px72wrHdOrO0cdPVrQ9uOjdZI/0s4+3SQUmPFgKQPE1HOqDza/jmk+EI/LD3SIWfrtJCKkWgpsmbbFSZQZ6WipD3bXm+n4/L8TA7nJe646pvORrHQb1GkwYGzEuxgnLgpKC7/1rl8mgRnR/wfZppJWw+oup+5CvJmlx7+7yGO2QBz8YagNiXkRy7u0NTcNCokHX/SljurAcH9hDprvC3hoWgdvAmA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=70/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecugfgrrhhlhicushhprhhinhhgucdljedtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvjedvhfefjefhuefffeektedtieejffffudfhtdetueefteeikeelleetveekudenucffohhmrghinhepghhoohhglhgvtghouggvrdgtohhmnecukfhppedutdelrdduheehrddufedtrdduiedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrddufedtrdduiedtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgt
        ohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 70
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599D6F; Tue, 25 Aug 2020 09:38:07 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 01/18] apache_support: Convert to markdown
Date:   Tue, 25 Aug 2020 09:37:26 +0100
Message-Id: <20200825083743.6508-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825083743.6508-1-richard_c_haines@btinternet.com>
References: <20200825083743.6508-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/apache_support.md | 79 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/src/apache_support.md b/src/apache_support.md
index 8e8df1c..5c012cf 100644
--- a/src/apache_support.md
+++ b/src/apache_support.md
@@ -1,5 +1,8 @@
 # Apache SELinux Support
 
+- [*mod_selinux* Overview](#mod_selinux-overview)
+- [Bounds Overview](#bounds-overview)
+
 Apache web servers are supported by SELinux using the Apache policy
 modules from the Reference Policy (*httpd* modules), however there is no
 specific Apache object manger. There is though an SELinux-aware shared
@@ -25,31 +28,20 @@ configuration details is available from:
 
 The objective of these Apache add-on services is to achieve a fully
 SELinux-aware web stack (although not there yet). For example, currently
-the LAPP<a href="#fnap1" class="footnote-ref" id="fnaph1"><strong><sup>1</sup></strong></a>
-(Linux, Apache, PostgreSQL, PHP / Perl / Python) stack has the following support:
-
-<table>
-<tbody>
-<tr>
-<td>L</td>
-<td>Linux has SELinux support.</td>
-</tr>
-<tr>
-<td>A</td>
-<td>Apache has partial SELinux support using the 'Apache SELinux Plus' module.</td>
-</tr>
-<tr>
-<td>P</td>
-<td>PostgreSQL has SELinux support using the PostgreSQL <em>sepgsql</em> extension .</td>
-</tr>
-<tr>
-<td>P</td>
-<td>PHP / Perl / Python are not currently SELinux-aware, however PHP and Python do have support for libselinux functions in packages: PHP - with the <em>php-pecl-selinux</em> package, Python - with the <em>libselinux-python</em> package.</td>
-</tr>
-</tbody>
-</table>
-
-The [A secure web application platform powered by SELinux](http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf)
+the LAPP[^fn_as_1] (Linux, Apache, PostgreSQL, PHP / Perl / Python)
+stack has the following support:
+
+**L** - Linux has SELinux support.
+
+**A** - Apache has partial SELinux support using the 'Apache SELinux Plus' module.
+
+**P** - PostgreSQL has SELinux support using the PostgreSQL *sepgsql* extension.
+
+**P** - PHP / Perl / Python are not currently SELinux-aware, however PHP
+and Python do have support for libselinux functions in packages: PHP - with
+the *php-pecl-selinux* package, Python - with the *libselinux-python* package.
+
+The "[A secure web application platform powered by SELinux](http://sepgsql.googlecode.com/files/LCA20090120-lapp-selinux.pdf)"
 document gives a good overview of the LAPP architecture.
 
 ## *mod_selinux* Overview
@@ -59,22 +51,20 @@ What the *mod_selinux* module achieves is to allow a web application
 context based on policy rather than that of the web server process
 itself, for example:
 
-1.  A user sends an HTTP request to Apache that requires the services of
-    a web application (Apache may or may not apply HTTP authentication).
-2.  Apache receives the request and launches the web application
-    instance to perform the task:
--   Without *mod_selinux* enabled the web applications security context
-    is identical to the Apache web server process, it is therefore not
-    possible to restrict it privileges.
-
--   With *mod_selinux* enabled, the web application is launched with
-    the security context defined in the *mod_selinux.conf* file
-    (*selinuxDomainVal &lt;security_context&gt;* entry). It is also
-    possible to restrict its privileges as described in the
-    [Bounds Overview](#bounds-overview) section.
-
-3.  The web application exits, handing control back to the web server
-    that replies with the HTTP response.
+1. A user sends an HTTP request to Apache that requires the services of
+   a web application (Apache may or may not apply HTTP authentication).
+2. Apache receives the request and launches the web application
+   instance to perform the task:
+   - Without *mod_selinux* enabled the web applications security context
+     is identical to the Apache web server process, it is therefore not
+     possible to restrict it privileges.
+   - With *mod_selinux* enabled, the web application is launched with
+     the security context defined in the *mod_selinux.conf* file
+     (*selinuxDomainVal \<security_context\>* entry). It is also
+     possible to restrict its privileges as described in the
+     [Bounds Overview](#bounds-overview) section.
+3. The web application exits, handing control back to the web server
+   that replies with the HTTP response.
 
 ## Bounds Overview
 
@@ -120,11 +110,8 @@ operation will be denied and an *SELINUX_ERR* entry will be added to
 the audit log stating *op=security_compute_av reason=bounds* with
 the context strings and the denied class and permissions.
 
-<section class="footnotes">
-<ol>
-<li id="fnap1"><p>This is similar to the LAMP (Linux, Apache, MySQL, PHP/Perl/Python) stack, however MySQL is not SELinux-aware.<a href="#fnaph1" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+[^fn_as_1]: This is similar to the LAMP (Linux, Apache, MySQL, PHP/Perl/Python)
+stack, however MySQL is not SELinux-aware.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

