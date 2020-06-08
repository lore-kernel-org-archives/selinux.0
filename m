Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F807C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108A1206D5
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOcoHWeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgFHP2E (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgFHP2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 11:28:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD8AC08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 08:28:02 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so13933439otr.12
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UM/G56AWoCA1pj+EF1FKO36UYu2T9pvOvP+K9ghgLA0=;
        b=lOcoHWeX603+g+Bb3N5H2BlUPW3rnhev7RNwj99Nb3u36JHbhBBY6CRnu06R4nZXAR
         pyrjAkcFStA8JRXF0prEIZBQknPMhp7O6r9PpManf7rCjj7xQ3I8yKNJp8bovPV3PIq5
         xHQ9uW/9yM5t8ydNRjHlX17gN8dYYTqR1bogMRPEMlx9G1v2ZvYVwFOa4LA/r9VAOFok
         PVB8PV0Z/BrF8iPuXVUF6nWD+kn+NBVqx4garjCEbtcyoownvCUG/8YmqFhUEdAmzlwn
         l38wgw9xcA65Pq0k+6/N0UUszx4DCUTxribE8LAjWd+S/UiuxDpdpSbGJIKfSNJZ4K4m
         qlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UM/G56AWoCA1pj+EF1FKO36UYu2T9pvOvP+K9ghgLA0=;
        b=D/d2667zNLdULfaztG4LWJlVwN4Qjd5VYjQY9AGnfkPuSdnXoDLCpnX6VNqc4XuZct
         We5ATipEH/vFmKZ4nc6xAuW3XYcLaUrBf/L9rkaYSdhwomQ5v5eNCIJ03ouaBvbQ8/Cd
         jSNd8coC9FA3H5itKPVeuzRoDOIEo/wRyostliEG4xUNvUo5PplmMj36fYhzoE37vdnN
         DreyQ/m+FRvMBUb6lP8PSUy1PvWRWwYbn0SbQotgL9rxJ2lvuKzTsjaFRmV/0uT93w84
         XTSC8g0Y0RUBKHmRcrQrwZiq/kflyJo+dgjPoB1Cm93/7pviJOooQEkYKhwJKUo1nzwP
         I8pw==
X-Gm-Message-State: AOAM530oO4VdTcGLtqY0nku8PsNx6649CDhLi30cl4ZzWUSg9knc94cL
        qblwC/mj+IOacM2/cmOPc4SoUpJFLRaixKgMIj8=
X-Google-Smtp-Source: ABdhPJwzSmM6sPygCsRJ6jRlA7mCxb2WLwyUDWhf6s0rczclhWHDF7QjWYlGMeeAKuuyNRl/S4uXdqBoNrMJMU7Zw3k=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr17024894otp.89.1591630081408;
 Mon, 08 Jun 2020 08:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200528125128.26915-1-cgzones@googlemail.com> <20200605144912.22522-1-cgzones@googlemail.com>
In-Reply-To: <20200605144912.22522-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 11:27:50 -0400
Message-ID: <CAEjxPJ6cmsJHD3DLURQT0Rvy98TFizDwvFK=FqPRKXm0TMdGYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sepolgen: parse gen_tunable as bool
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 5, 2020 at 10:49 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently sepolgen-ifgen parses a gen_tunable statement as interface
> and reports in verbose mode:
>
>     Missing interface definition for gen_tunable
>
> Add grammar for gen_tunable statements in the refparser
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

NB when previously acked and no changes, you can include the previous
Acked-by line in the re-submission.
