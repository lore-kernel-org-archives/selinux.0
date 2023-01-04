Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A2C46467
	for <selinux@archiver.kernel.org>; Wed,  4 Jan 2023 21:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjADVMN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbjADVMM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Jan 2023 16:12:12 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3451B1CF
        for <selinux@vger.kernel.org>; Wed,  4 Jan 2023 13:12:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vm8so78772732ejc.2
        for <selinux@vger.kernel.org>; Wed, 04 Jan 2023 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vn/j3HO4R+Fqz0tAXHoWVMSVrQI6RKRgcZz5IKNwn8=;
        b=FUKTwuHiia2yi2LL281niv4QOjaqlp16l6mYE4SvW03FbtCaX3aXk2/PtI+4KKlIz4
         a41cS7lEzvUwyEOAtOSbO/kqu818+2VqbxQTXzWdtuudCKjH/IeS+8Pfb0piDDDXWo8a
         q1JEZq7ssbpzRo5YyKJEXHG7gEvT4aSecqLumVvWsNy5gUc5MTSo+Mipieoxxk1p/nG1
         24upr3zCmkCjo1VbnA0gllxdWN9+G7ctjhxxne0ll6hq01SE/g661/HxYDKxSlKsTXZ2
         8tfpTt/c24A/XzECJLtMVvauALHab9OcW5GiPr4nJ7Zg1072T72y7e8XDNz5aRbutuYw
         ZdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Vn/j3HO4R+Fqz0tAXHoWVMSVrQI6RKRgcZz5IKNwn8=;
        b=rlDAEgolayTU0FPiDTDVHndTtLWlYqyHQ5WilUd9nbiPkPvE2Rcq/OfmSGkkl93uYx
         32BNCQUMz89eAujxIBNL1EDp+9tDGULdus1qb1SDgbSHuMAC11cQGlVgTl9BueQG//Ja
         tN8l4orRkz9sPJRAQPwZBB6WKV9GnFJu7IVJgNXUa/OO7aiOV2p3b6QSBxirYHzN/5ly
         tuLPcVbvwRyPPAgl4GrDnsxmTVKuYFNLWBe12jcrrnLi09MJ5jSMZZewcpMmQ7VdagpN
         1I195eEy00UZkWT6O3UiBVZ3wBm7o2DxMUdSjmL5T8Le1n8QLbtt+w6ptZuL+I4ofUgs
         DRjw==
X-Gm-Message-State: AFqh2kpHK+2oYRuh1dk5yeY705VlbyPE5s83erLBzKQ0K/D+LljoaWJY
        tu9y0zhWEXkanWydzrkW+SD4LRYPgDH4zBMQIl8=
X-Google-Smtp-Source: AMrXdXvgPqEUISYKzpeWsLHaumdmZsUtQP729fpzH/kLr+34/MCUsgl6jwyZ4UN2qlxGFbmiUKcNI791EfEDneA6gdw=
X-Received: by 2002:a17:907:584:b0:7b2:b992:694d with SMTP id
 vw4-20020a170907058400b007b2b992694dmr3147483ejb.651.1672866730346; Wed, 04
 Jan 2023 13:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20230103083200.168385-1-lautrbach@redhat.com>
In-Reply-To: <20230103083200.168385-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Jan 2023 16:11:59 -0500
Message-ID: <CAP+JOzQfZqXcdwNd6STsEAZ_Up+NZM34-YjJQ6Ws4ken5X8Wrw@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: Make generated boolean descriptions translatable
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 3, 2023 at 3:40 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 68907a4f9759..be89dd2f9928 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -1222,7 +1222,7 @@ def boolean_desc(boolean):
>          return _(booleans_dict[boolean][2])
>      else:
>          desc = boolean.split("_")
> -        return "Allow %s to %s" % (desc[0], " ".join(desc[1:]))
> +        return _("Allow {subject} to {rest}").format(subject=desc[0], rest=" ".join(desc[1:]))
>
>
>  def get_os_version():
> --
> 2.39.0
>
