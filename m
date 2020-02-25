Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D428FC35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F5321556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjJob2xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgBYUCf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:35 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41306 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgBYUCf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:35 -0500
Received: by mail-pf1-f174.google.com with SMTP id j9so110456pfa.8
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXSS00ZAZsFLLPDoa9ybt5zPiHlzpNw+yzNlvL1aL5c=;
        b=DjJob2xcy1BgDLsaw26TDgAcy03nCngisgIA4fLyxiISRnTooR10Fek0TWvnNBmDCB
         DAIEnhgK1LC2fjT4eMvwFw+v5FNYpnqQwmHU5AfVe9hjTQt1ZxUollOqu2W3B/wOoVe4
         Odtmy4Ale7INdME2IZSDKQ4TT02pozuQiuFfLEqXPACx2JweCDyVy5TAdpyAGwHxFWYC
         N1nMBdV0I2R9UOTm331Cg8iwNyEoMfZME5i1w4E6CQaPsBTonjgWEGz5hpuBNBZUeHiw
         7o+1pVDH4hnmmsQ/28BERpFur+0NPOL3hwtzdtEN+xKJZ29cojzy823uBtCpAbnfPC2l
         Q7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXSS00ZAZsFLLPDoa9ybt5zPiHlzpNw+yzNlvL1aL5c=;
        b=NoHPj6AajPZLGA99QH04CPQNFQ9Oys0IR5R+CB5gLz9kaidIqSp1xe4ZoINErXQ+Q2
         o8Q+WtdaaKoOh684ohISO0pvZfbVrgml6JrlsM9bonwW+Rl9cQqsV1I5WN65rVgQ/Yk+
         NI4glaceI3BcnGMZleKxyjHS1oxeEcsGITvG76TnJ5olQfptM9nOkI2+Hi7AHHNO0G/l
         vDZQpX0l7AY3gdGiZKi2mIOJiGJU6/qVmsLrWK24LiSYhR6jO37ttSsC6TgEduI+YIMa
         zxBsSzzanyE3BqgOxwDagJy6VTmtcL7B24c0pm2gqf2AygdyhGLGNa6PRkkwCoj7MTBZ
         LwdA==
X-Gm-Message-State: APjAAAUKp+1LmCeATgqxDZU5PhMSPgJMZ1Qhj7Sv3vGBGvZoD222MzZc
        45F7yXCo3kaTewyrSpn/XeUf5L1E
X-Google-Smtp-Source: APXvYqwwONs7mkZNJDwDdH0tSFN5BoeLyB404iSTy15bCFFMLoOJqW7s/O4OYvydkouKx3nUyVOS+Q==
X-Received: by 2002:a63:6841:: with SMTP id d62mr216987pgc.86.1582660953025;
        Tue, 25 Feb 2020 12:02:33 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:32 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Subject: Annotate Deprecated Functions in libselinux
Date:   Tue, 25 Feb 2020 14:02:02 -0600
Message-Id: <20200225200219.6163-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I went through and annotated deprecated routines we have in
libselinux that are mentioned to be deprecated either in code
comments and/or manpages.

External users, when compiling will see a warning similair to some
sample output:

a.c: In function ‘main’:
a.c:18:2: warning: ‘foo’ is deprecated: foo bar msg [-Wdeprecated-declarations]
  foo();
  ^~~
a.c:5:5: note: declared here
 int foo(void) {
     ^~~
a.c:19:2: warning: ‘boo’ is deprecated [-Wdeprecated-declarations]
  boo();
  ^~~
a.c:11:5: note: declared here
 int boo(void) {

The annoying part is internal users of the routines. We could always make
a v2 version of the function for internal callers, and leave the old
interfaces intact to work around the warnings, or just pragma them out.
This series pragma's them out.

diagnostic push has been supported since GCC v4.6. Earlier versions will
warn on this, and the sideffect is that the diagnostic ignored pragma
will be valid for the rest of the file. Clang has similair support thats
been around *at least* since clang 6.0.

[PATCH 01/17] security_load_booleans: update return comment
[PATCH 02/17] selinux_booleans_path: annotate deprecated
[PATCH 03/17] selinux_booleans_path: annotate deprecated
[PATCH 04/17] selinux_users_path: annotate deprecated
[PATCH 05/17] rpm_execcon: annotate deprecated
[PATCH 06/17] sidget: annotate deprecated
[PATCH 07/17] sidput: annotate deprecated
[PATCH 08/17] checkPasswdAccess: annotate deprecated
[PATCH 09/17] matchpathcon_init: annotate deprecated
[PATCH 10/17] matchpathcon_fini: annotate deprecated
[PATCH 11/17] matchpathcon: annotate deprecated
[PATCH 12/17] avc_init: annotate deprecated
[PATCH 13/17] src/selinux_internal.h: fix hidden_proto indents
[PATCH 14/17] selinux_internal.h: disable warnings on deprecated
[PATCH 15/17] avc_open: mark allowed use of avc_init
[PATCH 16/17] src/matchpathcon: allow use of deprecated funcs
[PATCH 17/17] utils/matchpathcon: allow use of deprecated funcs

