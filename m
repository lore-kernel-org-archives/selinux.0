Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8177C7EE26
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjEHUsv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHUsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:48:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750D59F5
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:48:48 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-55aa1da9d4aso90143587b3.2
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683578928; x=1686170928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkcNKakaDu+HoZoxB90Hwbbs1jnPzGJ6uGzyaBVrJ30=;
        b=YJZCdM1X8NICO6Nl/dFvu32eC4XRYPi+2QAs0NQERjfbG2/F4GtSQw8dmvuqDjs8mP
         aemX/zG6vOGzJml2VZ9I4xd51M9fpo5+0r3zL8axEb+77Whk6ZOJJlP26DtEB87c5vWd
         Ogk5F49uyEDbxjzXRN5+MCTYnS4QcpjV95TyzHmEuJuBLVV/i9AUi46w+tt9TFSMfuxS
         HO3YT8YXTX3an94GET9UefidUURTykK6M6zsrX17dSxTaFTFnA6NEQz7bEZl+NAzXvtD
         qV+gCAyny5/m7jZ+k6TWCg8oSBazO1MBgWrpeFqNwHjM9y9feiwIPGiqjWasmyYxyEZL
         pYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578928; x=1686170928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkcNKakaDu+HoZoxB90Hwbbs1jnPzGJ6uGzyaBVrJ30=;
        b=UzHBw5b6iMQQFnqRCFPAYmuWDiylUTMCIFGUbWEbDSvU01jJ7P/4RMo7/77pFFanhp
         T9hcBdZ8F5Qvj5kFkJlBLrC4th8nWdTd7uzRiBRHsRNTx+bJ69lZV3b245QFbYnCTvve
         NRbSELCDgVE9xN/mv4x5nCOQo8KHJAITx1rrh4JO2ipRUGDX2G7MJxZ9oq0Ng9jhuURt
         iV0eApAx0Uk1scGWuZTlLFLhR4ShAfa5upTJD+SdD5+MtbjeGxQuVnnLTptiFj44tcvG
         FJ+CCtJSisQk/vbTU422oaYT+4hhhvAJLPRy+yOjZu4ZIWM04HJxJFKjjK8BE0SjXqlK
         RJGw==
X-Gm-Message-State: AC+VfDxGMikswx353l2xkXYkUjUGfPzHyzggILyviA7k3F7qj+ItZo0R
        hNfeUx+a9jUbXNIQuwurMrwB7SoFvGi3HTFJQO4fTpoOQKNFrUc=
X-Google-Smtp-Source: ACHHUZ77eKlXWRuzE46t2uhlJyakXtXcZzA3ByeS7Oflxn+8QdR6JCt/YYBrKZIzr3iUikaPq4x27yrqb3tZJm3Fw+M=
X-Received: by 2002:a25:686:0:b0:b99:4d19:2b3c with SMTP id
 128-20020a250686000000b00b994d192b3cmr11691972ybg.2.1683578927905; Mon, 08
 May 2023 13:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230420150503.22227-1-cgzones@googlemail.com> <20230420150503.22227-4-cgzones@googlemail.com>
In-Reply-To: <20230420150503.22227-4-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:48:37 -0400
Message-ID: <CAHC9VhT5+RW-Ng5qkSYFbrROqEQYM1qaFxgh=xGS=49v7ZzDgQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] selinux: drop return at end of void function avc_insert()
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
> Commit 539813e4184a ("selinux: stop returning node from avc_insert()")
> converted the return value of avc_insert() to void but left the now
> unnecessary trailing return statement.
>
> Improves: 539813e4184a ("selinux: stop returning node from avc_insert()")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/avc.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/next, without the improves tag, thanks.

--=20
paul-moore.com
