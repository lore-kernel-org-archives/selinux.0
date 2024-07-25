Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF365588B
	for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933238; cv=none; b=g5OcpttA4FbQM25qM2Z66JGPyBL5LeCi4kpoFUVbBT05VIq9svgRlWjvZmjoHO9hchEXAP6olXMKcv6DBvcklytRuV1CVdLNnPDRyOqA0Dq06MtbEI5+3BflR9ZNFZaao6vRhBdwcvBEekA0RLPwWu4YpZgzTzi41iZSePhZSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933238; c=relaxed/simple;
	bh=jZqLpdL6u8jI62R+ZN7/5Jmoq7xyVVTaPQqfYbEZHLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTmBgUwFFavxZe7txy9m/L946N7BMtwJvQ5MQ7B7+ShP6VYis1Inc+3pacsm7BEsUsyrXgM+oyfydrYxocawBHgpFZNS6hjYPJkZQEx9f5Qxp5guUt6nbThpu9S3GkSm8NRDCHm4SxBaaseveyYIo9v14I0macUvhySUsjFq3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQhv5AXv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQhv5AXv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc491f9b55so12257955ad.3
        for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721933236; x=1722538036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8RqUGgfcWd7qNrfGo2QYXV4vw6NIDJ3Wetg3p0SmlY=;
        b=UQhv5AXvo5a6/bGUnFuYp52zc2w/hB3RqkRm+W9WP/IMsu/M5l76YpHXNHAm1Ezz1J
         i2DyerMftaTfMKVWz4zFyJPoRXrvsM7bfaAZzhc+Ut9SSjqWSnrhznfjNylHi+ZqHQdh
         W6b2u9L669jnfH2vqkaOYcwQKgxj4xVSbcI0pAjAvNofgst9FafRuO9o6O/aFiDFQcNV
         iobS3baE781qFRl4ZY6bUzzhoelaBqmM4X5wpXzpq8LhNWcDUvrag56TEEjpgGfIjl3/
         DCb7Fzst74Ag9jPTqxvcEhvMfRAHoUuNxJWDDpPNighOAOpMtkn1oUUykCcNa12vhcWp
         KPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721933236; x=1722538036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8RqUGgfcWd7qNrfGo2QYXV4vw6NIDJ3Wetg3p0SmlY=;
        b=k1Mc56imQCniDEt7epWeAWDGlKcdmVKlkDYD3myqThvKTQqiZVu87SzM/QODu5lLAI
         o5bICLna6fKtj8rD9cEkfoqa1gh97Vy2v88wBcXgGOH6n/D+GlUvuE93fMp1XVne50x9
         LNmn3YKUWcE+pXsZHORuC/FFF0iiqMLAnLM6B41I2SJybZ36bdZn5aBhLDTxUuz4DpFW
         TT/YgfeqXgJyK0iO2WsIZ07+P3KgHCVjhgm0fE5a2dvmwCsvzq0c+CBCJ1RlC1VG6niu
         rVYX9r6mHoRD3e1oU7UnhgstIXu3qF+bmESmfzAnbhRR4S2wmIu1XrzS8KhdqaLuoJOF
         WEKQ==
X-Gm-Message-State: AOJu0YyJ8URY+E15RM+9drKrL6ip//kbVZkL0mC5mS8b6moM7caPzC6n
	d2PhDYXW0JOaQWiDSjQzrzMJypH5YbmWM4TafdlmXRQPtOnu0XI7pqQNo8KT+oizF3fr5sE3bcv
	EkRjJpHKLKKvos4C8tE3JbE+mTWc=
X-Google-Smtp-Source: AGHT+IFBRr6yXCixS+UbFtR6Sp3fb4kDybXL8YzOGB6hIJxfrD01tlftCOutXC4rv+6qAXUgBy9ztSiYYk7uvpLtKzY=
X-Received: by 2002:a17:90b:4c50:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2cf2e9ab13dmr3182729a91.8.1721933236083; Thu, 25 Jul 2024
 11:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com> <20240725161107.1446978-1-vmojzis@redhat.com>
In-Reply-To: <20240725161107.1446978-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jul 2024 14:47:04 -0400
Message-ID: <CAEjxPJ4hUc67Ra7vE7z1znGfx=8UqCSFY_OouJ0_mOQW4-qx1Q@mail.gmail.com>
Subject: Re: [PATCH v4] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> Make sure that file context (all parts) and ownership of
> files/directories in policy store does not change no matter which user
> and under which context executes policy rebuild.
>
> Fixes:
>   # semodule -B
>   # ls -lZ  /etc/selinux/targeted/contexts/files
>
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Ju=
l 11 09:57 file_contexts
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Ju=
l 11 09:57 file_contexts.bin
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Ju=
l 11 09:57 file_contexts.homedirs
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Ju=
l 11 09:57 file_contexts.homedirs.bin
>
>   SELinux user changed from system_u to the user used to execute semodule
>
>   # capsh --user=3Dtestuser --caps=3D"cap_dac_override,cap_chown+eip" --a=
ddamb=3Dcap_dac_override,cap_chown -- -c "semodule -B"
>   # ls -lZ  /etc/selinux/targeted/contexts/files
>
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 4=
21397 Jul 19 09:10 file_contexts
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 5=
93470 Jul 19 09:10 file_contexts.bin
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  =
14704 Jul 19 09:10 file_contexts.homedirs
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  =
20289 Jul 19 09:10 file_contexts.homedirs.bin
>
>   Both file context and ownership changed -- causes remote login
>   failures and other issues in some scenarios.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/semanage_store.c | 31 +++++++++++++++++++++++++++++++
>  libsemanage/src/semanage_store.h |  1 +
>  2 files changed, 32 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 27c5d349..95596a93 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -36,6 +36,7 @@ typedef struct dbase_policydb dbase_t;
>  #include "database_policydb.h"
>  #include "handle.h"
>
> +#include <selinux/restorecon.h>
>  #include <selinux/selinux.h>
>  #include <sepol/policydb.h>
>  #include <sepol/module.h>

I get the following error when building:
$ make DESTDIR=3D~/obj install > make.out
In file included from semanage_store.c:39:
/home/sdsmall/obj/usr/include/selinux/restorecon.h:137:52: error:
=E2=80=98struct selabel_handle=E2=80=99 declared inside parameter list will=
 not be
visible outside of this definition or declaration [-Werror]
  137 | extern void selinux_restorecon_set_sehandle(struct
selabel_handle *hndl);
      |                                                    ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [Makefile:111: semanage_store.o] Error 1
make[1]: *** [Makefile:15: install] Error 2
make: *** [Makefile:40: install] Error 1

It appear that either we need to modify
libselinux/include/selinux/restorecon.h to #include <selinux/handle.h>
prior to using selabel_handle or to add it prior to including
selinux/restorecon.h here. The first option seems correct to me.
