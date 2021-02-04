Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DBC433DB
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 23:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B87064F39
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 23:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBDXT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 18:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBDXT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 18:19:57 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7AC0613D6
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 15:19:17 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id d7so5165849otf.3
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1bkSvr+ndbppScBcgMHL3trWPemTG7bKtrF1VxWLSE=;
        b=Qd8WwYg4Py70wuz8jhmU2nxw7b+C5KJU1/FwUY6sXGuHpy3wF2Z3GqBDRbW14frl7E
         gEZKMRdhKke069L3buxMjS0ToGku7f7h2TZDwJNzF5FbfJn0UrLRoi/ZU8zWLLO4P52Z
         0eIbCtok7wIui0zvDhF5tDcPRRGds/z5GteP5dA3M9E8K0WLjTq1Tnkb9LdnDdmjlKsz
         zVj51ZanXrJpYPzzbGl6Aif7wo60EsX+zpavzTr25U1nKyTAh3WKjUWrJMateidTmiYJ
         GvesW7gATLhiqft7+JLs5pdaC7Ay5JeXHrX+skb1EZE7mfBO+3niCJCXxBAeKbbG5f/G
         SODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1bkSvr+ndbppScBcgMHL3trWPemTG7bKtrF1VxWLSE=;
        b=FISukETV0OBs/FYQ1fhwdJ0nN94l8Q9OnmniNNJl1ThkBMuQ9tyYRBJ3QVAPhEW9Sq
         OmndLMW8S2NRZSihqStaA+DG5D7mfQ6arGQD/O4aulVLV4EsX91k5UjzXJTmRkcXU3nx
         F2aA/JI078GnkA/BGJCPkdTAVG1gYlkr1CGeqfYvS2iP2Ndi14aIB6/DAUJFv4LsjsaA
         8RPMkJHznad8Ev7bAgA01EFujTC7bZXDNXgbsux5SRBsVtjZQTstJfFd5zTyIrfjesbn
         G9K0VWStUUDdIfmzpSWC3Uh/KuhZEDUhY7/qdJtaVQzRzS/CvqoahagZnAz4Q2DIe2AV
         +Yqw==
X-Gm-Message-State: AOAM530cYCOCld1TATmbcKU1PNqjEokIi+nVu1Z8ewFQf3e5+zxw2VcV
        XBVkR4tddFp3uUf11691ubjhqOzgDMRB5ikCs4zB3edx
X-Google-Smtp-Source: ABdhPJyy1279YIpAyoDK2YdjqwGYqEATTy6CiSKLim1NJDecy/4Q+/yGc942N/7+S2orq1IAe/Fv6T5Grf8UCAP3c6k=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr1324064otu.59.1612480756750;
 Thu, 04 Feb 2021 15:19:16 -0800 (PST)
MIME-Version: 1.0
References: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
 <CAP+JOzQ6Vv7dFJfqBUe5SO596UVQ3-SzJ_Vi50nLf7fv6ofTVQ@mail.gmail.com> <82ba2e85-54f6-5a7b-2bc4-b49bc509de18@gmail.com>
In-Reply-To: <82ba2e85-54f6-5a7b-2bc4-b49bc509de18@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 Feb 2021 18:19:05 -0500
Message-ID: <CAP+JOzT3Ee=WnMfnME3N=MCytb1um3F=iBZnNUzV6xN6R8PYpg@mail.gmail.com>
Subject: Re: [PATCH 0/2] secilc/docs: add syntax highlighting for cil examples
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 4, 2021 at 4:28 PM bauen1 <j2468h@googlemail.com> wrote:
>
> On 2/4/21 9:17 PM, James Carter wrote:
> > I notice on page 10:
> > (block unconfined
> >     (user user)
> >    ...
> >
> > That the second user (which is the name of the user) is highlighted as
> > well as the user keyword.
> >
> > Similar thing happens further done on page 10 with the rule:
> > (portcon udp 12345 (unconfined.user object_r unconfined.object ((s0) (s0(c0)))))
> >
> > The "user" part of "unconfined.user" is highlighted.
> >
> > "unconfined.user" is used in other examples as well.
> >
> > Changing the first statement to be (user user1) would be fine, but I
> > would like "unconfined.user" to remain as is.
> > I am not sure how hard it would be to fix that.
> >
>
> I thought this would be harder, but just highlighting the first cil keyword in a block is actually very easy, and I can rework the patch to do just that.
>
> It becomes more difficult when trying to add (some) highlighting to everything else since keywords are reused as names very often (I do that by design even):
>
> Some examples from the guide:
>
> (macro all ((type x))
>     (allow x bin_t (policy.file (execute)))
>     (allowx x bin_t (ioctl policy.file (range 0x1000 0x11FF)))
> )
> (call all (bin_t))
>
> (mlsvalidatetrans file (domby l1 h2))
>
> (defaultrole char target)
>
> (type t1)
> (allow bb.t2 bb.t1 (policy.file (read write execute))))))
>
> In the above e.g. all is name, but is usually a keyword with a very important meaning, so imho it should be highlighted, in a lesser way this also goes for t1, or domby, ...
>
> The only way I avoid highlighting _all_ names as keywords is to implement a lot of the CIL grammar in the syntax highlighter, but I'm not really sure if it's worth the effort.
> It could be done for some keywords, e.g. constraints, filecon.
>
> A better alternative might be to just highlight less, e.g. drop `low`, `low-high` keywords entirely.
>
> I've uploaded another version with some small fixes and a debug color theme to better show what-is-what:
>
> https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide2.html
>
> and with more keywords removed:
>
> https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide3.html
>
> ; only in version 2: file is considered a keyword (builtin), but this should normally only be the case in filecon statements, here it references a class
> (mlsvalidatetrans file (domby l1 h2))
>
> ; all, t1, low is considered a keyword (builtin), but is a name
> (call all (bin_t))
> (type t1)
> (userlevel u5 low)
>
> ; but here t2, t1 are no longer highlighted erroneously.
> (allow bb.t2 bb.t1 (policy.file (read write execute)))
>
> I think Version 3 only has mismatches in the example policy due to usage of `all`, `t1` and `t2` as names, so that might be the way to go.
>

I like version 3 the best, but I really don't like the color used for
"self", "object_r", "h1" , etc. It just stands out too much.

Thanks,
Jim

> > I am not sure if this matters to anyone, but if the document is
> > printed, the syntax highlighting (particularly for the comments) might
> > make it a little bit hard to read.
>
> pandoc can still be run without syntax highlighting (--no-highlight) if you want to actually print the document in greyscale.
>
> It also looks like I messed up when sending the patches, patch 1, the least problematic one ironically, got lost somewhere.
>
> --
> bauen1
> https://dn42.bauen1.xyz/
