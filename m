Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7739AC282C3
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762D20870
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 19:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="phJ2oxEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfAVTmO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:42:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42931 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAVTmO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 14:42:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so18980754lfh.9
        for <selinux@vger.kernel.org>; Tue, 22 Jan 2019 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LTdmrGWkLAOPXlWZ/vqZoHvEjnxw4Lb7CvJD2zzhtpc=;
        b=phJ2oxElFrWY8y+LTnZSr6QzLrmhHJ3gM1knbQ6/JCuzC2PTFoI3dGlzQmrRw267ZU
         TvhXOhHa4xZOwcFbKbAUjVrcHLCvSRoqGK+EijkRkdRltUhnDEuh1qvAjTxowQW+P2Of
         7VoWwKPZLWeQcMqGIN5EFfURHdy5d0MPUzP5HSg4D81AzlCxCDq031+yPtaHjHA0ZC/q
         NnGkb59o8Vfz02c4ETwmcrBFGdRXfjYmQRLStBzCB+tDj2S3KL7g2R18xfMShdOni7jB
         mGPw6Si9CpQOeMgwQ9QU7XvN+mtvZluN3D6twWK7YEWJem8QqCncaRLv4CXoPha92m3t
         /0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LTdmrGWkLAOPXlWZ/vqZoHvEjnxw4Lb7CvJD2zzhtpc=;
        b=PQCv8gE6GG6gSq/gCxfRufVXi9a6jeftM/Tlgnuc03Hsraszr7y4cdvkeGkAE/ck0x
         xnoHgA2rQK9w5jc79DH5GTP4HJAM1V8/7lDAhwKrMZuXfJt2KkvuuWpt35CnmSAcUvID
         c7Kuj3aODOXWdGisYWOFhoICNY58pYy4OJ2cCujotsZqpeDE9HezlzkuqyU35/iJYOB3
         nWMK/dV/jDYUluP8ZhTquEmRnD7IPvxPd8q8IXyQnyPgkQQ7SJ/s4JQCcg0sAfOA8Kk7
         YQE14NXDqt0Ywa3UE0JbERo/3DRqyXDp+uW/X/ZAwjz8X8VzhEE0sKzopT2vYh+4ykAM
         3rZQ==
X-Gm-Message-State: AJcUukfQgM+nz6vYT3I+QYh1cRvjQe7v8nmgx+a/GmQ9QIV8sBIbNVmW
        B1CKAn2M8fwLxebWLM26w/Tx3xkrlHgizRbec81OzJ0=
X-Google-Smtp-Source: ALg8bN717hR3sIgeYf8esSC62xxmk3ePVNcmwwueFJdoBV98Ex2MJ3ZJzTCPNutkN9zzDGILFKWgY4qYDlbZbVA4Ay0=
X-Received: by 2002:a19:5e5d:: with SMTP id z29mr21424879lfi.105.1548186131476;
 Tue, 22 Jan 2019 11:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20190121153605.26847-1-omosnace@redhat.com>
In-Reply-To: <20190121153605.26847-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Jan 2019 14:42:00 -0500
Message-ID: <CAHC9VhRDSMeojFEFz+8rshiP4TmtoGuEuOK0AwZecyJ0SWN3Ug@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log invalid contexts in AVCs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-audit@redhat.com, Daniel Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 21, 2019 at 10:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
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
s15:c0.c1023 trawcon=3Dsystem_u:object_r:banana_t:s0 tclass=3Dfile permissi=
ve=3D1

I would like us to add new fields at the end of existing records; the
recent audit config changes are a bit of a special case as discussed
previously.

Also, under what cases would we ever see a srawcon field?  This is
only going to happen if we have a running process whose domain is
removed during a policy reload, correct?  I'm find with including this
for the sake of completeness, but I would mention this in the patch
description for the next revision.

> Cc: Daniel Walsh <dwalsh@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1135683
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: Rename fields to "(s|t)rawcon".
>
>  security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9b63d8ee1687..df5490db575b 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16=
 tclass, u32 av)
>         audit_log_format(ab, " }");
>  }
>
> +static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *=
state,
> +                        u32 sid, char type)
> +{
> +       int rc;
> +       char *context, *rcontext;
> +       u32 context_len, rcontext_len;
> +
> +       rc =3D security_sid_to_context(state, sid, &context, &context_len=
);
> +       if (rc) {
> +               audit_log_format(ab, "%csid=3D%d ", type, sid);
> +               return;
> +       }
> +
> +       audit_log_format(ab, "%ccontext=3D%s ", type, context);
> +
> +       /* in case of invalid context report also the actual context stri=
ng */
> +       rc =3D security_sid_to_context_force(state, sid, &rcontext,
> +                                          &rcontext_len);
> +       if (!rc) {
> +               if (strcmp(context, rcontext))
> +                       audit_log_format(ab, "%crawcon=3D%s ", type, rcon=
text);
> +               kfree(rcontext);
> +       }
> +       kfree(context);
> +}
> +
>  /**
>   * avc_dump_query - Display a SID pair and a class in human-readable for=
m.
>   * @ssid: source security identifier
> @@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u1=
6 tclass, u32 av)
>  static void avc_dump_query(struct audit_buffer *ab, struct selinux_state=
 *state,
>                            u32 ssid, u32 tsid, u16 tclass)
>  {
> -       int rc;
> -       char *scontext;
> -       u32 scontext_len;
> -
> -       rc =3D security_sid_to_context(state, ssid, &scontext, &scontext_=
len);
> -       if (rc)
> -               audit_log_format(ab, "ssid=3D%d", ssid);
> -       else {
> -               audit_log_format(ab, "scontext=3D%s", scontext);
> -               kfree(scontext);
> -       }
> -
> -       rc =3D security_sid_to_context(state, tsid, &scontext, &scontext_=
len);
> -       if (rc)
> -               audit_log_format(ab, " tsid=3D%d", tsid);
> -       else {
> -               audit_log_format(ab, " tcontext=3D%s", scontext);
> -               kfree(scontext);
> -       }
> +       avc_dump_sid(ab, state, ssid, 's');
> +       avc_dump_sid(ab, state, tsid, 't');
>
>         BUG_ON(!tclass || tclass >=3D ARRAY_SIZE(secclass_map));
> -       audit_log_format(ab, " tclass=3D%s", secclass_map[tclass-1].name)=
;
> +       audit_log_format(ab, "tclass=3D%s", secclass_map[tclass-1].name);
>  }
>
>  /**
> --
> 2.20.1

--=20
paul moore
www.paul-moore.com
