Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A046AC433E6
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 04:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE6164F9E
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 04:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCKEck (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Mar 2021 23:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCKEcP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Mar 2021 23:32:15 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B359C061574
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 20:32:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y6so770933eds.1
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 20:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHOhGjmvzrB2gk4cBTa5YvyzwnxpAyMed1nNXQc3Z4g=;
        b=GnWkm1CaJdBx+zeOIaIdfwg+4pZISCKXECFDhFKJLpcMGzixkpnrW8k24Y1XM0avhF
         HsFG8MirvFx/kzQy+iq1ZNGePj77yxsCuTfEZaDQBQGQj7/r4PcDh9PgT6rX2J3kbwAL
         naQYCZVGEhJ/KGCW+J9ocJAeRBOdUFiDElzXSti86F6ueWbr2ghyM/RIKCgcHG3Ebk9f
         Bs0yU07C0K284gBQjn5zxJRtu7iu2XaBKGc6w4mqcBDNCgZ5YgNqDlpVgs9CTF4uJwvO
         3IyDlFclERmWMumJ8BYFtCdArTmQ4M74goPQTODfuJkliQYPx0O0tekP9UyBx+X1XJ3d
         hp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHOhGjmvzrB2gk4cBTa5YvyzwnxpAyMed1nNXQc3Z4g=;
        b=TpYzmq0BHN+bQEIqb7ByhtHYm00QNYiuQ/n6+e/Z7MQaGi79psZB4w3KOt4UiNtn51
         YtgzEX5mx7AL5DamHAGD8+p7ycz7A2qPmeUP7movgu1AL+jPhic5hZz3w3g/r0RRk0Im
         8Dc45T3WXnJN57nzoIcvfEq6TSfg9ftY9fC1aOUDQYF2UBonJkS2zk3SlijzoRKItlFJ
         Pi/mVR5Dx4BUtjn+13Sr27Ymu3jR58yQhZpM52TDFkrngyw/FpIEFE1WPzVMr3eD3t5J
         mOmvLEoiuWqyBMkZArKSqbKog3xGwleuQkyyfhDvKs/L9piVIB9H6fqSyeyiXK7nKB27
         Fh8A==
X-Gm-Message-State: AOAM530JNuwFBcJd7l7h9pCZD0gLujXs3gihtQrphkf5EbPYS9scI3cs
        vx6UOOFyzaKB7BZb5Z0hmL+7SU/Cu7MH3eBP7C89
X-Google-Smtp-Source: ABdhPJx/YG3XP2UAuESOwSLpj64PL3u9CvRelFs99xuHBzzOiR3nWkSYxJxeLSHiEP/BKNcEPynWtODAArxRXIkHQY0=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr6632426edb.128.1615437133890;
 Wed, 10 Mar 2021 20:32:13 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377735153.87807.7492842242100187888.stgit@sifl> <b27662cf-4bcf-ec23-92f5-49a5b2f8c119@canonical.com>
In-Reply-To: <b27662cf-4bcf-ec23-92f5-49a5b2f8c119@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Mar 2021 23:32:02 -0500
Message-ID: <CAHC9VhQmwFHFYZ2yCPDLWanjc1hzof7G3XO4fqPEX2ykiHCN3g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] selinux: clarify task subjective and objective credentials
To:     John Johansen <john.johansen@canonical.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 9, 2021 at 10:06 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/19/21 3:29 PM, Paul Moore wrote:
> > SELinux has a function, task_sid(), which returns the task's
> > objective credentials, but unfortunately is used in a few places
> > where the subjective task credentials should be used.  Most notably
> > in the new security_task_getsecid_subj() LSM hook.
> >
> > This patch fixes this and attempts to make things more obvious by
> > introducing a new function, task_sid_subj(), and renaming the
> > existing task_sid() function to task_sid_obj().
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> I have a couple of questions below but the rest looks good
>
> > ---
> >  security/selinux/hooks.c |   85 +++++++++++++++++++++++++++-------------------
> >  1 file changed, 49 insertions(+), 36 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f311541c4972e..1c53000d28e37 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -229,10 +229,23 @@ static inline u32 cred_sid(const struct cred *cred)
> >       return tsec->sid;
> >  }
> >
> > +/*
> > + * get the subjective security ID of a task
> > + */
> > +static inline u32 task_sid_subj(const struct task_struct *task)
> > +{
> > +     u32 sid;
> > +
> > +     rcu_read_lock();
> > +     sid = cred_sid(rcu_dereference(task->cred));
> > +     rcu_read_unlock();
> > +     return sid;
> > +}
> > +
> >  /*
> >   * get the objective security ID of a task
> >   */
> > -static inline u32 task_sid(const struct task_struct *task)
> > +static inline u32 task_sid_obj(const struct task_struct *task)
> >  {
> >       u32 sid;
> >
> > @@ -2034,11 +2047,8 @@ static inline u32 open_file_to_av(struct file *file)
> >
> >  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
> >  {
> > -     u32 mysid = current_sid();
> > -     u32 mgrsid = task_sid(mgr);
> > -
> >       return avc_has_perm(&selinux_state,
> > -                         mysid, mgrsid, SECCLASS_BINDER,
> > +                         current_sid(), task_sid_obj(mgr), SECCLASS_BINDER,
> >                           BINDER__SET_CONTEXT_MGR, NULL);
> >  }
> >
> > @@ -2046,8 +2056,8 @@ static int selinux_binder_transaction(struct task_struct *from,
> >                                     struct task_struct *to)
> >  {
> >       u32 mysid = current_sid();
> > -     u32 fromsid = task_sid(from);
> > -     u32 tosid = task_sid(to);
> > +     u32 fromsid = task_sid_subj(from);
>
> fromsid potentially gets used as both the subject and the object the following
> permission checks. It makes sense to use the same cred for both checks but
> what I am not sure about yet is whether its actually safe to use the subject
> sid when the task isn't current.
>
> ie. I am still trying to determine if there is a race here between the transaction
> request and the permission check.

Okay, I see what you are concerned about now ... and unfortunately I'm
not seeing a lot of precedence in the kernel for this type of usage
either; the closest I can find is something like task_lock(), but that
doesn't seem to cover the subjective creds.  In fact, looking at
override_creds(), there is nothing preventing a task from changing
it's subjective creds at any point in time.

Beyond the task_sid_subj() code here, looking back at patch 1 and the
use of security_task_getsecid_subj() we look to be mostly safe (where
safe means we are only inspecting the current task) with the exception
of the binder code once again.  There are some other exceptions but
they are in the ptrace and audit code, both of which should be okay
given the nature and calling context of the code.

The problem really does seem to be just binder, and as I look at
binder userspace example code, I'm starting to wonder if binder is
setup properly to operate sanely in a situation where a process
overrides its subject creds.  It may be that we always need to use the
objective/real creds with binder.  Jeff, any binder insight here you
can share with us?

> > +     u32 tosid = task_sid_subj(to);
> its not clear to me that using the subj for to is correct

Yes, I believe you are correct.  Jeff, I know you looked at this code
already, but I'm guessing you may have missed this (just as I did when
I wrote it); are you okay with changing 'tosid' in
selinux_binder_transaction() to the task's objective credentials?

--
paul moore
www.paul-moore.com
