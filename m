Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC76C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54F421855
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ANIM0mvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAYWLQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:11:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45710 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYWLQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 17:11:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so9593657ljd.12
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5x6h1zaPniNuVXgsMwmQDRXh57R3QY9N3mqsdEX+94=;
        b=ANIM0mvGD6ork/jCZIf0ouRhq3eB+cQUqPYsI0y+3+Cy+ltBTnf5c8Xo53y2p6E8UD
         8l8F5DB/k57tq7KQ/zwUhGnoxnPacndg7o6A2AqLRLjUnykeI61M9uBaa+w1qeWF8XRk
         gjour7aKbaZL072ibpsRwJpQcDzcQGhrOz/uBINg138yth/de2fhHsXeg8IDN4Z2AF/n
         csXQFTwf9gaZfvrMEboaFblHTKZUtz7xMjJlPZk7waIf2St5UUSYKLoBuTlN4jNlprA2
         UI3WRyN1fLO2a8+SrbFK1hXF1SQl5yQiDy4M+WOyH9oryBdP6EJrFTP0FOWLSuAiAJ+m
         p6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5x6h1zaPniNuVXgsMwmQDRXh57R3QY9N3mqsdEX+94=;
        b=KpK3Y/2rfqPoUlOeHezsQQ6ktzH4Htu08Ct+FuDw6eiwIN/HFVSM5/cP5MYuaoRyh2
         fysY76KSFIw77norTO7FqafDLSb+LlI2yYjm2rnbv5dqwGDWYpZcWGCIiAdlIlqiTCFO
         0XGp0cqORYJQWUG/cFtJ+tvZLztk3UpE0IiPP7ByJjlrxnW5BrUgXtoIhdeDMNKL1aQQ
         8AKzuQHquD9v117Fh1N5GgT/Ws0qG1Kj1ckSU4ZyihqUL13r1I+/K5PRPy/LAFFStefM
         e91u2yrMRpedJkfHc0fq70ZXrKrf6588fxxDbBFiwlemh4EsA8QgWlTwb2wgzcZ5relW
         1Snw==
X-Gm-Message-State: AJcUukf3pD7DNk87ooD1j+jEq/9x4A7kXXxAl3pLW8a7Zm14rYV6QJvI
        2D7mdDHCmrSdyttl1Wk1pC7LLVnXFfQ45h1ReY3Q
X-Google-Smtp-Source: ALg8bN61hKNLCQLAbTelBz2u+Vh8RjcNtA2uXaZlPuzMJk/gXfrfvfEGK7xztLwuS8K5DKxRDy4j4SxSh+nWx6dFMoc=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr10281073ljj.161.1548454273152;
 Fri, 25 Jan 2019 14:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20190125100651.21753-1-omosnace@redhat.com> <20190125100651.21753-2-omosnace@redhat.com>
In-Reply-To: <20190125100651.21753-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 17:11:01 -0500
Message-ID: <CAHC9VhQv8zPiNMzZ4d7cTP8La-Ncbj-Bp5nhMLo4V2EmAwcYpw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] selinux: inline some AVC functions used only once
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 25, 2019 at 5:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> avc_dump_av() and avc_dump_query() are each used only in one place. Get
> rid of them and open code their contents in the call sites.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c | 140 +++++++++++++++++------------------------
>  1 file changed, 58 insertions(+), 82 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9b63d8ee1687..502162eeb3a0 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -129,75 +129,6 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
>         return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
>  }
>
> -/**
> - * avc_dump_av - Display an access vector in human-readable form.
> - * @tclass: target security class
> - * @av: access vector
> - */
> -static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> -{
> -       const char **perms;
> -       int i, perm;
> -
> -       if (av == 0) {
> -               audit_log_format(ab, " null");
> -               return;
> -       }
> -
> -       BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> -       perms = secclass_map[tclass-1].perms;
> -
> -       audit_log_format(ab, " {");
> -       i = 0;
> -       perm = 1;
> -       while (i < (sizeof(av) * 8)) {
> -               if ((perm & av) && perms[i]) {
> -                       audit_log_format(ab, " %s", perms[i]);
> -                       av &= ~perm;
> -               }
> -               i++;
> -               perm <<= 1;
> -       }
> -
> -       if (av)
> -               audit_log_format(ab, " 0x%x", av);
> -
> -       audit_log_format(ab, " }");
> -}
> -
> -/**
> - * avc_dump_query - Display a SID pair and a class in human-readable form.
> - * @ssid: source security identifier
> - * @tsid: target security identifier
> - * @tclass: target security class
> - */
> -static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
> -                          u32 ssid, u32 tsid, u16 tclass)
> -{
> -       int rc;
> -       char *scontext;
> -       u32 scontext_len;
> -
> -       rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
> -       if (rc)
> -               audit_log_format(ab, "ssid=%d", ssid);
> -       else {
> -               audit_log_format(ab, "scontext=%s", scontext);
> -               kfree(scontext);
> -       }
> -
> -       rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> -       if (rc)
> -               audit_log_format(ab, " tsid=%d", tsid);
> -       else {
> -               audit_log_format(ab, " tcontext=%s", scontext);
> -               kfree(scontext);
> -       }
> -
> -       BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> -       audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> -}
> -
>  /**
>   * avc_init - Initialize the AVC.
>   *
> @@ -735,11 +666,37 @@ out:
>  static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>  {
>         struct common_audit_data *ad = a;
> -       audit_log_format(ab, "avc:  %s ",
> -                        ad->selinux_audit_data->denied ? "denied" : "granted");
> -       avc_dump_av(ab, ad->selinux_audit_data->tclass,
> -                       ad->selinux_audit_data->audited);
> -       audit_log_format(ab, " for ");
> +       struct selinux_audit_data *sad = ad->selinux_audit_data;
> +       u32 av = sad->audited;
> +       const char **perms;
> +       int i, perm;
> +
> +       audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
> +
> +       if (av == 0) {
> +               audit_log_string(ab, " null");
> +               return;
> +       }
> +
> +       BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
> +       perms = secclass_map[sad->tclass-1].perms;
> +
> +       audit_log_string(ab, " {");
> +       i = 0;
> +       perm = 1;
> +       while (i < (sizeof(av) * 8)) {
> +               if ((perm & av) && perms[i]) {
> +                       audit_log_format(ab, " %s", perms[i]);
> +                       av &= ~perm;
> +               }
> +               i++;
> +               perm <<= 1;
> +       }
> +
> +       if (av)
> +               audit_log_format(ab, " 0x%x", av);
> +
> +       audit_log_string(ab, " } for ");
>  }
>
>  /**
> @@ -751,15 +708,34 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>  static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>  {
>         struct common_audit_data *ad = a;
> -       audit_log_format(ab, " ");
> -       avc_dump_query(ab, ad->selinux_audit_data->state,
> -                      ad->selinux_audit_data->ssid,
> -                      ad->selinux_audit_data->tsid,
> -                      ad->selinux_audit_data->tclass);
> -       if (ad->selinux_audit_data->denied) {
> -               audit_log_format(ab, " permissive=%u",
> -                                ad->selinux_audit_data->result ? 0 : 1);
> +       struct selinux_audit_data *sad = ad->selinux_audit_data;
> +       char *scontext;
> +       u32 scontext_len;
> +       int rc;
> +
> +       rc = security_sid_to_context(sad->state, sad->ssid, &scontext,
> +                                    &scontext_len);
> +       if (rc)
> +               audit_log_format(ab, " ssid=%d", sad->ssid);
> +       else {
> +               audit_log_format(ab, " scontext=%s", scontext);
> +               kfree(scontext);
>         }
> +
> +       rc = security_sid_to_context(sad->state, sad->tsid, &scontext,
> +                                    &scontext_len);
> +       if (rc)
> +               audit_log_format(ab, " tsid=%d", sad->tsid);
> +       else {
> +               audit_log_format(ab, " tcontext=%s", scontext);
> +               kfree(scontext);
> +       }
> +
> +       BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
> +       audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
> +
> +       if (sad->denied)
> +               audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
>  }
>
>  /* This is the slow part of avc audit with big stack footprint */
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
