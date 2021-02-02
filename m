Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FAC433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 07:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCB864EE2
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 07:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhBBHeY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 02:34:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47789 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhBBHeX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 02:34:23 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 854DD5653C3
        for <selinux@vger.kernel.org>; Tue,  2 Feb 2021 08:33:41 +0100 (CET)
Received: by mail-oi1-f181.google.com with SMTP id k142so7355341oib.7
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 23:33:41 -0800 (PST)
X-Gm-Message-State: AOAM5310n9FpZko17LIa2k9SWCpSxdUeeu/38n5e53K2v9uUwjl+jhKt
        LqCuzoQRsZ1/dzmbVAXCzW2Qh3qsP3GfHf7yW9s=
X-Google-Smtp-Source: ABdhPJyldyDVKW8jydI9+bvUrtiWeM3ZKLNW4FcRrXc3wcpBeiuAEvL6fgk3tiBnHv5cQsneh0annJ5pYHeeCbsMuzc=
X-Received: by 2002:a05:6808:918:: with SMTP id w24mr1896902oih.20.1612251220218;
 Mon, 01 Feb 2021 23:33:40 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 2 Feb 2021 08:33:29 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mudsPu6FDMY29oXUSVGA7ggqkXPu0RiXa=-=jqwCZzvA@mail.gmail.com>
Message-ID: <CAJfZ7=mudsPu6FDMY29oXUSVGA7ggqkXPu0RiXa=-=jqwCZzvA@mail.gmail.com>
Subject: libsepol: signed integer overflow in the HLL line counter of CIL compiler
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb  2 08:33:41 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

OSS-Fuzz found an integer overflow when compiling the following
(empty) CIL policy:

;;*lms 2147483647 a
; (empty line)

";;*lms" is a line mark which can be produced by the HLL compiler (if
I understand correctly the meaning of CIL_KEY_HLL_LMS in
libsepol/cil/src/cil_parser.c). The line number is parsed as an "int"
variable:

  *hll_lineno = strtol(tok.value, &end, 10);
  if (errno == ERANGE || *end != '\0') {
    cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
    goto exit;
  }

This code has another issue which is that it silently truncates values
to 32-bit signed integers on systems where sizeof(long) is 8, because
hll_lineno is of type "int *", not "long *".

But the issue found by OSS-Fuzz is that when 2147483647 is used (which
is INT_MAX, 0x7fffffff in hexadecimal), "hll_lineno++;" overflows the
capacity of signed integers, in cil_parser(), and this is an undefined
behavior. This could be fixed by limiting the number of lines in a
source file to some sane value. Another approach consists in emitting
a warning and resetting the line counter every time it reaches
INT_MAX. Thoughts?

For reference (and for the people who have access to it), the related
OSS-Fuzz issue is
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28751.

Cheers,
Nicolas

