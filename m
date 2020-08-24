Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F8C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7A8206BE
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj6p/JNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHXTaE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXTaD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 15:30:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE8C061573;
        Mon, 24 Aug 2020 12:30:03 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b9so5916235oiy.3;
        Mon, 24 Aug 2020 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deXlORBbZU7IWdokjl5teOi2WJn+pCpbuBcieHq8M0Y=;
        b=Pj6p/JNgXXnPJgJjTtg1z3fX5AWLe/xjf5LlZUBl0Fka4VNv1o4RyL/mxjO5XZveqm
         /vDIa0HxL5c0NtrZQ3S717ngsVvpQR6YFr0CnXrHPgMPDGQHKQndZ/UooUSq0iH1LgLs
         73LltyOK2W6NOdUQI33P0jPw4Ta6I6E0ULmHSwRpa3Hf9WdSgNDyr3OF12KnVrR0ak+3
         FH97vZfO+WY4kXZF2yHWpsaJwV961t3wx/T2tOwG/Fu5+RxV2EFo6JdL/PTBV0XPfHD0
         H3Y45fjGVx9H12wOEmGh00ReGgcZsBrFl1s21Hz0JRph7bebsK++5Yo9k1kFc1nGXvq6
         +QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deXlORBbZU7IWdokjl5teOi2WJn+pCpbuBcieHq8M0Y=;
        b=JM83BzZfqC0Jcv10h5btFl5MYr8lmGoqoIKuPhhBw5MY6ZgWHMdW+mvwUalMoM+9KI
         HGy31bH8f2kd0+BJDvI/X47Desxnnr1NzEjw7h0BiyH6gA4e7O+5dnlKhd4UtMloShyb
         52zMvxxDMbuv197YyayJnXy1fVQ7xfBX5pXUJP06UuYUgedrGm6oOw89FoWHDi3WZpbz
         hxLI4YHPbi/RXd7HncEteJQK67yM94r5n0lZou69XspQFAxoSJ+c4LtWcYQjor22o1x0
         yDDIpC0M+VM7z/0LvgCUkKLuwVxILG1Y7WCJLRODCXjobsQ/MJGtESpYuvUAL6mSKEPU
         ipMA==
X-Gm-Message-State: AOAM531COynI/IQxJjnF8kJAm1qJwOzR71bx0Sv5zC1i7KDPX24j53nj
        AIiI+P6iDoNX5SH06shcW+KBb2C/2BpKDKeR0lI=
X-Google-Smtp-Source: ABdhPJyAUcJjgst/CGdSR9bt5PMVqWQ0nTOGdTqMxGP1Nvw1fW3rU+cCYs5SKra6Kls9Yx4MqeJPWmLLw/YJMf/wTC0=
X-Received: by 2002:a54:4817:: with SMTP id j23mr602022oij.140.1598297402894;
 Mon, 24 Aug 2020 12:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com> <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
In-Reply-To: <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 15:29:52 -0400
Message-ID: <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 8/24/20 7:00 AM, Stephen Smalley wrote:
>
> >> +int security_read_policy_kernel(struct selinux_state *state,
> >> +                               void **data, size_t *len)
> >> +{
> >> +       int rc;
> >> +
> >> +       rc = security_read_policy_len(state, len);
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       *data = vmalloc(*len);
> >> +       if (!*data)
> >> +               return -ENOMEM;
> >>
> >> +       return security_read_selinux_policy(state, data, len);
> >>   }
> >
> > See the discussion here:
> > https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.com/T/#t
> >
> > In order for this to be safe, you need to ensure that all callers of
> > security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
> > any use of security_read_policy_len() occurs while holding the mutex.
> > Otherwise, the length can change between security_read_policy_len()
> > and security_read_selinux_policy() if policy is reloaded.
> >
>
> "struct selinux_fs_info" is available when calling
> security_read_policy_kernel() - currently in measure.c.
> Only "struct selinux_state" is.
>
> Is Ondrej's re-try approach I need to use to workaround policy reload issue?

No, I think perhaps we should move the mutex to selinux_state instead
of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
it can then use it indirectly.  Note that your patches are going to
conflict with other ongoing work in the selinux next branch that is
refactoring policy load and converting the policy rwlock to RCU.
