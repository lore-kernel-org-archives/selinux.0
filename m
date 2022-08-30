Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1482BECAAD4
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 11:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiH3LPu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiH3LP3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 07:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2655AC58
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 04:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661858124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rOWImMat0VPDPDR/sIJkmCit8ljEOwpnYIV+uAEt/qE=;
        b=PByxdbZN69CT7S9XyQV7lHkcZcBGgn/AuHAmK+JTvlmgNj+JbbDeYRM+IDJP7g+ZukbItz
        pshirGQlmeJC5nCPPuBSfOcIajUssZyI+gHRmHQXi57QWFoCsf5WgjFdkoiSU0PPj9su+c
        48SNk0VDbb2j95BrO92EmlFmBfhthDY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-288-vkTXhNhXOhSROpnlvZd0Ig-1; Tue, 30 Aug 2022 07:15:23 -0400
X-MC-Unique: vkTXhNhXOhSROpnlvZd0Ig-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-33dce8cae71so171235427b3.8
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 04:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rOWImMat0VPDPDR/sIJkmCit8ljEOwpnYIV+uAEt/qE=;
        b=JIsOJFvMQ5yXj+nsGLq0blvYNUWhnyp7tgn5rcf+qN8+dPLAWBZwhsEG69BrEDlm5/
         I7J1CoLRKnLOcBmLKg9UXKdGbhnZ/exCOBYANfLpFT2bxvK8AGTxKiLrW278fcrxnQ4E
         A6P+9m4noQL0pZ8iGBck3Y8/5YemmN47r9U2IDoQMP+LTAyNn0/XLXFzx3SMD1qstuIr
         2jO5zx3jvrQL94jw0cLBuuc1EV8k13RTQUaX2ZYwnlqK5WUzB8eCia8ewPGZK/x1h8wU
         nMbaRujq+unIeCN7xtXSCFBTrVelI1qKXx7Fv4lVfNJScM5MXTQ3ELGIK2RpdG66tmZN
         hrMw==
X-Gm-Message-State: ACgBeo0wsfpGCD30ZBRuPRzQS+oKvX5DGaLazhqBSxZS15plZQsp7kYf
        IE3ZcWy/ZL1QcFeOQaZ2a6F/KYpxcktUhyYB8DxzMH95h24IceSS8ftmxSXDL45wDQFjUl6zCKw
        baPDDGndPOMF99vbEUWHvRGer3A978WnBgA==
X-Received: by 2002:a25:d948:0:b0:696:6d66:6b01 with SMTP id q69-20020a25d948000000b006966d666b01mr11359573ybg.255.1661858122477;
        Tue, 30 Aug 2022 04:15:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5sd9+G6Ip71VJKH8ITqxsijbf/BZRqJ40kxDpzOo40sKZh7RMeopFaQq/wr/dSxAtoAeyZ+sSRa6vg+ecIvVE=
X-Received: by 2002:a25:d948:0:b0:696:6d66:6b01 with SMTP id
 q69-20020a25d948000000b006966d666b01mr11359561ybg.255.1661858122230; Tue, 30
 Aug 2022 04:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <166061510477.614432.940552725841920786.stgit@olly>
In-Reply-To: <166061510477.614432.940552725841920786.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 30 Aug 2022 13:15:11 +0200
Message-ID: <CAFqZXNvRysLGgU9K85egER6Y8sL1k=+LmKS6BtGqsVp=jOzizg@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH] tests/binder: remove stray flag files
 with 'make clean'
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 16, 2022 at 8:50 AM Paul Moore <paul@paul-moore.com> wrote:
> Failed or incomplete test runs can leave temporary test files in
> the binder test directory, remove them with 'make clean'.
>
>   mkfifo: cannot create fifo \
>     'binder/manager_flag': File exists
>   mkfifo: cannot create fifo \
>     'binder/service_provider_flag': File exists
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/binder/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/binder/Makefile b/tests/binder/Makefile
> index e78ad16..b89d4db 100644
> --- a/tests/binder/Makefile
> +++ b/tests/binder/Makefile
> @@ -18,6 +18,6 @@ endif
>  all: $(TARGETS)
>
>  clean:
> -       rm -f $(TARGETS)
> +       rm -f $(TARGETS) manager_flag service_provider_flag
>
>  $(TARGETS): $(DEPS)
>

Now applied as:
https://github.com/SELinuxProject/selinux-testsuite/commit/a262824a32b9af008302b4fa42f8c452e3f90c73

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

