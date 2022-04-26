Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F7BC433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Apr 2022 18:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbiDZSSp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351467AbiDZSSo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Apr 2022 14:18:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337B2E9DD
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 11:15:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 129so2050181wmz.0
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbRg3+D0qvDncNTkVqOcbyfIAlM3Zlr4GMjtiFZIfZM=;
        b=01gTfT0gcVgLiKXhgLBlbwibmeAHTTbph2mbBpIfbM+VBaogBEcxO1BC68Vv4+P7gd
         EtZ3XYD33SqbEAJxKGaqxTt3ZELkStaKc/inWJ/oOdUUxuldxDnT4OXLoV+ntuwvX9q2
         VaUqJHTpva6CnlBikyb4eyUSqCpx2X2VVr2pUuv73s9fNFp6/HW5CRuY2Rr65j5QT7mT
         aKaPjB0CajSuCxj08E7oDIEwAr3UggP2TUFSu7R0mIqwhATIPA6lAerJeXmfqAjsvFR6
         KQK/sXmjJEoVHl0qmx5lF482kkrJXG/3eUh1EBlRVAV9teY2m1DPOQwtWva2KaHGasDb
         HpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbRg3+D0qvDncNTkVqOcbyfIAlM3Zlr4GMjtiFZIfZM=;
        b=a4YzAL5Pas65Rm4zMKKHvtByhV2TMhpX0X2GBiUl9ySua1LGghoS8GJhkT6LJepKTS
         EgsGQxbLpwmvlsBTEN++qx+cTLEt2OL8Kp87AxBT1A7WG1bFC1M0EpCHvqpBo6l6Kpjf
         WlCIfZN/4knKcI03InguvuYY268cPOqgC+Z4SY7CPuBmLMReUrY5o74GOd2iWyjcxyIN
         eM8BOMDs/8BxNiRe8e6t1CWtvehkM857c8Au5DdUbr0/wgLPID6lh9hTrFQdNgdMS0aw
         izL+bhCw3xM+gy7IPAnRBl5txUc54EeAVIdGzXT3LsYlc9dXwO1lDEwDi7NM99wm/H4+
         R6sA==
X-Gm-Message-State: AOAM533LqTvUVAcROHXAn3+KB+XWOB1E/2XbTXdjNPUqXTY6kR8U270+
        DYEcPt1e7syNtGCELI7xsKr91Gpaq6SFzTVxwpfl
X-Google-Smtp-Source: ABdhPJzsQMvzjT3zCpAssxoYUdMMx+uX/m7hjgtVQrQQXoBmGGpReRk+J6g64zUtXpR0bHk3ZTZXK0lO+sdMqdmQ/zI=
X-Received: by 2002:a1c:f009:0:b0:387:6fea:8ebc with SMTP id
 a9-20020a1cf009000000b003876fea8ebcmr32002327wmb.84.1650996933878; Tue, 26
 Apr 2022 11:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-27-casey@schaufler-ca.com> <ad1e85e1-8706-7b93-59cd-99ccef273be4@canonical.com>
In-Reply-To: <ad1e85e1-8706-7b93-59cd-99ccef273be4@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 14:15:23 -0400
Message-ID: <CAHC9VhS0ht0wWtruDjVvOsy_1LOCswF0kjmd9u8XZXm00jHvOw@mail.gmail.com>
Subject: Re: [PATCH v35 26/29] Audit: Add record for multiple task security contexts
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 25, 2022 at 9:08 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/18/22 07:59, Casey Schaufler wrote:
> > Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> > An example of the MAC_TASK_CONTEXTS (1420) record is:
> >
> >     type=MAC_TASK_CONTEXTS[1420]
> >     msg=audit(1600880931.832:113)
> >     subj_apparmor=unconfined
> >     subj_smack=_
> >
> > When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
> > the "subj=" field in other records in the event will be "subj=?".
> > An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> > multiple security modules that may make access decisions based
> > on a subject security context.
> >
> > Functions are created to manage the skb list in the audit_buffer.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Besides moving the aux fns, and the whining below
> Reviewed-by: John Johansen <john.johansen@canonical.com>

...

> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 4d44c05053b0..8ed2d717c217 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2185,16 +2238,44 @@ int audit_log_task_context(struct audit_buffer *ab)
> >       if (!lsmblob_is_set(&blob))
> >               return 0;
> >
> > -     error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
> > +     if (!lsm_multiple_contexts()) {
> > +             error = security_secid_to_secctx(&blob, &context,
> > +                                              LSMBLOB_FIRST);
> > +             if (error) {
> > +                     if (error != -EINVAL)
> > +                             goto error_path;
> > +                     return 0;
> > +             }
> >
> > -     if (error) {
> > -             if (error != -EINVAL)
> > +             audit_log_format(ab, " subj=%s", context.context);
> > +             security_release_secctx(&context);
> > +     } else {
> > +             /* Multiple LSMs provide contexts. Include an aux record. */
> > +             audit_log_format(ab, " subj=?");
>
> just me whining, you sure we can't just drop subj= here

Have I recently given you my "the audit code is crap" speech? ;)

I more or less answered this with my comments on the earlier patch,
but we need to keep this around for compatibility.  It will get better
in the future.

-- 
paul-moore.com
