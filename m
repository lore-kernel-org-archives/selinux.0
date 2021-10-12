Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E4C433FE
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 14:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A74C60EFE
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhJLOPW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJLOPV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 10:15:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC27C061749
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 07:13:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w14so67436edv.11
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieKETngd4wQHVII+IJcs5CQY5wbzV3iEx77J8xRx2vA=;
        b=bWaI4AeFcuNvWGD1I8cg7W6CG/azm1vaRBxjX1dsRUwDZWLVCDsVzS85MZqppDPqW9
         34rds3D76bwkkPcvjsGuCTXawVOxwdB47aCElSGmvamfQoH+DDNnXd3o+dxEIfXWrjbD
         9So44VhRb03JVhThMjaEnhw5YCUaZMPe/VCwNVxdjRE0o6eP32scGLvrv27NbXQkVhLG
         QYRO+iyEJ5oGBWxHSDEfHBIXts79CsmV5cbX2N+FVqkQp/3zRx7G8QI8fCoNxTXhr8Lp
         cOCeSQ0fT/VSaazPoGa379Fp+1k7ZCgjR7y/PXuIDNZ0PKRb5OjvhAoDrfEbCq60UVDa
         yVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieKETngd4wQHVII+IJcs5CQY5wbzV3iEx77J8xRx2vA=;
        b=gSJ6vJPrXp2fb1mPdEUfB/i0Xio0ipTKOl+ieqNSLe6F+KQDMGSbIhnV0+5FZMyaIm
         yIjbDg6KxiFbzsq+BHibpi6drrPfP2eajI0NIN9Oyj/8IeNxFufgdkHLg9Q1j6bHBz/x
         UkgIsZqPzMyK+ELOpbvzm8t2HhwT4VFGEfe60X6sm7LuNvF1WAyI/Onv9QwxaQBmF9si
         6YMAShwPU8maBtF6uM0E+xXGVbAVTyf12rnEbFNGvvK+W9GwwFOo+Cf1EjDx/ckA4C8s
         Cem36xNAwXJc+E3NjPNFORSPXaEgFQST4iHXBNsew0KkuqWc/ycotfItj/pZGeLK90eM
         W+gQ==
X-Gm-Message-State: AOAM531UG0dhCcN6KNt8Avtk48dv6XSKiMuauOGyYxN/yddDORHmAN6y
        2CYQMuP9jl1LErGQ3mfWf7sFvJtV2X3NTZV1J3PM
X-Google-Smtp-Source: ABdhPJwOMKZYa/n4x55N6Emss5rBP+EcS7P39AqLbYHCH7HSMgM0Rumxq877HQtO60UwMW0rF+Cn72qdnnCrQ2cNdok=
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr32291219eji.126.1634047997689;
 Tue, 12 Oct 2021 07:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211007004629.1113572-1-tkjos@google.com> <20211007004629.1113572-3-tkjos@google.com>
 <CAHC9VhSDnwapGk6Pvn5iuKv0zCtZSbfnGAkZwKcxVYLVRH6CLg@mail.gmail.com>
 <8c07f9b7-58b8-18b5-84f8-9b6c78acb08b@schaufler-ca.com> <20211012094101.GE8429@kadam>
In-Reply-To: <20211012094101.GE8429@kadam>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 10:13:06 -0400
Message-ID: <CAHC9VhROz8V7MWch8UfrhjR030VmY7rKEUFgUvYqL6kdZCy3aw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] binder: use cred instead of task for getsecid
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Todd Kjos <tkjos@google.com>, zohar@linux.ibm.com,
        arve@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        James Morris <jmorris@namei.org>, kernel-team@android.com,
        tkjos@android.com, keescook@chromium.org, jannh@google.com,
        selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        maco@android.com, christian@brauner.io, gregkh@linuxfoundation.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 5:41 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Oct 11, 2021 at 02:59:13PM -0700, Casey Schaufler wrote:
> > On 10/11/2021 2:33 PM, Paul Moore wrote:
> > > On Wed, Oct 6, 2021 at 8:46 PM Todd Kjos <tkjos@google.com> wrote:
> > >> Use the 'struct cred' saved at binder_open() to lookup
> > >> the security ID via security_cred_getsecid(). This
> > >> ensures that the security context that opened binder
> > >> is the one used to generate the secctx.
> > >>
> > >> Fixes: ec74136ded79 ("binder: create node flag to request sender's
> > >> security context")
> > >> Signed-off-by: Todd Kjos <tkjos@google.com>
> > >> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >> Cc: stable@vger.kernel.org # 5.4+
> > >> ---
> > >> v3: added this patch to series
> > >> v4: fix build-break for !CONFIG_SECURITY
> > >>
> > >>  drivers/android/binder.c | 11 +----------
> > >>  include/linux/security.h |  4 ++++
> > >>  2 files changed, 5 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > >> index ca599ebdea4a..989afd0804ca 100644
> > >> --- a/drivers/android/binder.c
> > >> +++ b/drivers/android/binder.c
> > >> @@ -2722,16 +2722,7 @@ static void binder_transaction(struct binder_proc *proc,
> > >>                 u32 secid;
> > >>                 size_t added_size;
> > >>
> > >> -               /*
> > >> -                * Arguably this should be the task's subjective LSM secid but
> > >> -                * we can't reliably access the subjective creds of a task
> > >> -                * other than our own so we must use the objective creds, which
> > >> -                * are safe to access.  The downside is that if a task is
> > >> -                * temporarily overriding it's creds it will not be reflected
> > >> -                * here; however, it isn't clear that binder would handle that
> > >> -                * case well anyway.
> > >> -                */
> > >> -               security_task_getsecid_obj(proc->tsk, &secid);
> > >> +               security_cred_getsecid(proc->cred, &secid);
> > >>                 ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> > >>                 if (ret) {
> > >>                         return_error = BR_FAILED_REPLY;
> > >> diff --git a/include/linux/security.h b/include/linux/security.h
> > >> index 6344d3362df7..f02cc0211b10 100644
> > >> --- a/include/linux/security.h
> > >> +++ b/include/linux/security.h
> > >> @@ -1041,6 +1041,10 @@ static inline void security_transfer_creds(struct cred *new,
> > >>  {
> > >>  }
> > >>
> > >> +static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
> > >> +{
> > >> +}
> > > Since security_cred_getsecid() doesn't return an error code we should
> > > probably set the secid to 0 in this case, for example:
> > >
> > >   static inline void security_cred_getsecid(...)
> > >   {
> > >     *secid = 0;
> > >   }
> >
> > If CONFIG_SECURITY is unset there shouldn't be any case where
> > the secid value is ever used for anything. Are you suggesting that
> > it be set out of an abundance of caution?
>
> The security_secid_to_secctx() function is probably inlined so probably
> KMSan will not warn about this.  But Smatch will warn about passing
> unitialized variables.  You probably wouldn't recieve and email about
> it, and I would just add an exception that security_cred_getsecid()
> should be ignored.

I'd much rather just see the secid set to zero in the !CONFIG_SECURITY case.

-- 
paul moore
www.paul-moore.com
