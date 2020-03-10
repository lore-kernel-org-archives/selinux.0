Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F3C10F27
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B1621D56
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 19:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6CdUzE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCJTSf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:18:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36939 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgCJTSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 15:18:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id b3so14343789otp.4
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 12:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2Myj0bR4dGXLESIkPem6LCF0yDG83RhHWSsqSKD5/A=;
        b=t6CdUzE3dHgQhh90QuPfyptas/tEzR958JwrsSwksBgpHyHs8M7Mv6fgIsbyxbtGJK
         BVg4tpQq1wmBdYfNCeAjmpeyjb9GaZ8slwArUeCF5vuZKIfrFtT3RdMTleTh6MwX+Bhw
         qQOVdnYivQgRucZ5oUMe1Q/S1a7vn9GXSamFwDd8cyj8CO0BQBr3ooX2Nom8co0FU1Wi
         UuFWln3/smV7nFbAXu2eWGXPpaAueY0YgbYzxKg2BiNVq2gG8kwvQW1rr0SoOi8H7v+2
         enXnBWYLZvRZmtR+fGwCHubiCfrurbJTe9kp54j1poncbqLGLd9/rrB/F12UxCQcKDjC
         L3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2Myj0bR4dGXLESIkPem6LCF0yDG83RhHWSsqSKD5/A=;
        b=HWqRhASRKJQSRVKwwKkNOQSH0C6tQWP5KxfmsG3+jtsOOixUEgpg6rFzWjGfLSahr3
         jCYa43st3VTRRIhV4+/We6uGKMPN6SJI6asMrNobuorgHtbt16JI/1A+lR3kvV/D2M54
         kcMwlHXAnedj5LvqPN/Yr4iIGErsvvN9jlKloEAbJGQ259g8NVyD+epmYHpP/uSbkHdx
         ljOgo1SNMKpHwuZCjvlhG1ZzOUXqcNcvjkrzLkTlye/P5MQSKFNJIO2MgNf0OGcx7NgH
         eNIZny5db22ZnRNiD3X4D3cApOP7zDPY8YmnUML4EGAir/pdiP6ogGzdKcQKIWsdCKHh
         f6qA==
X-Gm-Message-State: ANhLgQ1bJvnDyLXnhfvkwDUKa0V0WY2ZyUD3Zirz/AqsUYXG4HGM2lyK
        ENKlfzaPgBHYvbbv+l3gXaaceUWCW0WQk1d5MiaUj+2B
X-Google-Smtp-Source: ADFU+vvbCOlDkn/I6bnZisTspGhS8E/f10ihQ8CVEEvPn9xRr9w6R+m13fEcWHutQX4CLJa/TDgx2qRXBzwARaHY0Fc=
X-Received: by 2002:a05:6830:1144:: with SMTP id x4mr17757619otq.59.1583867911598;
 Tue, 10 Mar 2020 12:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200310144133.381567-1-dburgener@linux.microsoft.com>
In-Reply-To: <20200310144133.381567-1-dburgener@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Mar 2020 15:19:56 -0400
Message-ID: <CAP+JOzTwr8hC2zkjy15PJpJb_jjJAMdAhj8d-JwzzBVOVWpWwQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Treat invalid characters as an error
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 10, 2020 at 10:42 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Previously the behavior was to warn, discard the character and proceed. Now the build will halt upon encountering an expected character.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  checkpolicy/policy_scan.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index e2f676e4..8c100f3d 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -290,7 +290,7 @@ GLBLUB                              { return(GLBLUB); }
>  "]" |
>  "~" |
>  "*"                            { return(yytext[0]); }
> -.                               { yywarn("unrecognized character");}
> +.                               { yyerror("unrecognized character");}
>  %%
>  int yyerror(const char *msg)
>  {
> --
> 2.24.1
>
