Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67324C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F592078B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 18:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LqJfuXEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgGISV6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGISV5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 14:21:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A42C08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 11:21:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so2595288edb.3
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LX6FYQ8KvPT7Sv99otzCioTUqxDQNzCz28DkT+W5Eg=;
        b=LqJfuXEbq2d+AbCpSDjod8KuqiJJzJLpl2AGMerdE8uejKuWFXVcHpPNX3+Bm0bXli
         c/IwsbTnyvBT7+ZX/+Vv7nlOSeU4e/ay0u+Z3UoaQ++0eZfdWOqRYhfmbW1auYHM9Cmm
         QE3D6n5yuHbKxuXFOZZIM5h4ahZf1rr62LPLUYptqysjjFHZpNQNogZwwzIRYmVqazSt
         D3XeZI79ES/CkVfOjbfNxkWtFVhWdakaOWJ47R+fcN/IGNtuKuT6F5C3V3Pm5nnMou9N
         CzpD7oHHsLlrrTOu/YA6WuHi1MhaiqDbml2PoiRwDjM0+hr+0tcgUvUpW6UECE+6d/Bb
         6Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LX6FYQ8KvPT7Sv99otzCioTUqxDQNzCz28DkT+W5Eg=;
        b=Mxv/kvdTDp6sAweX1j2UUnKkDe1RQTpinfs3O8fkeJ8ZMNU2Jgk10y+RzBFybB3LMk
         UCt9d3qkgMG1y7d3RioE5LLvUhsv6Yhup14iBdiJpTv2rKYGrlduMUz5vpim19yWk5uE
         +/tvsh0qLe6cRDkjIOmHzOigd7EH76d0zOnmPVQHV46P7lnLfnWBLrT3uHXEkXN3hBF5
         KQz3x+iNMSi85yZcvkR8DFnm88Jzrbwm7bw9vx7mJfGWk9GJsKxetlEhyATiTzpxTKin
         Wj/DypxsSGytpfBMWGchBfpWML6RAYKIrpC2qr7LWMog6NVQoWcjsgVA2Op4eNdXrhNX
         MNMA==
X-Gm-Message-State: AOAM533aCiu3KfKNdhcQmGl+28Rjl9+m8K24tnJDD5gxOUMqHXWIlzpv
        NSllztHeSeYHaFFqa/d8botIui/YVFan2U9lCiyx/aILTA==
X-Google-Smtp-Source: ABdhPJxN2pld2Fd5sMpn9CN11z475uiLVs6Tso6ANcthJ4mNIfLmitAvypwxHSnGlVdjeh5aWV+RRZMStjVTnXlPh/k=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr52784037edy.135.1594318916236;
 Thu, 09 Jul 2020 11:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200709075056.1670642-1-dominick.grift@defensec.nl> <47c6b95c59fd088bed61761c78e38bc04b9506d2.camel@btinternet.com>
In-Reply-To: <47c6b95c59fd088bed61761c78e38bc04b9506d2.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Jul 2020 14:21:45 -0400
Message-ID: <CAHC9VhQvtuDb-u8RYx2JShPEd9i9_LGCbU81Q8tb03kSJ6N0MQ@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] auditing.md: describe avc record
 permissive keyword
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 10:14 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Thu, 2020-07-09 at 09:50 +0200, Dominick Grift wrote:
> > This was added to Linux 4.17 via "selinux: Report permissive mode in
> > avc: denied messages."
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > ---
> >  src/auditing.md | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
> Acked-by: Richard Haines <richard_c_haines@btinternet.com>

Merged into the main branch, thanks Dominick!

> > diff --git a/src/auditing.md b/src/auditing.md
> > index 19f8be6..295373a 100644
> > --- a/src/auditing.md
> > +++ b/src/auditing.md
> > @@ -161,6 +161,12 @@ section that follows.
> >  <td>tclass</td>
> >  <td>The object class of the target or object.</td>
> >  </tr>
> > +<tr>
> > +<td>permissive</td>
> > +<td>Keyword introduced in Linux 4.17 to indicate whether the event
> > +was denied or granted due to global or per-domain permissive
> > +mode.</td>
> > +</tr>
> >  </tbody>
> >  </table>

-- 
paul moore
www.paul-moore.com
