Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C3C433E6
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2464F4A
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBEJfC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:35:02 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:53890 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBEJc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:32:58 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7F72D564F5D
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:32:06 +0100 (CET)
Received: by mail-oi1-f175.google.com with SMTP id y199so4807198oia.4
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 01:32:06 -0800 (PST)
X-Gm-Message-State: AOAM531NdbuNFIFZLX7IsmcgYmnjCqWwswKrZa8ADShHXkIeL5pmHSea
        27pBllmGR+Q6XnlrexclxcLFUlIpf95JhhxySOU=
X-Google-Smtp-Source: ABdhPJxmhI+4T9wa3oBOUp92ZQeA2V5o/XdiqzNf5sGBP/nfid332ap8bTF4f/QmJPeuZDqiHHHHtqhEUu549qrYi8k=
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr2549466oij.40.1612517525368;
 Fri, 05 Feb 2021 01:32:05 -0800 (PST)
MIME-Version: 1.0
References: <e8b641c5-4e60-a264-1a4e-0c0b2dd98981@gmail.com>
 <CAP+JOzQ6Vv7dFJfqBUe5SO596UVQ3-SzJ_Vi50nLf7fv6ofTVQ@mail.gmail.com>
 <82ba2e85-54f6-5a7b-2bc4-b49bc509de18@gmail.com> <CAP+JOzT3Ee=WnMfnME3N=MCytb1um3F=iBZnNUzV6xN6R8PYpg@mail.gmail.com>
In-Reply-To: <CAP+JOzT3Ee=WnMfnME3N=MCytb1um3F=iBZnNUzV6xN6R8PYpg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 5 Feb 2021 10:31:54 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kNYttj=fSAaNdC9djsWXeUpVQ1TPXF2x1V0gJ5zy9mNg@mail.gmail.com>
Message-ID: <CAJfZ7=kNYttj=fSAaNdC9djsWXeUpVQ1TPXF2x1V0gJ5zy9mNg@mail.gmail.com>
Subject: Re: [PATCH 0/2] secilc/docs: add syntax highlighting for cil examples
To:     James Carter <jwcart2@gmail.com>, bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:32:06 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 12:20 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Feb 4, 2021 at 4:28 PM bauen1 <j2468h@googlemail.com> wrote:
> >
> > On 2/4/21 9:17 PM, James Carter wrote:
> > > I notice on page 10:
> > > (block unconfined
> > >     (user user)
> > >    ...
> > >
> > > That the second user (which is the name of the user) is highlighted as
> > > well as the user keyword.
> > >
> > > Similar thing happens further done on page 10 with the rule:
> > > (portcon udp 12345 (unconfined.user object_r unconfined.object ((s0) (s0(c0)))))
> > >
> > > The "user" part of "unconfined.user" is highlighted.
> > >
> > > "unconfined.user" is used in other examples as well.
> > >
> > > Changing the first statement to be (user user1) would be fine, but I
> > > would like "unconfined.user" to remain as is.
> > > I am not sure how hard it would be to fix that.
> > >
> >
> > I thought this would be harder, but just highlighting the first cil keyword in a block is actually very easy, and I can rework the patch to do just that.
> >
> > It becomes more difficult when trying to add (some) highlighting to everything else since keywords are reused as names very often (I do that by design even):
> >
> > Some examples from the guide:
> >
> > (macro all ((type x))
> >     (allow x bin_t (policy.file (execute)))
> >     (allowx x bin_t (ioctl policy.file (range 0x1000 0x11FF)))
> > )
> > (call all (bin_t))
> >
> > (mlsvalidatetrans file (domby l1 h2))
> >
> > (defaultrole char target)
> >
> > (type t1)
> > (allow bb.t2 bb.t1 (policy.file (read write execute))))))
> >
> > In the above e.g. all is name, but is usually a keyword with a very important meaning, so imho it should be highlighted, in a lesser way this also goes for t1, or domby, ...
> >
> > The only way I avoid highlighting _all_ names as keywords is to implement a lot of the CIL grammar in the syntax highlighter, but I'm not really sure if it's worth the effort.
> > It could be done for some keywords, e.g. constraints, filecon.
> >
> > A better alternative might be to just highlight less, e.g. drop `low`, `low-high` keywords entirely.
> >
> > I've uploaded another version with some small fixes and a debug color theme to better show what-is-what:
> >
> > https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide2.html
> >
> > and with more keywords removed:
> >
> > https://glados.bauen1.xyz/misc_stuff_might_disappear/CIL_Reference_Guide3.html
> >
> > ; only in version 2: file is considered a keyword (builtin), but this should normally only be the case in filecon statements, here it references a class
> > (mlsvalidatetrans file (domby l1 h2))
> >
> > ; all, t1, low is considered a keyword (builtin), but is a name
> > (call all (bin_t))
> > (type t1)
> > (userlevel u5 low)
> >
> > ; but here t2, t1 are no longer highlighted erroneously.
> > (allow bb.t2 bb.t1 (policy.file (read write execute)))
> >
> > I think Version 3 only has mismatches in the example policy due to usage of `all`, `t1` and `t2` as names, so that might be the way to go.
> >
>
> I like version 3 the best, but I really don't like the color used for
> "self", "object_r", "h1" , etc. It just stands out too much.
>
> Thanks,
> Jim

Thanks for working on this. On my side, I have a minor comment,
related to the second patch:

+    <list name="keywords">
+        <item>auditallow</item>
+        <item>tunableif</item>
+        <item>allow</item>
+        <item>dontaudit</item>
...
I find it easier to maintain if the items were sorted in alphabetical
order (this enables inserting new items if the need comes one day,
without wondering whether the new items should be at the end of the
list or if the order should match the one used in some source
files...). Or, if you want to keep this order, please add comments
describing how the lists were created, in order to ease future
modifications.

Thanks,
Nicolas

