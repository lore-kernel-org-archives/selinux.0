Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCD0C433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiDDVzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386472AbiDDVmp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 17:42:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5544C1EC6C
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 14:34:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so12647952edu.10
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzwUyuTI5gSLqTotPRzVG9YIm07ovz4YulzYRDgpudU=;
        b=XYhkRN8zHKNuTpYyHf/m75FKFfdLyDPCSnBAzycymo4yzHe57aEjX/WgnqUbN9ZT9W
         mwTZ+LJgDsQPNF6hbA2G3eQ3zzR5ShIr2w11jKQAUZMlvDt7G1cuhTabgmkkGpJStajE
         zsMsZIwBJm0WoCkwmfzoLejiiGk6JZn6ESj5R3hxg5zOIKbOGao/R9vud3sykfYNQK2m
         eSqeNXz5mAsmFsF/SyCKr/j8oDl3szFEr6sqHUwcmz+hOW6RcVw8clof1BtSs6U5ojck
         23I4YoPRUfPY+1LlMGpj8hnZZkOo8PBcDkKj9zvXUjDlbMVPwY26GXfFFS9YSE77CmI9
         Gfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzwUyuTI5gSLqTotPRzVG9YIm07ovz4YulzYRDgpudU=;
        b=4BzgplxX4fEtoM6C+kSJjaNS6KFl60uY7dnO+U3HFD6up3y3E/rBk/lOKlEjxXduRZ
         piyu+BIC4AwGUcjHQuczPPbzJNfNuCpFg4tLQTXqrRHRo5NmOQYEvi5RGmVKqBWmuCdm
         ZyL9ecHUaYqKEFns44qDHIvYNVVyPKTddPqZ1m7Dx3IITCnJRfA9rVZm0TmmHC81ASvL
         HxvXCjHOMS+tydkkS9+9p2ETZF0hcZDw8WZ4oscPDigCJ+kMUOAXqViVcyy3M8GJtT7G
         5xL1wcv9+9ejg4naWAuj8TObqbaqVpiW2ZFlxWnnrWr8PgsOId4kM2X9w1yvLa0IPwL6
         0xzg==
X-Gm-Message-State: AOAM532z5BN7YzCC3SQRqMIYtw3FwczGpAH9xqWYDzIdKR0yW73NFfko
        RuE2oyq5951xyczjncD6wosT/TKqTA+5JhA4rgVBrWF/lQ==
X-Google-Smtp-Source: ABdhPJwZUICQSBI6XZgNY1ZNtweE3kg7XsWpHKlPeM0jut/3YrZ9DYqcrIoZH9ClEjf9xGusEPO19RyVkbrR6FOEIxQ=
X-Received: by 2002:a05:6402:d2:b0:413:2e50:d6fd with SMTP id
 i18-20020a05640200d200b004132e50d6fdmr157380edu.171.1649108065797; Mon, 04
 Apr 2022 14:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220404083746.5929-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220404083746.5929-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 17:34:14 -0400
Message-ID: <CAHC9VhTP7Ww4G6wK3eFbkTkH1BRdP6f7LVzKfVYGdRNEUWMjkQ@mail.gmail.com>
Subject: Re: [PATCH Notebook] Reference Policy: Module versioning now optional
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 4, 2022 at 4:37 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Since Reference Policy release 2.20220106 the version_number argument
> is optional. If missing '1' is set as a default to satisfy the policy
> syntax.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/modular_policy_statements.md | 4 +++-
>  src/reference_policy.md          | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Merged, thank you!

-- 
paul-moore.com
