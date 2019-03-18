Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA8CC43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 22:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606372171F
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 22:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Uzz3UsbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfCRW7K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:59:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46257 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCRW7K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 18:59:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id y62so4863566lfc.13
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 15:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UESEmQeWXxfMraEUEpSGJ6efVxP25nU6/26YmOCFa2E=;
        b=Uzz3UsbH1azV4CGh9ZFZfsl3iAQlAEJ69b62dyjSTR7ov7Dlcm5XiC2NTZdpRYfP1N
         4E6JrWoXk8BD8sZeIOfUA7Kp12M8f4eIQJEdTdhbKAqU8Ul+QcWnG8qTkHF31Y+BvfOM
         EB+0MgoRCUqR2uwK/vjbgrU7L7rs0RoeNXVobW6gdnvW5EBSQc5BG6y2H+P6yxIgOtIh
         KD7YLiejams0Y7KPVXHgU4iMv5Xdhggcw1cPm3naHdx4oZWnwLPBhH6E7nbZ2QOiJ4ey
         Sw01f48284HmkX11ZEaCTb9B8hhOqGiHVUjwBJw1sC2gKuHcd3ulNlKylTTlyRYz8+Xb
         o5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UESEmQeWXxfMraEUEpSGJ6efVxP25nU6/26YmOCFa2E=;
        b=q7gvov9Qr+wiN15gL+aHpokglcumYy2J+6ZFcnhdqNc+fMd6tnyDEUvPXBZ6D4y91Q
         ngUSKZL5Z7ruVGg474Ec0MoAvQQC8vxzLQnOKkUgND91KqLL6+nO9Mg9uQuT8LhAONiI
         x/A8zLl96dwwuE/Y2vI227mDbKGbs/T5d4MoQiPM2cnM15Cq2Neohl0Ac/Uzs794NyuX
         q3G7CrrKRwVLeAo0vdMmM364EjzKmrB0q5seJNqhRJH2JbSxJiq/Lp8RcdMOEPwrAwIb
         lo9EU+JoagtfxSf5MLEKZReck8EUgkuK008zG+12X8OsT6i+LwYoJuhixJLFKpX4+uVR
         em8g==
X-Gm-Message-State: APjAAAXhiSYbegFPyDtK7sgENGgVcp018hBHnzuHIlQrdVVb51kjWgEN
        LG5UaCAnbvo2dpdsnvm/eWpOpcdhlScy790AQAFgzM0=
X-Google-Smtp-Source: APXvYqxVHZJDOomrpIZiPsY3wTydeVaPjaNEh6Ex139EK25xHAjKgxaR+wCmeO9wQGaPjYnOeCX2OD/DkKF2zVhaI14=
X-Received: by 2002:ac2:5205:: with SMTP id a5mr11648849lfl.102.1552949947327;
 Mon, 18 Mar 2019 15:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190225005528.28371-1-paulo@paulo.ac> <87y36170y2.fsf@paulo.ac>
 <CAHC9VhSaMcD232ZzXuS16usQL2DHSZRy5JqtFZWkjV+h6eUztw@mail.gmail.com> <87bm2xm8jv.fsf@paulo.ac>
In-Reply-To: <87bm2xm8jv.fsf@paulo.ac>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Mar 2019 18:58:55 -0400
Message-ID: <CAHC9VhRrnAurS=pOoDLyKRzzy20ue4dzqtzrW1Tc_75-QNavrg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use kernel linux/socket.h definitions for PF_MAX
To:     Paulo Alcantara <paulo@paulo.ac>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 27, 2019 at 12:46 PM Paulo Alcantara <paulo@paulo.ac> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Wed, Feb 27, 2019 at 12:07 PM Paulo Alcantara <paulo@paulo.ac> wrote:
> >> Paulo Alcantara <paulo@paulo.ac> writes:
> >> > When compiling genheaders and mdp from a newer host kernel, the
> >> > following error happens:
> >> >
> >> >     In file included from scripts/selinux/genheaders/genheaders.c:18:
> >> >     ./security/selinux/include/classmap.h:238:2: error: #error New
> >> >     address family defined, please update secclass_map.  #error New
> >> >     address family defined, please update secclass_map.  ^~~~~
> >> >     make[3]: *** [scripts/Makefile.host:107:
> >> >     scripts/selinux/genheaders/genheaders] Error 1 make[2]: ***
> >> >     [scripts/Makefile.build:599: scripts/selinux/genheaders] Error 2
> >> >     make[1]: *** [scripts/Makefile.build:599: scripts/selinux] Error 2
> >> >     make[1]: *** Waiting for unfinished jobs....
> >> >
> >> > Instead of relying on the host definition, include linux/socket.h in
> >> > classmap.h to have PF_MAX.
> >> >
> >> > Signed-off-by: Paulo Alcantara <paulo@paulo.ac>
> >> > ---
> >> >  scripts/selinux/genheaders/genheaders.c | 1 -
> >> >  scripts/selinux/mdp/mdp.c               | 1 -
> >> >  security/selinux/include/classmap.h     | 1 +
> >> >  3 files changed, 1 insertion(+), 2 deletions(-)
> >>
> >> Ping?
> >>
> >> Could someone please take a look at this issue?
> >
> > It looks fine to me, but I typically don't merge patches this late in
> > the development window (we are at -rc8), unless it is a serious bug
> > fix.
>
> Fair enough.
>
> >> It's quite easy to reproduce on my host (4.20+) when building an
> >> unpatched 4.14 kernel ...
> >
> > While this is a good patch that does fix a real but, the fact that it
> > has been broken for several releases tells me this is not a serious
> > bug and not likely worth the risk for the upcoming merge window
> > (however small it may be).  There has been a lot of good work put into
> > mdp very recently, and I expect to merge that, as well as your fix,
> > once the upcoming merge window closes.
>
> Looks good to me. Thanks!

Merged into selinux/next, thanks for the patch and your patience.

-- 
paul moore
www.paul-moore.com
