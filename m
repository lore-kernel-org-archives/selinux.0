Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86526C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376CF218D0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 22:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0nCIRYhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAYWfR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:35:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34222 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYWfR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 17:35:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so8082998lfc.1
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 14:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qYE6kEb/PAP3qttvtkJzFj4cX6nws32ZGZdqBKOiKOM=;
        b=0nCIRYhsG5zlSn2a0ymSBV+8XA2RQgLE7p3fchviFMzZxIVBRDl9SsOY7zgDdt7BXM
         s9EHAoPwQNYuU3CgA0UklwR6RUolmsTgohVpwCeEUkNgEVZsM80gMA5VLtKyOUpGn+PS
         iSxpiorC5NmK/k9r0kXTL6xGvdzDkzO7EdWqNkDpVJuYdGSLZPyF4pgsPLBsvZq03Vhu
         yrzXBUL7Rjln26j1Ap+M21VOY0ZPWDwkfeL9m1b6J+8Sj32LyPaQgrt6J7d5pf+nq5Uz
         mx1WS7wUiv728jHtQcRn/hiMFeae3kdH6Ot7INUfrumPtxOZkFFb2Oy+HvYt2BGaLWby
         WPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qYE6kEb/PAP3qttvtkJzFj4cX6nws32ZGZdqBKOiKOM=;
        b=r/6EW5eY0HblW1IL7xMMdkX1VVUSqAnbhNBO/7zQdoWFoQdo2BSDw3haEru8vlt5l5
         5UcFLPDIeXnKoHyWyauS9yFRb/m9+bK69YhiizHmzSko23LB0TM0evlp8lio4o41VPXN
         Mj5tNCfXHy0FUjAkiJxdvehjpdB97wCcgjVEzLZoGqJl1gSj+lEmKkSx4TdKMlz7V1RP
         3WhjzA0LhGfcE4nT0G3eJEBr0LfWOd87S5tiUgZEYRSck+sisv8v/8zIN+mskTrTYiFp
         EYEayO/lgE8fRQAEWmowAOf5665pYEjy4td3Gb7LAdxkEqXTEsKMN5MFccCxZz+EL69c
         2gFA==
X-Gm-Message-State: AJcUukdDmEOog4YnqHf6F0GBLXImAsgFBdhhIklVy2pTiLo3XXSZpiwg
        mc6c4gcTSzJxjPs7Mnd92fW56WXqE3gSPLdYbVut
X-Google-Smtp-Source: ALg8bN5SCid5Lt1mxdNepd+7r9uIw+41ViBau4QKVs0hBf8GOBLTIqvga2KIIuZtSrDfY2zvzrz7/mQm6UPhL3u8qMo=
X-Received: by 2002:a19:c995:: with SMTP id z143mr9702173lff.79.1548455714241;
 Fri, 25 Jan 2019 14:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20190125100651.21753-1-omosnace@redhat.com> <20190125100651.21753-5-omosnace@redhat.com>
In-Reply-To: <20190125100651.21753-5-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 17:35:03 -0500
Message-ID: <CAHC9VhR+xNhtpGY0aoQx+AuYmaJE6OSBsETXXfADvq+Qh1xKQQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selinux: log invalid contexts in AVCs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-audit@redhat.com, Daniel Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 25, 2019 at 5:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> In case a file has an invalid context set, in an AVC record generated
> upon access to such file, the target context is always reported as
> unlabeled. This patch adds new optional fields to the AVC record
> (srawcon and trawcon) that report the actual context string if it
> differs from the one reported in scontext/tcontext. This is useful for
> diagnosing SELinux denials involving invalid contexts.
>
> To trigger an AVC that illustrates this situation:
>
>     # setenforce 0
>     # touch /tmp/testfile
>     # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/=
testfile
>     # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
>
> AVC before:
>
> type=3DAVC msg=3Daudit(1547801083.248:11): avc:  denied  { open } for  pi=
d=3D1149 comm=3D"cat" path=3D"/tmp/testfile" dev=3D"tmpfs" ino=3D6608 scont=
ext=3Dsystem_u:system_r:sshd_t:s0 tcontext=3Dsystem_u:object_r:unlabeled_t:=
s15:c0.c1023 tclass=3Dfile permissive=3D1
>
> AVC after:
>
> type=3DAVC msg=3Daudit(1547801083.248:11): avc:  denied  { open } for  pi=
d=3D1149 comm=3D"cat" path=3D"/tmp/testfile" dev=3D"tmpfs" ino=3D6608 scont=
ext=3Dsystem_u:system_r:sshd_t:s0 tcontext=3Dsystem_u:object_r:unlabeled_t:=
s15:c0.c1023 tclass=3Dfile permissive=3D1 trawcon=3Dsystem_u:object_r:banan=
a_t:s0
>
> Note that it is also possible to encounter this situation with the
> 'scontext' field - e.g. when a new policy is loaded while a process is
> running, whose context is not valid in the new policy.
>
> Cc: Daniel Walsh <dwalsh@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1135683
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c              | 15 ++++++++++++
>  security/selinux/include/security.h |  3 +++
>  security/selinux/ss/services.c      | 37 +++++++++++++++++++++++++----
>  3 files changed, 50 insertions(+), 5 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 478fa4213c25..047de65589bd 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -734,6 +734,21 @@ static void avc_audit_post_callback(struct audit_buf=
fer *ab, void *a)
>
>         if (sad->denied)
>                 audit_log_format(ab, " permissive=3D%u", sad->result ? 0 =
: 1);
> +
> +       /* in case of invalid context report also the actual context stri=
ng */
> +       rc =3D security_sid_to_context_inval(sad->state, sad->ssid, &scon=
text,
> +                                          &scontext_len);
> +       if (!rc && scontext) {
> +               audit_log_format(ab, " srawcon=3D%s", scontext);
> +               kfree(scontext);
> +       }
> +
> +       rc =3D security_sid_to_context_inval(sad->state, sad->tsid, &scon=
text,
> +                                          &scontext_len);
> +       if (!rc && scontext) {
> +               audit_log_format(ab, " trawcon=3D%s", scontext);
> +               kfree(scontext);
> +       }
>  }
>
>  /* This is the slow part of avc audit with big stack footprint */
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index ba8eedf42b90..f68fb25b5702 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -255,6 +255,9 @@ int security_sid_to_context(struct selinux_state *sta=
te, u32 sid,
>  int security_sid_to_context_force(struct selinux_state *state,
>                                   u32 sid, char **scontext, u32 *scontext=
_len);
>
> +int security_sid_to_context_inval(struct selinux_state *state,
> +                                 u32 sid, char **scontext, u32 *scontext=
_len);
> +
>  int security_context_to_sid(struct selinux_state *state,
>                             const char *scontext, u32 scontext_len,
>                             u32 *out_sid, gfp_t gfp);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index dd44126c8d14..9be05c3e99dc 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1281,7 +1281,8 @@ const char *security_get_initial_sid_context(u32 si=
d)
>
>  static int security_sid_to_context_core(struct selinux_state *state,
>                                         u32 sid, char **scontext,
> -                                       u32 *scontext_len, int force)
> +                                       u32 *scontext_len, int force,
> +                                       int only_invalid)
>  {
>         struct policydb *policydb;
>         struct sidtab *sidtab;
> @@ -1326,8 +1327,14 @@ static int security_sid_to_context_core(struct sel=
inux_state *state,
>                 rc =3D -EINVAL;
>                 goto out_unlock;
>         }
> -       rc =3D context_struct_to_string(policydb, context, scontext,
> -                                     scontext_len);
> +       if (only_invalid && !context->len) {
> +               scontext =3D NULL;
> +               scontext_len =3D 0;
> +               rc =3D 0;
> +       } else {
> +               rc =3D context_struct_to_string(policydb, context, sconte=
xt,
> +                                             scontext_len);
> +       }
>  out_unlock:
>         read_unlock(&state->ss->policy_rwlock);
>  out:
> @@ -1349,14 +1356,34 @@ int security_sid_to_context(struct selinux_state =
*state,
>                             u32 sid, char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(state, sid, scontext,
> -                                           scontext_len, 0);
> +                                           scontext_len, 0, 0);
>  }
>
>  int security_sid_to_context_force(struct selinux_state *state, u32 sid,
>                                   char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(state, sid, scontext,
> -                                           scontext_len, 1);
> +                                           scontext_len, 1, 0);
> +}
> +
> +/**
> + * security_sid_to_context_inval - Obtain a context for a given SID if i=
t
> + *                                 is invalid.
> + * @sid: security identifier, SID
> + * @scontext: security context
> + * @scontext_len: length in bytes
> + *
> + * Write the string representation of the context associated with @sid
> + * into a dynamically allocated string of the correct size, but only if =
the
> + * context is invalid in the current policy.  Set @scontext to point to
> + * this string (or NULL if the context is valid) and set @scontext_len t=
o
> + * the length of the string (or 0 if the context is valid).
> + */
> +int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
> +                                 char **scontext, u32 *scontext_len)
> +{
> +       return security_sid_to_context_core(state, sid, scontext,
> +                                           scontext_len, 1, 1);
>  }
>
>  /*
> --
> 2.20.1
>


--=20
paul moore
www.paul-moore.com
