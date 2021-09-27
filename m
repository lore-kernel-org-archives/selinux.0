Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2907C433EF
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 14:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6B360F46
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 14:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhI0OJf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhI0OJf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 10:09:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68EAC061575
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 07:07:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l8so22207962edw.2
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8m23xDtfPXR13fcDGGniJRw6agexSiLkTr6Fmkp1eA=;
        b=uQ6J2koMhmTfaJLCA7xaYRy0c2g+6D8ORbjV1n1ju8hEwnVm8tIP+TPo1hbyYJpM8o
         z9YCdd5gpKN3Iyh8Ssbloqw/N4vituYsndhz+Cy8Cmm2m/A+9i6ys+xUPmaIuU1o/L4c
         mUkYo4NThnHtCFasWEvySCtIKAWyeZVYYI1mrQVCDQI1DleQdjHITMvB5YO/T47YHr03
         YkwUB+3qxxJhxZw0XoBYuwhcYwWYJwArY3sadbBQx/zuEUOlGJPFTKCjtT8rzUZJfgWP
         rFc5L01GMfbcS02pLfyg2xj9uqijQF9oCe5GqjXxsZ6tDR4qnBJcKaFLls3eScLwSq5S
         UN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8m23xDtfPXR13fcDGGniJRw6agexSiLkTr6Fmkp1eA=;
        b=jocNjobusUQH5IawQ7vLAYnO6zHpaVF/hHbdI2SKIGcaoYoVqfGXf3AOR5JKfQv3Mm
         Oe2TughbsSMaqMOhaqsBZuxPCOek+42EqBDdqjNaiM9MogjQVtpDhuc9fKRylRgSr/Uy
         Fa+0OHJhaSdNhU+BU/67bd7Wqh5FoFkmkiEYyGBPOB6P1U0dTTDFBsHid4xweELQ3hNZ
         LYo4MFYgWFu3Kyr/Qs/Srll/oVaD5AqAjt8hF5ELp/ZyTWDjrE4d9TIrtk63etqkhari
         c/ENDB318ovZZZujh7KvgAluaMKaBH8SDPOA6WliOYWsg6krx2rw2dyse2lSrRqP7FTR
         YVNw==
X-Gm-Message-State: AOAM531K8sRDefNxOhkoznoS/PD4CwNbKXh2/Xsham4tshiMFaHjqslD
        UuCyckZ6ZyWMiWfZwK4IkUyjKGmTrU1816PAWO3r
X-Google-Smtp-Source: ABdhPJw/Tpaqxjrk2xHY1HnWNF8E9HNJng+ZPSFniEnxmx1U1f75Q/MiveGprsqnjcriuiimOhUN6dEN5g+85AMzu8o=
X-Received: by 2002:a17:906:71c6:: with SMTP id i6mr262144ejk.344.1632751675305;
 Mon, 27 Sep 2021 07:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly>
 <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
 <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com>
 <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com> <38bc94ba-b200-e141-2423-6c7f64234a10@ieee.org>
In-Reply-To: <38bc94ba-b200-e141-2423-6c7f64234a10@ieee.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Sep 2021 10:07:44 -0400
Message-ID: <CAHC9VhQhpYJ29kbzDn8QtwyfnytJEP_HehV28jxbzr7z7MVLmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Chris PeBenito <pebenito@ieee.org>,
        Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 25, 2021 at 5:07 PM Chris PeBenito <pebenito@ieee.org> wrote:
> On 9/24/21 11:12 AM, Stephen Smalley wrote:
> > On Fri, Sep 24, 2021 at 10:22 AM Paul Moore <paul@paul-moore.com> wrote:
> >>> On Thu, Sep 23, 2021 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> The original SELinux lockdown implementation in 59438b46471a
> >>>> ("security,lockdown,selinux: implement SELinux lockdown") used the
> >>>> current task's credentials as both the subject and object in the
> >>>> SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> >>>> proved to be incorrect in a number of cases as the core kernel was
> >>>> calling the LSM lockdown hook in places where the credentials from
> >>>> the "current" task_struct were not the correct credentials to use
> >>>> in the SELinux access check.
> >>>>
> >>>> Attempts were made to resolve this by adding a credential pointer
> >>>> to the LSM lockdown hook as well as suggesting that the single hook
> >>>> be split into two: one for user tasks, one for kernel tasks; however
> >>>> neither approach was deemed acceptable by Linus.
> >>>>
> >>>> In order to resolve the problem of an incorrect SELinux domain being
> >>>> used in the lockdown check, this patch makes the decision to perform
> >>>> all of the lockdown access control checks against the
> >>>> SECINITSID_KERNEL domain.  This is far from ideal, but it is what
> >>>> we have available to us at this point in time.
>
> > Can we get Linux distro and Android folks to speak as to whether they
> > consider the check in this reduced form to still be useful or whether
> > we should just remove it altogether?
>
> FWIW, I think the check should be removed.

/me punches another voting card

Thanks Chris.  Unless we hear a rather compelling case from the
Android folks I think we've got our answer.

Jeff, or any of the other Android folks, now is the time to speak up
on this.  If I don't hear from any of you guys within the next few
days I think we'll rip out the SELinux lockdown hook.

-- 
paul moore
www.paul-moore.com
