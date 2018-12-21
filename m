Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F90DC43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5326D21929
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390647AbeLUUx6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:53:58 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36292 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbeLUUx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:53:57 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8D6BC5612AF
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 21:53:54 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id 32so6273547ota.12
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 12:53:54 -0800 (PST)
X-Gm-Message-State: AJcUukd2VC02o2uFIDTRa0jfPRCx//hoTI5FEEhmYVrNhKUrBDLaw7O4
        aDQHTFjqTNJBYPdLe7TRACQcvoqhN6Mmq1JVnI0=
X-Google-Smtp-Source: ALg8bN6ZQosia6SSp2y0yltAKwQLJGqL9OQHkd547KQlWiev2Gu6DOAHtSSKB/THyBH44Ui3MYjQXyC5KCNDaO5tvYk=
X-Received: by 2002:a9d:6c44:: with SMTP id g4mr2510233otq.368.1545425633522;
 Fri, 21 Dec 2018 12:53:53 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 21 Dec 2018 21:53:42 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kwP5YkjSQssxLR9--uZgfa3MgyM7m4Dv9_Z34cac3HTQ@mail.gmail.com>
Message-ID: <CAJfZ7=kwP5YkjSQssxLR9--uZgfa3MgyM7m4Dv9_Z34cac3HTQ@mail.gmail.com>
Subject: [large PATCH on GitHub] python/sepolgen: upgrade ply to release 3.11
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Dec 21 21:53:55 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,
I tried to send a large patch to the mailing list but it did not seem
to work. Therefore I opened
https://github.com/SELinuxProject/selinux/pull/117 and send now a
smaller version below.
Cheers,
Nicolas
----------------

PLY (Python Lex-Yacc) 3.11 has been released in February 2018:
- http://www.dabeaz.com/ply/index.html
- https://github.com/dabeaz/ply/releases/tag/3.11

Copy lex.py and yacc.py from this new release.

This fixes the following warning from "make test":

    python run-tests.py
    ../src/./sepolgen/lex.py:634: DeprecationWarning: Using or importing
    the ABCs from 'collections' instead of from 'collections.abc' is
    deprecated, and in 3.8 it will stop working
     if isinstance(t, collections.Callable):

(Python 3.3 moved collections.Callable to collections.abc.Callable)

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/lex.py  | 1298 ++++---
 python/sepolgen/src/sepolgen/yacc.py | 4930 ++++++++++++++++----------
 scripts/run-flake8                   |    4 +-
 3 files changed, 3872 insertions(+), 2360 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/lex.py
b/python/sepolgen/src/sepolgen/lex.py
index c13acef0507a..f95bcdbf1bb5 100644
--- a/python/sepolgen/src/sepolgen/lex.py
+++ b/python/sepolgen/src/sepolgen/lex.py
[Diff available on https://github.com/SELinuxProject/selinux/pull/117/files ]

diff --git a/python/sepolgen/src/sepolgen/yacc.py
b/python/sepolgen/src/sepolgen/yacc.py
index afef174849f2..88188a1e8ead 100644
--- a/python/sepolgen/src/sepolgen/yacc.py
+++ b/python/sepolgen/src/sepolgen/yacc.py
[Diff available on https://github.com/SELinuxProject/selinux/pull/117/files ]

diff --git a/scripts/run-flake8 b/scripts/run-flake8
index 207edd20dd89..6ad029fa6852 100755
--- a/scripts/run-flake8
+++ b/scripts/run-flake8
@@ -17,10 +17,8 @@ IGNORE_LIST="$IGNORE_LIST,E101" # indentation
contains mixed spaces and tabs
 IGNORE_LIST="$IGNORE_LIST,E711" # comparison to None should be 'if
cond is not None:'
 IGNORE_LIST="$IGNORE_LIST,E712" # comparison to False should be 'if
cond is False:' or 'if not cond:'
 IGNORE_LIST="$IGNORE_LIST,E722" # do not use bare 'except'
-IGNORE_LIST="$IGNORE_LIST,E999" # TabError: inconsistent use of tabs
and spaces in indentation

 IGNORE_LIST="$IGNORE_LIST,F401" # module imported but unused
-IGNORE_LIST="$IGNORE_LIST,F812" # list comprehension redefines 'f',
in lex.py and yacc.py
 IGNORE_LIST="$IGNORE_LIST,F841" # local variable '...' is assigned to
but never used


@@ -75,4 +73,4 @@ IGNORE_LIST="$IGNORE_LIST,F405" # '...' may be
undefined, or defined from star i
 IGNORE_LIST="$IGNORE_LIST,F811" # redefinition of unused ...


-exec flake8 --max-line-length=120
--builtins='_,unicode,lextab,parsetab' --ignore=",$IGNORE_LIST" "$@"
+exec flake8 --max-line-length=120 --builtins='_,basestring,unicode'
--ignore=",$IGNORE_LIST" "$@"
--

