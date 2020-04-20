Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5383DC54FD0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278FF2080C
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HDORczxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDTShd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDTShc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 14:37:32 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9386AC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 11:37:32 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id i185so2876726vki.12
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNKybJJ3wQfzYalcl0i/hFwKH103yWMJw4qY4gYESyI=;
        b=HDORczxia3AmlCLQXjC+v1iGvw2jluvZlIJqTk4PNa0jy1IZJvaJ3AdsirncMKvepe
         7hJX3BbQRkUrPVYGirVk0t3QtwXCIPpUgh5vDGZjNRl4wgKWuXYI8HvVJmo1JEdgkUqY
         uiBQxxqvtPkJh0W475W2FIsRSDvLTHajKf99htgW0NdM2LOQ7kee1AVKO795eUb+iszn
         Ku55yt6BY0n6f1aH0R3+Lc7lKIxcoGEQaqSvdm8MyZ4UGJkQbzgXVGQKdt/anmCrdjcj
         +BOLqcqTaJQ3ZxOrK67MTGX2s4vAVo/R4HjQPAFdkcVSkA9zXPJMj4dYOIiI1PPyD8ME
         f0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNKybJJ3wQfzYalcl0i/hFwKH103yWMJw4qY4gYESyI=;
        b=Xjn/AIk/lk6QT/yYqewa6GgnqT3oSg7VdmGzZe5BZM5wqvAXLTnPIx22pWFPQyJXh5
         VF+X25ru95Kb2uqIrWHqB2bh7YDaFD+CKXz+AGF8s5PkiGQIA13I75ypzJXLOXaxnlxY
         NNzlfxSWWSSvtpA8ib8ByuUrIJPhqW1LiN44fzUk9pxuXQtMUeTNI7rKyT02YJKDq5FQ
         339Yn0DaQ7Yz0R4cc82JZMILfeU68F3dXOtdh12fArA4+iujYo1IOkoBnZfLtQyXJfYQ
         nnP/jtp+mLnSs7ayytSkNR1XiI9ryhFRyMK1Wvq66yYcfEFgi+ShGKjyXENjAF4aXHWi
         EFLw==
X-Gm-Message-State: AGi0PuYPwv3npThM4XJu8ZePoPZdHSU6FK+L/izbCvAAEDb5GhRtDUeZ
        GuOH9AKHJvnWMtXX2XLV29y7KiKY2GZJpxGOa54=
X-Google-Smtp-Source: APiQypLNvkNzGIukaDycH+Yw+PnzRXg7VZNUMc2OWutFb5OB9+3/7DeWaSv4NfLA6ldpq3T83cWUq0NkjmRg0XNSZtI=
X-Received: by 2002:a1f:9182:: with SMTP id t124mr12192774vkd.38.1587407851316;
 Mon, 20 Apr 2020 11:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200419140055.86159-1-nicolas.iooss@m4x.org> <476DC76E7D1DF2438D32BFADF679FC5649ED3B7E@ORSMSX101.amr.corp.intel.com>
 <CAJfZ7==KyK=+AE8+tojCbZRo-UnB-QwEgL8tseLSfq73kL+mQg@mail.gmail.com>
In-Reply-To: <CAJfZ7==KyK=+AE8+tojCbZRo-UnB-QwEgL8tseLSfq73kL+mQg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 20 Apr 2020 20:37:20 +0200
Message-ID: <CAJ2a_DcwDeMcF6XTokC=y41uyTgC2-oG0ZpEGYqD2t5QkBMJ1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] python/semanage: check rc after getting it
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     "Roberts, William C" <william.c.roberts@intel.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mo., 20. Apr. 2020 um 20:30 Uhr schrieb Nicolas Iooss
<nicolas.iooss@m4x.org>:
>
> On Mon, Apr 20, 2020 at 4:29 PM Roberts, William C
> <william.c.roberts@intel.com> wrote:
> >
> > We should probably add the checker so it comments on the PRs. It would have caught it
> > Before it got in tree.
>
> In this case, the bug has been introduced in 2008 ;) Anyway, I have
> never configured lgtm.com to look on PRs, or contributed to a project
> that did this. For SELinux, I am wondering whether the hundreds of
> alerts currently reported in
> https://lgtm.com/projects/g/SELinuxProject/selinux/?mode=list could
> affect the usefulness of having it integrated to PRs.

I think lgtm.com only shows new issues on pull requests.
For example systemd uses it and I never got an unrelated alert.
