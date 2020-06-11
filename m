Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D8C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C6E20760
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 14:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR3xvovX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFKODg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFKODf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 10:03:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A73C03E96F
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 07:03:35 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b18so4619743oti.1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKDzV1Ybak3hJr/LxBNynQWIEKfTADeAMWhYlrIHMAQ=;
        b=WR3xvovX7rd8mmDz1K5RgMhQ0NAC2k1QP3MR0wiJH2tDXGj+G+je34qb9ftL4OoRST
         rdfFJBtFSl38V6Fo/fVpXGH/DZa63s4NRxNRtyUdiX10BMVxdNVt1Xte7szZ1TmuEKjY
         eRgVRRldaydbYLbLMXODL54dpCokzTgpS4UxRjVT7Mm2oj5rJCtp+rPfFPHr1dfBhWS5
         wqjbVOH4iNp0EY+R4AUxsy0ZtUQcTkIQHvPTJZMnuFMHas6UVDzpcxcl9hWritCmfs53
         Jcj9ULP37i7bLoI8VJuE7HsbC472UeppvHCyBANeT15Joajud6/ElmNYHZ/qE1bwGSDg
         KWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKDzV1Ybak3hJr/LxBNynQWIEKfTADeAMWhYlrIHMAQ=;
        b=p1Sdnay0TqVPY12mkrcwC9w9T01P6oyPgr9EKRvsdjdA8tU8XgVd2479fIyfsohPuD
         vBXkt5dLSr6CR+DZCvpEZ0KWGDnFJ/Z9Ya0RiiWmjJ3q1kuro6eoA6gH/a4buDjmfOmt
         XJGRaFV5IHyMHt2Gn5ilnXrYFD9u69NlQLW5EiXvuQW+nO+S4fg/a40qNYfUxIj+niYX
         Z/vhROZtswItPjB9Q+3hiWcajGO21HCi3uCHli5Ley0GBYXC9VN0yjMdmqOFvU2cM1Yq
         FsdNHF6yKD/TU04cItVtWLHgzs7oXygmDEl72qZlXsnCUU1+SWJnqKHqRtwZeJn3LM5u
         CFsQ==
X-Gm-Message-State: AOAM5324FhE1ezBl/q8OzMhSw/CoZZP5jC81byvosnT5BrPTTsT/O6Ee
        ksgS0h/R2OKqu9WLGXoGiFiolMOoh4tljbPoMbwXTtmq
X-Google-Smtp-Source: ABdhPJwsBvJkwyECU/zMJHP6TxNuffAcYnArYGO1KrYtmzMmJM2HV8l1K2RmfDCwVyCCyNmPNfM+8GrhTrdmAyLJN+I=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr6854985oti.162.1591884214677;
 Thu, 11 Jun 2020 07:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200611135303.19538-1-cgzones@googlemail.com> <20200611135303.19538-3-cgzones@googlemail.com>
In-Reply-To: <20200611135303.19538-3-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 11 Jun 2020 10:03:23 -0400
Message-ID: <CAEjxPJ4=Nc_jaNQjyNo8+GDvkDdfNfTT94zMFttsRF5YsCu2vA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] sepolgen-ifgen: refactor default policy path retrieval
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 9:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On a SELinux disabled system the python call
> `selinux.security_policyvers()` will fail.
>
> Move the logic to find a binary policy from the python script
> `sepolgen-ifgen` to the C-helper `sepolgen-ifgen-attr-helper`.
> Change the helper command line interface to accept an optional policy
> path as second argument.  If not given try the current loaded policy
> (`selinux_current_policy_path`) and if running on a SELinux disabled
> system iterate over the default store path appending policy versions
> starting at the maximum supported policy version
> (`sepol_policy_kern_vers_max`).
>
> This changes the helper command line interface from:
>     sepolgen-ifgen-attr-helper policy_file out_file
> to
>     sepolgen-ifgen-attr-helper out_file [policy_file]
> and adds a linkage to libselinux.
>
> Export LIBSELINUXA like LIBSEPOLA in the root Makefile

I don't think you need the static libselinux, just add -lselinux and
use the shared library.
I would have added a -p policy_file optional argument via getopt(3)
but no big deal either way.
I don't think selinux_binary_policy_path() ever returns a complete
pathname so I'm not sure there is any point in testing it first
without a version suffix at all?
You don't need to re-post the first two patches; those are already
queued for merging.
