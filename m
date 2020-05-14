Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D77C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9096C2065D
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 12:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgENMpk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 08:45:40 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:41418 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgENMpj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 08:45:39 -0400
Received: by mail-qt1-f179.google.com with SMTP id m44so1181955qtm.8
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 05:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1bnBX+nEZL4rwerrTF+qJONSPgHMv8eFlIR23YCTYxE=;
        b=ShOl07AEwmzCSvbtaNgihSzg8itYkfZYCOtYGqMxI9gTSioCH5w8dT37CCcSdeYoTg
         fb3mX2EiKOANvMq2U7+2t/IIpaI+8XM50xUWGiizCf4e7p8Er3jFvYWmRsk37Op+nBK/
         5dmmVFrvzl7Cb0guGIyw8Bo/qx6KGy4Tw+YqQZHID0fVgaopWutSIfmlShJqyJuLtkys
         9fIBpFFUPJCMR2NEJ3azGzyKB5zl5QWh3J/munZ+jECyV+zBrnQ5826ORj8SEB1QQroD
         oxG3uANdq0DFaaHzX2hi2rMnJqmfmbhkeXP9IRTFOrVijr38QWUSsIlOJU5tBYRWI6PV
         Q+Yg==
X-Gm-Message-State: AOAM531Q7+US2d/xdkfLo6BZ2lTS/xuhdYRUEmhphavUHCdDuNHcDAKL
        NKWEbYrO+O1KwyhrpqfndfPAx42AsynMafSwecaOrCIkOAs=
X-Google-Smtp-Source: ABdhPJyvkpE9NHwL8XQ7Ajosc1ODN87phP6NL8hjkJUJyMHSIGJLChPy8A3bvzRBD4hFrovVSEVuYb/gJjDekE1/klo=
X-Received: by 2002:ac8:6891:: with SMTP id m17mr2359332qtq.41.1589460337717;
 Thu, 14 May 2020 05:45:37 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Tagliamonte <paultag@debian.org>
Date:   Thu, 14 May 2020 08:45:26 -0400
Message-ID: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
Subject: Configuring MLS with a daemon operating at multiple sensitivities
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hey SELinux fans,

I've been playing with MLS on a test box. The "read down/write up"
model makes total sense, but i'm running up against an odd problem set
and trying to figure out how to best work this into an SELinux policy
/ configuration.

I'm interested in having a demon that operates at multiple sensitivity
levels depending on the security context of the peer network
connection (within the same process, ideally, otherwise maybe
threads?).

I'm able to use NetLabel and CIPSO to mark packets with the desired
sensitivity level, and I'm able to get that level via `getpeercon`
during a network connection, but that connection's context hasn't been
dominated by my process's. I'd like to either get that "combined"
context (for instance, if my daemon is s0-s3:c1.c3 and the peer
connection is s2-s15:c3, I'd like to see the value `s2.c3`), or to
actually assume that role (to prevent reading/writing where it's not
supposed to).

Has anyone done something like this before? I have to imagine yes --
but a lot of the docs out there are for things like HTTP Servers,
where you can operate at a high sensitivity for everyone, since the
only data you're writing out is high sensitivity data, and you can
read/serve any other data.

I'm looking for an example where based on categories, the HTTP Server
will only serve files contained within the peer's context's
categories.

    paultag
