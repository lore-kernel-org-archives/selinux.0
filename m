Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E70C6FD1F
	for <selinux@archiver.kernel.org>; Thu, 16 Mar 2023 09:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCPJ0L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Mar 2023 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCPJ0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Mar 2023 05:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0084B7D87
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678958720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6U4yZW9h6BOplmAYXSnutKBz0WoV8AEFkx/k8GKmtdo=;
        b=KcxO7q7emy52OwTfERyQjiKYgRqHurCxgIRTsyuqx0c3lKhtN0cDng2M+opUZVWnCsn7o5
        pON5kErHP9v5iRVvIEs+9DQ7y8ReRvsrnh9St5CxOCgLxV8SqnklK45TPb0wQOON5VyuS7
        1p6kRl85AsZS/e5sa+VpEr/uI6hgW8w=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-PCQx9Y0EODycYwxSuQdHcA-1; Thu, 16 Mar 2023 05:25:19 -0400
X-MC-Unique: PCQx9Y0EODycYwxSuQdHcA-1
Received: by mail-pf1-f199.google.com with SMTP id t30-20020a056a00139e00b006228307e71bso833802pfg.0
        for <selinux@vger.kernel.org>; Thu, 16 Mar 2023 02:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678958718;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6U4yZW9h6BOplmAYXSnutKBz0WoV8AEFkx/k8GKmtdo=;
        b=Bc+Z4Pmxt8Yod76KoJ9GW2XagVPYqGbOLIr9OkPdwImjiotp+Gs84YAKOnSQkMIvDK
         090wi3i0ZufIlzfN3UnVdvxRJe6BbDaVqHUVhw0k2w3qrthbBAzhkckbaPyA5dkI7kma
         PM4STbQDPNXgudOpROweYmGoBzVkXCto8eYnepTRazIul/9JMRSpjwxMkSxtCdiqQJxc
         GPCk3QstMp3sz3Z/eWUvxzC8RH08xk5KQeJOc6+nKjIyzdEzCQ8abzfCTkjuOyQMkWl3
         ST++FkeaLgbOVtmJ3VrVLO10WI6Bn2pvDippNQT35F12JqSmsw8sfi0lp1qOYg/FdqBE
         FF2w==
X-Gm-Message-State: AO0yUKX7ymMdXf4jYqN1XYL2R9nhNZS8aO56o0tYZjBmr/SrNbyxg5I+
        HprEmcesmfEYIh12M8sutdzVpN4Teh4l8ak06nQb3SaaFcOWagL6+qmw69MaPqew8LtVb935mr+
        nWlKfdnmKGInORZ5C4VY3344YbNgbjiZQPpvnfKTWpXEut6k=
X-Received: by 2002:a17:903:44d:b0:19f:35d3:ed0b with SMTP id iw13-20020a170903044d00b0019f35d3ed0bmr1118817plb.2.1678958718272;
        Thu, 16 Mar 2023 02:25:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set/cSWuluqrpvTKT6SWqKpv4GFxPXqXpX/WUa7QGsGUXK7c6JCkiczsHGzZEPdzlyz6SIkH6rxRGY8Nwv7DUDlE=
X-Received: by 2002:a17:903:44d:b0:19f:35d3:ed0b with SMTP id
 iw13-20020a170903044d00b0019f35d3ed0bmr1118810plb.2.1678958717958; Thu, 16
 Mar 2023 02:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230314165858.498705-1-omosnace@redhat.com>
In-Reply-To: <20230314165858.498705-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Mar 2023 10:25:06 +0100
Message-ID: <CAFqZXNuwh1Xsooh-z4jnH+D-PX7Tgn1Rb9EPoEiXjaxdPOFBZg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/atsecure: avoid running bash under test domains
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 14, 2023 at 5:58=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The 'env' utility can be used just as well. This avoids the "bash:
> /root/.bashrc: Permission denied" error message that appears when the
> testsuite is ran with a terminal attached to the stdout/stdin and the
> corresponding AVC denials.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/atsecure/test | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/atsecure/test b/tests/atsecure/test
> index 59ba3a4..4079a1b 100755
> --- a/tests/atsecure/test
> +++ b/tests/atsecure/test
> @@ -20,12 +20,12 @@ ok( $result, 0 );
>
>  # Verify that LD_PRELOAD is ignored when noatsecure permission is not al=
lowed.
>  $result =3D system(
> -"runcon -t test_atsecure_denied_t -- bash -c 'LD_PRELOAD=3D$basedir/evil=
.so runcon -t test_atsecure_newdomain_t $basedir/good'"
> +"runcon -t test_atsecure_denied_t -- env LD_PRELOAD=3D$basedir/evil.so r=
uncon -t test_atsecure_newdomain_t $basedir/good"
>  );
>  ok( $result, 0 );
>
>  # Verify that LD_PRELOAD is honored when noatsecure permission is allowe=
d.
>  $result =3D system(
> -"runcon -t test_atsecure_allowed_t -- bash -c 'LD_PRELOAD=3D$basedir/evi=
l.so runcon -t test_atsecure_newdomain_t $basedir/good'"
> +"runcon -t test_atsecure_allowed_t -- env LD_PRELOAD=3D$basedir/evil.so =
runcon -t test_atsecure_newdomain_t $basedir/good"
>  );
>  ok($result);
> --
> 2.39.2
>

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/17fecc443e267407=
f2f48e2cb17fbe83699f235d

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

