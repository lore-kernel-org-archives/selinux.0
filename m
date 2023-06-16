Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C3EB64DA
	for <selinux@archiver.kernel.org>; Fri, 16 Jun 2023 02:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjFPCEY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Jun 2023 22:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFPCEX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Jun 2023 22:04:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37502135
        for <selinux@vger.kernel.org>; Thu, 15 Jun 2023 19:04:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76228cfd5afso26332185a.2
        for <selinux@vger.kernel.org>; Thu, 15 Jun 2023 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686881061; x=1689473061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r941DbmSHryypmdWJXUOSdFaOQn70DfzQh7tnWdPwm0=;
        b=Xi7evTjV8BRCQeHMaPv4rr+SLstR+TWBHfCUZNz6NDKjO5L6zOEhkxZf65hdMz0epO
         7gIONgvmPnGlJH9YFvNHIJpIkxrz6cT3VlIN9PLhyetLc3DX2y3xrx/9ttKUnE0mhd7s
         r+cr/sohPEJ7NFXOzehWq7+g9x/XjXq/z0lbm0AMTVRY89jd4ck+f+CQba0P9wRvazpB
         G2FFtmJHE9OU0Py2RPcMQ65dpADmV9j1/lQm9FsjoTxUF0Vy3QBNnb/1VPPZXa6ZbsbN
         Q9EaUBqU9Cx9z1oW/VCtlAQ8vLBFKOrPI0TjbAjMDm3ryl1qGFigOlwyzyjAvmxKPpHJ
         4e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686881061; x=1689473061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r941DbmSHryypmdWJXUOSdFaOQn70DfzQh7tnWdPwm0=;
        b=QlrCALqByXLTab6ITxqBckwDRYNXHQzky7sioGq0gk4gAfzMvHOOa5JOeuoUR5B5to
         jQ12nK0FI+HlcphJR+xyDtpI4uY8fhaBZry0Yh1hzPgMuAAsd/VZHFhejtykrQAfXJGm
         n8Kuo17H3u4DkQPsQob8FPQC1hOBgztSl1MSxvNC8Hk8s25li/Hq+SumdW25I28VQp/q
         Z7GKAiYW7suAM6NlFYi171TF/e3cQ+OM/6k2vE7sOgpUGY6cwRdLFwo+ItxZByFlcMA8
         cn9nTMA2dAqJi1r7GWzdn1S0ZBfF9YO0q9212MuUAme3XdHtLHSABhKF5gGbztNJ5wGd
         Mliw==
X-Gm-Message-State: AC+VfDw4qcdTulNu4iOWR4HPpKm+IjaqI9Mn0yKW1qavOuxxs0Z2ALx4
        iHtDNo0NsQjwuI8scTqReu7c1q7KDfFU919/Um1J
X-Google-Smtp-Source: ACHHUZ5rKWcckiulAzoud+4ALGQPsTjilwrs4EOhMUl3BBe9r64P/FkYDk7gRkY30E7vwBSXMyGPmlVXeGQNzrpgRhQ=
X-Received: by 2002:a05:620a:458e:b0:75b:23a1:3670 with SMTP id
 bp14-20020a05620a458e00b0075b23a13670mr376273qkb.49.1686881060737; Thu, 15
 Jun 2023 19:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
 <CAHC9VhQZE9Qtsu=7N38sOjHkD=RS4GXsqHOcUgobsJOA+iq2_A@mail.gmail.com> <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
In-Reply-To: <20230601170302.nrhuay2wh44g6sh4@jmarcin-t14s-01>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 15 Jun 2023 22:04:09 -0400
Message-ID: <CAHC9VhRCBkx7ioHAEMpn=ug3zAo2nEOUBe2uWsm0Tb8p6-vE7g@mail.gmail.com>
Subject: Re: [PATCH 0/5] selinux: add prefix/suffix matching to filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 1, 2023 at 1:03=E2=80=AFPM Juraj Marcin <juraj@jurajmarcin.com>=
 wrote:
> On 2023-05-31 18:24, Paul Moore wrote:
> > On Wed, May 31, 2023 at 7:32=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> > >
> > > Currently, filename transitions are stored separately from other type
> > > enforcement rules and only support exact name matching. However, in
> > > practice, the names contain variable parts. This leads to many
> > > duplicated rules in the policy that differ only in the part of the na=
me,
> > > or it is even impossible to cover all possible combinations.
> > >
> > > First, this series of patches moves the filename transitions to be pa=
rt
> > > of the avtab structures. This not only makes the implementation of
> > > prefix/suffix matching and future enhancements easier, but also reduc=
es
> > > the technical debt regarding the filename transitions. Next, the last
> > > patch implements the support for prefix/suffix name matching itself b=
y
> > > extending the structures added in previous patches in this series.
> > >
> > > Even though, moving everything to avtab increases the memory usage an=
d
> > > the size of the binary policy itself and thus the loading time, the
> > > ability to match the prefix or suffix of the name will reduce the
> > > overall number of rules in the policy which should mitigate this issu=
e.
> > >
> > > This implementation has been successfully tested using the existing a=
nd
> > > also new tests in the SELinux Testsuite.
> > >
> > > Juraj Marcin (5):
> > >   selinux: move transition to separate structure in avtab_datum
> > >   selinux: move filename transitions to avtab
> > >   selinux: implement new binary format for filename transitions in av=
tab
> > >   selinux: filename transitions move tests
> > >   selinux: add prefix/suffix matching support to filename type
> > >     transitions
> >
> > Just a quick comment as I haven't had a chance to properly review this
> > series yet; you show some memory usage and performance measurements in
> > some of the intermediate patches, that's good, but I don't see the
> > same measurements taken when the full patchset is applied.  Please
> > provide the same memory usage and performance comparisons with the
> > full patchset applied.
>
> Of course, here are the measurements with the whole patchset applied.
>
> I also included measurements with new policy (based on the Fedora
> policy) that uses prefix filename transitions where possible. This new
> policy has been generated by merging existing filename transitions into
> prefix ones if it would reduce the number of transitions overall while
> keeping the resulting type same.
>
> [1] Reference kernel (c52df19e3759), Fedora policy (format v33)
> [2] This patchset, Fedora policy (format v33)
> [3] This patchset, Fedora policy without prefix/suffix rules (format v35)
> [4] This patchset, Fedora policy with prefix rules (format v35)
>
>
>  Test | Mem   | Binary | Policy | Create tty      | osbench
>       | Usage | policy | load   |                 | create
>       |       | size   | time   | (ms/file)       | files
>       | (MiB) | (MiB)  | (ms)   | real   | kernel | (us/file)
> ------+-------+--------+--------+--------+--------+-----------
>  [1]  |   157 |    3.4 |     78 | 1.1021 | 0.7586 | 7.8277
>  [2]  |   200 |    3.4 |    206 | 1.1193 | 0.7724 | 8.2711
>  [3]  |   169 |    5.8 |    106 | 1.1021 | 0.7724 | 8.0304
>  [4]  |   164 |    3.8 |     86 | 1.1029 | 0.7586 | 7.9609

Thanks for performing those measurements.

I apologize that I haven't had an opportunity to review your patcheset
in detail just yet (I've been struggling with some self-inflicted
networking issues this week), but looking strictly at the numbers
above it appears that by every metric in the table this patchset
results in a policy that is larger (both on-disk and in-memory) as
well as performance that is at best the same (although in most cases,
it is worse).  Are there any improvements expected beyond test
configuration [4] (above)?

--=20
paul-moore.com
