Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B513C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 22:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLPWAB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPWAA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 17:00:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A6D12AC4
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:59:59 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kw15so9187561ejc.10
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYtnP8VYDZdiAih0aniweX7Z4tbVbUvAVei7tpwchjQ=;
        b=iidD9ynNUOGBXMc62FJrmHlU0Jhri0xbahgsAHHc0AjQcL5ZShlAAtiVUbd8VQQz7P
         Vob+DrqUzOLNjO3yXyjm6bvW/Q5FceN+M1jzL29UlrI2YOdg7J1InA2sr922cKkLUHWq
         0zYKpw9lzaUEqQ77m4fLho8sRRbh1GGA0XGcRWGgkpqBIfVfKnHl4G1HEhtwOGeDeuwF
         ZGggyA5kNwHa5GctlhGTNSsA7aJRDuZxYCYWNX2Nvn3XifMLSl7S0uYk+z8lcnluqlJS
         VsNEgx9gHmNxgzf6vFJFSSKhh7tAnpOYzsgPZ+Vfwgt3YqDeNdW5H/o258Fd33CyC+4B
         8+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYtnP8VYDZdiAih0aniweX7Z4tbVbUvAVei7tpwchjQ=;
        b=zPB2kpwqXvBIMphtmJ0bU3jSEnKWfjQekYZdNecCs9j408RPYayX3yCBQfGv3RW8LN
         1QSoO685sNdKs5PCqawgSIMp668a/kZhtLrOduiKe436yFCdnGi3ChxIXqXOh/AhTTn2
         TQDPbKNrIpKJX5PLktUtSy8e6me5A5Br5to0Ww9w0v+bapoueDadWIPUS+OUPn3FZbc+
         Q7z43ocdTVWeCqB/1Vvjl6x/k+xY14OoRyAusDyCObawsxFmvrX7MnhyLzmfBHNCXHnd
         eWbdq5r+d+qP+OrWD7hCsM+jLyvybDty26XzgsFDtWnFLnG+AwiPEcp9LcOTooySMUWt
         7GQA==
X-Gm-Message-State: ANoB5pkSpejWodwOCfgHQYUX/V+2Lkd26BPvrCR8HhhvzJMYfv7WTjgV
        CZ07FOr7XHMNkx+F6Rv6ahozX9lDda2smHBWKgBuIjkB
X-Google-Smtp-Source: AA0mqf6fdzp9ZQ7UFNUB2Q25reN1QNyh7f+5z6UlViuYVrhdVOLO6WdHwSpdz04Dcn4qqTAcEpvMgQw6VJxz6GtD98g=
X-Received: by 2002:a17:906:fc3:b0:7c0:a880:dc71 with SMTP id
 c3-20020a1709060fc300b007c0a880dc71mr31833511ejk.705.1671227998067; Fri, 16
 Dec 2022 13:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20221124163153.500945-1-vmojzis@redhat.com> <CAP+JOzSGcmHHzaZOWS=wPqa-o-psgGJddLsFLJ15WDWg=KGDtQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSGcmHHzaZOWS=wPqa-o-psgGJddLsFLJ15WDWg=KGDtQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 16:59:47 -0500
Message-ID: <CAP+JOzR2NtbCf3a+ASuSjQv-t-40raSEvqYLON33+jovG4v1cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: Improve error message for type bounds
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 15, 2022 at 5:13 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Nov 24, 2022 at 11:40 AM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Make the error message consistent with other occurrences of the
> > same issue:
> > https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/module_compiler.c#L243
> > https://github.com/SELinuxProject/selinux/blob/master/checkpolicy/module_compiler.c#L488
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Both of these have been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 41e44631..86d57017 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1416,7 +1416,7 @@ static int define_typebounds_helper(char *bounds_id, char *type_id)
> >         if (!type->bounds)
> >                 type->bounds = bounds->s.value;
> >         else if (type->bounds != bounds->s.value) {
> > -               yyerror2("type %s has inconsistent master {%s,%s}",
> > +               yyerror2("type %s has inconsistent bounds %s/%s",
> >                          type_id,
> >                          policydbp->p_type_val_to_name[type->bounds - 1],
> >                          policydbp->p_type_val_to_name[bounds->s.value - 1]);
> > --
> > 2.37.3
> >
