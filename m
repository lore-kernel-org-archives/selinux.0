Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44548C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 00:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD7222CA1
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 00:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JpfLO58D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHGAWq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgHGAWn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 20:22:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9CEC061756
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 17:22:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so7587284wmc.0
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrwX/wfFzmOB6yLRhb7qEWgDu6TEjOMw7c5SuWROcuA=;
        b=JpfLO58DHRpIaearkFKOnrfvqBCUl0RamhydiUAyJKHTIjLYcYkw7jHOswLhEnvlz+
         42rMjdrWtq1srri4CwkYJOOZqz9/+yBOurDBNaTXbUNL7sGwOZSau9gPNwqlyl1D/7TE
         o5VG1NlGwBD81xYZqfeyR2hIsZ7Qv7Lk4Sk5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrwX/wfFzmOB6yLRhb7qEWgDu6TEjOMw7c5SuWROcuA=;
        b=qxma+ttP1FbJ+SDSL9kMsl4UsQ1xBmBkze8jLTnzSlgQqrMUt9N0n/85shW+Ik9wLE
         uP/f3WJ+ufS0AuBmmjcWZQId2kP74W+/VZRCSmwwB16j0NgEXLM8GJ41QtYtWXCFJecQ
         WgnSEbhGCkz9cr91QOURfqhJByPbPUkoUdnyk6pPppI/ymENKR7OgkhWBMDP8a/+gLQs
         7VxKVcp5cuo7NIpHjVoYaeQk2vsAQmAIcGYMh4KHt1V4tdHndaBny6qx7PbDYcF6FUdy
         szDo805SEX+4XGRSUZ2TOy1xiImSxf18hv3OYzho8jyKj27fJ2JsUtDWcK5B0LfIq1c3
         zZJw==
X-Gm-Message-State: AOAM530ZrOKiFLmjxUw1OR/xmEka4ud+TuZD/X1k7NeVCAlxLSokl113
        04J+OfuNpXKJoFYWplKmeppNkwgfsXpXj9LMI9IJXw==
X-Google-Smtp-Source: ABdhPJz2CSFYHBHps5lsYSSXi4LmfIaF9F6g3gv7J9WuzjjQKkuYj3RGkVMthT3YMgBgze8VgIBd8JCNOrPtY+ZUvC4=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr10198939wmj.56.1596759760832;
 Thu, 06 Aug 2020 17:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200729175845.1745471-1-keescook@chromium.org>
 <20200729175845.1745471-12-keescook@chromium.org> <20200805145342.GA22100@linux-8ccs>
In-Reply-To: <20200805145342.GA22100@linux-8ccs>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 7 Aug 2020 02:22:30 +0200
Message-ID: <CACYkzJ6dbUPydbg+HVt3toAPhgZAFut5Wt5OVckWMrKuPZ0ibw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        linux-efi@vger.kernel.org,
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

On Wed, Aug 5, 2020 at 4:53 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Kees Cook [29/07/20 10:58 -0700]:
> >Now that there is an API for checking loaded contents for modules
> >loaded without a file, call into the LSM hooks.
> >
> >Cc: Jessica Yu <jeyu@kernel.org>
> >Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

Reviewed-by: KP Singh <kpsingh@google.com>
