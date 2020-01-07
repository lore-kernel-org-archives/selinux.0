Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86DC33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF42146E
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="F1qqQkmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgAGQ1c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:27:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43080 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQ1c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 11:27:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so175833ljm.10
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMlqGm3qlVuBN+QTSp89ym99tgs0Xn22mS5YJSOJIuE=;
        b=F1qqQkmo7bvyvTMfEkZ+ris6dPJTHj3ExkkdWPiR3lbN0iEOvhoWc4ntZlWPGpTfNa
         P8zmMGHhM8LOZN85wUO07YVmbLFNXq3HNQVA1xO5+2SGdFCD+nQDLv7rXvibpv4bYco0
         ak2icDCgztr1TSCiDWL21uH4NkChNLAMYrHlOd44s+mZ9PwujIEqcBw/kGWPg7DTMZim
         5h5hBZhvU04KFfAxD7NTlaN56sRMoM3B2TMUtzpUUToOjeDdWF5WZy7REJuyXvxYFQNZ
         kU0X3i9MRZ3a1tptY/Nzf3jbnFsEJcOa0LfGY8ec4UAUa6szDpc9YZAstMLpkDsVAIit
         5P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMlqGm3qlVuBN+QTSp89ym99tgs0Xn22mS5YJSOJIuE=;
        b=EnM4NDInruQ6ONUrpuDTQJ5XduOb8jXvN0DXFeT8qL1N1+0+koEJ0ziQVRSUvm0DBn
         A2IwoBwKcv/eZDWjzHIPTJLBjUDbeuYLzZgFK+YuMhHtr8fvhDog4PQS82Yijvl6pkQi
         fT+Q0fdq7eqIKR7KhlHRRZZiCwwd1E9J6+vaBoDUcmpvLD6B6VEwKEDTjjgABMYurAVk
         MkS1gwvXrkkkVZ2V7CEwR0NGxrVzOoDxeyHsQCZ/kfw7nP/2q7zEiOjYOs+et5JRSrSS
         hMRQrkoMOtVGPKkXN/8s+/hOgCkJ7vTHbRZqOOWNVJ9IJMvE1cCFOcw2DdaMGLkbgpvc
         772A==
X-Gm-Message-State: APjAAAUeeCup2uRHysJl5ZFDTOGs65t5wLRwxbaicq4HscnnyqO43pgk
        M0QiCvdkR42zWUZCKaUkhy/2oG8PkQAb5sxT39M4t5ZhVw==
X-Google-Smtp-Source: APXvYqwx03tqM3zT/4C76KpgwppLkQmU9w4SWlhNFc6wp73vUE08h128SQiTS3gNwPRQIuRd+AjpUTDpGhjkpdGpTlg=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr186241ljg.126.1578414449769;
 Tue, 07 Jan 2020 08:27:29 -0800 (PST)
MIME-Version: 1.0
References: <1578326514-22012-1-git-send-email-rsiddoji@codeaurora.org>
 <CAHC9VhRROm6esDfhTc5DUuA9ocmFN5dUyXHHv+=neeW4km8DMg@mail.gmail.com> <54b618f1-879f-7233-b66e-0fa00c4cdde2@codeaurora.org>
In-Reply-To: <54b618f1-879f-7233-b66e-0fa00c4cdde2@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jan 2020 11:27:18 -0500
Message-ID: <CAHC9VhRr4qe-V7DncxySjmMhVR8+rXRf5ebxpFYBQrmjZHq3FQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 10:21 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
> Move cache based  pkey sid  retrieval code which was added
> with  Commit "409dcf31" under CONFIG_SECURITY_INFINIBAND.
> As its  going to alloc a new cache which impacts
> low ram devices which was enabled by default.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>   security/selinux/Makefile         |  4 +++-
>   security/selinux/include/ibpkey.h | 13 +++++++++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index ccf950409384..2000f95fb197 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -6,7 +6,7 @@
>   obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
>
>   selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
> -         netnode.o netport.o ibpkey.o \
> +         netnode.o netport.o \
>            ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
>            ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
>
> @@ -14,6 +14,8 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
>
>   selinux-$(CONFIG_NETLABEL) += netlabel.o
>
> +selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
> +
>   ccflags-y := -I$(srctree)/security/selinux
> -I$(srctree)/security/selinux/include

It looks like your email client is wrapping lines (above) and causing
the patch to be malformed.  The documentation that was mentioned
earlier has more information on how to send patches properly via
email, it also references a second document with more information on
email clients (Documentation/process/email-clients.rst).

At this point I would suggest that you send the patch just to yourself
first to verify that you can apply the patch directly from your email;
once you have that working you can try sending to the list again.

-- 
paul moore
www.paul-moore.com
