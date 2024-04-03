Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D64155751
	for <selinux@vger.kernel.org>; Wed,  3 Apr 2024 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172941; cv=none; b=Xa8IcapCpBN4wFXPUc7hUG+Yk6N/52uttkqnT3MTfksrRmm+GNhL0B4h+xV0zFyJIfknS8aBVQDPoy3vPQ0j9XOBCoVaaNmfYBo0ljxvdyffztmAP9Fl2hc8Bwg9IFg6ZDGZHSoapfe1/MUtlMjYrfKo4L80f4hXfN0wsdql3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172941; c=relaxed/simple;
	bh=pAgeyRMt2Cc1Mn2I7zLHVVPSNEVZb3Ldrmy5gPpyNpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG32v0UaFqs2GeSi0JPisIhqEFIIxKVDNMJx6M5BpnSRX96E4fQ2fQvDvg6gcOOhbn4zf+040FcgXEw1frDXgpubzBv3L7WgqIWOgZrOrI42r/EZ4L0T0iRxc45NKFsK9X4h0A2LBixfj0fB0JYlSp6/u3ou7ybj6OYOhw+zQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgXUX5a6; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgXUX5a6"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e307f172efso89771241.1
        for <selinux@vger.kernel.org>; Wed, 03 Apr 2024 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712172938; x=1712777738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=722kJhZ069XfrsO0LwXdN64R3C+5rKFxPzrSSJ7FLHI=;
        b=NgXUX5a6unqFdl6LmIaSGK397848eGVVt2IcBOO+fYLmTN518QwRt2c+tBpjio6XaN
         0zM10ZOwYWdtU9WqdGRh9u/UmIKyzD/D37rMj8UND79vEGA5YRswCnhGWj0YbZpldUdb
         HKScPVPrHKJ55BB6W80yTEhG5excGWddrBSyw5mQWAkEQdPXtSju8D4UCxoSl5+y1ovN
         dZR0bTl1xP7Bgrp/3kD8XPaCe8D1EnaximwpnBvJCCdT3dr0xTVJdSLPGIuQ92/YolwE
         zvzEhxBdzb2hf3Qkk1IlxbHOHfCTAARSUwdhUVZtED6yW3uJdytTAUE9FUAHxoTskAlu
         MCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712172938; x=1712777738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=722kJhZ069XfrsO0LwXdN64R3C+5rKFxPzrSSJ7FLHI=;
        b=gwm6/Li7Ay9yXLqh9yl/KI1YWyt6Fw/weKQ62+3KdbAJQkVX0HghNLVus7LDg2daSs
         CwSJeLfPyitUuFdy1rtHLKNMolMGAy8+YAwXyuA8K9vtNtB2OVmFS/NEyrG2zdSAO4Tb
         lbw2b8UAeBH2jSAVl+pa5vMGPQIxsbK61jvHL/fhD+/Gyzp4YZDR8YeT8D5nfsdu0JFt
         3sugZ9pY+Sz95rDTs/Biz/ulfXNIbZ+PC9DkDmmeXZ8XpUo3RNI/buyUP5bZnxrnY6M8
         pWFtqq+QZ9Vm4tIftJYqP4FoKJkiX0MlLE6xvrgbzRX2im8DZ/fK2tB8hO61WwITGoMG
         V50w==
X-Gm-Message-State: AOJu0YynsVJamCtHPVypo5KFcb3lkXGzjaQDcR9U/RdmRH/8xXJkHGst
	59GEPL3ZWdAqRZ0EIc5ZHuGTYU92j/4GhFuoyBKFG8JWHp02xyveolakcEm/q6V1B+2HdK2EdcU
	gvxaFx+QgRG0hk9qUk6Q5WeqRXec=
X-Google-Smtp-Source: AGHT+IFEtMCRuz2cm45/jBnKy2Oss9B+3Zckk0+nbaZPdTphVL8KfwJGVK/GDuZY8l9u/PyJVSRU0qSTGk4/20F2pHI=
X-Received: by 2002:a67:f70d:0:b0:472:eca1:46c with SMTP id
 m13-20020a67f70d000000b00472eca1046cmr282303vso.30.1712172938594; Wed, 03 Apr
 2024 12:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402152925.99781-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240402152925.99781-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 3 Apr 2024 15:35:27 -0400
Message-ID: <CAP+JOzQruPoyL1YLLmfRR-nxTGGbXb91Zc7q__jreFMty0v4Fw@mail.gmail.com>
Subject: Re: [PATCH 1/6] checkpolicy: include <ctype.h> for isprint(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:29=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Include the necessary header for isprint(3) to avoid an implicit
> function declaration:
>
>     policy_scan.l: In function =E2=80=98yyerror=E2=80=99:
>     policy_scan.l:342:13: warning: implicit declaration of function =E2=
=80=98isprint=E2=80=99 [-Wimplicit-function-declaration]
>       342 |         if (isprint((unsigned char)yytext[0])) {
>           |             ^~~~~~~
>     policy_scan.l:36:1: note: include =E2=80=98<ctype.h>=E2=80=99 or prov=
ide a declaration of =E2=80=98isprint=E2=80=99
>        35 | #include "y.tab.h"
>       +++ |+#include <ctype.h>
>        36 | #endif
>
> This does not currently break the build cause -Werror is stripped for
> the parsing code to avoid breakage on old flex/bison versions that might
> not generate warning free code.
>
> Fixes: 39b3cc51350a ("checkpolicy: handle unprintable token")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these six patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_scan.l | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index d7cf2896..62f28c11 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -22,6 +22,7 @@
>
>  %{
>  #include <sys/types.h>
> +#include <ctype.h>
>  #include <limits.h>
>  #include <stdint.h>
>  #include <string.h>
> --
> 2.43.0
>
>
