Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F0C433EF
	for <selinux@archiver.kernel.org>; Fri, 21 Jan 2022 12:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380283AbiAUMGk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380298AbiAUMG3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jan 2022 07:06:29 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DACC061401
        for <selinux@vger.kernel.org>; Fri, 21 Jan 2022 04:06:28 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bf5so13244099oib.4
        for <selinux@vger.kernel.org>; Fri, 21 Jan 2022 04:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iww8y5xMefRYlZAD9BqWTH/8OXeHge24a+EzmbG9tUI=;
        b=NADsUbuh6nRZQA2sMb0FSbyBn/wWLnM4n5ChQYVRGg03Z7rldrgSIaua8R0vJvG79d
         dAsT5H/k49gmlK5ndeEK6Q7frph5G+o8kfda300OM8qwO028sa+/WTgp/SBLc4+SLAm7
         MJGMKND1QGNRlLtmf1Vwilo3+2ruu/ua7AvaspeBuLwGFkE7SLOw0Q3efaqByOwpCO8v
         Ty3Xii8f9b6bnza+d9j9XuM716OHsBsQ0BNBERZ6qMYSvQvedRC9fRqd8vqfuOLxLpMW
         LRsdJlqJBLdxDXCBL1WvnvRR5DYqrfK57YJQMMCe/w9KFneIc2drQSJjVhQFg/4Hd7DL
         4F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iww8y5xMefRYlZAD9BqWTH/8OXeHge24a+EzmbG9tUI=;
        b=uVnsY/nBl0by75f5+dWrZOpkwz1gi1a0VpZ0MMidcsIYP7mvoB276OhmynqNakYs6O
         BrGNtOVn7zQyvkuoE0HPlycEm/e7oltLVSsfG9REQ7ph1gaHNzz9PFFlBA5cKRn4w6pv
         YbsDIe3h9shozTaf1OCMUZ4Vo/oIxm3wDOyB4jUv7bSM9FZ7O0Oi0fmOZB1TQRaiuXw2
         Oh0Fp2t96MGLVWjZI8YCes6iLDyExt18EdbIS9C4KiMA4ReRprPAScCn23AkErlpp+XX
         PV2g3/vZjlLydfAQsYC5tnQakmexPiFShzf1G8E+n3jVbjk0EXRlbMHDAizgQxdrxheb
         kRIQ==
X-Gm-Message-State: AOAM531FXmQad8augGO1Md0gQ2LmTabSIlMTSZvTToKJtrytwSkE71KA
        AawSxihkhXeRSVp4yQ1Ata0f2P11mSLo9q0o/mLc6vgGMuk=
X-Google-Smtp-Source: ABdhPJz1g9Zry24Tvi7cY+sIX+0PfiQA3xmgYNU1ipgBwZb8J3y/Ezlg/CYu9U6FqnwFu3MQ06l+DcK23AjspfD4vNQ=
X-Received: by 2002:a05:6808:1a23:: with SMTP id bk35mr313508oib.52.1642766787244;
 Fri, 21 Jan 2022 04:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20220121084012.GS7643@suse.com>
In-Reply-To: <20220121084012.GS7643@suse.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 21 Jan 2022 13:06:16 +0100
Message-ID: <CAJ2a_Ded5vUji+FmPZ0F09aZ_QGzk_aSAVKiejbAkwJNcPfEDg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Cached security context not accurate
To:     Johannes Segitz <jsegitz@suse.de>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 21 Jan 2022 at 09:40, Johannes Segitz <jsegitz@suse.de> wrote:
>
> Hello,
>
> a colleague of mine (Olaf Kirch) identified a problem with libselinux tha=
t
> has a small security impact. I discussed this with some people on this li=
st
> privately before and we think it doesn't have a big impact and can be
> discussed here without harm.
>
> The reproducer below works on SUSE and RH systems.
> # gcc -Wall -o test -lselinux test.c
> # ./test
> Parent: child context according to library unconfined_u:unconfined_r:unco=
nfined_t:s0
> Parent: child context according to procfs: unconfined_u:unconfined_r:pass=
wd_t:s0
> bummer, context mismatch
>
> You need to make you system permissive to allow the initial context chang=
e.
>
> The problem is the procattr cache in libselinux, which doesn't work prope=
rly.
> Attached is a small patch that "fixes" the issue at the cost of not using=
 the
> cache as soon as a pid is specified.
>
> With this applied we see the correct result:
> # ./test
> Parent: child context according to library unconfined_u:unconfined_r:pass=
wd_t:s0
> Parent: child context according to procfs: unconfined_u:unconfined_r:pass=
wd_t:s0
>
> In most use cases this issue will not be much of a problem, but it's stil=
l
> a small security issue, since this incorrect information might lead to
> incorrect access decisions. This way of doing it is inherently racy and
> should not be used for security decision, it's also probably pretty rare =
to
> see this. ATM not CVE was assigned. Strictly speaking we probably need on=
e,
> but I won't push for it given the low impact.
>
> Thanks,
> Johannes
>
> /*
>  * This demonstrates some odd behavior in libselinux.
>  *
>  * procattr query functions seem to return cached content from
>  * previous calls to the corresponding set function, but without
>  * taking the pid into account.
>  *
>  * This means that getpidcon() returns the context installed
>  * by the most recent setcon() call, rather than the actual
>  * context of the process we wanted to query.
>  *
>  * Apparently, this was introduced by commit 1d403326a
>  *
>  * Enjoy,
>  * Olaf Kirch <okir at suse.de>
>  */
> #include <selinux/selinux.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <signal.h>
> #include <unistd.h>
>
> static void
> fatal(const char *msg)
> {
>         perror(msg);
>         exit(1);
> }
>
> static char *
> getpidcon_sinatra(pid_t pid)
> {
>         static char linebuf[128];
>         char path[1024];
>         FILE *fp;
>
>         snprintf(path, sizeof(path), "/proc/%d/attr/current", pid);
>         if ((fp =3D fopen(path, "r")) =3D=3D NULL)
>                 fatal(path);
>
>         if (fgets(linebuf, sizeof(linebuf), fp) =3D=3D NULL)
>                 fatal("read from /proc file");
>         fclose(fp);
>
>         return linebuf;
> }
>
> int
> main(void)
> {
>         char *lib_context =3D NULL, *actual_context;
>         pid_t pid;
>
>         pid =3D fork();
>         if (pid < 0)
>                 fatal("fork");
>
>         if (pid =3D=3D 0) {
>                 if (setcon("unconfined_u:unconfined_r:passwd_t:s0") < 0)
>                         fatal("child setcon");
>
>                 sleep(15);
>                 exit(0);
>         }
>
>         /* Set my own process context.
>          * This will addle the library's brain by setting prev_current
>          * in procattr.c
>          */
>         if (setcon("unconfined_u:unconfined_r:unconfined_t:s0") < 0)
>                 fatal("parent setcon");
>
>         /* Wait for the child process to complete initialization */
>         sleep(1);
>
>         /* Ask the library about the security context */
>         if (getpidcon(pid, &lib_context) < 0)
>                 fatal("getpidcon");
>         printf("Parent: child context according to library %s\n", lib_con=
text);
>
>         /* Query /proc/$pid/attr/current directly, which is what
>          * the library is supposed to do. */
>         actual_context =3D getpidcon_sinatra(pid);
>         printf("Parent: child context according to procfs: %s\n", actual_=
context);
>
>         kill(pid, 9);
>
>         if (strcmp(lib_context, actual_context) !=3D 0) {
>                 printf("bummer, context mismatch\n");
>                 return 1;
>         }
>
>         return 0;
> }
>
>
> Johannes
> --
> GPG Key                EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
> Subkey fingerprint:    250F 43F5 F7CE 6F1E 9C59  4F95 BC27 DD9D 2CC4 FD66
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nuernberg
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev (HRB 36809, AG N=C3=BCrnberg)
>
>
>
> - if (prev_context && prev_context !=3D UNSET) {
> + if (prev_context && prev_context !=3D UNSET && !pid) {

Wouldn't it make logically more sense to first check if pid is zero
and then check if the cache is set, cause we never want to access the
cache if not operating on out own process?

Also isn't setprocattrcon_raw() affected too?

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 142fbf3a..c7a842ed 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -242,9 +242,9 @@ static int setprocattrcon_raw(const char * context,
                       return -1;
       }

-       if (!context && !*prev_context)
+       if (pid =3D=3D 0 && !context && !*prev_context)
               return 0;
-       if (context && *prev_context && *prev_context !=3D UNSET
+       if (pid =3D=3D 0 && context && *prev_context && *prev_context !=3D =
UNSET
           && !strcmp(context, *prev_context))
               return 0;

@@ -272,9 +272,11 @@ out:
               free(context2);
               return -1;
       } else {
-               if (*prev_context !=3D UNSET)
-                       free(*prev_context);
-               *prev_context =3D context2;
+               if (pid =3D=3D 0) {
+                       if (*prev_context !=3D UNSET)
+                               free(*prev_context);
+                       *prev_context =3D context2;
+               }
               return 0;
       }
}
