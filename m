Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B44C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6636C20850
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 14:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wc4eyK9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfCYOb2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:31:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39803 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYOb1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 10:31:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so8024166ljg.6
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2s1D7RXNIZ5T1d+vRMajFgcZM3Rxy5knD9PjIUKYBU=;
        b=wc4eyK9A26IEfA77scQurxWB1ItR/63/lUwKhl2oTqE1+enTttOtnLC63STV1cJfd0
         takVIXlBZAfbFD7VNexXGewrUUYd9B0I3ICgRZOmHmWWhc1gIGnc3Khg8SEQ5FXg7IyK
         +i2Zu0JoLzvg6SJvP9L1l7/sedXoqqSWSTu3pgqnxxFVcGxhaMz3F5fgWNEfmkG9+IRB
         kbYHi902OpfjpcSMIU9fz/th90ek/3xLcXA0ExqRdKh3LW24k26AI67Y021L4S9+r6fi
         dpgKQhjxFdwfrJ8RXmykWD4ujJJ010DrRSX8EwmRJ+qKbWta56DJZclM1f++YrNQeUoc
         Bnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2s1D7RXNIZ5T1d+vRMajFgcZM3Rxy5knD9PjIUKYBU=;
        b=mFQTwqYCYZPnz02fAG2pG1cZSHO2rPixnaallZYqQAMhoD2qJd34SELPAyZuht9EDU
         CmWkIjZClyceCdcUF2G2/N40arduxqKOXMVHCi/Qh9wObMOL+9gr9fPVvqsHgGW0Vhlc
         VQIIoz4sF+r5v/m5dHqtkWB1xJMhmzpJeDY82AO26EGwBU/7fZRdaDezzyzJnu1+rhOU
         k5tTQFVGGMZaXVuK44vH7mLwkRDyi/kTIJNcuG2MUQ+UQ3nBujCCIIEpwG0d6qQi/+ef
         VXY6w0owe8XwWGBfuE3sOvS1zQx6QB60+xDjRPbsvVk62qDkl/sOuLN2HeVRh6BStQPW
         AqOA==
X-Gm-Message-State: APjAAAUzbd0aRX+JpiPx/3NF5f1jxTg6swHzuU1Xl/P9fo4z4JgK+tev
        kFq1ZDmWumELFEapN0wZIQ3auXvWuAEldJpRi8gRZ+Q=
X-Google-Smtp-Source: APXvYqyyh3pgYbGgO41dxeokZOFlUbEeZswuqHXU9fEXXDzV8wy5WAN2pTQWUX6Id3CKbQY3IqHWbEtvh+NvNaC16LQ=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr13461096ljb.169.1553524285611;
 Mon, 25 Mar 2019 07:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190325081115.19874-1-omosnace@redhat.com>
In-Reply-To: <20190325081115.19874-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 25 Mar 2019 10:31:14 -0400
Message-ID: <CAHC9VhT+CC2+nba=am9te5oZKDp7L6xbKiYxUCeMhrGENh+JiQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove useless assignments
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The code incorrectly assigned directly to the variables instead of the
> values they point to. Since the values are already set to NULL/0 at the
> beginning of the function, we can simply remove these useless
> assignments.
>
> Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Fixes: fede148324c3 ("selinux: log invalid contexts in AVCs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ec62918521b1..b18a8d7c1b5e 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1318,14 +1318,11 @@ static int security_sid_to_context_core(struct selinux_state *state,
>                 rc = -EINVAL;
>                 goto out_unlock;
>         }
> -       if (only_invalid && !context->len) {
> -               scontext = NULL;
> -               scontext_len = 0;
> -               rc = 0;
> -       } else {
> +       if (only_invalid && !context->len)
> +               rc = 0; /* *scontext/*scontext_len are already set to NULL/0 */

The compiler doesn't like that you've used "/*" inside a comment.  I'm
surprised you didn't see this when compiling the code ... you did
compile this before sending it to the list, right?

Anyway, the patch looks fine to me otherwise so I removed the comment
(it was a arguably verbose anyway) and merged into selinux/next.

> +       else
>                 rc = context_struct_to_string(policydb, context, scontext,
>                                               scontext_len);
> -       }
>  out_unlock:
>         read_unlock(&state->ss->policy_rwlock);
>  out:

-- 
paul moore
www.paul-moore.com
