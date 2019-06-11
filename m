Return-Path: <SRS0=utbs=UK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914ACC31E46
	for <selinux@archiver.kernel.org>; Tue, 11 Jun 2019 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C42086D
	for <selinux@archiver.kernel.org>; Tue, 11 Jun 2019 22:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="h/fMYVlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436780AbfFKW4W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:56:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36637 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436972AbfFKW4W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jun 2019 18:56:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so13300646ljj.3
        for <selinux@vger.kernel.org>; Tue, 11 Jun 2019 15:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UScBCj1990BVlduYhjEjZO8DvaVBEZygOQq5R++5jBU=;
        b=h/fMYVlzXohUsYXVqGlAQg+VF1DcgMP20jyQOEs9YAX4WZmM8C4gkGlDl3BrOHKrNg
         YniodCgimo7I2vE96B9XnivOnwGbtKDlOzoDSdVwEH5HAzKks5PVy+Nhl8bnSARMsxST
         UNOs6JL7vMWACSK3nSKWioA0RmwRl/zFcdR+P/T+OiDHFfxOF7Ief9VEsd2R/irMIAdg
         HrNAehA5YJamdl8Uky0VnmfBkXhamENu+qvJTjv6gAxfxgG1XhOo3/SRbrSAfPnc/CQG
         8rqjAXdHTsFrTf1fuNqBQ6fkzhOyCnbhGL8uwzGLQOkmjo7abnqX55wP4z8KjM0fgMqO
         HLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UScBCj1990BVlduYhjEjZO8DvaVBEZygOQq5R++5jBU=;
        b=YNtJusnmFfQTiWTSevrmU8jInW4OF0LOot3fv4IArs6jk7jkuTYpMoVn7dhkCWOyq4
         AICA8019UIbI5X6vJe80F0oNZDnVroNW3vuFkYI1L70pDM/f8i5/++TgpaipFR0HMMgF
         8dIPg87yIC0kcQntlk8favqzfQufKh6NskS/9PAH0ojZZ/GicjlO7mJhhoF/P0UYA2q+
         2XILUYnGAZNWCziPWOE30qy2RkfRgnGIFnjDATgPrx1L4S01lNQSIUhkbEF5VXeyhTJQ
         ImLb+m/UpLBBHpqzT4frzlf/GGOj+vze7425iAINemlEWoUhory3AOpOzLRHar7NEKrh
         ILSw==
X-Gm-Message-State: APjAAAVPZXwljXK6eB4NDWA2N6puZrXQNgMACbemL0zzObyUTjP8hiHo
        7M/LgJ5BRyRjjNilhPSDikhireULiskoYf/FEc60
X-Google-Smtp-Source: APXvYqwtxK+/bIRr62KFoQFlOyzNPs5ldqCN7Rv6OQD1h2T8J38lOn5K6QCTh1FuTca1QK796UfokyzhNWn9yHXqvgI=
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr8869166ljj.160.1560293779452;
 Tue, 11 Jun 2019 15:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190611080719.28625-1-omosnace@redhat.com>
In-Reply-To: <20190611080719.28625-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Jun 2019 18:56:07 -0400
Message-ID: <CAHC9VhSXZp6QierOGRBXmyUf=pT3Y4mf=78AmQAquuQ8-WBSGw@mail.gmail.com>
Subject: Re: [PATCH] selinux: log raw contexts as untrusted strings
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 11, 2019 at 4:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> These strings may come from untrusted sources (e.g. file xattrs) so they
> need to be properly escaped.
>
> Reproducer:
>     # setenforce 0
>     # touch /tmp/test
>     # setfattr -n security.selinux -v 'ku=C5=99ec=C3=AD =C5=99=C3=ADzek' =
/tmp/test
>     # runcon system_u:system_r:sshd_t:s0 cat /tmp/test
>     (look at the generated AVCs)
>
> Actual result:
>     type=3DAVC [...] trawcon=3Dku=C5=99ec=C3=AD =C5=99=C3=ADzek
>
> Expected result:
>     type=3DAVC [...] trawcon=3D6B75C5996563C3AD20C599C3AD7A656B
>
> Fixes: fede148324c3 ("selinux: log invalid contexts in AVCs")
> Cc: stable@vger.kernel.org # v5.1+
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks, the patch looks fine to me, but it is borderline -stable
material in my opinion.  I'll add it to the stable-5.2 branch, but in
the future I would prefer if you left the stable marking off patches
and sent a reply discussing *why* this should go to stable so we can
discuss it.  I realize Greg likes to pull a lot of stuff into stable,
but I try to be a bit more conservative about what gets marked.  Even
the simplest fix can still break things :)

I'm going to start building a test kernel now with this fix, but I
might hold off on sending this up to Linus for a couple of days to see
if I can catch Gen Zhang's patches in the same PR.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 8346a4f7c5d7..a99be508f93d 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -739,14 +739,20 @@ static void avc_audit_post_callback(struct audit_bu=
ffer *ab, void *a)
>         rc =3D security_sid_to_context_inval(sad->state, sad->ssid, &scon=
text,
>                                            &scontext_len);
>         if (!rc && scontext) {
> -               audit_log_format(ab, " srawcon=3D%s", scontext);
> +               if (scontext_len && scontext[scontext_len - 1] =3D=3D '\0=
')
> +                       scontext_len--;
> +               audit_log_format(ab, " srawcon=3D");
> +               audit_log_n_untrustedstring(ab, scontext, scontext_len);
>                 kfree(scontext);
>         }
>
>         rc =3D security_sid_to_context_inval(sad->state, sad->tsid, &scon=
text,
>                                            &scontext_len);
>         if (!rc && scontext) {
> -               audit_log_format(ab, " trawcon=3D%s", scontext);
> +               if (scontext_len && scontext[scontext_len - 1] =3D=3D '\0=
')
> +                       scontext_len--;
> +               audit_log_format(ab, " trawcon=3D");
> +               audit_log_n_untrustedstring(ab, scontext, scontext_len);
>                 kfree(scontext);
>         }
>  }
> --
> 2.20.1

--=20
paul moore
www.paul-moore.com
