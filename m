Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927DC4363A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD20522460
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slEQVnRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463206AbgJWSGs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462850AbgJWSGs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 14:06:48 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B8C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 11:06:48 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t15so2178393otk.0
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rXP/hn/jMfaKsL2Q5jv5cEKxZQmIXrAO68Y6Mzzc4Lg=;
        b=slEQVnRtdyxuziwbcRLzcdl4jyOkEI6qWkaL1gwlUkFkeptGzvruf2fjEKfyRdqJu0
         1vce4UiJvg98OgMvMFb/IyAKwjOSRe3aRoay7vEeqlGAFwjmywNPWhvRhNpEaOeA+kcL
         lsct0gzy8o4Iw/0UM/0TmfSjXL826xsaqjSxquq/VSYdq46LXBLmmYmp+bwe1xfOv2UK
         jgiTYPEUtuKyWL7jhAQj5JV3rFpoBCvHSdZSavo4r0qirnwCeNLq0uuLBXf/98qFyOkM
         IqYrGvMhyCV6/5spmrL/98LptSadUDv6wHOzBzzSAKhjmT18+65GIIl4gdx+PhuYRzVn
         8ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rXP/hn/jMfaKsL2Q5jv5cEKxZQmIXrAO68Y6Mzzc4Lg=;
        b=gA4vdPidaLn1T7ukxF7Aikxe76oJDePIF3hMy6EuhHgKxQr8dld+9aRa8a9x3sNSwB
         a0vpFazkGU8kLyTXcVQeiFSd3MB/uZfo9sSrP3sdeLs7VZDS2U85Jttm8Lbr6lYSJ2ez
         T+5mTbknxwWVhTx4EFsZsR2DOJwFRarJndXAQNSrYxJdjMdGxf+0DGxV2Knht6AqUv2n
         Q5QQfr1SnUS+rHUVpZkyel6T82t00MOlO/LRp96Fs5d1EDNxqthlMvvvII7aKO0Ygy4M
         LJfAFjGmvORPtAno0Sg4+mG2ebKRh3gH0eXj0OqCZbMrKBAlYViYRZBAARRSNWceMjMl
         hagQ==
X-Gm-Message-State: AOAM532rJO006Arj25n/Cb6T3znfF36srwpIl2t18OQMG3IGWR1J9Y9f
        WSD/OlygBRN35XiXRiiM4iU0Q8/ZF3UDS1FhAc8=
X-Google-Smtp-Source: ABdhPJwXzpebB2tyCNDHzuvte1C5FT1RMLITBAn8gNGrIlpRSo7bgZ95quUowBt8eLaHRph70h49c0xxqsEOTf8yAJ0=
X-Received: by 2002:a05:6830:10d3:: with SMTP id z19mr2765538oto.295.1603476407571;
 Fri, 23 Oct 2020 11:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <08E7D9BD-ACF8-4DDA-85A7-52F5C89B274F@gmail.com>
In-Reply-To: <08E7D9BD-ACF8-4DDA-85A7-52F5C89B274F@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 23 Oct 2020 14:10:44 -0400
Message-ID: <CAP+JOzTd21176V19FkvVzSyp_qDE3KOH3QbmXpou3YRuJ8drPQ@mail.gmail.com>
Subject: Re: How to avoid relabeling rootfs at every boot
To:     Ian M <merinian@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 23, 2020 at 12:02 PM Ian M <merinian@gmail.com> wrote:
>
> Hello,
>
> I hope this is the right list for this question:
>
> I've got an embedded system that uses its initramfs as its root filesyste=
m as well.  At boot, after the selinux policy loads, everything on the root=
fs is incorrectly labeled as system_u:object_r:root_t.   I have temporarily=
 worked around this by adding a restorecon on the rootfs at boot, but since=
 the rootfs is a ramdisk the changes do not survive a system reboot.
>
> I may be incorrect, but my understanding (assumption?) is that the labels=
 would be applied when the policy is loaded at boot.  So I cannot understan=
d why the labels are always incorrect.
>
Filesystem labels are not applied when the policy is labeled. On
filesystems that support xattrs, a fs_use_xattr rule is used to tell
SELinux to use the label stored in the security.selinux xattrs, but
the filesystem will still have to be labeled initially. If the fs does
not support xattrs and every file can be labeled the same, then a
genfscon rule can be used.

I am not sure of your exact case, but you can find more information in
the SELinux Notebook - See
https://github.com/SELinuxProject/selinux-notebook

Jim

>
> Thanks,
>
> Ian
