Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA240C433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAAD60240
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 22:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQW46 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCQW43 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 18:56:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B6CC06174A
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 15:56:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so933873ejr.5
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+08TCMXZyjlZrUSLxo3iiA6zUw9BGeYa2hlwFsECIY=;
        b=t11two/QxA5RIKVR27oCZ44kE2UoHAGFyECntvDL8K6Xmd5Fg/CLAIU2akBPdDsxQS
         bqbapnCnu3vl9bgwlT49abRo2lo70BZzk5aKv5xO0flvdI8enW08GUv8vpndhUb0L/sq
         cPWlYXH9Z0Fb8OKs5aU5l4zWvDQpBiO2fw9+r264W65CIGnYKXaoL3rbC+NzZg7xxytq
         CrPWw9tRlgKBeXkaSKkIDkQTzRXzTAd0cyi4NrcaD/wrc0blqSsBMlZbI1NYqIO068h1
         lb1acxj7XvtNlmHn9PMtla4PzreA82UyciHX0PSvZHedakgwPpXRvSn0mNXUo6f5wjPm
         mSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+08TCMXZyjlZrUSLxo3iiA6zUw9BGeYa2hlwFsECIY=;
        b=oA8CpPU5f/3nmMyW1FOOIVddOlQDoyfmL/mc48rXxqvk4ssgi9G4zVTaJK7Upj6L7H
         mvbp5iW7jjru8+JldrL4MjyO3PQ9+iCiGOPOIv0q+lb0lwYvMsGYG7bUAfBXoWYhS3uR
         e4WLh9KIKgkrw4Rb1/DJqimKSKctSCH4j4W59xUuzJXg+jH89fB7q8xk5KKCzT+vDTtm
         bf2dCcAH3RJ7N9+xDx9N2LHNAAQG7wqWE1mkGbP832VFk61SbPj2QochyXAKm4OgR49y
         4Ewy/6b5yeIk5MUjNmpppMS2qORu+4ByReDXSSeP73Ni70IJ1j9+JkoTgWMQgFQx4tjf
         ENQg==
X-Gm-Message-State: AOAM532jxfxg3CPVNu8dRXmHqDmSMUK0qt1jUGTS/q/z6hNwjLQWmh5R
        j9RVZUoNREDeMMetUHHF+UzLXAS93N5Duf3H2xgn
X-Google-Smtp-Source: ABdhPJwQ6DhvzGENYehzx0SNW4HCm0PCWmztvPNIkgcIJ3iZTziPQupBbExCf+lV7Fg3ZHzMlKrtUDUImmoF8nDBLek=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr37538189ejb.542.1616021787231;
 Wed, 17 Mar 2021 15:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377735153.87807.7492842242100187888.stgit@sifl> <b27662cf-4bcf-ec23-92f5-49a5b2f8c119@canonical.com>
 <CAHC9VhQmwFHFYZ2yCPDLWanjc1hzof7G3XO4fqPEX2ykiHCN3g@mail.gmail.com>
In-Reply-To: <CAHC9VhQmwFHFYZ2yCPDLWanjc1hzof7G3XO4fqPEX2ykiHCN3g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Mar 2021 18:56:16 -0400
Message-ID: <CAHC9VhR5_Fd_vCFME-zZJuap1rSpc5hEBGjK8p10QnaXiGrBug@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 11:32 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 9, 2021 at 10:06 PM John Johansen
> <john.johansen@canonical.com> wrote:
> > On 2/19/21 3:29 PM, Paul Moore wrote:

...

> > > @@ -2034,11 +2047,8 @@ static inline u32 open_file_to_av(struct file *file)
> > >
> > >  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
> > >  {
> > > -     u32 mysid = current_sid();
> > > -     u32 mgrsid = task_sid(mgr);
> > > -
> > >       return avc_has_perm(&selinux_state,
> > > -                         mysid, mgrsid, SECCLASS_BINDER,
> > > +                         current_sid(), task_sid_obj(mgr), SECCLASS_BINDER,
> > >                           BINDER__SET_CONTEXT_MGR, NULL);
> > >  }
> > >
> > > @@ -2046,8 +2056,8 @@ static int selinux_binder_transaction(struct task_struct *from,
> > >                                     struct task_struct *to)
> > >  {
> > >       u32 mysid = current_sid();
> > > -     u32 fromsid = task_sid(from);
> > > -     u32 tosid = task_sid(to);
> > > +     u32 fromsid = task_sid_subj(from);
> >
> > fromsid potentially gets used as both the subject and the object the following
> > permission checks. It makes sense to use the same cred for both checks but
> > what I am not sure about yet is whether its actually safe to use the subject
> > sid when the task isn't current.
> >
> > ie. I am still trying to determine if there is a race here between the transaction
> > request and the permission check.
>
> Okay, I see what you are concerned about now ... and unfortunately I'm
> not seeing a lot of precedence in the kernel for this type of usage
> either; the closest I can find is something like task_lock(), but that
> doesn't seem to cover the subjective creds.  In fact, looking at
> override_creds(), there is nothing preventing a task from changing
> it's subjective creds at any point in time.
>
> Beyond the task_sid_subj() code here, looking back at patch 1 and the
> use of security_task_getsecid_subj() we look to be mostly safe (where
> safe means we are only inspecting the current task) with the exception
> of the binder code once again.  There are some other exceptions but
> they are in the ptrace and audit code, both of which should be okay
> given the nature and calling context of the code.
>
> The problem really does seem to be just binder, and as I look at
> binder userspace example code, I'm starting to wonder if binder is
> setup properly to operate sanely in a situation where a process
> overrides its subject creds.  It may be that we always need to use the
> objective/real creds with binder.  Jeff, any binder insight here you
> can share with us?
>
> > > +     u32 tosid = task_sid_subj(to);
> > its not clear to me that using the subj for to is correct
>
> Yes, I believe you are correct.  Jeff, I know you looked at this code
> already, but I'm guessing you may have missed this (just as I did when
> I wrote it); are you okay with changing 'tosid' in
> selinux_binder_transaction() to the task's objective credentials?

Hearing no comments from the Android/binder folks, I'm in the process
of switching this patchset to always use the objective creds in the
case of binder.  It's safe and I'm not sure binder is really prepared
for the idea of a task changing it's creds anyway.

Once the kernel builds and passes some basic sanity checks I'll repost
the patches for review and inclusion, minus the AppArmor patch.

-- 
paul moore
www.paul-moore.com
