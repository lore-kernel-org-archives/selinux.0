Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C5C433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Feb 2022 19:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiBKTtM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:49:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiBKTtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 14:49:11 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F52A1
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 11:49:10 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id x193so10834461oix.0
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9Nx2PEqGaTocStmu9Y4XxjO8Rm5Rws6VyatpaAubrEk=;
        b=LR4vgyrWlZE7QZ1AHYle7VP453G2OUcxU8tOIfbP8Chn9QYtSY0/yQ4Coz0IGsWW8f
         aGgLA4hR0NOQb94aztP1NZz1RgYfDvBCXkyWAUWFPipW5+BRTgqoBQoPiqDeZZOowWl4
         I/lca21OR2JJqmQy02ReboyNa6o3rltsK9Olhkrb0oZ21Felj0SRWABIl1Qz8zz0GLup
         cq6lErPqLYXB8ERGwlW5hCtAMbOsvNq2dWktREzdyPsODMttumzKAPfkTPieC4WwKnhQ
         YpQWofOZVwS2jOqXifD6gucNQjZVjTum9lKa360ZUVbBGVSTnDtlQvHJsaeyDgYzx5OI
         CFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9Nx2PEqGaTocStmu9Y4XxjO8Rm5Rws6VyatpaAubrEk=;
        b=XKBWw28JJ1K+bk3Dn6t0K5IT0OSe7Cl7BsZmN54L978nOLXWkxLuz06jKohL7gwNkb
         hB6pdPrKUUngTwVQsOUO7Zd0llGONCErhNY4b01hiuHj8zQf+XutvaRyB+jVJp9NDnUJ
         5+Rim4U9JNW9ZtXlGcDIK7/PBGsJaC2etLELOlLHLkkksfOuJrMU6YdhrzAsNZKbp5xX
         iUDfcBfvDL+FdJK672UkCBcj/jT+I8aJlQyl4Y3RVQJ38ouNwmb4jMDYZGM04RKcdcjx
         PnMR3aax/XeRyqWMg3xiPGT3biTAHPBLLFzMfDjeYCLevsFvg/c2jq+2qu7kL+ZAbuk3
         WSMg==
X-Gm-Message-State: AOAM5302ovg5z9Xiv1Dg/zIo4BSXoUq1D/luyexabwcsvnP9rEiVR4fv
        7JKtkfeuTOVy/U8cXHYJGteTpqMHoYPa4j5tLbgGxnhC
X-Google-Smtp-Source: ABdhPJxXM8XcjUBz1EvJ6Kmp2SBpTuan7Y3wOd5ft3WZRtoFvxSkMAglYmNcHn3zKMRoGqk2/GVWZSMcF+Xgf6Sjl5U=
X-Received: by 2002:a54:408e:: with SMTP id i14mr990652oii.200.1644608949442;
 Fri, 11 Feb 2022 11:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20220113160422.675541-1-jwcart2@gmail.com> <CAP+JOzRcW_izEVpxwG8m099O6tK-UWEUfBebVyzfsaJLikzFUQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRcW_izEVpxwG8m099O6tK-UWEUfBebVyzfsaJLikzFUQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Feb 2022 14:48:58 -0500
Message-ID: <CAP+JOzSGTNuG2GWBBt=9W0P1CoHxdPE6QQenb9BOn3hcJRqKFw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Ensure that the class in a classcommon is a
 kernel class
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 7, 2022 at 1:56 PM James Carter <jwcart2@gmail.com> wrote:
>
> I also plan on merging this patch at the end of the week.
> Jim
>
This patch has now been merged.
Jim

>
> On Thu, Jan 13, 2022 at 11:04 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > Map classes use the same struct as kernel classes, but only the kernel
> > class uses the pointer to a common class. When resolving a classcommon,
> > make sure that the class that is found is a kernel class and not a
> > map class. If not, then return an error.
> >
> > Found by oss-fuzz (#43209)
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index e97a9f46..d359eca0 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -754,6 +754,11 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
> >         if (rc != SEPOL_OK) {
> >                 goto exit;
> >         }
> > +       if (NODE(class_datum)->flavor != CIL_CLASS) {
> > +               cil_log(CIL_ERR, "Class %s is not a kernel class and cannot be associated with common %s\n", clscom->class_str, clscom->common_str);
> > +               rc = SEPOL_ERR;
> > +               goto exit;
> > +       }
> >
> >         rc = cil_resolve_name(current, clscom->common_str, CIL_SYM_COMMONS, extra_args, &common_datum);
> >         if (rc != SEPOL_OK) {
> > --
> > 2.31.1
> >
