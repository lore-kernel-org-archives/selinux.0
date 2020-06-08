Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE3C433DF
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 12:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AED206C3
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 12:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0b5c4wO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgFHMSg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:18:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49478 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729310AbgFHMSf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 08:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591618714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hPecxYeYFwAmHQUMdwRBr+KDrfg7cGU76EWYcooZyik=;
        b=E0b5c4wO+dziIEOE0T7NYAlj5AtCG8s1VCJjhnqMe75u3i25fZD2EY1uDqa6hk5wU+aWA3
        ISYpZfqH98TRCwRq936PlCFS03TYZQksB8fCJYtPWJ7ISgH+DBGoKhnJdjLS5ZBPE0aqAp
        OsTLoTx8FfWkVNwxOaXE2Nz+ZIFzJ9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-aEQ8lvihP4i8HGlNjLy1lw-1; Mon, 08 Jun 2020 08:18:32 -0400
X-MC-Unique: aEQ8lvihP4i8HGlNjLy1lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB5E83DC10
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 757F8500DE;
        Mon,  8 Jun 2020 12:18:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/sepolicy: Use xml.etree.ElementTree.Element.iter()
Date:   Mon,  8 Jun 2020 14:18:23 +0200
Message-Id: <20200608121823.109113-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

xml.etree.ElementTree.Element.getiterator() was deprecated since Python 3.2 and
dropped in Python 3.9

Fixes:
Verify sepolicy interface -c -i works ... Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 691, in <module>
    args = parser.parse_args(args=parser_args)
  File "/usr/lib64/python3.9/argparse.py", line 1819, in parse_args
    args, argv = self.parse_known_args(args, namespace)
  File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/lib64/python3.9/argparse.py", line 2043, in _parse_known_args
    positionals_end_index = consume_positionals(start_index)
  File "/usr/lib64/python3.9/argparse.py", line 2020, in consume_positionals
    take_action(action, args)
  File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/lib64/python3.9/argparse.py", line 1208, in __call__
    subnamespace, arg_strings = parser.parse_known_args(arg_strings, None)
  File "/usr/lib64/python3.9/argparse.py", line 1852, in parse_known_args
    namespace, args = self._parse_known_args(args, namespace)
  File "/usr/lib64/python3.9/argparse.py", line 2061, in _parse_known_args
    start_index = consume_optional(start_index)
  File "/usr/lib64/python3.9/argparse.py", line 2001, in consume_optional
    take_action(action, args, option_string)
  File "/usr/lib64/python3.9/argparse.py", line 1929, in take_action
    action(self, namespace, argument_values, option_string)
  File "/usr/bin/sepolicy", line 216, in __call__
    interface_dict = get_interface_dict()
  File "/usr/lib/python3.9/site-packages/sepolicy/interface.py", line 149, in get_interface_dict
    for i in m.getiterator('interface'):
AttributeError: 'xml.etree.ElementTree.Element' object has no attribute 'getiterator'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/interface.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 7d4ebd7ecdba..bdffb770f364 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -146,12 +146,12 @@ def get_interface_dict(path="/usr/share/selinux/devel/policy.xml"):
             tree = xml.etree.ElementTree.fromstring(xml_path)
         for l in tree.findall("layer"):
             for m in l.findall("module"):
-                for i in m.getiterator('interface'):
+                for i in m.iter('interface'):
                     for e in i.findall("param"):
                         param_list.append(e.get('name'))
                     interface_dict[(i.get("name"))] = [param_list, (i.find('summary').text), "interface"]
                     param_list = []
-                for i in m.getiterator('template'):
+                for i in m.iter('template'):
                     for e in i.findall("param"):
                         param_list.append(e.get('name'))
                     interface_dict[(i.get("name"))] = [param_list, (i.find('summary').text), "template"]
-- 
2.26.2

