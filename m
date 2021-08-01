Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36BFC4338F
	for <selinux@archiver.kernel.org>; Sun,  1 Aug 2021 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E17C60EB5
	for <selinux@archiver.kernel.org>; Sun,  1 Aug 2021 14:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhHAOcA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Aug 2021 10:32:00 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:54428 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhHAOcA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 1 Aug 2021 10:32:00 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Aug 2021 10:31:59 EDT
Received: from markus (markus.lan [IPv6:2001:985:d55d::123])
        by agnus.defensec.nl (Postfix) with ESMTPSA id C230B2A006A
        for <selinux@vger.kernel.org>; Sun,  1 Aug 2021 16:22:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl C230B2A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1627827756;
        bh=PcuutTOYlz2jJ84fMACZw3nATXke48r2Nl5Q8vAv1gk=;
        h=From:To:Subject:Date:From;
        b=qv5BTWCUdLr4Y6nJJ8MFMWyOArAD55hZVqK0YX9EOCiv723aW7WSJ3WB8HO+d1wip
         RPW6vdbosx5Ym6p5FgLCFkPrSSr6QoEoIm4GePHU+TctX7t9bh72kFARA0hFEe+7NE
         2Fc/szpS7nfGAedA6vuzPNoVK7qolBu1iAD2te2o=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: libsepol regressions
Date:   Sun, 01 Aug 2021 16:22:34 +0200
Message-ID: <871r7dtfbp.fsf@defensec.nl>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Fedora recently decided to pull in various libsepol patches from
master[1]

My policy has broken down in various way's. Some changes make sense but
some others I have issues with.

An example of something I never expected to be allowed in the first
place is re-declarations of blocks and recent changes exposed some instances
where I declared blocks multiple times and got away with it.

However I also encountered issues that i am not sure how to deal
with.

re-declarations of macros are no longer allowed:

Take this example:
https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil

Here I inherit a set of macros from the
"file.all_macro_template_chr_files" template and then I override some of these
macros by manually re-declaring them with slighty different content (the
xperm rules are appended).

This use to be allowed but I am no longer allowed to redeclare macros.

This would not necessarily be a big problem IF this would instead work:

diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
index 1c0fe66..4f067db 100644
--- a/src/dev/termdev.cil
+++ b/src/dev/termdev.cil
@@ -3,21 +3,9 @@

 (block termdev

-       (macro appendinherited_all_chr_files ((type ARG1))
-             (allow ARG1 typeattr appendinherited_chr_file)
-             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
-
-       (macro readwriteinherited_all_chr_files ((type ARG1))
-             (allow ARG1 typeattr readwriteinherited_chr_file)
-             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
-
        (macro type ((type ARG1))
              (typeattributeset typeattr ARG1))

-       (macro writeinherited_all_chr_files ((type ARG1))
-             (allow ARG1 typeattr writeinherited_chr_file)
-             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
-
        (typeattribute typeattr)

        (blockinherit .file.all_macro_template_chr_files)
@@ -33,3 +21,12 @@

              (allow typeattr termdev.typeatt
                     (chr_file (not (execmod mounton))))))
+
+(in termdev.appendinherited_all_chr_files
+    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
+
+(in termdev.readwriteinherited_all_chr_files
+    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
+
+(in termdev.writeinherited_all_chr_files
+    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))

But the above in-statements cannot be resolved.

This is not the only instance where this approach does not work. I also
have templates that declare blocks. I use to be allowed to re-declare
these blocks so that I could add to them but this is no longer
allowed. However these blocks also cannot be resolved outside of the
templates, so I cannot use "in" to reference them.

It seems as if the "in" blocks are resolved before the "blockinherit"
blocks are expanded.

[1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
