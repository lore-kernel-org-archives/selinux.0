Return-Path: <SRS0=8iER=XG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C4C49ED6
	for <selinux@archiver.kernel.org>; Wed, 11 Sep 2019 23:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E0D20872
	for <selinux@archiver.kernel.org>; Wed, 11 Sep 2019 23:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hlIxrC6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfIKX4m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Sep 2019 19:56:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36281 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfIKX4l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Sep 2019 19:56:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id l20so21836094ljj.3
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2019 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COe8HdsQEN2nHciuEkiYpNWcokiFVStPloCbIrXvFlY=;
        b=hlIxrC6He3JbzJaiZ6zUfK0iJtWasekNAkhiM9BpUZ2ztHGe6Z6VQ/G7aK62YyEKLY
         pEIMdQe75CDbV1mU9LsGRfEAL8r71k9hODrdyuGZL2BB+sbRIMBabwEYBcycMYSa8pgM
         kOmfdX/UJc5Ahc4qv3fLMEQEFZ+daqIVeVeBtFTaTPTkSK/6bLDeb48j9togPbqzD8T/
         AqDUGfxP9sTSz/kM5W08zG42fv8n5MBXKQM/YDoYD6OeBqe+1Q/Cj9/UZZw7Mej7J7z7
         rgFY72VQjBtrvWuphH+LEITWYVgeMwfQGBIhY8nBr89lBeBkqYOhcYldSClmo9WVeXzs
         YNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COe8HdsQEN2nHciuEkiYpNWcokiFVStPloCbIrXvFlY=;
        b=lNQt9LcvkmFfOwpALz9UKtK5IDtzm1//0+SYF0XfzkhHhaWA/9jOzTRIsLVHNSgkel
         iwnCI70v/ZSFAvM7weLv2R3+KjKdTPFbjb1BeEyVFbJtT1DK0GTIRzrZtHcXJe12YYYr
         LUwqR8S524TwqXN6CzlqrcOez6aU4XsX8rXDkpf9+2BxeZB4m812ggA658gGULlkPfbo
         phlEw/9hThuCWozikp4oLAk0IwxaE+t5mEv/86GwORoFvyV7XKce549C67P6waQJdzAv
         OV+k/iPPXuPMNfZapjQTrMwxZJSfz3H8nWijjEfxqoypWu1PEh1+7KMfDrkkppVueBAE
         UqsQ==
X-Gm-Message-State: APjAAAXgJbHvGikY61a5fLP+tOUJuFttYGtuFxt20nywEIKxbFLYRzJ0
        mOb0FddW9oGNKyk4kIsKMY2RAbNowktxQXbZ5Ovl
X-Google-Smtp-Source: APXvYqzcNadNRCfWEnZMa6nvjiQ9+p2MoSDwLg8OOLwtW6gr90SjTRjkzgC3uZBYOTmi5f6bnqIKJ0EozKU8ZUT67kI=
X-Received: by 2002:a2e:6e18:: with SMTP id j24mr359544ljc.158.1568246199620;
 Wed, 11 Sep 2019 16:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190819193032.848-1-jlebon@redhat.com> <CAHC9VhSLc=ORU2CkJSHiCmzTENEjk5Sy-dK2Op1btWgr17DZfg@mail.gmail.com>
 <CACpbjYoR19bm2-DDJafnSNPcEt6XLK-ZFBCJ6=UpBQDmnSVKwg@mail.gmail.com>
In-Reply-To: <CACpbjYoR19bm2-DDJafnSNPcEt6XLK-ZFBCJ6=UpBQDmnSVKwg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Sep 2019 19:56:28 -0400
Message-ID: <CAHC9VhSf6bD7iLmFEp78RuUT5g+f0tC_90L5cQ7hB+vwzPjbKQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow labeling before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 11, 2019 at 5:28 PM Jonathan Lebon <jlebon@redhat.com> wrote:
> On Tue, Aug 27, 2019 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> > As I'm looking at this, I'm wondering why we don't just bail out early
> > if the policy isn't loaded?  The context lookup and permission checks
> > later in the function are pretty much useless if the policy hasn't
> > been loaded (they are just going to return defaults/allow), I think
> > the only thing we would need to check would be
> > inode_owner_or_capable().
>
> Yes, I think you're correct. Though in that case, would it make sense
> to just do the inode_owner_or_capable() check once upfront instead?
>
>   int selinux_inode_setxattr(...)
>   {
>
>     if (strcmp(name, XATTR_NAME_SELINUX)) {
>       ...
>     }
>
>     if (!inode_owner_or_capable(inode)
>       ...
>
>     if (!selinux_state.initialized)
>       return 0;
>
>     if (sbsec & SBLABEL_MNT)
>       ...
>
>     ...
>   }
>
> Hmm, though I guess it does change the behaviour slightly even in the
> initialized case by returning EPERM first where before we might've
> returned EOPNOTSUPP (I've seen userspace code which subtly relied on
> the order in which the kernel checks for error conditions). I'm happy
> to be conservative and go with your approach if you prefer.

Exactly.  I suggested the approach I did because I was trying to avoid
changing the return behaviour; unless you can prove beyond a shadow of
a doubt that changing the return values doesn't break anything (that's
a pretty high bar), stick with the conservative approach.

-- 
paul moore
www.paul-moore.com
