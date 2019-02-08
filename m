Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1ECC169C4
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B08021908
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 21:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXIHfd20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBHVtn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:49:43 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38961 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHVtm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 16:49:42 -0500
Received: by mail-vs1-f66.google.com with SMTP id e16so3012775vsq.6
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 13:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fRaS5HEGitPBMuZe/mI/6bybUFiM7/sj7x0YbePNjY=;
        b=aXIHfd20YOICHLRxigPSutLUUA6kYK4NZVrf9MClkFK8qLumsLJdHErpIFkPz7VZwp
         1QIXzZRMp+Vq1UigA5uj8WukuebbfHr83hFjjPC3kox3rspL9sy6U9KIU4lnmVytb31j
         Se66MTZg1Lbx1T7tFRrtLK9DEg9xTBERYHVbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fRaS5HEGitPBMuZe/mI/6bybUFiM7/sj7x0YbePNjY=;
        b=IzTs6qaxe1/oPUlSUSLg3ET+fh5BhQlx9nWNKZSH8uFo0C+x59E3mFAJpBEcz3Nhx2
         sBSKON+S1fKMqueNkkbZmdf9yfpmdNKHXJrqTEx4+s3DD6t+OXTSkI0hA7ACQ7Fa3DbI
         5i/ZvI2PWT8XYPaan273Ep0ZbfW1T2jAi0TD97iukT20SkpP1YZ2q7V/CzSE8CqtlQLb
         mbJCPUasgv8mDoYh0GwIwNn8hfbwG5yQ9QtEmuFO+AFTlQx+hEZRLSGfGCIIoNPyG4mv
         8JkHqBZD6BMa2L31p5bS6KPPRadKwMvYZVAgEoI7nMu/Pf/+vfNSes0buwYB2YHJA972
         aSTA==
X-Gm-Message-State: AHQUAubDPw3cAd6JWiwvMAXM/8nO2t/nWuZyD2ew5+0fHiZwGUKq5jtX
        i92ZVHmjJU5gciX/5dlQdqheC4oLqGA=
X-Google-Smtp-Source: AHgI3IYOSYko6SD2+szgMtDYqCWTsOUdeBIHFbrAmsTQd9WovmOPKgLwf+jcTFzC2MtywZAfoHZL7Q==
X-Received: by 2002:a67:81c1:: with SMTP id c184mr3267327vsd.111.1549662581587;
        Fri, 08 Feb 2019 13:49:41 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id b131sm4141499vkf.45.2019.02.08.13.49.40
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 13:49:41 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id z11so1610541uaa.10
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 13:49:40 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr869203uan.114.1549662580116;
 Fri, 08 Feb 2019 13:49:40 -0800 (PST)
MIME-Version: 1.0
References: <8f48e1d0-c109-f8a9-ea94-9659b16cae49@i-love.sakura.ne.jp>
 <0d23d1a5-d4af-debf-6b5f-aaaf698daaa8@schaufler-ca.com> <201902070230.x172UUG6002087@www262.sakura.ne.jp>
 <6def6199-0235-7c37-974c-baf731725606@schaufler-ca.com> <54c0ae39-f35c-bdcd-a217-8e62ef14e41b@i-love.sakura.ne.jp>
In-Reply-To: <54c0ae39-f35c-bdcd-a217-8e62ef14e41b@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 8 Feb 2019 13:49:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJF1M8K39fT0ctOWKBJegboyvLD1pc9U2P_x=miENHw+A@mail.gmail.com>
Message-ID: <CAGXu5jJF1M8K39fT0ctOWKBJegboyvLD1pc9U2P_x=miENHw+A@mail.gmail.com>
Subject: Re: [PATCH] LSM: Allow syzbot to ignore security= parameter.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@vger.kernel.org>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 8, 2019 at 2:52 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/02/08 1:24, Casey Schaufler wrote:
> >>>> Then, I think that it is straightforward (and easier to manage) to ignore security= parameter
> >>>> when lsm= parameter is specified.
> >>> That reduces flexibility somewhat. If I am debugging security modules
> >>> I may want to use lsm= to specify the order while using security= to
> >>> identify a specific exclusive module. I could do that using lsm= by
> >>> itself, but habits die hard.
> >> "lsm=" can be used for identifying a specific exclusive module, and Ubuntu kernels would
> >> have to use CONFIG_LSM (or "lsm=") for identifying the default exclusive module (in order
> >> to allow enabling both TOMOYO and one of SELinux,Smack,AppArmor at the same time).
> >>
> >> Since "security=" can't be used for selectively enable/disable more than one of
> >> SELinux,Smack,TOMOYO,AppArmor, I think that recommending users to migrate to "lsm=" is the
> >> better direction. And ignoring "security=" when "lsm=" is specified is easier to understand.
> >
> > I added Kees to the CC list. Kees, what to you think about
> > ignoring security= if lsm= is specified? I'm ambivalent.
> >
> >
>
> To help administrators easily understand what LSM modules are possibly enabled by default (which
> have to be fetched from e.g. /boot/config-`uname -r`) and specify lsm= parameter when they need,
> I propose changes shown below.
>
> diff --git a/security/security.c b/security/security.c
> index 3147785e..051d708 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -51,8 +51,6 @@
>  static __initdata const char *chosen_lsm_order;
>  static __initdata const char *chosen_major_lsm;
>
> -static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
> -
>  /* Ordered list of LSMs to initialize. */
>  static __initdata struct lsm_info **ordered_lsms;
>  static __initdata struct lsm_info *exclusive;
> @@ -284,14 +282,22 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  static void __init ordered_lsm_init(void)
>  {
>         struct lsm_info **lsm;
> +       const char *order = CONFIG_LSM;
> +       const char *origin = "builtin";
>
>         ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
>                                 GFP_KERNEL);
>
> -       if (chosen_lsm_order)
> -               ordered_lsm_parse(chosen_lsm_order, "cmdline");
> -       else
> -               ordered_lsm_parse(builtin_lsm_order, "builtin");
> +       if (chosen_lsm_order) {
> +               if (chosen_major_lsm) {
> +                       pr_info("security= is ignored because of lsm=\n");

This is intended to be the new default way to change the LSM
("lsm=..."), so I'd rather not have this appear every time. Also, it
must continue to interact with the builtin ordering, so if you wanted
this, I think better would be to do:

diff --git a/security/security.c b/security/security.c
index 3147785e20d7..e6153ed54361 100644
--- a/security/security.c
+++ b/security/security.c
@@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
        ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
                                GFP_KERNEL);

-       if (chosen_lsm_order)
+       if (chosen_lsm_order) {
+               if (chosen_major_lsm) {
+                       pr_info("security= is ignored because of lsm=\n");
+                       chosen_major_lsm = NULL;
+               }
                ordered_lsm_parse(chosen_lsm_order, "cmdline");
-       else
+       } else
                ordered_lsm_parse(builtin_lsm_order, "builtin");

        for (lsm = ordered_lsms; *lsm; lsm++)

> +       pr_info("Security Framework initializing: %s\n", order);
> +       ordered_lsm_parse(order, origin);
>
>         for (lsm = ordered_lsms; *lsm; lsm++)
>                 prepare_lsm(*lsm);
> @@ -333,8 +339,6 @@ int __init security_init(void)
>         int i;
>         struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
>
> -       pr_info("Security Framework initializing\n");
> -
>         for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
>              i++)
>                 INIT_HLIST_HEAD(&list[i]);



-- 
Kees Cook
