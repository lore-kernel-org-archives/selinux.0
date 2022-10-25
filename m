Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA56FA373E
	for <selinux@archiver.kernel.org>; Tue, 25 Oct 2022 20:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYUto (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJYUtn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Oct 2022 16:49:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874AE9E
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 13:49:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w189so11661535pfw.4
        for <selinux@vger.kernel.org>; Tue, 25 Oct 2022 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hu3xiyTeKZUsIEjo52u95oK3OiOS82aorz2YVpU2bs=;
        b=YxdA3qt+dMc/WEdyRluAIwimUY20WqH4vpcGgF6Yv9pT0PGbFN5p7OAv91m14bULne
         V/moyMk3CifWvc9hZJ8xV64Mi6fQ5UHy54lEb6bLVI5fj7vatrpwdA/GLkvJVfqzmYDo
         SQbJZst44E/gbvAO/UDwvvYQj38t8NYwIVzORvP8U8RtfpG/sCedZHzo+pYuXmj5+zJZ
         oApRkOlsVckYX49/rlxyuuGQiJb9t+JfbvOQ8nVZyJikRLe8XM/jiNhucMZhpqEZshs4
         evhkIHo6GfsAYA1w1dqThQKTQAY41k/gTwk0erYr9fQ+3ozQGh4D43sB+JJUWjPaxpYK
         yPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Hu3xiyTeKZUsIEjo52u95oK3OiOS82aorz2YVpU2bs=;
        b=GjKY9sCUyerUBINCsp0ZBzfkUNiKOq5XKPkEHvrRlGqPckL8Zm7SRI+JaIJBFiNMdU
         QBPw8PxxXxPRyhbRnz6l4Vyo/bLPiVHPkjAgspg7dsMiLdls2HGWfDwB/p0LcKF2/EDq
         bTJH4gl028aci0EZEvwlvdonlXSfW/db6iN4kgTnIlEBUH9SaRcdzKnEn0VuNC5fn2yr
         5dk+bc6QNJvpRL5srzG8qXj6NLiw/9+ezXAYJEdKg7rcm6+hM1ki/pXKr47xkXfVI0af
         8hjbxHTOpBAR/WFqLkrn7nE34u6HpjVubJK0w2XcuDlleJtpEwhgV8T+Mjdf2LO7R45n
         8v+w==
X-Gm-Message-State: ACrzQf0y3LE/tGyOUF5uL1cBpVWIyS2aDEPOE0P6/QD7RdfS5tGuX7XF
        HEayKI9puYR6UQ9ND7rH57fJl5VLwtbPWAkk2/8=
X-Google-Smtp-Source: AMsMyM73dmxYSx7VPS3k4T08Uc5Vd5VnLIrjddeV6olX7gXNypzXsqj3ChJ/PLRXUExyKgMufZMuPnHyjfj4LwYwIl0=
X-Received: by 2002:aa7:8b46:0:b0:56c:349f:191e with SMTP id
 i6-20020aa78b46000000b0056c349f191emr3166242pfd.29.1666730980521; Tue, 25 Oct
 2022 13:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220801015721.393211-1-chris.lindee+git@gmail.com>
In-Reply-To: <20220801015721.393211-1-chris.lindee+git@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 25 Oct 2022 16:49:29 -0400
Message-ID: <CAP+JOzTfD-DcLYQhDhmEEORd4vMZ31eiMYM-dV5W2FoD5Jz5+g@mail.gmail.com>
Subject: Re: Adjust sepolgen grammar to support allowxperm, et. al.
To:     chris.lindee@gmail.com
Cc:     selinux@vger.kernel.org,
        Chris Lindee <chris.lindee+github@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 31, 2022 at 10:07 PM <chris.lindee@gmail.com> wrote:
>
> Provide basic support for allowxperm, auditallowxperm, dontauditxperm and=
 neverallowxperm.  While I would prefer additional changes to help avoid th=
e presence of magic numbers (e.g. a new macro, much like interface, but for=
 recursively defining named xperm numbers), this patch set is sufficient fo=
r my and - hopefully - the majority of the community's needs.
>
> In particular, this change will keep /usr/bin/sepolgen-ifgen from spewing=
 errors on the following policy every time selinux-policy-targeted gets upd=
ated: https://github.com/openzfs/zfs/pull/13271/files#diff-70b325e496b997b3=
c4a5a9f0aacee16343b82e07a8ed8220304ccb5f6504a582
>
> Signed-off-by: Chris Lindee <chris.lindee+github@gmail.com>

I have been looking at these two patches. Either there is a problem in
them or there is a problem elsewhere. I can't tell.

What I did to test them was to modify
python/sepolgen/tests/test_refparser.py and add an interface to the
interface_example string.

This is what I added:

define(`XPERM1',`0x9901')
interface(`test_extended_permissions',`
    gen_require(`
        type device_t;
    ')
        allow $1 device_t:chr_file {ioctl};
        allowxperm $1 device_t:chr_file ioctl 0x9910;
        dontauditxperm $1 device_t:chr_file ioctl 0x9911;
        auditallowxperm $1 device_t:chr_file ioctl 0x9912;
        neverallowxperm $1 device_t:chr_file ioctl 0x9913;
        allowxperm $1 device_t:chr_file ioctl { 0x9914 };
        allowxperm $1 device_t:chr_file ioctl { 0x9915 0x9916 };
        allowxperm $1 device_t:chr_file ioctl { 0x9917-0x9919 };
        allowxperm $1 device_t:chr_file ioctl XPERM1;
')

I then uncommented the "refpolicy.print_tree(h)" line in test_refparser.py.

If I comment out the definition of XPERM1 and every xperm rule except
the first four (the first allowxperm, dontauditxperm, auditallowxperm,
and neverallowxperm) then the tree will printed out (although the
rules are printed in reverse order). There is one weirdness in that
the operation is printed out as "['ioctl']", but that is not due to
anything in your patches.

If any xperm rule with curly brackets is used or the definition of
XPERM1, then the test_extended_permissions() interface is not printed
out. It appears that parsing is abandoned as soon as one of those
rules is encountered without an error being given. I literally typed
random characters on the line after the definition of XPERM1 and no
error was given.

I don't see any obvious error in what you have done and it is very
possible that the problem is elsewhere. The xperm stuff that is in
sepolgen is strange. In access.py, xperms are stored in the
AccessVector class as a dictionary with the operation being used as
the key. In refpolicy.py, xperms have their own class, AVExtRule, with
the operation being one field and the xperms being another field that
is an XpermSet.

At this point, your patches might remove the parsing errors, but that
will only give a false sense that the xperms are actually being
handled, when they are not.

I am not sure where to go from here. I don't know the python code very well=
.

Thanks,
Jim


> ---
>  python/sepolgen/src/sepolgen/refparser.py | 96 +++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  python/sepolgen/src/sepolgen/refpolicy.py | 18 ++++++++++++++++++
>  2 files changed, 113 insertions(+), 1 deletion(-)
>
>
