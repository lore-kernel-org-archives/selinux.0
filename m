Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC675C7EE25
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEHUpR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjEHUpN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:45:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A61BF5
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:45:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b996127ec71so6827120276.0
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683578712; x=1686170712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Cv1UlCxeTALJV0mpB7xwgtp38ag2A9smSWsO8TW+Os=;
        b=Y0zETYFOVWWJb8oVNo3i9HEi6EVtXcN5LRJXHZAlghuoRskxv2ZhBUxGizvFE4Usxu
         wrJR8N5Wl7EHrvhkAntW3vD6VqCQjpXyBQoZAsdeVtagvODlKP1wgTrTQTZds0dj4Rd1
         3BQC2VPXTKc0xkNfaIlwNcvBoBWNLo49uGrVHnrkEGCRmyhYMKBI47Kmw2MHzeQSgl1Q
         eqUbW1vnx/WKWpirnIWTkvI7q7BcP/N27/GeFAETUliapMRzFnrTT+k1iSydL5hQ/w4B
         z0rlQkz3MVK0DsP3tLJVvQ11XZgPsrBfAiRJRi89O5LE2Ad1Mlo80P29m7UOhKLz8L7z
         UHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578712; x=1686170712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cv1UlCxeTALJV0mpB7xwgtp38ag2A9smSWsO8TW+Os=;
        b=G9dO8lxdwzig60v+JbM7WwnArvv8IgfMQ9ZSBP7oY3HjwLz166RJSRCCeQqu62SlWJ
         Q9zXQS9MLDKFYR+A3dkR2ATUvFk1lUmcZt9fEKGi3NxooE/143cjFNpIOO63qCv/MWAn
         N3tbG7D25Xj5pS7/zHvcatYhWuq4nII1y5at+4r2MhI3y9H1fSyjSlnBx/TKc/HD6lz6
         5RZFzA2QDhP3DUdlXKn+SSEhJw5cWDLQzlu0pqtf6B2ZoX3UFnchnfoHZx4YGwGNJ7ku
         l3YOkxN3RuqIHFYDGAkSk2BROcc6+vgvs1Z7dbLoJ3Iju/KeNOJu0OZbgvevR7Yd8gzx
         gMBw==
X-Gm-Message-State: AC+VfDxBagIvvi68p+YMnrm9QNebF/YxE8nSjezh9VxkwZWJBWvxWKmc
        GgjJiQSjlqPBG5Nxpo11GGNFw+5evQuf+XfvACT3
X-Google-Smtp-Source: ACHHUZ7xOEWMfDR4pPTPIUy0xczDmbm7X+ER0b5Mdf13RltwW9VrH+Maxw3eTFhZo1MJLgQmn09TzKAMCkq/Wpra3W4=
X-Received: by 2002:a25:41d0:0:b0:b99:370f:a35c with SMTP id
 o199-20020a2541d0000000b00b99370fa35cmr10477723yba.35.1683578712056; Mon, 08
 May 2023 13:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230420150503.22227-1-cgzones@googlemail.com> <20230420150503.22227-2-cgzones@googlemail.com>
In-Reply-To: <20230420150503.22227-2-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:45:01 -0400
Message-ID: <CAHC9VhQUQVc_oAHZ9zkQPczN4_zuO5wNpvpw+jErTbQCwSihHA@mail.gmail.com>
Subject: Re: [PATCH 2/6] selinux: adjust typos in comments
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 11:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Found by codespell(1)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c         | 2 +-
>  security/selinux/ima.c           | 2 +-
>  security/selinux/include/audit.h | 2 +-
>  security/selinux/include/ima.h   | 2 +-
>  security/selinux/selinuxfs.c     | 2 +-
>  security/selinux/ss/services.c   | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Merged into selinux/next.

--=20
paul-moore.com
