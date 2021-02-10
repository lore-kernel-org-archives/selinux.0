Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE0C433DB
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 17:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A927164D8F
	for <selinux@archiver.kernel.org>; Wed, 10 Feb 2021 17:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBJRHE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhBJRHD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 12:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612976737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UhmuDTHpmOoLOnsyFTMm0qvPoPiKxmGQ4c7Oci/yjlk=;
        b=IvqbI0L+I5sWhGEaUB0xDahh3ZDNZlhgPEB7/VWduvVuBr/JyLpo4jGzD2zZTRlC7PnKEQ
        IYHa8DbY4Puynpf8eFpwOIF7rKSvwy2EHFWpCJPBz0pGF0Ez/RuV31sz+n1Tdgrw3OWzA8
        unhZMeO/DHPY9kXF7xIz6GGBaKqqGsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-ctQ3I0h6Oo6Z8ufQjIdqrg-1; Wed, 10 Feb 2021 12:05:35 -0500
X-MC-Unique: ctQ3I0h6Oo6Z8ufQjIdqrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5089880196E
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 17:05:34 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6378614FA
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 17:05:33 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux(8,5): Describe fcontext regular expressions
Date:   Wed, 10 Feb 2021 18:05:29 +0100
Message-Id: <20210210170529.1395705-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Describe which type of regular expression is used in file context
definitions and which flags are in effect.

Explain how local file context modifications are processed.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---

 libselinux/man/man5/selabel_file.5  |  9 ++++++++-
 python/semanage/semanage            |  2 +-
 python/semanage/semanage-fcontext.8 | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index e97bd826..baba7776 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -125,7 +125,14 @@ Where:
 .RS
 .I pathname
 .RS
-An entry that defines the pathname that may be in the form of a regular expression.
+An entry that defines the path to be labeled.
+May contain either a fully qualified path,
+or a Perl compatible regular expression (PCRE),
+describing fully qualified path(s).
+The only PCRE flag in use is PCRE2_DOTALL,
+which causes a wildcard '.' to match anything, including a new line.
+Strings representing paths are processed as bytes (as opposed to Unicode),
+meaning that non-ASCII characters are not matched by a single wildcard.
 .RE
 .I file_type
 .RS
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 125271df..18a27105 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -379,7 +379,7 @@ If you do not specify a file type, the file type will default to "all files".
     parser_add_seuser(fcontextParser, "fcontext")
     parser_add_type(fcontextParser, "fcontext")
     parser_add_range(fcontextParser, "fcontext")
-    fcontextParser.add_argument('file_spec', nargs='?', default=None, help=_('file_spec'))
+    fcontextParser.add_argument('file_spec', nargs='?', default=None, help=_('Path to be labeled (may be in the form of a Perl compatible regular expression)'))
     fcontextParser.set_defaults(func=handleFcontext)
 
 
diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 561123af..49635ba7 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -11,6 +11,24 @@ SELinux policy without requiring modification to or recompilation
 from policy sources.  semanage fcontext is used to  manage the default
 file system labeling on an SELinux system.  This command maps file paths using regular expressions to SELinux labels.
 
+FILE_SPEC may contain either a fully qualified path,
+or a Perl compatible regular expression (PCRE),
+describing fully qualified path(s). The only PCRE flag in use is PCRE2_DOTALL,
+which causes a wildcard '.' to match anything, including a new line.
+Strings representing paths are processed as bytes (as opposed to Unicode),
+meaning that non-ASCII characters are not matched by a single wildcard.
+
+Note, that file context definitions specified using 'semanage fcontext'
+(i.e. local file context modifications stored in file_contexts.local)
+have higher priority than those specified in policy modules.
+This means that whenever a match for given file path is found in
+file_contexts.local, no other file context definitions are considered.
+Entries in file_contexts.local are processed from most recent one to the oldest,
+with first match being used (as opposed to the most specific match,
+which is used when matching other file context definitions).
+All regular expressions should therefore be as specific as possible,
+to avoid unintentionally impacting other parts of the filesystem.
+
 .SH "OPTIONS"
 .TP
 .I  \-h, \-\-help
-- 
2.29.2

