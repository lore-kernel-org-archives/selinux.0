Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EFAC433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 17:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6B260E98
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 17:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhJKRMM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJKRML (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 13:12:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B704C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 10:10:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g10so69709809edj.1
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3T0XXQ9iBmgBchuIgIIl9wx2la12Dzs8VkR/un8jEw=;
        b=ezJOM4hBes4xYUVhlKeDqbXlGycEoqtDLUNr+6lQJn9RmUus/42blIVIx2UaJr0Fhj
         5JeNZi1v3dL1xAkPppkoxi9ZnGx5IisQOMGR084jnNOE0COmma7UfMgRHeWf3w2KrIAc
         jYughpS9bFQjFrExAgVpLBjKsFAMrk03QS421wIIlLgWG9NFFm19AZ5u1k4CEbsJcc7P
         TVFzJaMs+CoWcygZgio9dchFuZPzhq118g80tPnCUu3KUN4MIkQLs7Xlr8ptvyFVQj/D
         5oJ9gBREkqv+6NSUW3WVRohXhxAGfE5CnRDhCF/YlBlOc3m+fCB1kgsc1cN27aJ4oZaM
         4B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3T0XXQ9iBmgBchuIgIIl9wx2la12Dzs8VkR/un8jEw=;
        b=5U/Uzf0YzcHL8xrzua2sA4ksvsZE2Bhke7Dv1nZo1eK7QdD/UNdspT2bQHIBUqsPIp
         RYX2k3sUg6Fqigv5dz5j+J1/HzHlLYQWqjl5N2Yz+zpQmfGQJJSOPWfSu0yVIJhSAxSv
         F5XqQsSgoEtx8QP4Jow4dOXKiiNOmsWodcv5LE+pfksjskxeWDFBM8qjhJOMHxPip04h
         XFYaQ0EKXHCkEK11dcwEMx7Sj7xsku8SnMX77HuhLsNwhRrS/HbHC4Z+xDBuncwS/A7I
         eAOUbVH4X1DQ9rgSqtpYdBvGWUSROys9OlEnC0+MT7Gkoj66UY5P2i/PTfQLhh7HQaeJ
         eSyw==
X-Gm-Message-State: AOAM533uLVogzAduF5tOx4JlqB+IY5juJtjY6q/2YNo5ilD0e7A3QfCa
        32Gt4BV+q8vlSL+/zRdXhCEr6gdEYJQQv7f4/3DR
X-Google-Smtp-Source: ABdhPJxgayxznnnxmue4CT3ei5lWb+27Pl8LfmJev+eNAqxOQ0N6p+h65bpmJOrt5jn5xhnm78bzY3GMjnEzUc4JNJg=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr26861071ejc.24.1633972209503;
 Mon, 11 Oct 2021 10:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211011142416.26798-1-fw@strlen.de>
In-Reply-To: <20211011142416.26798-1-fw@strlen.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Oct 2021 13:09:58 -0400
Message-ID: <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
Subject: Re: [PATCH v2 selinux] selinux: remove unneeded ipv6 hook wrappers
To:     Florian Westphal <fw@strlen.de>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 10:25 AM Florian Westphal <fw@strlen.de> wrote:
>
> Netfilter places the protocol number the hook function is getting called
> from in state->pf, so we can use that instead of an extra wrapper.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  v2: add back '#endif /* CONFIG_NETFILTER */' erronously axed in v1.
>  Applies to 'next' branch of
>  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/
>
>  security/selinux/hooks.c | 52 ++++++++++------------------------------
>  1 file changed, 12 insertions(+), 40 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7ebd45ca345..831b857d5dd7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7470,38 +7442,38 @@ DEFINE_LSM(selinux) = {
>
>  static const struct nf_hook_ops selinux_nf_ops[] = {
>         {
> -               .hook =         selinux_ipv4_postroute,
> +               .hook =         selinux_hook_postroute,
>                 .pf =           NFPROTO_IPV4,
>                 .hooknum =      NF_INET_POST_ROUTING,
>                 .priority =     NF_IP_PRI_SELINUX_LAST,
>         },

Thanks for the patch Florian, although the name "selinux_hook_*" seems
a bit ambiguous to me, after all we have a little more than 200
"hooks" in the SELinux LSM implementation.  Would you be okay with
calling the netfilter hook functions "selinux_nf_*" or something
similar?  If you don't have time I can do the rename during the merge
assuming we can all agree on a name.

-- 
paul moore
www.paul-moore.com
