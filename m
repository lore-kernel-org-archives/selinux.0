Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5937BC05027
	for <selinux@archiver.kernel.org>; Thu,  9 Feb 2023 14:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBIOcU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjBIOcL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Feb 2023 09:32:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0F20059
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 06:32:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rp23so6868337ejb.7
        for <selinux@vger.kernel.org>; Thu, 09 Feb 2023 06:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lkuVh+mzjkJKLi8HYy7J16Z9bzL+4ak7Mo0ACog/A4=;
        b=EFsMkPU39+fNDKyC3S9Dw6FvlQigx3SnSd238loQFmRlLH6ws7gSuc8EJsMy8zAeBa
         /PrITOOFGqr3G7SiTJBgUN4vgLhtvGQyJKxn5tI6yvE4QfJKUIZzyvlD2nqxIiwmYrVp
         gtzv/qlJoDiNxEX1rfaLvspKtVHWdv+A+rfsGfMuPryfqwGkv4jbL+UWQzzQiEMxen1b
         L5oXENA6vYv4jq9t75cO1b/ViCNa2xM31NBfMScaI10WLruL7NNO+xGFxdhoUKvYXwsN
         Rl4Q18oS6st3dQWDZ8ZqTgi0eKxjMbpxsKQXQDX2yJhVvKdkL+cnWMfLXzI9/vtUOrIn
         PUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lkuVh+mzjkJKLi8HYy7J16Z9bzL+4ak7Mo0ACog/A4=;
        b=3LQfv6t6ZxW74Tgk9ne6OSpJjkAhk0etf9mOxX3Ed/lUTMLtwYs8zXMOBNWKTAGzaY
         19IOR6Ov//dPEiPXDtoeIwbE1pfOoUjBuTMWW/UGI3mxV/6cUxYBCQcvVhYjPhagB/aN
         M+8P+l2HMf9/JDajS+q5r9K6aTWEU/K2YxdZ8byfOX5Pko9QMSQYpaju7nlS/7AHmsa4
         Dat4x2W3SkEbVtA6yhzWOCFz/eLSwQw4JVwcKfhywQqbdCGnIGzNVA88IDg5lHrAik1L
         meJWyIkA2ZcNSiVLsE2LU09mx0gDEMujqWrXxk5MDGAKOuTaCq083KdgA0sBGSb7Kxrl
         iftg==
X-Gm-Message-State: AO0yUKVYnifxsN0vVBenAFevSdnKk9roTQff2MWF2JZzNH10um1QiPGG
        N/HlBfR5mrK3gegbQVhUvn/QdSqS8uknHsPuASH5xetL
X-Google-Smtp-Source: AK7set8ezAsaK6PcIEESExGraluKDDljDjZlIQWyTT5knQG2yVCigEyW1N7X447NQsStfk3aCIrZMYxTZZ6CUlZ0cIE=
X-Received: by 2002:a17:906:4ccf:b0:883:ba3b:eb94 with SMTP id
 q15-20020a1709064ccf00b00883ba3beb94mr531599ejt.3.1675953122609; Thu, 09 Feb
 2023 06:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20221215213429.998948-1-jwcart2@gmail.com> <20221215213429.998948-9-jwcart2@gmail.com>
 <c160c7b6-81b7-208e-1d68-5175bcb2f272@linux.microsoft.com>
In-Reply-To: <c160c7b6-81b7-208e-1d68-5175bcb2f272@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Feb 2023 09:31:51 -0500
Message-ID: <CAP+JOzTbmk_wiTBiYMWGzxZif9kvxOOTSA5+KTz738B=j3LkvA@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] secilc/test: Add a deny rule test
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 3, 2023 at 5:54 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 12/15/2022 4:34 PM, James Carter wrote:
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >   secilc/test/deny_rule_test.cil | 384 +++++++++++++++++++++++++++++++++
> >   1 file changed, 384 insertions(+)
> >   create mode 100644 secilc/test/deny_rule_test.cil
> >
> > diff --git a/secilc/test/deny_rule_test.cil b/secilc/test/deny_rule_test.cil
> > new file mode 100644
> > index 00000000..3ef4ac98
> > --- /dev/null
> > +++ b/secilc/test/deny_rule_test.cil
> > @@ -0,0 +1,384 @@
> > +(class CLASS (PERM))
> > +(class C1 (p1a p1b p1c p1d))
> > +(class C2 (p2a p2b p2c p2d))
> > +(class C3 (p3a p3b p3c p3d))
> > +(class C4 (p4a p4b p4c p4d))
> > +(classorder (CLASS C1 C2 C3 C4))
> > +(sid SID)
> > +(sidorder (SID))
> > +(user USER)
> > +(role ROLE)
> > +(type TYPE)
> > +(category CAT)
> > +(categoryorder (CAT))
> > +(sensitivity SENS)
> > +(sensitivityorder (SENS))
> > +(sensitivitycategory SENS (CAT))
> > +(allow TYPE self (CLASS (PERM)))
> > +(roletype ROLE TYPE)
> > +(userrole USER ROLE)
> > +(userlevel USER (SENS))
> > +(userrange USER ((SENS)(SENS (CAT))))
> > +(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
> > +
> > +(classmap cm5 (mp5a mp5b))
> > +(classmapping cm5 mp5a
> > +           (C2 (p2a p2b)))
> > +(classmapping cm5 mp5b
> > +           (C2 (p2c p2d)))
> > +
> > +(classpermission cp6)
> > +(classpermissionset cp6 (C3 (p3a p3b)))
> > +(classpermissionset cp6 (C4 (p4a p4b)))
> > +
> > +(classpermission cp7)
> > +(classpermissionset cp7 (C2 (p2a p2b)))
> > +(classpermissionset cp7 (C2 (p2c p2d)))
> > +
> > +; Test 1
> > +(type t01a)
> > +(type t01b)
> > +(allow t01a t01b (C1 (p1a)))
> > +(deny t01a t01b (C1 (p1a)))
> > +(neverallow t01a t01b (C1 (p1a)))
> > +
> > +; Test 2
> > +(type t02a)
> > +(type t02b)
> > +(allow t02a t02b (C1 (p1a p1b)))
> > +(deny t02a t02b (C1 (p1a)))
> > +(neverallow t02a t02b (C1 (p1a)))
> > +; (neverallow t02a t02b (C1 (p1b))) ; This check should fail
> > +
> > +; Test 3
> > +(type t03a)
> > +(type t03b)
> > +(allow t03a t03b (C1 (p1a)))
> > +(deny t03a t03b (C1 (p1a p1b)))
> > +(neverallow t03a t03b (C1 (p1a p1b)))
> > +
> > +
> > +; Test 11
> > +(type t11a)
> > +(type t11b)
> > +(type t11c)
> > +(type t11d)
> > +(typeattribute a11a)
> > +(typeattribute a11b)
> > +(typeattributeset a11a (t11a t11b))
> > +(typeattributeset a11b (t11c t11d))
> > +(allow a11a a11b (C1 (p1a)))
> > +(deny a11a a11b (C1 (p1a)))
> > +(neverallow a11a a11b (C1 (p1a)))
> > +
> > +; Test 12
> > +(type t12a)
> > +(type t12b)
> > +(type t12c)
> > +(type t12d)
> > +(typeattribute a12a)
> > +(typeattribute a12b)
> > +(typeattributeset a12a (t12a t12b))
> > +(typeattributeset a12b (t12c t12d))
> > +(allow t12a t12c (C1 (p1a)))
> > +(deny a12a a12b (C1 (p1a)))
> > +(neverallow a12a a12b (C1 (p1a)))
> > +
> > +; Test 13
> > +(type t13a)
> > +(type t13b)
> > +(type t13c)
> > +(type t13d)
> > +(typeattribute a13a)
> > +(typeattribute a13b)
> > +(typeattributeset a13a (t13a t13b))
> > +(typeattributeset a13b (t13c t13d))
> > +(allow a13a a13b (C1 (p1a)))
> > +(deny t13a t13c (C1 (p1a)))
> > +(neverallow t13a t13c (C1 (p1a)))
> > +; (neverallow t13b t13d (C1 (p1a))) ; This check should fail
> > +
> > +; Test 21
> > +(type t21a)
> > +(type t21b)
> > +(allow t21a t21b (cm5 (mp5a)))
> > +(deny t21a t21b (cm5 (mp5a)))
> > +(neverallow t21a t21b (cm5 (mp5a)))
> > +
> > +; Test 22
> > +(type t22a)
> > +(type t22b)
> > +(allow t22a t22b (cm5 (mp5a mp5b)))
> > +(deny t22a t22b (cm5 (mp5a)))
> > +(neverallow t22a t22b (cm5 (mp5a)))
> > +; (neverallow t22a t22b (cm5 (mp5b))) ; This check should fail
> > +
> > +; Test 23
> > +(type t23a)
> > +(type t23b)
> > +(allow t23a t23b (cm5 (mp5a)))
> > +(deny t23a t23b (cm5 (mp5a mp5b)))
> > +(neverallow t23a t23b (cm5 (mp5a mp5b)))
> > +
> > +; Test 24
> > +(type t24a)
> > +(type t24b)
> > +(allow t24a t24b (C2 (p2a)))
> > +(deny t24a t24b (cm5 (mp5a)))
> > +(neverallow t24a t24b (cm5 (mp5a)))
> > +
> > +; Test 25
> > +(type t25a)
> > +(type t25b)
> > +(allow t25a t25b (cm5 (mp5a)))
> > +(deny t25a t25b (C2 (p2a)))
> > +(neverallow t25a t25b (C2 (p2a)))
> > +; (neverallow t25a t25b (C2 (p2b))) ; This check should fail
> > +
> > +; Test 31
> > +(type t31a)
> > +(type t31b)
> > +(allow t31a t31b cp6)
> > +(deny t31a t31b cp6)
> > +(neverallow t31a t31b cp6)
> > +
> > +; Test 32
> > +(type t32a)
> > +(type t32b)
> > +(allow t32a t32b cp6)
> > +(deny t32a t32b (C3 (p3a p3b)))
> > +(neverallow t32a t32b (C3 (p3a p3b)))
> > +; (neverallow t32a t32b (C4 (p4a p4b))) ; This check should fail
> > +
> > +; Test 33
> > +(type t33a)
> > +(type t33b)
> > +(allow t33a t33b (C3 (p3a)))
> > +(deny t33a t33b cp6)
> > +(neverallow t33a t33b cp6)
> > +
> > +; Test 34
> > +(type t34a)
> > +(type t34b)
> > +(allow t34a t34b cp7)
> > +(deny t34a t34b (cm5 (mp5a mp5b)))
> > +(neverallow t34a t34b (cm5 (mp5a mp5b)))
> > +
> > +; Test 35
> > +(type t35a)
> > +(type t35b)
> > +(allow t35a t35b (cm5 (mp5a mp5b)))
> > +(deny t35a t35b cp7)
> > +(neverallow t35a t35b cp7)
> > +
> > +; Test 41
> > +(type t41a)
> > +(allow t41a self (C1 (p1a)))
> > +(deny t41a self (C1 (p1a)))
> > +(neverallow t41a self (C1 (p1a)))
> > +
> > +; Test 42
> > +(type t42a)
> > +(allow t42a self (C1 (p1a)))
> > +(deny t42a t42a (C1 (p1a)))
> > +(neverallow t42a t42a (C1 (p1a)))
> > +
> > +; Test 43
> > +(type t43a)
> > +(allow t43a t43a (C1 (p1a)))
> > +(deny t43a self (C1 (p1a)))
> > +(neverallow t43a self (C1 (p1a)))
> > +
> > +; Test 51
> > +(type t51a)
> > +(type t51b)
> > +(typeattribute a51a)
> > +(typeattributeset a51a (t51a t51b))
> > +(allow a51a self (C1 (p1a)))
> > +(deny a51a self (C1 (p1a)))
> > +(neverallow a51a self (C1 (p1a)))
> > +
> > +; Test 52
> > +(type t52a)
> > +(type t52b)
> > +(typeattribute a52a)
> > +(typeattributeset a52a (t52a t52b))
> > +(allow t52a self (C1 (p1a)))
> > +(deny a52a self (C1 (p1a)))
> > +(neverallow a52a self (C1 (p1a)))
> > +
> > +; Test 53
> > +(type t53a)
> > +(type t53b)
> > +(typeattribute a53a)
> > +(typeattributeset a53a (t53a t53b))
> > +(allow a53a self (C1 (p1a)))
> > +(deny t53a self (C1 (p1a)))
> > +(neverallow t53a self (C1 (p1a)))
> > +; (neverallow t53b self (C1 (p1a))) ; This check should fail
> > +
> > +; Test 54
> > +(type t54a)
> > +(type t54b)
> > +(typeattribute a54a)
> > +(typeattributeset a54a (t54a t54b))
> > +(allow a54a self (C1 (p1a)))
> > +(deny a54a a54a (C1 (p1a)))
> > +(neverallow a54a a54a (C1 (p1a)))
> > +
> > +; Test 55
> > +(type t55a)
> > +(type t55b)
> > +(typeattribute a55a)
> > +(typeattributeset a55a (t55a t55b))
> > +(allow a55a a55a (C1 (p1a)))
> > +(deny a55a self (C1 (p1a)))
> > +(neverallow a55a self (C1 (p1a)))
> > +; (neverallow t55a t55b (C1 (p1a))) ; This check should fail
> > +; (neverallow t55b t55a (C1 (p1a))) ; This check should fail
> > +
> > +; Test 61
> > +(type t61a)
> > +(type t61b)
> > +(type t61c)
> > +(type t61d)
> > +(type t61e)
> > +(type t61f)
> > +(type t61g)
> > +(type t61h)
> > +(type t61i)
> > +(type t61j)
> > +(type t61k)
> > +(type t61l)
> > +(type t61m)
> > +(type t61n)
> > +(type t61o)
> > +(type t61p)
> > +(type t61q)
> > +(type t61r)
> > +(type t61s)
> > +(type t61t)
> > +(typeattribute a61a)
> > +(typeattribute a61b)
> > +(typeattribute a61c)
> > +(typeattribute a61x)
> > +(typeattribute a61s)
> > +(typeattribute a61t)
> > +(typeattributeset a61a (t61a t61b t61c t61d t61e t61f t61g t61h t61o t61p))
> > +(typeattributeset a61b (t61a t61b t61c t61d t61i t61j t61k t61l t61q t61r))
> > +(typeattributeset a61c (t61a t61b t61e t61f t61i t61j t61m t61n t61s t61t))
> > +(typeattributeset a61x (t61a t61b))
> > +(typeattributeset a61s (t61c t61d t61e t61f t61g t61h t61o t61p))
> > +(typeattributeset a61t (t61c t61d t61i t61j t61k t61l t61q t61r))
>
> Was the intention to have a failing check on a61x below?  I don't see
> a61x referenced anywhere except where it was declared and set.
>
> -Daniel
>

It probably was and then I decided that I didn't need it. I don't
know. It definitely is not needed now.
Thanks,
Jim


> > +(allow a61a a61b (C1 (p1a)))
> > +(deny a61c self (C1 (p1a)))
> > +(neverallow a61c self (C1 (p1a)))
> > +; (neverallow a61s a61b (C1 (p1a))) ; This check should fail
> > +; (neverallow a61a a61t (C1 (p1a))) ; This check should fail
> > +; (neverallow t61a t61b (C1 (p1a))) ; This check should fail
> > +; (neverallow t61b t61a (C1 (p1a))) ; This check should fail
> > +
> > +; Test 62
> > +(type t62a)
> > +(type t62b)
> > +(type t62c)
> > +(type t62d)
> > +(type t62e)
> > +(type t62f)
> > +(type t62g)
> > +(type t62h)
> > +(type t62i)
> > +(type t62j)
> > +(type t62k)
> > +(type t62l)
> > +(type t62m)
> > +(type t62n)
> > +(type t62o)
> > +(type t62p)
> > +(type t62s)
> > +(type t62t)
> > +(type t62u)
> > +(type t62v)
> > +(typeattribute a62a)
> > +(typeattribute a62c)
> > +(typeattribute a62d)
> > +(typeattribute a62s)
> > +(typeattributeset a62a (t62a t62b t62c t62d t62e t62f t62g t62h t62o t62p))
> > +(typeattributeset a62c (t62a t62b t62e t62f t62i t62j t62m t62n t62s t62t))
> > +(typeattributeset a62d (t62a t62b t62g t62h t62k t62l t62m t62n t62u t62v))
> > +(typeattributeset a62s (t62c t62d t62e t62f t62g t62h t62o t62p))
> > +(allow a62a self (C1 (p1a)))
> > +(deny a62c a62d (C1 (p1a)))
> > +(neverallow a62c a62d (C1 (p1a)))
> > +; (neverallow a62s self (C1 (p1a))) ; This check should fail
> > +
> > +; Test 63
> > +(type t63a)
> > +(type t63b)
> > +(type t63c)
> > +(type t63d)
> > +(type t63e)
> > +(type t63f)
> > +(type t63g)
> > +(type t63h)
> > +(type t63i)
> > +(type t63j)
> > +(type t63k)
> > +(type t63l)
> > +(type t63m)
> > +(type t63n)
> > +(type t63o)
> > +(type t63p)
> > +(type t63s)
> > +(type t63t)
> > +(typeattribute a63a)
> > +(typeattribute a63c)
> > +(typeattribute a63s)
> > +(typeattributeset a63a (t63a t63b t63c t63d t63e t63f t63g t63h t63o t63p))
> > +(typeattributeset a63c (t63a t63b t63e t63f t63i t63j t63m t63n t63s t63t))
> > +(typeattributeset a63s (t62c t62d t62e t62f t62g t62h t62o t62p))
> > +(allow a63a self (C1 (p1a)))
> > +(deny a63c self (C1 (p1a)))
> > +(neverallow a63c self (C1 (p1a)))
> > +; (neverallow a63s self (C1 (p1a))) ; This check should fail
> > +
> > +; Test 64
> > +(type t64a)
> > +(type t64b)
> > +(type t64c)
> > +(type t64d)
> > +(type t64e)
> > +(type t64f)
> > +(type t64g)
> > +(type t64h)
> > +(type t64i)
> > +(type t64j)
> > +(type t64k)
> > +(type t64l)
> > +(type t64m)
> > +(type t64n)
> > +(type t64o)
> > +(type t64p)
> > +(type t64q)
> > +(type t64r)
> > +(type t64s)
> > +(type t64t)
> > +(type t64u)
> > +(type t64v)
> > +(typeattribute a64a)
> > +(typeattribute a64b)
> > +(typeattribute a64c)
> > +(typeattribute a64d)
> > +(typeattribute a64s)
> > +(typeattribute a64t)
> > +(typeattributeset a64a (t64a t64b t64c t64d t64e t64f t64g t64h t64o t64p))
> > +(typeattributeset a64b (t64a t64b t64c t64d t64i t64j t64k t64l t64q t64r))
> > +(typeattributeset a64c (t64a t64b t64e t64f t64i t64j t64m t64n t64s t64t))
> > +(typeattributeset a64d (t64a t64b t64g t64h t64k t64l t64m t64n t64u t64v))
> > +(typeattributeset a64s (t64c t64d t64g t64h t64o t64p))
> > +(typeattributeset a64t (t64c t64d t64i t64j t64q t64r))
> > +(allow a64a a64b (C1 (p1a)))
> > +(deny a64c a64d (C1 (p1a)))
> > +(neverallow a64c a64d (C1 (p1a)))
> > +; (neverallow a64s a64b (C1 (p1a))) ; This check should fail
> > +; (neverallow a64a a64t (C1 (p1a))) ; This check should fail
>
