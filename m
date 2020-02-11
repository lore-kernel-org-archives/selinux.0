Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A95C352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 16:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F4D20714
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d9R/6apm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgBKQAX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:00:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37277 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgBKQAX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 11:00:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id s3so247399edy.4
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iAStRx1iBaEsWFxF3axNly8iHjztixjB5vHPTfoMpn4=;
        b=d9R/6apmZquFT95E5ABgH8ct/Nlu7FTJ8eIYGt3rJrl3bCG16cdFrW5jZZ+GQf/OJr
         W8Zl2WJlEcGi9Z9hlkYlMaU2yN++W+aE0/HHZyIiwfoI+JmLsH9kt+CLzt7WMZLWPmby
         oe9UNfQV2zzKoeO6jI7S1aL5UJdWzjV83V1YwHVnHP70afGNKsqLg2Jv+e85h4lZVQMt
         /l0UN8k/Dl367tKcUkf5tSPikg/BquFIY8+jXxoOOVFFJofEjykp+02UlUeuqmX4pllL
         gfjNOrO0+ZL9YYr3IvbHfkEpq0AKHkaCJQFFUFfv0O/lQKzA2D437X++9A7y5o9cIIOr
         srKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iAStRx1iBaEsWFxF3axNly8iHjztixjB5vHPTfoMpn4=;
        b=CYUziG3Mq+KdDzHfgrgqL/aaiQ1hJGY4JEnR45p8WqDq8y7r0k+SglrCjUBgvjT5Ec
         biccOj3cmpFx8HjZuPYYlgA7PKRQOQ3BvqTZPA+VkHbDBrXsSP+5xsmKuIfJce2qpyQN
         EW335qJJS+fnXWO4tK3LQM9JwoTfgJhfBdVuCXYCQQVY6tQGivMa9TQHMjAPJ6eGuQod
         6bayoywqj0klqCu1A8l7FhvJy9Dm+w6WiYae+WV1DhCNSZBnGMIbrTsDPN1FCFnE4/rL
         YzPeIDqCXWmnO4KD20Nj/wJ6JNH96OvPVBXDO2SWJJhJfkp2I/+A6U62OXuWhmkDSdus
         PPAQ==
X-Gm-Message-State: APjAAAVWeSLaHjZjXj1RScmgndQ8fH67W0d/rML9FqnHXZ304SziVvXv
        5xE2l8BSL/YyYSgVDRwdrfRL0iUVNF2K0NUWK2tvgpKCjNIP
X-Google-Smtp-Source: APXvYqwH0FCgMlZBy+HaJkeenAFpUFukaqDbD4x6mmE1Do6e9WStqO8fVErqtAXHyc+/UMGzU7yCiBJVE21LSGLEI2c=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr6298633edr.164.1581436821041;
 Tue, 11 Feb 2020 08:00:21 -0800 (PST)
MIME-Version: 1.0
References: <158143665924.193851.6057679833915268046.stgit@chester>
In-Reply-To: <158143665924.193851.6057679833915268046.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 11:00:09 -0500
Message-ID: <CAHC9VhS_rYd9kFnOS4pT6zcC_ejfBGBYYHF5zCX6O-rUDGK6_w@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add the quota package to the list of
 deps in README.md
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 11, 2020 at 10:57 AM Paul Moore <paul@paul-moore.com> wrote:
>
> From: Paul Moore <paul@paul-moore.com>
>
> The filesystem tests require the quota tools.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---

README.md |    4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

[NOTE: oops, if I don't send the mail from the top level git directory
stacked-git doesn't create the diffstat properly, I fixed it above]

> diff --git a/README.md b/README.md
> index 64f80c8..27c9d56 100644
> --- a/README.md
> +++ b/README.md
> @@ -54,6 +54,7 @@ similar dependencies):
>  * libbpf-devel _(tools used by the bpf tests)_
>  * keyutils-libs-devel _(tools used by the keys tests)_
>  * kernel-devel _(used by the kernel module tests)_
> +* quota _(used by the filesystem tests)_
>
>  On a modern Fedora system you can install these dependencies with the
>  following command:
> @@ -71,7 +72,8 @@ following command:
>                 attr \
>                 libbpf-devel \
>                 keyutils-libs-devel \
> -               kernel-devel
> +               kernel-devel \
> +               quota
>
>  The testsuite requires a pre-existing base policy configuration of SELinux,
>  using either the old example policy or the reference policy as the baseline.
>


-- 
paul moore
www.paul-moore.com
