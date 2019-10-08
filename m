Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4572DC4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 21:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7A2070B
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 21:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="S+3ss73w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJHVle (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:41:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46740 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfJHVle (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Oct 2019 17:41:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id d1so296405ljl.13
        for <selinux@vger.kernel.org>; Tue, 08 Oct 2019 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tea+i6hUyZDX387BDjZl5C+j+DnXizz4Oy6xV7KtGLM=;
        b=S+3ss73wUuY/Whxv1vfyWmEuVE4Y/ulLnhCWZsLy59Zm6Zd0HAyeMymobZxUXkBndb
         AuRv3xD6LAvHIAQdW7Q/MOluSVBrWKIzXg2UrYu93iNm95dQIlJ0ALB43GWdKFhWhVAk
         hcCNtaEmN91UqvUCl1lTKj+vyBU1ecG2ffLrwa0dqrOEOsKHg1KEMZ4mmzzdXVTOoDLD
         erR48X7U+5HEAnPMytdKbvrdBr2HjRxNNhKGrYa2dOrqj++J0Nl9qyzaqxpBTmXlHcdn
         ey2OphHedgiUf4cftmSOi1KY8hsj+5A4nDmCFWUo48d0VSmlVEsEBi6d23eiWuTiMWAP
         7UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tea+i6hUyZDX387BDjZl5C+j+DnXizz4Oy6xV7KtGLM=;
        b=sLVegYH+OQBGj1vnDs4/tPsmVhHL/uO7nkkBQcVTCCR/vYKMxGn2WrL6gH7QBWgZpl
         o37XuqGXDG8zGukZ5Zbf7w9yHdfqtnYNnRa6d3qcSsjXCGixjg+y3feCqF9birnE3QMO
         2XdKSU6w1TyqoekSz03gRpA+V0Gblz8lDcqPB8bZ3mTPggOPFzSkvCepzDuDz1m80ERn
         0QEi7Lg42XNi60dj6pbk1cYR5ybVomnEN7jvzk40z/ETAlme4PsUk1+vpBvlhbLD3ejV
         eIrDP5FxmBiZK39bUaQRJWiM7IXNQCeFHXBx/eNvfauWqT5yaWdFzaQPoWh6hV+phUov
         0oUA==
X-Gm-Message-State: APjAAAUi7IbrVsloHlNcUkB81lVo3qTKF9gqV1TsPMj4FZ5Rkub+id7g
        3LpuUrmGrKVyIoHnP1oxLi9NJEjV3fx6IZ+sWIJxN6c=
X-Google-Smtp-Source: APXvYqxzxK6cBClJeSFHzadcRJn3nxeAdWq8CcicFCify1KhUkx84oNYkO3j4t40qpSKit9q4QfyjmUg1dj2NVd52Y8=
X-Received: by 2002:a2e:1b52:: with SMTP id b79mr183839ljb.225.1570570892266;
 Tue, 08 Oct 2019 14:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
 <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov> <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
In-Reply-To: <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Oct 2019 17:41:21 -0400
Message-ID: <CAHC9VhScXPhbW14fUTpLW1SXE7YTffRoy9tqpgeWYnwYxm93kw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 7, 2019 at 11:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2019-10-07 at 10:28 -0400, Stephen Smalley wrote:
> > On 10/6/19 4:51 AM, Richard Haines wrote:
> > > Kernel 5.4 commit ca2864c6e8965c37df97f11e6f99e83e09806b1c
> > > ("binder: Add
> > > default binder devices through binderfs when configured"), changed
> > > the way
> > > the binder device is initialised and no longer automatically
> > > generates
> > > /dev/binder when CONFIG_ANDROID_BINDERFS=y.
> >
> > This seems like a userspace ABI break, no?  Same kernel config
> > before
> > and after this commit yields different behavior for /dev/binder.  I
> > suppose one might argue that one would only enable
> > CONFIG_ANDROID_BINDERFS if one wanted to use it instead of
> > /dev/binder
> > but the original commit that introduced binderfs specifically said
> > that
> > backward compatibility was preserved.
> I'll need to check this further, but from what I've seen so far, is
> that the /dev/binder is not available until you mount binderfs etc.
> that's why Paul had the failure on 5.4 as before then is was available
> when the binder driver first initialised.
>
> If indeed the above binder commit is seen as breaking backwards
> compatability, then this patch would not be needed (although it does
> tidy up some areas).

My guess is that the binder folks don't view this as a backwards
compatibility issue since you have to enable binderfs first.  I'm
honestly not sure how many distro kernels, outside Android, enable
this anyway; the secnext kernels explicitly patch the Rawhide kernel
config to enable binder.

> > > These changes implement the following:
> > > Kernel < 5.0 - use /dev/binder that is set by:
> > >      CONFIG_ANDROID_BINDER_DEVICES="binder"
> > > Kernel >= 5.0 - use /dev/binder-test that will be generated by the
> > > test
> > > using binderfs services.
> >
> > So you switch to using binderfs for any kernel that supports it (5.0
> > or
> > later) rather than only at the point where it ceases to be
> > backward-compatible (5.4)?  Not objecting per se, but wanted to
> > clarify
> > the discrepancy between distinguishing based on 5.0 here even though
> > the
> > breaking change doesn't occur until 5.4.
>
> Yes I decided that as I'm only testing binder SELinux, then I would use
> the original /dev/binder on < 5.0 and test binderfs on 5.0+. If you
> would like the tests more specific just let me know (I made the
> assumption that the binder team would have tests for their bits).

When in doubt, I think it is better to assume that there are *no*
tests.  Unfortunately It has been my experience that this holds true
more often than not.

-- 
paul moore
www.paul-moore.com
