Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F10ECAAA1
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiH3Upu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH3Upt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 16:45:49 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28775300C
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:45:48 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d15so6845375ilf.0
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lHTIJ24y+TUiykXtBPhQHQ3834MffSumqakMUKmFPZs=;
        b=kKB2l6IDxUO/uaXrexQbwxSp5n3dZlBnE2+snKsIIp8ntFLcTKLTdkKeLYRwyYzp46
         f5yMfJD9OfE629Jm3uvqZfYVtUBSXIzuzKyTZB6JpC/22MwkmqyUCGtvLlR0VLDGdsGn
         OAtEytq5iYd8uqzC1yI5ZiyjeP6c49uLyCwYXGBO09MPnXG+pTQj81/036FgNmxuBHWS
         DniXGqFSm6yH6K0AZY2XpImWWe8nLUD4Bj9B7gutxJxfnMOMgigZQhQ0zpuo2HAP/5ll
         DPg2VyMJb1OXEz7Ny9uCHeInd44VVebZwKglJTSUwYNFSuEa54jUw/d4k/ib8MncxrDi
         g8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lHTIJ24y+TUiykXtBPhQHQ3834MffSumqakMUKmFPZs=;
        b=49/GiayUvj0DdgS5lDvbt1e6ieWyrXwJP/14+hTz49Kh/1dPhTuZEDVXY4CalWW7YO
         jwIcUfUOijvO1W334eF0Cb5m9U0TUyW4azR2h1TnNMGQlOEEdgKE8cbJaLg/35LoSQUr
         fk0/0taJcSWsOiOROUBfktJKaMSF2RCGSQNwmXOVLQJlylGNe9Mx5/AH8gA/qIk+2N8Y
         DDIqZx6ETuBSEj8gTNqS6J2vISnHnCIm495swzx6ENGNMrVDMGJRjeHsj2yX8sjTRQNi
         YMKILWM+xq3Wy6XSyJqxMKHyp65nYLxfSNiAStR0/xO4pOr8u+sbVpUlM+IJoSM0movx
         ZVhw==
X-Gm-Message-State: ACgBeo1wsKGXTcSPI4VggDn2AKSuaE/QwCxkMuBWBWKcKmpX/tftL3NL
        ZO85sf8JDPz1Rodl0CrBwOEttNmDRuflKmpQQ0u+LxpkYTs=
X-Google-Smtp-Source: AA6agR6N5UGw7fQeo/n/vx6Znt9Jsc8K9ios662EeSTTAPOkFVNfDSNBKQTjCcjF5aMd4uTmB2KhfOJLO2Et+w8s8ZY=
X-Received: by 2002:a92:130f:0:b0:2e4:22c9:7721 with SMTP id
 15-20020a92130f000000b002e422c97721mr13628458ilt.34.1661892348115; Tue, 30
 Aug 2022 13:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <4ad30dd7-ec19-e88a-848e-98de8af7a16b@gmail.com>
In-Reply-To: <4ad30dd7-ec19-e88a-848e-98de8af7a16b@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 30 Aug 2022 16:45:37 -0400
Message-ID: <CAP+JOzS82HOzmEKbeofQGgWhf4mk76ywJ-2ogqYBJ4T_k29w_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] secilc/docs: selinuxuser actually takes a string not identifier
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 28, 2022 at 8:18 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Update parameter table and add note to example.
> This can very easily lead to confusion, because secilc does not reject
> e.g. (selinuxuser "admin_1" admin low_low).
>
> Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
> ---
>   secilc/docs/cil_user_statements.md | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_statements.md
> index d5674f12..45a52140 100644
> --- a/secilc/docs/cil_user_statements.md
> +++ b/secilc/docs/cil_user_statements.md
> @@ -429,7 +429,7 @@ Associates a GNU/Linux user to a previously declared [`user`](cil_user_statement
>   </tr>
>   <tr class="odd">
>   <td align="left"><p><code>user_id</code></p></td>
> -<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
> +<td align="left"><p>A <b>string</b> referencing a previously declared SELinux <code>user</code> identifier.</p></td>
>   </tr>
>   <tr class="even">
>   <td align="left"><p><code>userrange_id</code></p></td>
> @@ -445,7 +445,8 @@ This example will associate `unconfined.admin` user with a GNU / Linux user "`ad
>   ```secil
>       (block unconfined
>           (user admin)
> -        (selinuxuser admin_1 admin low_low)
> +        ; XXX: Because the user_id is a string, the fully qualified identifier needs to be used here:
> +        (selinuxuser "admin_1" "unconfined.admin" low_low)

I don't see this behavior.

The following:
(block b2
  (user user2_u)
  (userrole user2_u ROLE)
  (userlevel user2_u (SENS))
  (userrange user2_u ((SENS) (SENS (CAT))))
  (userprefix user2_u user2)
  (selinuxuser name2 user2_u ((SENS) (SENS (CAT))))
)
Gives me:
name2:b2.user2_u:SENS-SENS:CAT

It works with quotes as well, but it doesn't require them.

The following:
(block b3
  (user user3_u)
  (userrole user3_u ROLE)
  (userlevel user3_u (SENS))
  (userrange user3_u ((SENS) (SENS (CAT))))
  (userprefix user3_u user3)
  (selinuxuser "name3" "user3_u" ((SENS) (SENS (CAT))))
)
Gives me:
name3:b3.user3_u:SENS-SENS:CAT

Thanks,
Jim
