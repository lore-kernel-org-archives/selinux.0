Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB41FC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 20:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F82A21874
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 20:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jH9uz9xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfCVUCl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:02:41 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:43614 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCVUCl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 16:02:41 -0400
Received: by mail-lj1-f173.google.com with SMTP id f18so3056456lja.10
        for <selinux@vger.kernel.org>; Fri, 22 Mar 2019 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVhcFvBSU0ilIWQ6zraITGsbJeqbqMeecPM//6iFgS0=;
        b=jH9uz9xZZX2F8LWYXB1jJVPYDGKpnIcwAFsdxCmgl1V2qAjGcgryI9I8IM0mljKQD4
         cZ4mFjNX3Dx2Z5aI24LwSRw9IppAC1Hu1OtSSpRYSWb0zJth/V0rJKI1aGHIekcng5Zf
         LHBqAKbpCB1B5Iy2WmoQ+s9QdwzgT3Qqv1SB+nRwcWGFaiv6fMTNrzcUW/ukYtCeRlQ8
         kGgXsITY6gZnnGZpaAEh1wjrYsDPcbJFqWDc4uqg+/Fy8I+pXfQecwAi2LQMs+WQHaOM
         ON3SD6nvib27G15Z6OCem40jwr29WbT1A2tJv7fKX9DCd8fJGbtCatPD7SRmcGLZK8NP
         Ccng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVhcFvBSU0ilIWQ6zraITGsbJeqbqMeecPM//6iFgS0=;
        b=l5bHK/SIIad6O/iZu+iKfc8Fv48VvKNkXCb2HTG6CJE0aW/1X6WHewdPSoK/jdh3pU
         F8U5h3iwRXQqjIbvQ58J2+LoFN1FRdCH8IicrLIxB0bxCJGEArIMbHUPHZ9miNIVBtpK
         kLqTDKaxQqv0Or4Jo7ZGvNMRPDwcop+J4TbI0Xqu80BUZanLC6VBRFU2A6eUHtI60/fc
         gZ3j7TlGe4u1/kuqw/SmLimC+vRUmgcdsn/o2RTmHeorfWY3T0snbd+5t6GcWQnEs9zB
         MOBzfr1ItV9EfyN47M8mzKtpggxC/imw0nHalZNmbfVqnIwIC6bB8dt3/qAijFIASV+E
         lk6A==
X-Gm-Message-State: APjAAAV6MYXRbRH3ZXrAhiA0tih1P8M35CKJ8mTAPLLY4OEwOP1mREyh
        qPfB237Gd4hZzKVGmqL4pzguGqTb0Ioac1VlpL81
X-Google-Smtp-Source: APXvYqx1sPszIyYrTFmMNiYbIBu5EMB5UYqK1dgtaba+v7+UHYP8hAvhq6PSz4sDL9jUH2b01NQunZsR3JZjZ2T6knk=
X-Received: by 2002:a2e:904b:: with SMTP id n11mr6274461ljg.57.1553284959714;
 Fri, 22 Mar 2019 13:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140400.18892-1-yuehaibing@huawei.com> <CAFqZXNv-u+nAr2F+bYuovqMgvVJaS1LK9kCWXCZCtWGBYGj_cQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv-u+nAr2F+bYuovqMgvVJaS1LK9kCWXCZCtWGBYGj_cQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Mar 2019 16:02:27 -0400
Message-ID: <CAHC9VhR7eUWxB3Fviqtp5ZUtdjJVasVOdF2MbKTgqufa2vXLdg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Make selinux_kernfs_init_security static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 22, 2019 at 1:46 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Mar 22, 2019 at 3:04 PM Yue Haibing <yuehaibing@huawei.com> wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > Fix sparse warning:
> >
> > security/selinux/hooks.c:3389:5: warning:
> >  symbol 'selinux_kernfs_init_security' was not declared. Should it be static?
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Yup, another trivial mistake on my part...
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Thanks for catching that!

Yes, thanks for the patch; I don't always check for static (or
const'ified args) as much as I should when reviewing code.  Merged
into selinux/next.

-- 
paul moore
www.paul-moore.com
