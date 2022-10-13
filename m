Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3FEC433FE
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 15:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJMP0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMP0k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 11:26:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAFC25C7D
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:26:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l1so2077278pld.13
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1YoFpQB9CTV15REXMxOl6HZMs9iGRDGysE1CWIAtE=;
        b=ZvPWNCTewf93CgxHEpNyMzTS6+5UMw02BltJM9ygKBbLs+MI9dvgVySWvuWyzjt/CJ
         2+u9xs7ekYd+6/5M9CJ5/ePeh9e8hv3ZoxQ6Cb5u8ENyFVF2G+69m3JhaUB73+7eU4t5
         wXlByLcQ+LwA1QMt40rMxqsp8AJ9hyW42IzQfjPWY2cTSItgfkQimM9VDsgVDq5THJ67
         vWaR1j2nIyNZrw7GpHyQPLcWDt4VTEY+NcQCDVhRRp7MPi7nUn8O8unhv1OSlMjG+M1e
         S3NYLTSWJqmQVxSWE5O+XmEvmIGiZxgYsWaW64FgCTstrgV5j/7rsD8ReTq9Fa8xY+Ti
         snMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql1YoFpQB9CTV15REXMxOl6HZMs9iGRDGysE1CWIAtE=;
        b=B+xa9P70MMPoMS2uamZi7jH36h47iT054RrcKCvodTxEGjOnQ4C2KmXRa/fzn40J8i
         PkL+vUbeyJa4vge1OPZcv9B4Ab571fIoQyT9mQY9pPdJOGGxNGdJdwcriR9EVNS5bkyd
         H2I/DILFz3JJTWAq6Sz4aIbpmPeuD2X/BfDjOth92uDj0IR3wi2Gglan+V4hJLD7xs7s
         RED57qHrrHQAmvJ9QVWi99uRe+dZUURwaHLys3BEZyMW8Cm1GYByR28SurAmvvKhiNLf
         tQEzSX9uRDZ/r823RujLdagNu9zcwlCPdtou0+RqsH/0HwVYMv3P1wi9HjKiFyW66w26
         aG0Q==
X-Gm-Message-State: ACrzQf3kSTBmXbPjr5UuKSM+8ej358kT4r+SvDhLAWtY9mRyU7zxTBIZ
        Os7ByMahB/53KECQaoXxZU8B2EHjZqZ9JuUpfGk=
X-Google-Smtp-Source: AMsMyM4B6qLkxMrRVFNFn8GiufWVtYTPYw/qcFIoanf22HDNOfJuMGFFwZOdrzgmxncUK7RBJTvWqtZBQSHmvzl1X7o=
X-Received: by 2002:a17:90b:3b82:b0:20b:516:5ff5 with SMTP id
 pc2-20020a17090b3b8200b0020b05165ff5mr377027pjb.92.1665674798958; Thu, 13 Oct
 2022 08:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221012142751.17979-1-cgzones@googlemail.com>
 <CAP+JOzQr_1bBDAp=jyBb37cNFQKW0CDsixiM3aAcWSWAJtvQxg@mail.gmail.com> <87czavsw6u.fsf@redhat.com>
In-Reply-To: <87czavsw6u.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 13 Oct 2022 11:26:27 -0400
Message-ID: <CAP+JOzRTC-p8OL1T6OOVDFmRkoXETEh+DbjDc6hpfMQJzcGXhw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: restore error on context rule conflicts
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Milos Malik <mmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 13, 2022 at 9:13 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Wed, Oct 12, 2022 at 10:28 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> >>
> >> Commit bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for
> >> context rule conflicts") reworked the processing of context rule
> >> conflicts to limit the number of written conflicting statements to
> >> increase readability of the printed error message.  It forgot to set t=
he
> >> return value, signaling a context conflict, in the case the logging
> >> level is higher than warning (e.g. in semodule(8), which defaults to
> >> error).
> >>
> >> Reported-by: Milos Malik <mmalik@redhat.com> [1]
> >> Fixes: bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for =
context rule conflicts")
> >>
> >> [1]: https://lore.kernel.org/selinux/87y1u1rkoo.fsf@redhat.com/
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Acked-by: James Carter <jwcart2@gmail.com>
>
> Tested-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks!
>
Merged.
Jim

>
> >> ---
> >>  libsepol/cil/src/cil_post.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> >> index 6e95225f..11e572e2 100644
> >> --- a/libsepol/cil/src/cil_post.c
> >> +++ b/libsepol/cil/src/cil_post.c
> >> @@ -2290,6 +2290,7 @@ static int __cil_post_process_context_rules(stru=
ct cil_sort *sort, int (*compar)
> >>                 } else {
> >>                         removed++;
> >>                         if (!db->multiple_decls || concompar(&sort->ar=
ray[i], &sort->array[j]) !=3D 0) {
> >> +                               rc =3D SEPOL_ERR;
> >>                                 conflicting++;
> >>                                 if (log_level >=3D CIL_WARN) {
> >>                                         struct cil_list_item li;
> >> @@ -2297,7 +2298,6 @@ static int __cil_post_process_context_rules(stru=
ct cil_sort *sort, int (*compar)
> >>                                         li.flavor =3D flavor;
> >>                                         if (conflicting =3D=3D 1) {
> >>                                                 cil_log(CIL_WARN, "Fou=
nd conflicting %s rules\n", flavor_str);
> >> -                                               rc =3D SEPOL_ERR;
> >>                                                 li.data =3D sort->arra=
y[i];
> >>                                                 rc2 =3D cil_tree_walk(=
db->ast->root, __cil_post_report_conflict,
> >>                                                                       =
                  NULL, NULL, &li);
> >> --
> >> 2.37.2
> >>
>
