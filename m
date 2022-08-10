Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67BC00140
	for <selinux@archiver.kernel.org>; Wed, 10 Aug 2022 15:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiHJPds (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJPdr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Aug 2022 11:33:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED822294
        for <selinux@vger.kernel.org>; Wed, 10 Aug 2022 08:33:47 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10edfa2d57dso18273025fac.0
        for <selinux@vger.kernel.org>; Wed, 10 Aug 2022 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=13bnse+P/aaa9SiSSnleYNyZIpjnQ+bE/GCYUmp0Omo=;
        b=bsSBA+mqMDu59sQ5r1FeexGIOrGZ5gqkvlyg2PHOdh0FtzhRRQ7v/cNQxmH9hUymvc
         kTy2uh8nIaaRG6SsAYnxkcrkqj8A7RuYW+TjvvNa91C/rtd8I40JLLnoqm5wgVWQoWB5
         dXDc4/fY6/zIy6b8jeuDBtZ7/y0L2I20K9u1qWoFI3cj9Hw2Rz/tRjoyOu7Hdd81ybEZ
         2FdMK/py/p7zlY4omBO/es9x0qX+B44JPdZn1iOsUF+SSBcygNwVXqJzp+1YmtBcDeG1
         xiAgG7H11YksrZiRdS05SV7yPHhpPqwpvNYrMDLO7zXxmwLqIWfYsrPMrE3W2Mc12s+m
         2HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=13bnse+P/aaa9SiSSnleYNyZIpjnQ+bE/GCYUmp0Omo=;
        b=GHbYvaynHS9IqQbxiJnYEOqbifHMRZhnQbqWt82YHtMxVyHdEcMHvGAE2wmzp+adGB
         uUYtfcgSCUBPsc68lNuihjYDibYnDzimqN3qdwXODGxdqVfzrwLJspJgE8cvQuyd2DiG
         scknhZMO5nbM7KTIjAkro/SlNCdcz+qOOfp15FvbOOmUJpUKiAwhChv6z2rIUVbyQRWv
         wmFjYojDrKs4Q0RtiqeGGqea2EDN1AZmZ3RZmo8w3qDhf33t872TZzFfjHkvQf5COM4Y
         tLmSQMjc3kZvEDpeZpZ69afHbTPHJB/LJRKTuTqh2nds8SY7hJrrlaZZA2++3McYCuGo
         0I4g==
X-Gm-Message-State: ACgBeo0BKKkPysAWPW4tmrUOJIhm6Bw7zo+CH+oS325szhVguRSFiCel
        sgwE7HvaeIeBvZcHcRybXrNbZagqOKVHWlXCD0mEappI6nI=
X-Google-Smtp-Source: AA6agR5PyweNzDyDWFACV1IxWLC7RCOjwm+WH2RPAD/sfv9IchwN0KJe75s/WsuNEPhmH4AYNidsTNot31vVT0QXtMo=
X-Received: by 2002:a05:6870:89a5:b0:116:ca99:6de7 with SMTP id
 f37-20020a05687089a500b00116ca996de7mr1220891oaq.182.1660145625964; Wed, 10
 Aug 2022 08:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220808173429.16318-1-cgzones@googlemail.com>
In-Reply-To: <20220808173429.16318-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 10 Aug 2022 11:33:35 -0400
Message-ID: <CAP+JOzSXn++7PrSViBt2tEsBr1vNweAtduO00bAMmv3GjTOuCQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid newline in avc message
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 8, 2022 at 1:36 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not add a final newline to the avc log message as it will be treated
> as a part of the tclass field in final audit record:
>
>     {
>         "AUDIT_FIELD_EXE" : "/usr/bin/dbus-broker",
>         "_UID" : "104",
>         "_AUDIT_SESSION" : "4294967295",
>         "_TRANSPORT" : "audit",
>         "__REALTIME_TIMESTAMP" : "1659975331468531",
>         "_AUDIT_TYPE" : "1107",
>         "AUDIT_FIELD_SCONTEXT" : "system_u:system_r:systemd_t:s0",
>         "_AUDIT_LOGINUID" : "4294967295",
>         "_SELINUX_CONTEXT" : "system_u:system_r:system_dbusd_t:s0-s0:c0.c=
1023",
>         "AUDIT_FIELD_SAUID" : "104",
>         "MESSAGE" : "USER_AVC pid=3D1538 uid=3D104 auid=3D4294967295 ses=
=3D4294967295 subj=3Dsystem_u:system_r:system_dbusd_t:s0-s0:c0.c1023 msg=3D=
'avc:  granted  { send_msg } for  scontext=3Dsystem_u:system_r:systemd_t:s0=
 tcontext=3Dsystem_u:system_r:systemd_logind_t:s0 tclass=3Ddbus\n exe=3D\"/=
usr/bin/dbus-broker\" sauid=3D104 hostname=3D? addr=3D? terminal=3D?'",
>         "AUDIT_FIELD_TCONTEXT" : "system_u:system_r:systemd_logind_t:s0",
>         "_SOURCE_REALTIME_TIMESTAMP" : "1659975331462000",
>         "__MONOTONIC_TIMESTAMP" : "207995768",
>         "AUDIT_FIELD_TCLASS" : "dbus\n",
>         "AUDIT_FIELD_TERMINAL" : "?",
>         "_PID" : "1538",
>         "SYSLOG_FACILITY" : "4",
>         "_BOOT_ID" : "3921464b65f64fb4a7c037dee97cd6ad",
>         "SYSLOG_IDENTIFIER" : "audit",
>         "_MACHINE_ID" : "5d78c28f10d54c0fb7b6fd1acc6af8ff",
>         "_AUDIT_TYPE_NAME" : "USER_AVC",
>         "__CURSOR" : "s=3D84589ce96ff8400189fc515ff892674a;i=3Dc38e;b=3D3=
921464b65f64fb4a7c037dee97cd6ad;m=3Dc65c378;t=3D5e5bd1ff7d4f3;x=3Dc22e610fc=
9b00b10",
>         "AUDIT_FIELD_ADDR" : "?",
>         "AUDIT_FIELD_HOSTNAME" : "?",
>         "_AUDIT_ID" : "1075",
>         "_HOSTNAME" : "debianBullseye"
>     }
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/avc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 7493e4b2..8d5983a2 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -725,7 +725,6 @@ void avc_audit(security_id_t ssid, security_id_t tsid=
,
>         if (denied)
>                 log_append(avc_audit_buf, " permissive=3D%u", result ? 0 =
: 1);
>
> -       log_append(avc_audit_buf, "\n");
>         avc_log(SELINUX_AVC, "%s", avc_audit_buf);
>
>         avc_release_lock(avc_log_lock);
> --
> 2.36.1
>
