Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB5C433EF
	for <selinux@archiver.kernel.org>; Tue, 18 Jan 2022 15:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbiARPtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346016AbiARPtC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jan 2022 10:49:02 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBFC061574
        for <selinux@vger.kernel.org>; Tue, 18 Jan 2022 07:49:01 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso12090380otl.3
        for <selinux@vger.kernel.org>; Tue, 18 Jan 2022 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9nuHWcDRiQ+nU0IA7CvY0Rvz0dg68YqAwsju9zhKj0=;
        b=Stn3EOn+Dil3fc1vdt5//xnNSK/SU6+MuImU8je7TyStJo0qi78yAuZBtYajscxJjO
         7LZAehi2tlsH3eEDA3Wq34Lx/+hoD3Q8xZXYLiIwdhT4ABPWUmgkmemp88cjIxKbrlRc
         8GzS1O+zsryWqY9o/46nibvDQHLHY8D6GMuizRgEjbajGHUrmiSIemWJDFAp2nFIPKPG
         jG80Y0rj5gdeh8RXoz3fd/ivZxqEQKLh6T7LDjPUEycxG3//nIBXiwH0l2C5pO0ae8QA
         +I+vfDfvTbRvfLLhvj3C0NOhugYPcWIrTM6gWrSlLjRfzFyz0Xjtmu1p7lRbO/cLn9X5
         +EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9nuHWcDRiQ+nU0IA7CvY0Rvz0dg68YqAwsju9zhKj0=;
        b=iOnlSKZ0MLTAwIq0JWZRnrSbzBe+T5nojJ5fmeeA+28buwPsgPu3L803c0K/wYQhMD
         ZctuTGNzTFAzHPLNizDrrXBaAmA+7gV/rcCe/N/W4N0kvuZtstTeYHYr+Rfh2//631X8
         l7JudZ2rQewTriIsUHtn96H4WCW4f1zGrbKe7HefmV3OFZwDTUzvfLHW9w2APL6XkUwr
         L4yOGbB3id4mUDb8ZXNlBEt41YbfZC6l6vyXc5A0XFrXa4jhIebSyMp0kdE/yK5y9B8I
         hsez2CMb5edpY3sAlX4MjnlDpWD12x8FQtyV7E1SEKNfLLzGG3G/SFaOS7qJCXd5TZ4N
         MLgg==
X-Gm-Message-State: AOAM531deLogZAlc7vzUyWlf5NIjeMas3qgqr0wx+D5oO2Atz8dusvdn
        OKyruxWYG/yTCLQTzM1zKw25UGqIgkNsA0OED/4iAGf6
X-Google-Smtp-Source: ABdhPJyvxJtq36AKgl3kg/qCmVg1lryLrv+N9xAf5jjqzbEcWTrDkXQifXyRrpFZtMeGT6GfuKZdUyuLLhDLtKqll0Q=
X-Received: by 2002:a9d:4106:: with SMTP id o6mr14165330ote.139.1642520941372;
 Tue, 18 Jan 2022 07:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20220114192002.730773-1-jwcart2@gmail.com> <dd96ca20-2f8f-ea6c-48b8-6649915fac1c@gmail.com>
In-Reply-To: <dd96ca20-2f8f-ea6c-48b8-6649915fac1c@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 18 Jan 2022 10:48:15 -0500
Message-ID: <CAP+JOzSeF50B5fYCLLKJpnGCXXWwxkEDEFU=61ZUY-TyLU7E+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Limit the amount of reporting for
 neverallow violations
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 14, 2022 at 2:44 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Hi,
>
> as a heavy user of neverallow / neverallowx, please don't limit this.
>
> When adding a new neverallow rule there might quite a few types violating them, and having to rebuild the policy every 2 types would make fixing them incredibly annoying.
>
> If you want to limit this, then please make it opt-in or add it as a command line option.
>

I am trying to limit error messages because oss-fuzz seems to be good
at creating policies that generate a lot of error messages and
subsequently take a lot of time to process.

But I am not going to do that at the expense of people actually using secilc.

I was already thinking about making the amount of error reporting
depending on the verbosity level. What would think of it limiting it
to two by default, but unlimited at any higher verbosity level. I can
even add a message to use "-v" to see all of the errors.

Jim


> On 1/14/22 20:20, James Carter wrote:
> > When there is a neverallow violation, a search is made for all of
> > the rules that violate the neverallow. The violating rules as well
> > as their parents are written out to make it easier to find these
> > rules.
> >
> > If there is a lot of rules that violate a neverallow, then this
> > amount of reporting is too much. Instead, only print out the first
> > two rules (with their parents) that match the violated neverallow
> > rule along with the total number of rules that violate the
> > neverallow.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >   libsepol/cil/src/cil_binary.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index 4ac8ce8d..04a5d053 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -4640,6 +4640,8 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
> >       char *neverallow_str;
> >       char *allow_str;
> >       enum cil_flavor avrule_flavor;
> > +     int num_matching = 0;
> > +     int count_matching = 0;
> >
> >       target.rule_kind = CIL_AVRULE_ALLOWED;
> >       target.is_extended = cil_rule->is_extended;
> > @@ -4666,11 +4668,19 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
> >               goto exit;
> >       }
> >
> > +     cil_list_for_each(i2, matching) {
> > +             num_matching++;
> > +     }
> >       cil_list_for_each(i2, matching) {
> >               n2 = i2->data;
> >               r2 = n2->data;
> >               __cil_print_parents("    ", n2);
> >               __cil_print_rule("      ", allow_str, r2);
> > +             count_matching++;
> > +             if (count_matching >= 2) {
> > +                     cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
> > +                     break;
> > +             }
> >       }
> >       cil_log(CIL_ERR,"\n");
> >       cil_list_destroy(&matching, CIL_FALSE);
>
> --
> bauen1
> https://dn42.bauen1.xyz/
