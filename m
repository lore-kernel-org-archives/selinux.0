Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A323C433F5
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiAZU4b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiAZU4a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 15:56:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49295C06161C
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:56:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ka4so1111952ejc.11
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kQGUfbOiSlrXMWUB18ru2iMPwWDRo+fWaUgVereZ2qk=;
        b=wLSlYUEyQWUG6vKfQCq9KI7LXIXNt34AGU/mX3JinGyH12FdYVo8kEIoeU60EXb2mZ
         MlkSLV03PttxOVmBXcXapCY45/8sfSGnRCQjsFMu2jR/es/RTBNUvz5qCi7OVf77WU+Y
         7TYrLd/2nXd2fdynCbmwqrkopOJ//NxOX8JquCNQTFVNCdcvrovlNahGrjOeJCnWVe8T
         ClW8pOYYtQoYXf0ySW5WvNAvhg5ri22vqrNO95dE5Gs7F5hkx3tqm+WgAToLfQzKE1dJ
         ysuu8e5xSzUKHCAkUkWox443UH/2Wm/qo5oSTcrFa5gLXa+XOi5duQcq4910WWaIEkD7
         WRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kQGUfbOiSlrXMWUB18ru2iMPwWDRo+fWaUgVereZ2qk=;
        b=ANU2H3e4MVIA3g48j3D7TPXhqWgehswGmmCmFyVeLbql7+P8FAfjI6RvPn7vRh1M1K
         mxBqi1+4Aht47sRjUrKG9BybpoILZvf1w5HFbW8Wh66jHWFghTpeuqlPzHPVgnp9ZOly
         MoAg48jvOwCsK77WWuARQgI+BqxZ4GEMvThGBUzvQiJAjozPzJ7BaZQ4HwhXWzDGYqc5
         Y+3/bXRhENEjZd/kC5imdfyn9oKTx8HEd2CQz5gf0vKfrIKbLxKuqDmpStyP+3YS3Msq
         bMHeVs11JlBXAEhsMjLpfK5P49/hKeE0nEH/ia+8t7IZqiPE3XJgKhdj9YzBppFqtyDm
         c6HA==
X-Gm-Message-State: AOAM533WqtWpoy53ug4dq8aUlZ5T7+YxW2jfeim+42x0QThdNZU46TEq
        XaSBgnieHb2r4xqGODItCx8/PlNK6+mxsqaId8zQ
X-Google-Smtp-Source: ABdhPJyPolSj1HislWpwcc7wwWj76EMmcvl2tq9+mcpygxOEbytuu7jmEd/aqFx0WAIvqedUrEaqZY4du6iFu3T5ETM=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr504091ejc.112.1643230588804;
 Wed, 26 Jan 2022 12:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-6-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-6-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:56:17 -0500
Message-ID: <CAHC9VhQP+xpEQCppx-Qvyd0hW9rcANfaw9F6972zo2PwCk_ZyQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] selinux: do not discard const qualifier in cast
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not discard the const qualifier on the cast from const void* to
> __be32*; the addressed value is not modified.
>
> Reported by clang [-Wcast-qual]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/netnode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged, thanks.

--=20
paul-moore.com
