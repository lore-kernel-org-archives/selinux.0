Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6543C61D85
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 19:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKUTYc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 14:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUTYc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 14:24:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C112A
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 11:24:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28041176e77so4094325a91.0
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700594667; x=1701199467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2x7GX7+mJMdTH8cPBrS7Fy9mLlMjsavuCgRzJ4fQHYw=;
        b=Repc0iwa7qNEVLGIiLOUzll5RDtHRyyIhmHYSH14C1F8ryO9czPIhb95NA/1EjyDjv
         mAFzSgbqoJv6IPU3GngccK693/mNaAVBKYK+fI7qGbT32DZ9cD0+e9vENZMEWmCJ+w+V
         bG7vyZuAPcHLAa1X2WeG8aGL/olwIqhDRjpEpOO8C4Dsj9E9PgcH9kIKD4SDqkQsprJZ
         r3fWAdQk5FrVmpPkH5ehfINkTa4yTTVdx1znzFo1Wu+rxXvUPZ16AFbOlwLrrucaVXM1
         ESPD51g7+Ldn4Dix3zI++9WzV/zC79f/O1wTJGTOhOJb1ZijUty7GLVb+VOU7SdkMkSh
         cxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700594667; x=1701199467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2x7GX7+mJMdTH8cPBrS7Fy9mLlMjsavuCgRzJ4fQHYw=;
        b=K8KfCTfnkpr0hFbAfpk8H6b9cPTLDMTL7pVHWYPrFuof9tcAch42IobTOItfn1QrCv
         xEEMjxSUnsG6tWedKQvbrF4O+c9ENq/Febibnp3xYbeannQVw3NVuCPmoT8BYD0gs/DT
         6HsvaaphsbAd1M0ajI1TpWQtWvj061NHBPkDtEjN5ApxUn6KccC3c7aCl39wS6I4Huvz
         G0a4cnHJ/rjieGUMgn0z2Sh8DF2PBMQhbma4ZP2QchMVvmOre1s0SDtzAkkanXpLLL2l
         5HLqbc60/DmWvO0woSz7045ipSee4YPRmCF1dkv6KJ7pxTqCkyVV/VTQJYHOlUvALaVH
         7A5Q==
X-Gm-Message-State: AOJu0Yyeuw8H6mbf0VvJ+iIyB5OvTo57CyZROV0kGOjCcrbIAYWAev2i
        AVOoinfB7yDfiVs5kG/scIrpXIBLx2Z+LfUPwWs=
X-Google-Smtp-Source: AGHT+IG/Wf9JEZ5KLcIWft+AmGJmOzV+jBtdrfB/yT1K6pBysefLPmAq5qnTiN14h3fSo6H1pBZ1EH5Ikd5xiC4ov4g=
X-Received: by 2002:a17:90a:1d9:b0:27d:24d6:7343 with SMTP id
 25-20020a17090a01d900b0027d24d67343mr181823pjd.19.1700594667554; Tue, 21 Nov
 2023 11:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20231121122719.2332137-1-juraj@jurajmarcin.com>
In-Reply-To: <20231121122719.2332137-1-juraj@jurajmarcin.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Nov 2023 14:24:16 -0500
Message-ID: <CAEjxPJ5yxW0q9H1xAycP2JD4WbvaQKSmuhjYBrOkcBag9cN_Uw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: add prefix/suffix matching to filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 21, 2023 at 7:29=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Currently, filename transitions are stored separately from other type
> enforcement rules and only support exact name matching. However, in
> practice, the names contain variable parts. This leads to many
> duplicated rules in the policy that differ only in the part of the name,
> or it is even impossible to cover all possible combinations.
>
> This patch changes the filename transition table in the policydb
> structure into an array of three tables, where the index determines the
> match type for the rules contained (extract, prefix, and suffix match).
> Then the patch extends the functions that access the table through the
> policydb structure to accompany this change while reusing the majority
> of the old filename transitions code.
>
> This patch also updates the code responsible for finding the right
> filename transition based on the context and the name. The rules have
> the following order of prioriy, if no matching rule is found, the code
> moves on to the next category:
> - exact filename transitions,
> - prefix filename transitions in the order of the longest prefix match,
> - suffix filename transitions in the order of the longest suffix match.
> This ensures the compatibility with older policies.
>
> Without prefix/suffix rules in the policy, this patch has no impact on
> performance or policy loading times. Moreover, with prefix/suffix rules,
> the overall number of filename transitions can be reduced, which results
> in smaller binary policy size and therefore also slightly lower load
> time and memory usage.
>
> Performance tests:
>
> 1: Reference kernel (f5bbdeda34c63), Fedora policy (format v33)
> 2: This patch, Fedora policy (format v33)
> 3: This patch, Fedora policy without prefix/suffix rules (format v34)
> 4: This patch, Fefora policy with prefix rules (format v35)
>
>    | Mem    | Binary | Policy  | Create tty [1]       | osbench [2]
>    | Usage  | policy | load    |                      | create
>    |        | size   | time    | (ms/file)            | files
>    | (MiB)  | (KiB)  | (ms)    | real     | kernel    | (us/file)
> ---+--------+--------+---------+----------+-----------+-----------
>  1 |  298.7 |   3682 |  58.626 |   1.0228 |    0.6793 |    8.4916
>    | sd=3D4.1 |        | sd=3D0.47 | sd=3D0.058 | sd=3D0.0497 |  sd=3D0.1=
31
>  2 |  296.3 |   3682 |  58.915 |   1.0209 |    0.6752 |    8.5728
>    | sd=3D3.9 |        | sd=3D0.28 | sd=3D0.021 | sd=3D0.0244 |  sd=3D0.1=
56
>  3 |  295.7 |   3682 |  56.374 |   1.0160 |    0.6616 |    8.7467
>    | sd=3D2.6 |        | sd=3D0.44 | sd=3D0.008 | sd=3D0.0141 |  sd=3D0.1=
26
>  4 |  296.2 |   2585 |  51.434 |   1.0116 |    0.6699 |    8.7467
>    | sd=3D4.1 |        | sd=3D0.39 | sd=3D0.012 | sd=3D0.0115 |  sd=3D0.1=
26
>
> [1] Create test_tty benchmark:
>
>     mknod /dev/test_tty c 4 1
>     time for i in `seq 1 10000`; do
>         mknod /dev/test_tty$i c 4 1
>     done
>
> This benchmark should simulate the worst case scenario as many filename
> transitions affect files created in the /dev directory.
>
> [2] https://github.com/mbitsnbites/osbench
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
