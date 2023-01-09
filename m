Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2211C54EBD
	for <selinux@archiver.kernel.org>; Mon,  9 Jan 2023 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAIRJP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjAIRIY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Jan 2023 12:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D093C395
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673284008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+dpkNcgx74UiDllm4CrKHEHgSbpyk+Sz/Du9IbqY7Es=;
        b=cDh1cNO7WsV1mu2c0lTMeWnCmD3i5GGxAZ8LdVox/upLGVf64m6SKbwK3p/sOwH9gyUDZ8
        1FMT9dS3VvDYpvLuzV0wx91+R7gJsp+WXIoNIVhq8SnTwZgvtQz2WMDEtrK/Vr5fNdNews
        W1IGObFa86uuuUMwJGP4XqsraS0NMjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-EjYE6CvHNmmiQhWhSuu5Sw-1; Mon, 09 Jan 2023 12:06:46 -0500
X-MC-Unique: EjYE6CvHNmmiQhWhSuu5Sw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F504101A521
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 17:06:46 +0000 (UTC)
Received: from ovpn-193-114.brq.redhat.com (ovpn-193-114.brq.redhat.com [10.40.193.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4051740ED76D
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 17:06:46 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolicy: add missing booleans to man pages
Date:   Mon,  9 Jan 2023 18:06:26 +0100
Message-Id: <20230109170626.815271-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

get_bools should return a list of booleans that can affect given type,
but it did not handle non trivial conditional statements properly
(returning the whole conditional statement instead of a list of booleans
in the statement).

e.g. for
allow httpd_t spamc_t:process transition; [ httpd_can_check_spam && httpd_can_sendmail ]:True
get_bools used to return [("httpd_can_check_spam && httpd_can_sendmail", False)] instead of
[("httpd_can_check_spam", False), ("httpd_can_sendmail", False)]

- rename "boolean" in sepolicy rule dictionary to "booleans" to suggest
  it can contain multiple values and make sure it is populated correctly
- add "conditional" key to the rule dictionary to accommodate
  get_conditionals, which requires the whole conditional statement

Note: get_bools uses security_get_boolean_active to get the boolean
      value, but the value is later used to represent the default.
      Not ideal, but I'm not aware of a way to get the actual defaults.

Fixes:
        "sepolicy manpage" generates man pages that are missing booleans
        which are included in non trivial conditional expressions
        e.g. httpd_selinux(8) does not include httpd_can_check_spam,
        httpd_tmp_exec, httpd_unified, or httpd_use_gpg

        This fix, however, also adds some not strictly related booleans
        to some man pages. e.g. use_nfs_home_dirs and
        use_samba_home_dirs are added to httpd_selinux(8)

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 68907a4f..f51256aa 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -335,7 +335,12 @@ def _setools_rule_to_dict(rule):
         pass
 
     try:
-        d['boolean'] = [(str(rule.conditional), enabled)]
+        d['booleans'] = [(str(b), b.state) for b in rule.conditional.booleans]
+    except AttributeError:
+        pass
+
+    try:
+        d['conditional'] = str(rule.conditional)
     except AttributeError:
         pass
 
@@ -440,12 +445,12 @@ def get_conditionals(src, dest, tclass, perm):
                 x['source'] in src_list and
                 x['target'] in dest_list and
                 set(perm).issubset(x[PERMS]) and
-                'boolean' in x,
+                'conditional' in x,
                 get_all_allow_rules()))
 
     try:
         for i in allows:
-            tdict.update({'source': i['source'], 'boolean': i['boolean']})
+            tdict.update({'source': i['source'], 'conditional': (i['conditional'], i['enabled'])})
             if tdict not in tlist:
                 tlist.append(tdict)
                 tdict = {}
@@ -459,10 +464,10 @@ def get_conditionals_format_text(cond):
 
     enabled = False
     for x in cond:
-        if x['boolean'][0][1]:
+        if x['conditional'][1]:
             enabled = True
             break
-    return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(map(lambda x: "%s=%d" % (x['boolean'][0][0], x['boolean'][0][1]), cond))))
+    return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(map(lambda x: "%s=%d" % (x['conditional'][0], x['conditional'][1]), cond))))
 
 
 def get_types_from_attribute(attribute):
@@ -716,9 +721,9 @@ def get_boolean_rules(setype, boolean):
     boollist = []
     permlist = search([ALLOW], {'source': setype})
     for p in permlist:
-        if "boolean" in p:
+        if "booleans" in p:
             try:
-                for b in p["boolean"]:
+                for b in p["booleans"]:
                     if boolean in b:
                         boollist.append(p)
             except:
@@ -1141,7 +1146,7 @@ def get_bools(setype):
     bools = []
     domainbools = []
     domainname, short_name = gen_short_name(setype)
-    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x and x['source'] == setype, get_all_allow_rules())):
+    for i in map(lambda x: x['booleans'], filter(lambda x: 'booleans' in x and x['source'] == setype, get_all_allow_rules())):
         for b in i:
             if not isinstance(b, tuple):
                 continue
-- 
2.37.3

