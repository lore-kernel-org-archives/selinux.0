Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF0AC4332F
	for <selinux@archiver.kernel.org>; Sat, 15 Oct 2022 15:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJOPN5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Oct 2022 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJOPNn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Oct 2022 11:13:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADE54647
        for <selinux@vger.kernel.org>; Sat, 15 Oct 2022 08:13:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f11so11764919wrm.6
        for <selinux@vger.kernel.org>; Sat, 15 Oct 2022 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nP4X5l+DqTKniLwzsDVuf1W+7Ei+0+qFjaBfWl3ngCs=;
        b=GayDslgkYuWGzWIEvG9tI+IQpau7yQ/yplzKq7eiS0iX5GJ7rhvsFP0I4AubM0+Q7a
         endrWrBb5mDP8uNNrF38oyeQVYqEaZFA5IOVMgHq2YKoq5/t79BphjcbKP2Y00vPofTC
         wowWJ/9xwaEhAKIs0o4Dn/823VA8RQ5PALooRe4kwPWFZZw9asW4GCiBm/b7sOs901Lg
         h/X32OAsh1UoSXogcrBDU2NDwGBw+zzsdmu7MMWwdiErlQX//12RWnUGKllaakYWw8lZ
         pkVh4jA9GX3omJ8LTJ5+jHSN/CY6vDeLHfUFNtjJyFH2h3BlL8B2au7Kko/H00O0VBVX
         e0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nP4X5l+DqTKniLwzsDVuf1W+7Ei+0+qFjaBfWl3ngCs=;
        b=3oVZdXkbDYz4RM6WNv+McAX6H427Fgt/EUlgnafWZmg0FhAWG3ORPzSdRZpIAE7HVL
         oZcUUQFSx8kzJcHh01PQXvX/yTfB/c8NvqqcB3rUvzqHkGJFcnoj7gHxawe/gkK0KExe
         m11DGgPqk2nkKj7GDnyw5hJl6+zCQAnpDuxWaY+Ww1IYyjqi7X3/AJU6WZdAENLwYvPR
         6PLUGugOi+UU2QhVJctFmtyO/M5NqIKdsuOoV4tvc5kPsQIxCXcMsWupPrNiXmu1y+In
         nqLvxnBA/arFubt0cw5bb1gas/3Oj2t1aornFzTMn+zdeHVJjiJJM+9FOpwC3IrBS/RY
         WnFA==
X-Gm-Message-State: ACrzQf2YhOKxVDw0B08PXdIk6LxisNUsjhQS42bwaXCYayCrYLB5foPQ
        /+UV2fD5/EiL5xCXiUYiRwi/R/B4pK4InCBW8oQ=
X-Google-Smtp-Source: AMsMyM5Ff82wNIm1z0kcg3P83gMg/0h1MbiNk8cRiQgxmzrBmfuV848HDLOf9rn5aSDRHsDclNXnvj1mWO4azmwUmRU=
X-Received: by 2002:a05:6000:144c:b0:230:816f:3167 with SMTP id
 v12-20020a056000144c00b00230816f3167mr1750977wrx.532.1665846789488; Sat, 15
 Oct 2022 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221011112733.194079-1-plautrba@redhat.com> <877d12sn5v.fsf@redhat.com>
 <3e5a0cb1-73e5-6268-2c0b-4f470080073e@linux.microsoft.com> <87wn92qxmq.fsf@redhat.com>
In-Reply-To: <87wn92qxmq.fsf@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 15 Oct 2022 17:12:58 +0200
Message-ID: <CAJ2a_DeMFWTmZLQhekME+Qr9VDYaknq+vvDjrP=5qA25PeV1Bg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Add missing '\n' to avc_log() messages
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 14 Oct 2022 at 16:37, Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>
> > On 10/14/2022 6:41 AM, Petr Lautrbach wrote:
> >> Petr Lautrbach <plautrba@redhat.com> writes:
> >>
> >>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >>> ---
> >>>   libselinux/src/avc.c          | 2 +-
> >>>   libselinux/src/avc_internal.c | 4 ++--
> >>>   libselinux/src/checkAccess.c  | 4 ++--
> >>>   3 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> >>> index 8d5983a2fe0c..98a3fcae41c8 100644
> >>> --- a/libselinux/src/avc.c
> >>> +++ b/libselinux/src/avc.c
> >>> @@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
> >>>     if (denied)
> >>>             log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
> >>>
> >>> -   avc_log(SELINUX_AVC, "%s", avc_audit_buf);
> >>> +   avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);
> >>
> >>
> >> There is a conflict between this change and commit 142372522c7e ("libselinux: avoid
> >> newline in avc message").
> >>
> >> I'll send another version without it.
> >
> > Now that you've pointed out Christian's patch, this feels like
> > potentially the wrong level to solve this.
> >
> > As I understand it, the issue Christian was trying to solve is that
> > audit doesn't parse as we intend if there is a newline in the middle of
> > the message, and userspace object managers append additional material to
> > USER_AVC messages.  Hence his removal of newline above.
> >
> > The problem this patch is trying to solve is that when SELinux aware
> > applications call logging functions in libselinux, they get printed
> > directly to standard error, and in that case really should end in a newline.
> >
> > Secondarily, this patch solves the fact that previously the messages
> > logged by SELinux were just inconsistent with regards to final newlines.
> >
> > It happens that in the current state of things, userspace object
> > managers append to AVCs above, and rpm had issues with setenforce and
> > policyload, so segregating newlines based on message type as this patch
> > with the above hunk dropped would do addresses all the issues.
> >
> > I feel like that's sort of a happenstance that this is the current state
> > of the code though, and if a future change results in SELinux aware
> > applications dumping AVCs directly to standard error for example, then
> > there won't be a good solution in the current approach.
> >
> > Would it be perhaps a cleaner solution to standardize all libselinux
> > messages on no newline and then changing default_selinux_log() to append
> > a newline since that's writing directly to stderr and relying on callers
> > into libselinux to add a newline if needed?
>
> This is exactly my thoughts and reason why I haven't sent the new patch
> yet.
>
> If we do this we would need to check all main consumers whether they
> depend on the new line or not.

First of all I agree that log messages should fbe consistent in
whether they end with a newline or not, and that bahavior should be
documented (probably in selinux_set_callback(3)).

Looking at some callers of selinux_set_callback(3):


I. systemd

log_callback() [1] forwards the message either to
audit_log_user_avc_message(3), which does not expect a trailing
newline, or to the internal function log_internalv(), which to my
analysis also do not.

[1]: https://github.com/systemd/systemd/blob/3e15bed410ff616f5015b4e87eb25d1fee8828e5/src/core/selinux-access.c#L97


II. dbus-broker

bus_selinux_log() [2] forwards the message to the internal function
util_audit_log() [3], which either forwards it to
audit_log_user_avc_message(3) or explitcitly add a newline when
printing to stderr.

[2]: https://github.com/bus1/dbus-broker/blob/ef1c9f03a6be40474486044b6a28780d12107d9b/src/util/selinux.c#L288
[3]: https://github.com/bus1/dbus-broker/blob/ef1c9f03a6be40474486044b6a28780d12107d9b/src/util/audit.c#L104


III. dbus

log_callback() [4] forwards the message either to
audit_log_user_avc_message(3) or vsyslog(3), which both do not expect
a trailing newline.

[4]: https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c#L95


IV. pam

log_callback() [5] forwards the message either to
audit_log_user_avc_message(3) or vsyslog(3), which both do not expect
a trailing newline.

[5]: https://github.com/linux-pam/linux-pam/blob/f69a6042da801096c94b30465c118e17c803f5c2/modules/pam_rootok/pam_rootok.c#L54


V. shadow

selinux_log_cb() [6] forwards the message either to
audit_log_user_avc_message(3) or via a SYSLOG wrapper to syslog(3),
which both do not expect a trailing newline.

[6]: https://github.com/shadow-maint/shadow/blob/16afe18142bf8e0ba8b315aac10526b8998fa98e/lib/selinux.c#L113


Summary:

All of the checked applications expect a message without a trailing
newline, so I would favor dropping all newlines from existing
libselinux log messages and explicitly add a newline in the default
handler, default_selinux_log(), printing to stderr.


>
> Or given the number of avc_log() with "\n" vs those without, we could
> revert Christian's patch, document that messages are always ended with
> "\n" and let consumers strip it.
>
>
> Petr
>
>
>
> >
> > -Daniel
> >
> >>
> >>
> >>>
> >>>     avc_release_lock(avc_log_lock);
> >>>   }
> >>> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> >>> index 71a1357bc564..c550e5788527 100644
> >>> --- a/libselinux/src/avc_internal.c
> >>> +++ b/libselinux/src/avc_internal.c
> >>> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
> >>>     int rc = 0;
> >>>
> >>>     avc_log(SELINUX_SETENFORCE,
> >>> -           "%s:  op=setenforce lsm=selinux enforcing=%d res=1",
> >>> +           "%s:  op=setenforce lsm=selinux enforcing=%d res=1\n",
> >>>             avc_prefix, enforcing);
> >>>     if (avc_setenforce)
> >>>             goto out;
> >>> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
> >>>     int rc = 0;
> >>>
> >>>     avc_log(SELINUX_POLICYLOAD,
> >>> -           "%s:  op=load_policy lsm=selinux seqno=%u res=1",
> >>> +           "%s:  op=load_policy lsm=selinux seqno=%u res=1\n",
> >>>             avc_prefix, seqno);
> >>>     rc = avc_ss_reset(seqno);
> >>>     if (rc < 0) {
> >>> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> >>> index 022cd6b5ecab..319af267c6a7 100644
> >>> --- a/libselinux/src/checkAccess.c
> >>> +++ b/libselinux/src/checkAccess.c
> >>> @@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
> >>>          sclass = string_to_security_class(class);
> >>>          if (sclass == 0) {
> >>>            rc = errno;
> >>> -          avc_log(SELINUX_ERROR, "Unknown class %s", class);
> >>> +          avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
> >>>            if (security_deny_unknown() == 0)
> >>>                    return 0;
> >>>            errno = rc;
> >>> @@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
> >>>          av = string_to_av_perm(sclass, perm);
> >>>          if (av == 0) {
> >>>            rc = errno;
> >>> -          avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
> >>> +          avc_log(SELINUX_ERROR, "Unknown permission %s for class %s\n", perm, class);
> >>>            if (security_deny_unknown() == 0)
> >>>                    return 0;
> >>>            errno = rc;
> >>> --
> >>> 2.37.3
>
