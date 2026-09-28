Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B754F30EF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615060; cv=pass; b=BlszE8s00po3dA15wgh8SRJkTkYfytoMhSI8DtpIlEmSYoiNYbyZyJmTtHuLONH+CCpL3mP1z6f2R9sbNEZZA/MHSue4h7VARKfHI4KJPtouWPrsAcQ8eCBgWvJbsuVhvML+Fv+1jL1ktyB+17AcdUCPL6DavLdbM5eJWPjwj5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615060; c=relaxed/simple;
	bh=EARb/jT/CUn7LM+sM5ymQPwxLU/HxFeuIAiHIAj6Q8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrjPMdyEIiYmDc7J8H8nLLJsDcLybEGl/Y9dpgaUlsOC0u20dk2CMMiMTru6wlj3sQQAv5MZ4NY0zCEQ87yU4iZnbvIqzIPMKdSEBYKKoP6Zm5T76PKGq2X9WiW/yn1Gs7ixlqg00Tl5muNT/VFPAzOVELLcrCVazC1k3kkDlTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt9HnWTr; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt9HnWTr"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e5505aso32227847b3.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615058; cv=none;
        d=google.com; s=arc-20260327;
        b=mXlHi/+uSIg0JlF/1cI5lhdD009xpxEv1T5Gbgl7/tPHQ3ZTbOuLGMiNL+BxQt75c+
         Lk/djXgzYkehG7m9pzHlWeVJCfviSVUX41Jsf6GrhRAFiNJSiGMcLuNC0627THSNaslC
         JsqGk3NEWuN1FKZ47bfsXtZLtKitJr6EZ2jHUfWhr9S+AFEGiWrAAQzR6PnULk64J+nx
         dWCa4wz92jBvjBqUasv0N9hqqMEnmcUhvdIW7hluAhZDVEL+cSRgsAMK3c6gI+TdASPr
         EvdlQuMpGcEbJiLtmDa+zzx2wJ4sw/tt0qpGuHqyGqU6YrFNGtZHuluRsbl9kJbADjqw
         j4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hkAsuQiLh/QbSXqKXFwE+73vb5LgyM2tbg99NFau3/A=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=kUw+aAXtogot0EOy6HaEbDE4A1c8BFXSXUNZGpKNjOnV23HJRj0YmQ+frQByiWrZ08
         Yb0rCCnTxkCnilJDmOOzNDSvJnSaEQdF9AORSA4utXWKZicMX10Gny6sydtNSVbw+5jg
         DmKHZKi0ovD0nwRM7lzlQd/DCofXqaXzFARmFcKuCm7RUHjEUDVGkNmMxnzG+BZUa+9Z
         1DApw3GktFqLn8WAVxzcClkXdkG2ImVBxn04uW86/3++O/9D/7/KI9geZoii0qgOVLKM
         vf/gqcb18B0/yRp3UD3UHJId8OBZ/wKRe7I7rAzitO2lAJTV1d9sOyr9Xf0fK0NrJ76f
         bckw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615058; x=1791219858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hkAsuQiLh/QbSXqKXFwE+73vb5LgyM2tbg99NFau3/A=;
        b=Vt9HnWTrsK0CD843Ha35dEBYevkcVLybLoYdlwALuypTtudcDnd+u8DeQikUs/MYaP
         VBhQ/ceZAtAYp878oQb0Vp+QFd6ZTrR5ESmOGUFtzcMMk0u4uaGrnEWucmie7nswMnq+
         KOfF9j1fTDNUJL3pIJ2KRrEKWmdafwshgyZeF7+aZlmjhYJ3VbpYboMBR+5whTYPFFkO
         slNGQcLhe2LE24KrXhuuTbNU/e/zzA+i6TlND1bsQbypvc7vK/W1emxRJ1EouEVpB00x
         AXUBpnAhLR6mCEvdQAbmnKdoZM4W86kSUJDXI6PYEbJgjSJTsiX+mKC+k3KlK0kg+ewP
         kOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615058; x=1791219858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkAsuQiLh/QbSXqKXFwE+73vb5LgyM2tbg99NFau3/A=;
        b=MPd6vkTH/SSLgJH6EAFBdjySR/zpUeoiL4C2DMPtxeUS/2e9HsIXpN0QqyWwG53Hzk
         YKlaXVRiP/WCh3zdamcz3iDy0LTqsfInqr/ZlScb4F8o7bYhwbjJfZCx55i5CTPW3rU0
         ecmhFv+lhIECEibEAd1d86edslWBYRy62Nwkir9rT4rDkoFZo64cUq/Yyk9DmlF2EdY1
         b9QPn5lVmIcsYl08i3Tr2m07w+ULlwa0gEZAAtuCZ5jycD4V68+kz9YJAqNWFyel1Ktj
         zVgkTtT0HgdcZkmsCbzj4QlTCY/9RCbIbZfx9LzpfFG8/2fiMXzP6akdDX1bMjK7g1k0
         68sQ==
X-Gm-Message-State: AFq9FYJfJ/537qoZwVDVHZIKu2wgCIS0W77NMIoK9hEnJinBvSS6JyDs
	daUofYKDk8Vookh14jcXNDKLdQ9m0SZOM+xiTy/MnPDpEZHoJRr1QqwgTFdsctL9qHpkAZhoIZx
	bFIkTsOoEpeq6kzFgPS2yjTHCWOqgqF4=
X-Gm-Gg: AYBFou2ezukQpdqOWBXYYS2s3rC3zt9gz3Q341kjF5MgQPtm+HdrLAa2IvLeif7CRmX
	g4g7BUYQbHgfQFbrUXyy1d+ZNAmDeuIsnH4L+k1YhFaP4g42hR7iFDWCdZEiAaJZPNiXjBJYrqa
	DR2KG5yhOtrm5oWs559sb84SgEomyp4iZFhhcNRGlf3b4I6gHIWEB8yV+Uf6O+CqMVhJmrUQqvk
	OZ17WAKuL9TsVoPsbuw2g7Hxj4TcGG0zlCMqzy160dyHWtBhLWam4SuXMU3uXcWY/7fzX/+A5Oj
	XVxFbU0VW6CF37LdLCa+V/syl384tSmjzTHhQTaP0MQSCLuSy6wm43M=
X-Received: by 2002:a05:690c:c512:b0:8a1:17f0:a44a with SMTP id
 00721157ae682-8a64d800561mr74890467b3.46.1790615058327; Mon, 28 Sep 2026
 10:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-17-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 13:04:07 -0400
X-Gm-Features: AclHuK_G4NDGyudRSMDN_Vh93ubSIVeI7GgZgSwezFuvxij-5s6_g3ZQtN1VbfI
Message-ID: <CAEjxPJ6btMO7hjKTBp5p6RouVun0CKLwNcHXoOjvL_icWgvuzw@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] tests/filesystem: improve fsnotify check and
 preload loop module
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> fsnotify support might be missing from the running kernel.

You didn't update the subject or the line above to say "fanotify"
instead of "fsnotify", but regardless, the change to the perl scripts
is fine.

>
> Pre-load the loop module to ensure creating a loop device succeeds.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  tests/filesystem/Filesystem.pm | 2 +-
>  tests/filesystem/test          | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem=
.pm
> index ff6daec..115144e 100644
> --- a/tests/filesystem/Filesystem.pm
> +++ b/tests/filesystem/Filesystem.pm
> @@ -15,7 +15,7 @@ sub check_config {
>      $watch         =3D 0;
>
>      $result =3D `$base/../kvercmp $kvercur $kverminstream`;
> -    if ( $result > 0 && -e $fanotify_fs ) {
> +    if ( $result > 0 && -e $fanotify_fs && -d "/proc/sys/fs/fanotify/" )=
 {
>          $watch =3D 1;
>          $tst_count +=3D 11;
>      }
> diff --git a/tests/filesystem/test b/tests/filesystem/test
> index 56f116a..1525199 100755
> --- a/tests/filesystem/test
> +++ b/tests/filesystem/test
> @@ -182,6 +182,9 @@ ok( $result >> 8 eq 13 );
>
>  system("rm -rf $basedir/mntpoint 2>/dev/null");
>
> +# Preload module
> +system("modprobe loop 2>/dev/null");
> +
>  ############### Test Basic Mount/Unmount ##########################
>  mk_mntpoint_1($private_path);
>
> --
> 2.55.0
>
>
