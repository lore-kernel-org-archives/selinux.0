Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3760C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891820726
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWOzucg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFOvv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:51:51 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:38530 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgCFOvv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 09:51:51 -0500
Received: by mail-io1-f54.google.com with SMTP id s24so2323108iog.5
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 06:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TDx/VxCg5Zc27rTjXT6bK8FKSEDF3RqOooL1PqVfAOQ=;
        b=KWOzucg4AUrIIR/Ncs8APD0b7fA/iIC31XU5cQRSpdCs5uuhCn9k1TDS8sdlYv7HL/
         n0xPo3BdRWxkoK8TVWFJ0ECUHCE+9VW5Gj32+r/adk1c7Mhp+e8siJr5hapLTf05lUx+
         SBeX21rRgAY9CEjlabXpSuR6BNy78Us+CUx2RLqkpx50XzIjKgsyfHEYX5RJFqcTpnce
         Lz7C37gnIPYbA7SFu1QujAFpv2xr4qcoGdxMPGpY+xzuuucF2IJyFA/4rvt7yIRTIk4t
         DZY9y39+4SJRIJAwjcuZuquJwCmpTR535S7kT4PwRh1J1ikqYvyUWxsvSsAjZkD8XhiQ
         WByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TDx/VxCg5Zc27rTjXT6bK8FKSEDF3RqOooL1PqVfAOQ=;
        b=fVzDyTZSKIV1cLfnss+mervBBZQU5C2FvIj7iq7XbGuU6wm4mjBMpJ3ieUpKcx+B/E
         pH4LtY+ndZPzRCJOCrV5TQb7J0rIi4ZWUHIzHsU8Y0qR2CmVoPd5HsRpsXNcCeTd1L4g
         z2S3b/XOYesNOwuS+GxOsIw5oB9UxMxQBr8i/I4ZMkweU2/aXgu5Yz3gXE6bB2gN0Lkl
         VNxwq3Jp4U7UOp9DopUM6Qb9ntpVw1P0SpusN9PwWEKkpyQXqWlAn6Ug0lawC0SP1PGR
         SDGEVgN6BKfp5fV0tUhESPKxsxYAiQLBCn3HjBo34BQTnpu1yrD6F6odWdVzH9AUfXYm
         R0TQ==
X-Gm-Message-State: ANhLgQ27IPysfEI6TOK5T7hUM186syzuHrUJXCWGzSbRuVMaIKxGnwet
        NwdZ4gnbi0tQSP/UP8zkFDlEXM42osPmpZ5ziYT9p3YjPUA=
X-Google-Smtp-Source: ADFU+vuB02/CP7DtC3FAIehHmgZDsfMJR3AxD2V7VTm7wQjJ/CyAQBylD5tVsRYJkk1pwvCHVQQ9Pv+obgG5HxdWbkw=
X-Received: by 2002:a6b:7504:: with SMTP id l4mr3327722ioh.184.1583506310222;
 Fri, 06 Mar 2020 06:51:50 -0800 (PST)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 6 Mar 2020 08:51:39 -0600
Message-ID: <CAFftDdp8TtcWRSA2PPWGaq1SPB81y7cF+w3ThbKr-BniEx9Gmw@mail.gmail.com>
Subject: libsepol: drop dso question on CFLAGS (package maintainers weigh in please)
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The libsepol/src/Makefile has the below lines for CFLAGS:

CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2

override CFLAGS += -I. -I../include -D_GNU_SOURCE

Does anyone have a preference where I add the -fno-semantic-interposition?

I was thinking the conditional assignment because of the comment made
about packagers overriding things on the selinux drop dso patch
series.
