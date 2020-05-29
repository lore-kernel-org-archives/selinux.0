Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2A5C433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A974220721
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 14:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8stazyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgE2OqC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2OqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 10:46:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452EC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:46:01 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id i9so525298ool.5
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v5zWM0CEvT54oaoHZb/oKw/zc8WiDRiHw3XAUJVekGo=;
        b=u8stazyOUK2scwFmo30FYcWt54szvk44/Fli75DmzRpo9tU5A6DDhEvjWUANe0IiFr
         UWLT3aD9LKOClkSYBBdeHmkFfY4N1EDggV1QWJFRDwtvC4bzR49DdGj1T9tlX9WQ+Hl5
         B6LHvipEPxaftNIImyQYmYGtM8ANeLz/Ok3LUtvv7uBxY4ffrKQO3JkOXGo+aLgKbgbu
         VLDkyTpprPM0GSnWynF++v4c7r57NuCF7fTgjayhHPSiT4wZtjIbETtLNhwr4dUNoe1Y
         mnejoqJxXonbmJAKIRn3bRT1UoxzOO9RlkCxrFx/j8kZuXNol5AXHII9DWAAASNpHH+b
         Wsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v5zWM0CEvT54oaoHZb/oKw/zc8WiDRiHw3XAUJVekGo=;
        b=dZZIa4+A2uzuKmWXLUm7RjSgV+VS1sk7+z66910n95awxh70oQFdFyoibGa/m8QhW8
         nA+C7Gzgs4euVLvBHKGrhCicvwqhL1OPf3lCRWEgKHQzKX4ASc788CMRH8c51qX6NlPJ
         YbYc8CpQPy0gSFVsartQ8vExQh6xY0TueR+f8IGl7svZsYz8b4Y6xVyv5MV9vpo9PEmu
         rm21QwKYKzoLMBf295c6x3AjPDov95jksxY/NvLAHT22NxtyxCkeOprygkvs4jioHbCR
         uYu6MXKksTKE0s8PazlP03M+skPt8XtGxE7WRw9BSPifDLyRrM3uVFN/Cz4bm2PhF1Ci
         clSQ==
X-Gm-Message-State: AOAM531/wt5+j4qm/pI4+y+v9DG3QTsAyqzkDHP9BcPVfeeBhgEpYjHU
        DSBVLN3klidNkE3aoxHDXLWS+QeUpFi7PM+ci/KnGWjOcwM=
X-Google-Smtp-Source: ABdhPJzTAzh/xrmgT8kdUlkGpHEvNN1CotRcBPMdJETresWW2VfzJphFtrZHLoG+aRKK2tqIBENW31CzocwuzekGku0=
X-Received: by 2002:a4a:b607:: with SMTP id z7mr6659528oon.71.1590763560405;
 Fri, 29 May 2020 07:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
 <20200528125128.26915-1-cgzones@googlemail.com> <20200528125128.26915-3-cgzones@googlemail.com>
In-Reply-To: <20200528125128.26915-3-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 10:45:49 -0400
Message-ID: <CAEjxPJ6LcaDMVuocv5oPY_bgwobW0rr2S9OvpQmmewq+6452Ug@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sepolgen-ifgen: refactor default policy path retrieval
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 8:52 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On a SELinux disabled system `selinux.security_policyvers()` will fail;
> do not bailout but use a fallback policy version to check if a binary
> policy file with that extension exists.

Technically we should be using sepol_policy_kern_vers_max() as the
upper bound since this is for the purpose of reading the policy by
sepolgen-ifgen-attr-helper and it requires that the policy version be
known to the version of libsepol against which it was compiled but I
guess there isn't a python wrapper for it.  Not sure why we aren't
just having sepolgen-ifgen-attr-helper itself find the policy file in
which case it could call sepol_policy_kern_vers_max().  Not keen on
hardcoding an upper bound here.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  python/audit2allow/sepolgen-ifgen | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepol=
gen-ifgen
> index 4a71cda4..48e60f1d 100644
> --- a/python/audit2allow/sepolgen-ifgen
> +++ b/python/audit2allow/sepolgen-ifgen
> @@ -69,7 +69,11 @@ def get_policy():
>      p =3D selinux.selinux_current_policy_path()
>      if p and os.path.exists(p):
>          return p
> -    i =3D selinux.security_policyvers()
> +    try:
> +        i =3D selinux.security_policyvers()
> +    except OSError:
> +        # SELinux Disabled Machine
> +        i =3D 50 # some high enough default value
>      p =3D selinux.selinux_binary_policy_path() + "." + str(i)
>      while i > 0 and not os.path.exists(p):
>          i =3D i - 1
> @@ -80,18 +84,16 @@ def get_policy():
>
>
>  def get_attrs(policy_path, attr_helper):
> +    if not policy_path:
> +        policy_path =3D get_policy()
> +    if not policy_path:
> +        sys.stderr.write("No installed policy to check\n")
> +        return None
> +
>      try:
> -        if not policy_path:
> -            policy_path =3D get_policy()
> -        if not policy_path:
> -            sys.stderr.write("No installed policy to check\n")
> -            return None
>          outfile =3D tempfile.NamedTemporaryFile()
>      except IOError as e:
> -        sys.stderr.write("could not open attribute output file\n")
> -        return None
> -    except OSError:
> -        # SELinux Disabled Machine
> +        sys.stderr.write("could not open attribute output file: %s\n" % =
e)
>          return None
>
>      fd =3D open("/dev/null", "w")
> --
> 2.27.0.rc2
>
