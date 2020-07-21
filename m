Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D384FC433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B106820792
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVDkrmeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgGUNIk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGUNIj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 09:08:39 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB853C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 06:08:38 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h1so14998484otq.12
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YApAtrzJ40CjxDaMBdoJbZH16EVTDRh3HZoFd5Nx2hk=;
        b=KVDkrmeHodcT5zqLGynbb301lYitulXeuhOlaOmNgNMuotbKh0edjQ4apMnMJtq60L
         tI6iH67vZAfMKGkhGJJDFtq2ur6KGE4qNsXAqgH++H5gWY2cGV2g0ZoNRDNCaiOJ/0ov
         TX1I7zhBhEN9aUlLhVaDeOeOzuJDkbidky9+MpMTFSJ0qlnKRXsSJG08J/7NNlPezvGr
         5hB5xe8f7JANAZ+4G9y8kVVzBvtbspfiWKntLvtgqa6wTummkJ/bkH2cVPb64pwXdKXl
         cijQSxcRAuCfKe8uS+Ow2tzORow9K9RDKuWYxDd6WDscEujgQ2/RY0jZK3/yqhRhZa8X
         xdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YApAtrzJ40CjxDaMBdoJbZH16EVTDRh3HZoFd5Nx2hk=;
        b=TagkHW3XDNonVcpYf7Z6rzebaWAeNQFJnj8sEVBf0zVUB1vmgMKxeRAiWZzQAaD9IR
         HxaUun+0Dis3sQcXX3/DvaIMjm6djBsM+//SWwj+FGOBt3sjGMiTd+cNafV0IWcXZnzK
         mS3swvjorF0KAHttnBJM5mUz7byPtS9K3C3vTeT3Om624l2/rter8pxvyahPK+W9OhPk
         5NBPmU6K0z3DSyXoq7x5gTKoCeVKSMUNtVZS1sQvR9tFDYjcxoz8letMeQR6lSj1cAE2
         kHbLON1llT0S5o97VNaGe7RMk+nVVzwCBC8NfiUsuHUFAXK0nAc7OQI94YeG6tFQkgTM
         0ipA==
X-Gm-Message-State: AOAM5313SSgXttc9HXtpGFVF8eKe49viSSec1PL5j297w7+cvemj37mO
        eoYWFuFbxNPRkRNUEypjtgbyWk72ZesWLdwZXxZPyw==
X-Google-Smtp-Source: ABdhPJymsdUMZOlW/mxXjs18fGYHrGRRswo2OJBQbiJgVufymGiwlbEmoBVCffoCpPGT9gHGfplyc2p+ycAI5foxTjw=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr25033137oto.135.1595336918397;
 Tue, 21 Jul 2020 06:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200721112512.1906547-1-dominick.grift@defensec.nl>
In-Reply-To: <20200721112512.1906547-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 09:08:27 -0400
Message-ID: <CAEjxPJ6swWoPG_55QT8=GsoXkgiQD29=F1BhjHo2xLo6w-agXQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: fix inaccurate description in sestatus
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 7:27 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> strdup(selinux_policy_root()) does not return a path that can be used to derive "Loaded policy name"
> instead if returns a path that can be used to derive "Policy name from config file".
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

My only concern with this is whether it might break scripts that
extract bits of information from sestatus output by matching on the
existing prefix, especially since it has been this way for a long time
(approaching 9 years?).  OTOH, it looks like it was labeled "Policy
from config file" prior to that commit.  No strong feelings either way
except that we don't want to break things for users unnecessarily.

> ---
>  policycoreutils/sestatus/sestatus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
> index b37f0353..8b03b028 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -268,7 +268,7 @@ int main(int argc, char **argv)
>         free(root_path);
>
>         /* Dump all the path information */
> -       printf_tab("Loaded policy name:");
> +       printf_tab("Policy name from config file:");
>         pol_path = strdup(selinux_policy_root());
>         if (pol_path) {
>                 pol_name = basename(pol_path);
> --
> 2.27.0
>
