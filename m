Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B827C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 00:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5A022CA1
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 00:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUOOHTOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHGAVz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGAVz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 20:21:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F79C061574
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 17:21:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so63731wrs.11
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwItUOgNx85u5QZIQ4VOjuZBdBEzAvdaCSETt8ahY3s=;
        b=HUOOHTOjhFobum7n1FxSPal+6xOFjFHJ4KdS0H7W+nYIGtMNvuG6RtAWDbvRfRi0ON
         r3p8PkAPyykbju/M9pM+mqVPbykuZJ+c7T/2w1wt9VITrSqfM2RqDOqn7cXXRLbp3kK/
         xaxlqE39pxK4B109IawxwyTE8wJHK7VJ9zpH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwItUOgNx85u5QZIQ4VOjuZBdBEzAvdaCSETt8ahY3s=;
        b=gB0q76iKDjt2M+2Q3GoOxc9d1tYcaNh4klpZYp740ch7HmfBrufog4VxHGx7SMK2Zm
         VJ2jYmXhk5vx6zbPyuruax/T6Eg1g4JLYTJl9lOmekg1FuRWUGBN1GWTqW9S318Cvj+P
         tgNVCA5K1o3LhmSUPh46HN8b85IllBLHsBVnPjgzjV3mTXxEBCYksXj2NBB3ieZX3OJQ
         b5roqa+Tmwt3+rDDA8UtwkckMt5LTjmr7QkFDX34hrZtnIE4qJk8fh9fEkJVCSyKczGU
         sOUTsFXE4kah91MRudkgknDwhwWcTho5G0J2mOjhDv7188mBo1TwLCdxYcDyP9UjVroI
         pIYA==
X-Gm-Message-State: AOAM530jbVpxu7bqyIy6t3wKiTPamgyAfwjrkL/TuiKWhXrQD9vERXtc
        NOPanB4TJUMAp8QM5SII3eY1kA3x4SPIMQfJqnHzjqLnA9WfIQ==
X-Google-Smtp-Source: ABdhPJw7IlNrHiAatjwRzejW/qFOf8CuU+9oSt2zFkMHfDTIOYGDDIS1MZzK2AFyXhM1SERMQ4TPwB/50V0i6Q5JvOU=
X-Received: by 2002:adf:efce:: with SMTP id i14mr9666726wrp.359.1596759713673;
 Thu, 06 Aug 2020 17:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175845.1745471-1-keescook@chromium.org> <20200729175845.1745471-10-keescook@chromium.org>
In-Reply-To: <20200729175845.1745471-10-keescook@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 7 Aug 2020 02:21:42 +0200
Message-ID: <CACYkzJ6djhtZ2GUDZgf+YO-fXTFhmH9=Mu1t+3eAOosj=1kGhw@mail.gmail.com>
Subject: Re: [PATCH v4 09/17] LSM: Introduce kernel_post_load_data() hook
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>, linux-efi@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 29, 2020 at 7:59 PM Kees Cook <keescook@chromium.org> wrote:
>
> There are a few places in the kernel where LSMs would like to have
> visibility into the contents of a kernel buffer that has been loaded or
> read. While security_kernel_post_read_file() (which includes the
> buffer) exists as a pairing for security_kernel_read_file(), no such
> hook exists to pair with security_kernel_load_data().
>
> Earlier proposals for just using security_kernel_post_read_file() with a
> NULL file argument were rejected (i.e. "file" should always be valid for
> the security_..._file hooks, but it appears at least one case was
> left in the kernel during earlier refactoring. (This will be fixed in
> a subsequent patch.)
>
> Since not all cases of security_kernel_load_data() can have a single
> contiguous buffer made available to the LSM hook (e.g. kexec image
> segments are separately loaded), there needs to be a way for the LSM to
> reason about its expectations of the hook coverage. In order to handle
> this, add a "contents" argument to the "kernel_load_data" hook that
> indicates if the newly added "kernel_post_load_data" hook will be called
> with the full contents once loaded. That way, LSMs requiring full contents
> can choose to unilaterally reject "kernel_load_data" with contents=false
> (which is effectively the existing hook coverage), but when contents=true
> they can allow it and later evaluate the "kernel_post_load_data" hook
> once the buffer is loaded.
>
> With this change, LSMs can gain coverage over non-file-backed data loads
> (e.g. init_module(2) and firmware userspace helper), which will happen
> in subsequent patches.
>
> Additionally prepare IMA to start processing these cases.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for adding this! Would be really useful for us.

Reviewed-by: KP Singh <kpsingh@google.com>

> ---
>  drivers/base/firmware_loader/fallback.c       |  2 +-

[...]

> index 5de45010fb1a..1a5c68196faf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4019,7 +4019,7 @@ static int selinux_kernel_read_file(struct file *file,
>         return rc;
>  }
>
> -static int selinux_kernel_load_data(enum kernel_load_data_id id)
> +static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  {
>         int rc = 0;
>
> --
> 2.25.1
>
