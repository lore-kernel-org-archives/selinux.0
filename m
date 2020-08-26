Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E486C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BC7221E2
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Im6tr19K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgHZNnR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgHZNnO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 09:43:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764EC061756
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:43:08 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l2so2931558eji.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBkyLTWyqIaebksfO31pBpW4njKPTB/MM6lF43DkRgQ=;
        b=Im6tr19Ks7ww7kswNLb9uvjf7u3sjg01AO0zBctwcIkkQsOoV9X1dA4m6tAp9MattA
         v1/N5EIqHgXo5OtbIE03E99TzBxDKci+32maUkp0T1athH8hEx8qDvcDy2yMTmzj++a0
         VIh5Sfq0QLLuvLMj+4AVT1GjUIjN93YHRim+Ac3cMe2tUZ/nCC3ensE0X7tR7qjJ586S
         Wwa6hrBrnafK8jd37TVt0nWUs3gLsLiglYZ8emo6uCkwoUPXJG1bGuiLNh2XnTRgYpRD
         HbhtE1A/Z6wUsRdoCXV/114wKXhtw10sPE5D2EEo0tLD5D3E7h9qjraK/h6Jw/V/7Cbz
         IhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBkyLTWyqIaebksfO31pBpW4njKPTB/MM6lF43DkRgQ=;
        b=XRhLxnl3CwAR2HHLLzRf62FCrAzmtu2305dbWBwIAgQsqmzVy6ccdhMWOwLS6L+ipw
         ghbelZcdBShk46zXP4poqTGNzyUvwI/GQkW3quN3xIyAXjIebcufcUUiJNa7rfh9MGie
         VgMz2XMQVx/6E+cFfWFl2CNDIErYF0xxK7tu+7qCA+oGBVuLfi2HAbEWOChCwnA/S6Zp
         zFebqV7odHpDBWnSbeG66Dg9cHO1t1ZspITr9znoh++F7H/6BszJoYY0RKFkVboo0RCT
         OBofUl/id+KqbJaGtCa0/SYH2xfdVvwfQar2c7mF0x+2Sk5J5uUD/OQGGAaoSp2GS/iA
         Fkgw==
X-Gm-Message-State: AOAM530L5CZoU8l2o3+0IaxRu8UhgdnHB3pzt07DVFFw/EtlGVON6R4O
        97pSU0N1r6f7x1rw80etWEEbvLhJlYBZ9qJr1bgB
X-Google-Smtp-Source: ABdhPJxdzpgqh+03Fxp4xgtH+ZeMgN05JsgEA9Khjj7WG8+/5v7W84OolZeUhXWZSCx1h4QIOpLQX+saAPuLYV+uIuo=
X-Received: by 2002:a17:906:130a:: with SMTP id w10mr1087905ejb.106.1598449385897;
 Wed, 26 Aug 2020 06:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com> <20200824132252.31261-2-peter.enderborg@sony.com>
In-Reply-To: <20200824132252.31261-2-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 09:42:54 -0400
Message-ID: <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> This adds tracing of all denies. They are grouped with trace_seq for
> each audit.
>
> A filter can be inserted with a write to it's filter section.
>
> echo "permission==\"entrypoint\"" > events/avc/selinux_denied/filter
>
> A output will be like:
>           runcon-1046  [002] .N..   156.351738: selinux_denied:
>           trace_seq=2 result=-13
>           scontext=system_u:system_r:cupsd_t:s0-s0:c0.
>           c1023 tcontext=system_u:object_r:bin_t:s0
>           tclass=file permission=entrypoint
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
>  2 files changed, 62 insertions(+), 2 deletions(-)

My most significant comment is that I don't think we want, or need,
two trace points in the avc_audit_post_callback() function.  Yes, I
understand they are triggered slightly differently, but from my
perspective there isn't enough difference between the two tracepoints
to warrant including both.  However, while the tracepoints may be
redundant in my mind, this new event does do the permission lookup in
the kernel so that the contexts/class/permissions are all available as
a string which is a good thing.

Without going into the details, would the tracing folks be okay with
doing something similar with the existing selinux_audited tracepoint?
It's extra work in the kernel, but since it would only be triggered
when the tracepoint was active it seems bearable to me.

> diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
> index 94bca8bef8d2..9a28559956de 100644
> --- a/include/trace/events/avc.h
> +++ b/include/trace/events/avc.h
> @@ -54,6 +54,43 @@ TRACE_EVENT(selinux_audited,
>         )
>  );
>
> +TRACE_EVENT(selinux_denied,
> +
> +       TP_PROTO(struct selinux_audit_data *sad,
> +               char *scontext,
> +               char *tcontext,
> +               const char *tclass,
> +               const char *permission,
> +               int64_t seq
> +       ),
> +
> +       TP_ARGS(sad, scontext, tcontext, tclass, permission, seq),
> +
> +       TP_STRUCT__entry(
> +               __field(int, result)
> +               __string(scontext, scontext)
> +               __string(tcontext, tcontext)
> +               __string(permission, permission)
> +               __string(tclass, tclass)
> +               __field(u64, seq)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->result = sad->result;
> +               __entry->seq    = seq;
> +               __assign_str(tcontext, tcontext);
> +               __assign_str(scontext, scontext);
> +               __assign_str(permission, permission);
> +               __assign_str(tclass, tclass);
> +       ),
> +
> +       TP_printk("trace_seq=%lld result=%d scontext=%s tcontext=%s tclass=%s permission=%s",
> +                __entry->seq, __entry->result, __get_str(scontext), __get_str(tcontext),
> +                __get_str(tclass), __get_str(permission)
> +
> +       )
> +);
> +
>  #endif
>
>  /* This part must be outside protection */
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 1debddfb5af9..ca53baca15e1 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -92,6 +92,7 @@ struct selinux_avc {
>  };
>
>  static struct selinux_avc selinux_avc;
> +static atomic64_t trace_seqno;
>
>  void selinux_avc_init(struct selinux_avc **avc)
>  {
> @@ -731,9 +732,31 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>         tclass = secclass_map[sad->tclass-1].name;
>         audit_log_format(ab, " tclass=%s", tclass);
>
> -       if (sad->denied)
> +       if (sad->denied) {
>                 audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
> -
> +               if (trace_selinux_denied_enabled()) {
> +                       int i, perm;
> +                       const char **perms;
> +                       u32 denied = sad->denied;
> +                       int64_t seq;
> +
> +                       seq = atomic_long_inc_return(&trace_seqno);
> +                       perms = secclass_map[sad->tclass-1].perms;
> +                       i = 0;
> +                       perm = 1;
> +                       while (i < (sizeof(denied) * 8)) {
> +                               if ((perm & denied & sad->requested) && perms[i]) {
> +                                       trace_selinux_denied(sad, scontext, tcontext,
> +                                                            tclass, perms[i], seq);
> +                                       denied &= ~perm;
> +                                       if (!denied)
> +                                               break;
> +                               }
> +                               i++;
> +                               perm <<= 1;
> +                       }
> +               }
> +       }
>         trace_selinux_audited(sad, scontext, tcontext, tclass);
>         kfree(tcontext);
>         kfree(scontext);
> --
> 2.17.1

-- 
paul moore
www.paul-moore.com
