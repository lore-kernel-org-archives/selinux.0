Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF4C4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 19:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6B7610FD
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhHXTBX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhHXTBU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 15:01:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648D5C061757
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 12:00:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w4so37874879ljh.13
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnCasoco3ckaORmWO95aLHark62BOTSjMqhZfShSZPM=;
        b=lT202zeP80n5Qt/h5qQA5py8P8a+Yqs7l+HU+aqM0jBRKNMHuGLpIBrM1kxXNhllTU
         rfhqMZugkGpd7XXI5sBrFHDkHgiQaUBB3Y8CTyjSfcCbT/Mg39tKD+LCMI1mSdXyxfYB
         TfZtlU1Iq4sSbb6xKClnxLfeZqo2EPPehqTpPZoC+B2iwV32BA/y7GaIRSDuI38LnqPz
         SZnzuKVzZUel2Ol85hdNOR0ZT982hNbXDBO3ydV8P9knvBcFMMn2+mLNRiJDM2/UVdUQ
         iyIjQcUc0kMy69q4usjc72oDB6nkZAuXLFuNmeNf6jUdAC2POuUUghy6nwbWDxyxO1qG
         2ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnCasoco3ckaORmWO95aLHark62BOTSjMqhZfShSZPM=;
        b=LXbcT4OWmU8YJen98xnPQ2ufM8HydBUotgvH1KjIIbu0SCy8KRHdeu0JceJuJKd4GC
         SgCq9tbD8V0BeoviVyo5GiKa4WRiTGHfyOU5uIkJhWMvdzEdf6SuxS2BeodQ5c3XomaF
         l2r9UYBCwxlD2QcCgxOCfTBTnKsKQDS95U3sNVUgaQoCfWx4oY165t8rQRCLjXCm+MzH
         ZGcy/Yt6wa5RnZNxuUQW3inqG9Zn6BnHVpQolUfYHx7ZM6N/h2VkWxGJqr27YAqKLafQ
         Vxi/Ae/f+HCMLff1aTST1Gv1AP07qmBcq1p9b1MxG1Dj3sN0vNzIWpoY4HjiaJQnK069
         t9pA==
X-Gm-Message-State: AOAM530Y0yLH4Ybme8rXeB2oqrtwsTMnU0HtYBfXAdX3JKoE+SHsoVaR
        deYacVUr9LCb8u7SY6ON8uCr9JRBhJ667nzNWkA=
X-Google-Smtp-Source: ABdhPJz334CRsio8uuNB2+MP76T2tg/s0PQlxPWbgubzdt6azhbf6PoqYCG17B2KD2UY++LTkCMzYcWctaVxmBnnnOQ=
X-Received: by 2002:a2e:5345:: with SMTP id t5mr14575208ljd.20.1629831627794;
 Tue, 24 Aug 2021 12:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <f505f5bd-437a-2e38-5a93-b4abfac9fe81@gmail.com>
 <CAEjxPJ4FsWcme+Pk+OqZzG6M3p27Fs+8C4oMCTTxPZVUS0uBzQ@mail.gmail.com> <1f201b52-a7e8-f41a-e951-dc08e01a07b2@gmail.com>
In-Reply-To: <1f201b52-a7e8-f41a-e951-dc08e01a07b2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Aug 2021 15:00:16 -0400
Message-ID: <CAEjxPJ4rYn+n-0Pt+g79s75hja4RQ5WHiqh0j2epSkc6moMZyA@mail.gmail.com>
Subject: Re: security/selinux/hooks.c: FILE__ perms used as DIR__ perms
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 24, 2021 at 12:00 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 24.8.2021 15.47, Stephen Smalley wrote:
> > Some history and a few observations. These are the common file
> > permissions as declared in the common access vector blocks in the
> > policy inherited by all the file classes and as defined as
> > COMMON_FILE_PERMS in security/selinux/include/classmap.h.
> > We used to have COMMON_FILE__READ, COMMON_FILE__WRITE, ... permission
> > definitions as well but those went away with the migration to dynamic
> > class/perm mapping and weren't being used in the code anyway; we have
> > always just used FILE__x in the code when it was a common file
> > permission. execmod was moved from being file-specific to being
> > duplicated for chr_file to being taken into the common file perms
> > (b424485abe2b16580a178b469917a7b6ee0c152a). open was moved to common
> > file perms and the explicit per-class mapping dropped from the code in
> > 49b7b8de46d293113a0a0bb026ff7bd833c73367.
> >
> > Before removing a permission from a class you need to ensure that the
> > check can never fire. It isn't enough that the operation might not be
> > implemented for the object; if the permission check can be reached
> > then we either need the permission to remain or replicate the check
> > against the object type before checking permission and return the same
> > error as the underlying code ala ENOTSUP or whatever.
>
> Could there really be a case where a permission check for "execmod"
> could be reachable for class "dir"? Executing on some strange file
> system which does not distinguish files from directories?

Probably not. I think it is only applicable to file, chr_file, and
blk_file. That said I have been surprised before, e.g.
https://lore.kernel.org/selinux/20170512164124.16981-1-sds@tycho.nsa.gov/
