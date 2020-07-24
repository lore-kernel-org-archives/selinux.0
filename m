Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299AC433DF
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1FF206D7
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYVVkfxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXNNl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNNk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 09:13:40 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8FFC0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:13:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e4so7978744oib.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=To58rN8X5qRNMmVCcwN/9/UkQp4da7RkJJ449LbQhmU=;
        b=CYVVkfxWANZbxPA0aGrSAqBQ/DtWY2we2Rv0BwkypiXj73T0aw/rHUifjYvNIsAm1V
         2jG3adMi47chI/ov5vUsvz7Lym2FsTkTfm93olOITfrJKVIMleqckhMQdhjhJaWS93Oj
         S7/ovhER3+HKwtNi5g75qOrTXdji1IblsggQsdc7TFp58mJ09TLmMp4yZVSjUBj7KzfE
         LyjSfYko50xC6HnhKYFRq1NRLx8PO12AfVLuNPKXuF0rko5/0Oz0i4L6FzPAs/HfV0/h
         B8gJZza4RFGkSyWPhSvs0Eaa+LbzQje+El1baUCNOL/BkmSgDZDDDtw8RiT1hsi8tMF+
         6N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=To58rN8X5qRNMmVCcwN/9/UkQp4da7RkJJ449LbQhmU=;
        b=RNUZWDi8NIKR0HzqXnKzJC36B23Ob6+pVroKPrbXMzxuJwamYvR24mjIUDUF+Uvm9g
         +bPVeoA/AAOvhIh3FFMp3uULW8Qsh5esn2l1afSmb/IdO7wZKfFlWBrqvjR+g0qyGt/j
         y+SsoYIcJClgxtANR6Kyz4gebTb4lSojKOJBWwo2wlZ/aRJw0np056LAooFNN62Hja6Z
         WpqXDd5/NPZRsmTe8IACK5BNCLWaJlTD2O30QHcqQLwfiZalARzeDZq5HWb09tRjQZve
         JvNegHmfkM4wCniDYXUCRq5guYuedjwxFFEt5peUsNQLEIxwdgRt08VPD2X88prGVbTv
         qAOg==
X-Gm-Message-State: AOAM5303qD+AQpTekQT1FrQFJFSvuZscST/mpOKNA5buBEuqRw7VjMUS
        1J6f7DMWuD7gL0kSbYhxGrXspdtkQNfS/ySVo6s=
X-Google-Smtp-Source: ABdhPJyLabjt7kChPcb1CA7NzwFAPg8wk1v/Wqtz4YYGbGT00bRiTeBMfLRdfWJKgiG/nta7NSBA6S+EcPqLbdq/BKE=
X-Received: by 2002:aca:2807:: with SMTP id 7mr8087112oix.140.1595596419649;
 Fri, 24 Jul 2020 06:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2a_DfV0M1zD=fjQOGq3KPcBtvQxrgtZHSbBKDcxuOX7pJygA@mail.gmail.com>
In-Reply-To: <CAJ2a_DfV0M1zD=fjQOGq3KPcBtvQxrgtZHSbBKDcxuOX7pJygA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 09:13:28 -0400
Message-ID: <CAEjxPJ5nExmrkbgMfD2B9cs-iOdSAVnNfqcqbfns10vOa31=5Q@mail.gmail.com>
Subject: Re: getcon family: returning success while context is NULL
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 8:34 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Hi list,
>
> I stumbled over a systemd commit [1], handling the event where
> getcon_raw returns 0 (success) and the returned context is NULL.
> The commit points to the SELinux userland source lines [2].
>
> Is this by design?
> Or should either errno be set to ENODATA and ret to -1, or this case
> be mentioned in the manpage?

For most of the other process security attributes (e.g. exec,
fscreate, ...), get*con() can return NULL if the attribute has not
been set by the process, and set*con() can be passed NULL to clear the
attribute (i.e. reset to using the policy defaults), and this is not
an error condition.  getprevcon() and getcon() are the exceptions; the
kernel will always return non-zero length contexts for "prev" and
"current", so this will never happen for them (and you can't set
"prev" at all and "current" cannot be set to NULL/0-length).  They
just happen to share the same underlying libselinux implementation as
the others.  So this is not a possible case and doesn't require
handling.  I suppose we could make that clearer in the man pages.

>
>
> [1]: https://github.com/systemd/systemd/commit/199a892218e1f36e7bd7d5da2d=
78de6b13f04488
> [2]: https://github.com/SELinuxProject/selinux/blob/4246bb550dee5246c8567=
804325b7da206cd76cf/libselinux/src/procattr.c#L175
