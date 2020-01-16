Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606EC33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 19:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB2206D9
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 19:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IIGbVp5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgAPTd3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:33:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42657 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgAPTd3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 14:33:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so23875395ljj.9
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4RHKOZKelC3geKpblrBLKeAEswsnkBhqDgjIN2ojg8=;
        b=IIGbVp5fBm4iclpZHJbynFp/ZCPymI7IBx/8jbAlhGoEZMuyJTf5hmRhaZY51rJsev
         S6TrrA4FkbPJkL7Ni+ZD6YXGU9sGrdbNiR5r+IVru5UBhJrbf8D7sAJJX211gYAFjse1
         rmxPhHCRvOhBa3R9Ygw1XkT/rjSqTww0lLVo2NdRILBtMpsUTKs1wEc69ccooyZ845Os
         RDZ4zgqlK3fDqub+duknPgRW5siIMlBpptJCm5m9NBWCWNHO2Zq683sC5xg2b/1xrQCd
         Or5uD8UJMzHaDuRK9tpZ2lASDoIu3oOBC9XAE19+TBf4I2gWu2chiuzXQqq4A08+pTQC
         6OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4RHKOZKelC3geKpblrBLKeAEswsnkBhqDgjIN2ojg8=;
        b=KykIoT57JUrn4c8G/pLNCLbIONRRdQsmZzfQYyMOiG8Cyuzz2Cawr+b2OaqKrz7Wkn
         kzZN9q/eUHMmLH/dLiSyikKJYYCgvH/Fmlo7sXhL2XahGpO/yWXSVQ1aXP6SndERy1qk
         bRqCB0YrlREU0XY1fnB6LdE9Zlmr0cB/t80amblzY4WgWtHvRTBmn+O31o+rIPt0UWBG
         brihE68p1ml/sX1GTqdk3ye+Slsz1W9sO7DNfo0mmPDN1iCcoZQssgmROsXbU1fUIm0v
         qezWHGKXQgS7zjUiBfrvg8ZGbZs2/oi1YzL27Y3wDYaRH1fMhP3P+vH9uUPVMXE2Hop0
         +oEQ==
X-Gm-Message-State: APjAAAWGoNnEcaeIEqCJbHvICHBSGy9zDbyfwzz7TyNOXIM3YxxJWp3l
        2mvek3oJutnaOJOoI+03tnevI2drEIhABz23pkQ+s3c=
X-Google-Smtp-Source: APXvYqwuYYB8iRLH/rW72+dnj0zP+MwOiHIR4QxJSRJ4D5Blg4DSgf+D254pgwbObQOgA3wf/B/W+nUGjEdwH0Rl1aY=
X-Received: by 2002:a2e:8152:: with SMTP id t18mr3002321ljg.255.1579203207674;
 Thu, 16 Jan 2020 11:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20200116184557.344610-1-omosnace@redhat.com>
In-Reply-To: <20200116184557.344610-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 14:33:17 -0500
Message-ID: <CAHC9VhSx50ZkXEfUd_WQS6M5SL5Ua0_n+vR1T0XjGikKR__yBg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix wrong buffer types in policydb.c
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 16, 2020 at 1:46 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Two places used u32 where there should have been __le32.
>
> Fixes sparse warnings:
>   CHECK   [...]/security/selinux/ss/services.c
> [...]/security/selinux/ss/policydb.c:2669:16: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2669:16:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2669:16:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2674:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2674:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2674:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2675:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2675:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2675:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2676:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2676:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2676:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2681:32: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2681:32:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2681:32:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2701:16: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2701:16:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2701:16:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2706:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2706:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2706:24:    got restricted __le32 [usertype]
> [...]/security/selinux/ss/policydb.c:2707:24: warning: incorrect type in assignment (different base types)
> [...]/security/selinux/ss/policydb.c:2707:24:    expected unsigned int
> [...]/security/selinux/ss/policydb.c:2707:24:    got restricted __le32 [usertype]
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/ss/policydb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
