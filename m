Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70AC433FE
	for <selinux@archiver.kernel.org>; Tue, 15 Nov 2022 19:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKOTrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKOTrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Nov 2022 14:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A6275CB
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668541567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhDfbDMAjXx4S0RSzOev93uPtHrFWE4bSkmNZDl1fno=;
        b=Bm5FfRmOEFg8z98/pNJgZ3JHQGSvkIQPWgfNzzLwzsZBcj50qgFd/DH/iD6DGz9KGJNUc3
        HXK4bZcvw2/CZx5lMWqB45Q2/OoTu0ORCBDpMKecNqzfjh9HS4FxmMvNL5Lz/dViceQLA2
        YxgySo9bnA5FpUeTF7RaG4HhNeTis7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-KPxmc7OKNBqFvjPgNoWNnw-1; Tue, 15 Nov 2022 14:46:05 -0500
X-MC-Unique: KPxmc7OKNBqFvjPgNoWNnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E4F485A5A6
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-195-4.brq.redhat.com [10.40.195.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C787E112131E;
        Tue, 15 Nov 2022 19:46:04 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 3/3] python/sepolicy: Simplify generation of man pages
Date:   Tue, 15 Nov 2022 20:45:52 +0100
Message-Id: <20221115194552.338640-3-plautrba@redhat.com>
In-Reply-To: <20221115194552.338640-1-plautrba@redhat.com>
References: <20221115194552.338640-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Petr Lautrbach <lautrbach@redhat.com>

And do not hardcode Fedora and RHEL versions.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 71 ++++-------------------------
 1 file changed, 8 insertions(+), 63 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index de72cb6cda5f..d9973170f3c3 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -147,9 +147,6 @@ def _gen_types():
 def prettyprint(f, trim):
     return " ".join(f[:-len(trim)].split("_"))
 
-fedora_releases = ["Fedora17", "Fedora18"]
-rhel_releases = ["RHEL6", "RHEL7"]
-
 
 def get_alphabet_manpages(manpage_list):
     alphabet_manpages = dict.fromkeys(string.ascii_letters, [])
@@ -180,7 +177,7 @@ def convert_manpage_to_html(html_manpage, manpage):
 class HTMLManPages:
 
     """
-            Generate a HHTML Manpages on an given SELinux domains
+            Generate a HTML Manpages on an given SELinux domains
     """
 
     def __init__(self, manpage_roles, manpage_domains, path, os_version):
@@ -188,18 +185,12 @@ class HTMLManPages:
         self.manpage_domains = get_alphabet_manpages(manpage_domains)
         self.os_version = os_version
         self.old_path = path + "/"
-        self.new_path = self.old_path + self.os_version + "/"
-
-        if self.os_version in fedora_releases or self.os_version in rhel_releases:
-            self.__gen_html_manpages()
-        else:
-            print("SELinux HTML man pages can not be generated for this %s" % os_version)
-            exit(1)
+        self.new_path = self.old_path
+        self.__gen_html_manpages()
 
     def __gen_html_manpages(self):
         self._write_html_manpage()
         self._gen_index()
-        self._gen_body()
         self._gen_css()
 
     def _write_html_manpage(self):
@@ -217,67 +208,21 @@ class HTMLManPages:
                     convert_manpage_to_html((self.new_path + r.rsplit("_selinux", 1)[0] + ".html"), self.old_path + r)
 
     def _gen_index(self):
-        index = self.old_path + "index.html"
-        fd = open(index, 'w')
-        fd.write("""
-<html>
-<head>
-    <link rel=stylesheet type="text/css" href="style.css" title="style">
-    <title>SELinux man pages online</title>
-</head>
-<body>
-<h1>SELinux man pages</h1>
-<br></br>
-Fedora or Red Hat Enterprise Linux Man Pages.</h2>
-<br></br>
-<hr>
-<h3>Fedora</h3>
-<table><tr>
-<td valign="middle">
-</td>
-</tr></table>
-<pre>
-""")
-        for f in fedora_releases:
-            fd.write("""
-<a href=%s/%s.html>%s</a> - SELinux man pages for %s """ % (f, f, f, f))
-
-        fd.write("""
-</pre>
-<hr>
-<h3>RHEL</h3>
-<table><tr>
-<td valign="middle">
-</td>
-</tr></table>
-<pre>
-""")
-        for r in rhel_releases:
-            fd.write("""
-<a href=%s/%s.html>%s</a> - SELinux man pages for %s """ % (r, r, r, r))
-
-        fd.write("""
-</pre>
-	""")
-        fd.close()
-        print("%s has been created" % index)
-
-    def _gen_body(self):
-        html = self.new_path + self.os_version + ".html"
+        html = self.new_path + "index.html"
         fd = open(html, 'w')
         fd.write("""
 <html>
 <head>
-	<link rel=stylesheet type="text/css" href="../style.css" title="style">
-	<title>Linux man-pages online for Fedora18</title>
+	<link rel=stylesheet type="text/css" href="style.css" title="style">
+	<title>SELinux man pages online</title>
 </head>
 <body>
-<h1>SELinux man pages for Fedora18</h1>
+<h1>SELinux man pages for %s</h1>
 <hr>
 <table><tr>
 <td valign="middle">
 <h3>SELinux roles</h3>
-""")
+""" % self.os_version)
         for letter in self.manpage_roles:
             if len(self.manpage_roles[letter]):
                 fd.write("""
-- 
2.38.1

