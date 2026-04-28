Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C831439011
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381825; cv=pass; b=ZI2a7VeFMkCMdtIwiOaiNBI2wZgiaKmG7vsXS1+O6lWXX+h7TRHp25YJLMC985EZ3RAtcRq0qAOLS7khIVjXmlMQOY6oLhByxQNk5vac9W/S2/UtX10RwiwA5Mr2zGcTCVVndov769EPyQzhqZjGrebaXh3YR2S3rb3dACJ2Cd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381825; c=relaxed/simple;
	bh=gh4KC+cIOoTWvLocqC6R/CSCUKABRF0HLgXCMO7c5Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXIACu4zC3/o5XKuX8EwIKlRUppn2+GoESS8Ae3dOLvVlsMs0cRLhiKCtiQ8/SQQXRDgcffPtDMPg/ZCrL8MYhb627VmuzDdwOehynuNDAGl7SopVvn/d+yCvKnWFGYyh9D3wpF66uTeB+WghCQ7+H4SDTSNnPUvTgfVoQI8vWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epoj5aq8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIuo/KGf; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epoj5aq8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIuo/KGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777381822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsXgLbj7Wy2vh/eSaN1OVdLHt1jAUxXA/A2ATcJAgjY=;
	b=epoj5aq8ltur8Bn2EjCUcwXkk8K0xfCgWYLXLUf8KMEHWdu7Q2hqFAdKZDHHBdkceetIdA
	E1Eqv6uZswXjazdUehhdweY8UuRgMN1vVvAHjaHVcJ6Wa54U4eeL1o5qqTumvtT+wj2ubE
	s7OXgPX3wF0YUN+ae7E7Fp/QZ6BxeBU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jXzAtwpSN9KCZVheDS9law-1; Tue, 28 Apr 2026 09:10:20 -0400
X-MC-Unique: jXzAtwpSN9KCZVheDS9law-1
X-Mimecast-MFC-AGG-ID: jXzAtwpSN9KCZVheDS9law_1777381820
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so12482785a91.0
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 06:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777381819; cv=none;
        d=google.com; s=arc-20240605;
        b=Upg+8VGv91HLpKdn/mOeb4x0y8N9yw4gCo7tXjeZade7fGAqqUiqU/HQGqQioQcmKy
         4TKXUp3paNu1OAQFSEvAvrwAENybNxfYgX24PY1yJBq0TLB6aCExD7647+CCybMDFQ3N
         NH+xFZyP30Voieyf3/07cEYJqwyMqjZIi28fXsY9rWIRN25QxAd/38ktutqOrH2eLFn3
         OeGqocCr8Ai3f5VnTkvVI8GGQgYkPu3Ehe7ZmXpDCuid9EoyvseTUOKMj369mn+oYnAm
         uOI1IpFwjfdE7JMlvVyJZjrZ8w3yPYY6n+o+4FtNU2jt2QY2xhkpNjN5nm1enVHgbngV
         lUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsXgLbj7Wy2vh/eSaN1OVdLHt1jAUxXA/A2ATcJAgjY=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=lbfJvPP44l5hkf/CCCt/lWKKnWfiVz6gWWvOKhNwlXnYTwwjaQR+SuW9qrxERv/0/c
         HY1IrniF320AwmJG2SKv+njBW/b5XsM0j4fvqCpyYS0Sas7vzyU9JYFw48A0mO6bPtCx
         lvpprXOpxKWryJI/PAz2vhYBbQtxBywZILFOJDOWJjco6qwyPYWlTei+Dcey2qtwLgHv
         8KzrcZGjyuGqYqTkt3sCCf6AM7a07q+/r6TIFB3TDWoKjkyIOOv1YvzmphFeNmHOU9vt
         JgSUpdk6IX6W58YKQjr/EcA7MXBI11ji1YorV9J7tcXkpgPM9KAFxlLWbHM7eaa5VTl/
         PoEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777381819; x=1777986619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsXgLbj7Wy2vh/eSaN1OVdLHt1jAUxXA/A2ATcJAgjY=;
        b=bIuo/KGffmwGtnjuN+HTC47CByDA1p8+rwFtErCqVG194KfxjwEQ68INI0b3Cee1Q8
         RwIa5hVAStRqMfwFrcZm4pyyOt5TKZH18nnoNONC8Rfcptf8BQOctt1yE+WaIC9cqEY4
         XriRDtM1UI+5et4cL9pEFybkJWivu7lZmuDCIuu23B6TCw++BA416FaLu3f/Zgvu5Hgn
         OKbU53dVsz+/5Bft2y5Sm+4VGi/FU8L+kcUL3mluS31DACuS4XXvyPkA3lByQljogFsK
         Jajm2LaAaXINgd/i9Gn04gmOR4KtwP1FzxV0CljSqdlbhAy9sAgkm/h5QolXlu2CXemQ
         dOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381819; x=1777986619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsXgLbj7Wy2vh/eSaN1OVdLHt1jAUxXA/A2ATcJAgjY=;
        b=fQ5r1mfyq6ACW2GkYWkuCU6ucZMHUMyc5LpcLYvLROiqJJmLN7rw5xnatDaPjAsI5s
         rI6f89ZYCuUdZ7/1BlO9DOzmSuM+qBuRYkI1qucS3y1i5xe2FDcmXt0LK8VXjhlb6qYN
         s+2wLoGubBOlRyxcNmf7+wWw5A0118l/2YSRfSeR8o0LTJnM/ugcB5sP0RqLLFQA7IfS
         rtAmHnWugOflX3S2zxh5lPxni1t8vboysclc9rVusCAz6b8imFlTpnuoZ6ngiGwlu4j6
         dJHR4EgMPi4xRDNcQpCUAhB/PzuuCW9PIxBUyN4oO9np4chuWaQyuvSO1IPL8dQWe84n
         4IEw==
X-Gm-Message-State: AOJu0Yzug93YO8f9nup5uRBt8NE570yDRCn9RVnWjNcWIGXsyvELMJ1F
	S+PTN7Qwu57GEhz6Y2o7P4Mvb1UToIABGDrirNt+1RU8bzbR19zPAJWYw8hZaWH6yUOZe2yQYGM
	Urx+LDS6ucJZjtqSCsuYZnlwwY0GDswzoPjyDfiOzi5DyjRQlaqwfnogqb5FQz1Q2nzjmN4O8kh
	OYu0RMdZubPDHT1jxNtOZoD0G/edf/tFUB3LlOXw6tiU9WEWo=
X-Gm-Gg: AeBDieszxMIlm+0zaqCA3EphQaLZxvwRK/emHAToM8yX/hcXnivuyTF39a449He6sHW
	tcyntT5D1q0Jw6QObYCwyyQPwQNvITLg80G9j8WrlS+AfMzHXOzhrwLYxtEQFyg8XvTjl9P0w8v
	DdmWysOir+6M7mwTiIB6H/J26hD0sNNVC0u2ahZ+wxdZTJlsNFHTi5c9SV0Q5sdE2WwNpDwHrCx
	cbp0NhkF+h0A5Mk
X-Received: by 2002:a17:90a:16c1:b0:35f:b9ba:45b4 with SMTP id 98e67ed59e1d1-36491b4df35mr1484557a91.0.1777381819109;
        Tue, 28 Apr 2026 06:10:19 -0700 (PDT)
X-Received: by 2002:a17:90a:16c1:b0:35f:b9ba:45b4 with SMTP id
 98e67ed59e1d1-36491b4df35mr1484513a91.0.1777381818047; Tue, 28 Apr 2026
 06:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309144132.3039335-1-lautrbach@redhat.com>
In-Reply-To: <20260309144132.3039335-1-lautrbach@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 28 Apr 2026 15:10:06 +0200
X-Gm-Features: AVHnY4KL2cnD9_a3--bmV7uYN9e1Eg3LYohfekhtA5w0EldNdXNWtt4Hdd5BhF0
Message-ID: <CAFqZXNt+MPK2=-fsqu9g-FetepJ2N51a5K1cJhTL9NCkH3URiQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for UTF-8 in file context labels
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 3:44=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> - libselinux to be able to read UTF-8 spec entries
> - libselinux to compile regexes with UTF strings
> - initialize locales in setfiles, sefcontext_compile, semodule
> - semanage_exec_prog to execute external programs with LC_CTYPE set to
> the current environment
> - disable UTF-8 support build time using DISABLE_UTF=3Dy environment
> variable
>
> Fixes:
>     # cat unicode.cil
>     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u obj=
ect_r user_home_t ((s0) (s0))))
>
>     # semodule -i unicode.cil
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts:  line 2145 error due to: Non-ASCII characters found
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts:  line 2145 error due to: Non-ASCII characters found
>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid=
 argument
>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles returne=
d error code 1.
>     semodule:  Failed!
>
>     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=C4=8D=
k=C3=BD(/.*)?"
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts.local:  line 4 error due to: Non-ASCII characters found
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts.local:  line 4 error due to: Non-ASCII characters found
>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid=
 argument
>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles returne=
d error code 1.
>     OSError: Error
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
> Patch v2 changes:
> - add posibility to disable UTF-8 support during build time via DISABLE_U=
TF=3Dy
>
>  libselinux/Makefile                   |  4 ++++
>  libselinux/src/label_support.c        | 16 ++++++++++++++++
>  libselinux/src/regex.c                | 12 +++++++++---
>  libselinux/utils/sefcontext_compile.c |  5 +++++
>  libsemanage/src/semanage_store.c      | 10 +++++++++-
>  policycoreutils/semodule/semodule.c   |  5 +++++
>  policycoreutils/setfiles/setfiles.c   |  4 ++++
>  python/semanage/semanage-fcontext.8   |  8 ++++----
>  8 files changed, 56 insertions(+), 8 deletions(-)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index aeede2b56e8e..0f8412ccf1ea 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -3,6 +3,7 @@ SUBDIRS =3D include src utils man
>  PKG_CONFIG ?=3D pkg-config
>  DISABLE_SETRANS ?=3D n
>  DISABLE_RPM ?=3D n
> +DISABLE_UTF ?=3D n
>  ANDROID_HOST ?=3D n
>  LABEL_BACKEND_ANDROID ?=3D n
>  ifeq ($(ANDROID_HOST),y)
> @@ -21,6 +22,9 @@ endif
>  ifeq ($(DISABLE_X11),y)
>         DISABLE_FLAGS+=3D -DNO_X_BACKEND
>  endif
> +ifeq ($(DISABLE_UTF),y)
> +       DISABLE_FLAGS+=3D -DNO_UTF
> +endif
>  export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X1=
1 LABEL_BACKEND_ANDROID
>
>  USE_PCRE2 ?=3D y
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_suppor=
t.c
> index 57e191c8eb77..67fd2020bcf2 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -11,6 +11,7 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <errno.h>
> +#include <wchar.h>
>  #include "label_internal.h"
>
>  /*
> @@ -35,6 +36,7 @@ static inline int read_spec_entry(char **entry, const c=
har **ptr, size_t *len, c
>         *len =3D 0;
>
>         while (!isspace((unsigned char)**ptr) && **ptr !=3D '\0') {
> +#ifdef NO_UTF
>                 if (!isascii((unsigned char)**ptr)) {
>                         errno =3D EINVAL;
>                         *errbuf =3D "Non-ASCII characters found";
> @@ -42,6 +44,20 @@ static inline int read_spec_entry(char **entry, const =
char **ptr, size_t *len, c
>                 }
>                 (*ptr)++;
>                 (*len)++;
> +#else
> +               size_t char_len;
> +
> +               char_len =3D mbrtowc(NULL, *ptr, MB_CUR_MAX, NULL);
> +
> +               if ((char_len =3D=3D (size_t) -1) || (char_len =3D=3D (si=
ze_t) -2)) {
> +                       errno =3D EINVAL;
> +                       *errbuf =3D "Invalid UTF-8 encoding";
> +                       return -1;
> +               }

This is not going to always work - mbrtowc() will use the encoding
from the user's locale (given the setlocale() calls in the binaries),
which may or may not be UTF-8, while PCRE will expect UTF-8
unconditionally (since you always pass PCRE2_UTF). For example, if you
ran setfiles with LC_ALL=3DC, it would reject any non-ASCII character.
With other encodings it may pass the check, but the char_len values
will be wrong, which could create a mess.

An LLM suggests three possible solutions (all seem valid to me, with
different trade-offs; presented below in my own words):
1) Replace mbrtowc() with open-coded UTF-8 validation. This can be
done by a relatively simple function, but adds some complexity.
2) Drop the encoding validation and just split the string by
isspace(), letting pcre2_compile() do the validation on its own. This
would simplify the loop to just:

    while (!isspace((unsigned char)**ptr) && **ptr !=3D '\0') {
        (*ptr)++;
        (*len)++;
    }

...and should do the correct thing in both UTF-8 and ASCII cases. A
downside is that the encoding mismatch failure would occur later and
the error message may be less clear (didn't verify this).
3) Keep mbrtowc() and set locale temporarily and thread-safely to
C.UTF-8 using uselocale():

    locale_t utf8_loc =3D newlocale(LC_CTYPE_MASK, "C.UTF-8", (locale_t)0);
    locale_t old =3D uselocale(utf8_loc);
    /* ... mbrtowc calls ... */
    uselocale(old);
    freelocale(utf8_loc);

This is kind of messy and depends on C.UTF-8 being available (not
generally guaranteed!), but avoids locally implementing the UTF-8
validation.

> +
> +               *ptr +=3D char_len;
> +               *len +=3D char_len;
> +#endif
>         }
>
>         if (*len) {
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 976f00d4806d..2ebeb7c137c7 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -85,9 +85,15 @@ int regex_prepare_data(struct regex_data **regex, char=
 const *pattern_string,
>         if (!(*regex))
>                 return -1;
>
> -       (*regex)->regex =3D pcre2_compile(
> -           (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTA=
LL,
> -           &errordata->error_code, &errordata->error_offset, NULL);
> +       (*regex)->regex =3D pcre2_compile((PCRE2_SPTR)pattern_string,
> +                                       PCRE2_ZERO_TERMINATED,
> +#ifdef NO_UTF
> +                                       PCRE2_DOTALL,
> +#else
> +                                       PCRE2_DOTALL | PCRE2_UTF,
> +#endif
> +                                       &errordata->error_code,
> +                                       &errordata->error_offset, NULL);
>         if (!(*regex)->regex) {
>                 goto err;
>         }
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index 811b2a1a6a98..fb848ff112ca 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -1,6 +1,7 @@
>  #include <endian.h>
>  #include <errno.h>
>  #include <getopt.h>
> +#include <locale.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -551,6 +552,10 @@ int main(int argc, char *argv[])
>         struct spec_node *root =3D NULL;
>         struct sidtab stab =3D {};
>
> +       /* Initialize locale for UTF-8 support */
> +       setlocale(LC_ALL, "");
> +
> +
>         if (argc < 2)
>                 usage(argv[0]);
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index e3048c08df0e..21ee6dfb78b0 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -57,6 +57,7 @@ typedef struct dbase_policydb dbase_t;
>  #include <sys/wait.h>
>  #include <limits.h>
>  #include <libgen.h>
> +#include <locale.h>
>
>  #include "debug.h"
>  #include "utilities.h"
> @@ -1479,6 +1480,11 @@ static int semanage_exec_prog(semanage_handle_t * =
sh,
>         char **argv;
>         pid_t forkval;
>         int status =3D 0;
> +       char *envp[] =3D { NULL, NULL};
> +
> +       /* we expect that locales are already initialized */
> +       if (asprintf(&envp[0], "LC_CTYPE=3D%s", setlocale(LC_CTYPE, NULL)=
) =3D=3D -1)
> +               envp[0] =3D NULL;
>
>         argv =3D split_args(e->path, e->args, new_name, old_name);
>         if (argv =3D=3D NULL) {
> @@ -1492,11 +1498,13 @@ static int semanage_exec_prog(semanage_handle_t *=
 sh,
>         if (forkval =3D=3D 0) {
>                 /* child process.  file descriptors will be closed
>                  * because they were set as close-on-exec. */
> -               execve(e->path, argv, NULL);
> +               execve(e->path, argv, envp);
>                 _exit(EXIT_FAILURE);    /* if execve() failed */
>         }
>
>         free_argv(argv);
> +       if (envp[0])
> +               free(envp[0]);
>
>         if (forkval =3D=3D -1) {
>                 ERR(sh, "Error while forking process.");
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodu=
le/semodule.c
> index ab5168ebdc00..aea22f6e94e8 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -21,6 +21,7 @@
>  #include <sys/types.h>
>  #include <libgen.h>
>  #include <limits.h>
> +#include <locale.h>
>
>  #include <sepol/cil/cil.h>
>  #include <semanage/modules.h>
> @@ -418,6 +419,10 @@ int main(int argc, char *argv[])
>         int i, commit =3D 0;
>         int result;
>         int status =3D EXIT_FAILURE;
> +
> +       /* Initialize locale for UTF-8 support */
> +       setlocale(LC_ALL, "");
> +
>         const char *genhomedirconargv[] =3D { "genhomedircon", "-B", "-n"=
 };
>         create_signal_handlers();
>         if (strcmp(basename(argv[0]), "genhomedircon") =3D=3D 0) {
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 351940f33a9b..7824cffe460e 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -7,6 +7,7 @@
>  #include <regex.h>
>  #include <sys/vfs.h>
>  #include <libgen.h>
> +#include <locale.h>
>  #ifdef USE_AUDIT
>  #include <libaudit.h>
>
> @@ -153,6 +154,9 @@ int main(int argc, char **argv)
>         long unsigned skipped_errors;
>         long unsigned relabeled_files;
>
> +       /* Initialize locale for UTF-8 support */
> +       setlocale(LC_ALL, "");
> +
>         /* Initialize variables */
>         memset(&r_opts, 0, sizeof(r_opts));
>         altpath =3D NULL;
> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semana=
ge-fcontext.8
> index a29b74994763..f590ea30fe9e 100644
> --- a/python/semanage/semanage-fcontext.8
> +++ b/python/semanage/semanage-fcontext.8
> @@ -15,10 +15,10 @@ This command maps file paths using regular expression=
s to SELinux labels.
>
>  FILE_SPEC may contain either a fully qualified path,
>  or a Perl compatible regular expression (PCRE),
> -describing fully qualified path(s). The only PCRE flag in use is PCRE2_D=
OTALL,
> -which causes a wildcard '.' to match anything, including a new line.
> -Strings representing paths are processed as bytes (as opposed to Unicode=
),
> -meaning that non-ASCII characters are not matched by a single wildcard.
> +describing fully qualified path(s). PCRE flags in use are PCRE2_DOTALL a=
nd
> +PCRE2_UTF. PCRE2_DOTALL causes a wildcard '.' to match anything, includi=
ng
> +a new line. PCRE2_UTF treats pattern and subjects as UTF strings and can=
 be
> +disabled build time via `DISABLE_UTF=3Dy` environment variable.

disabled *at* build time

>
>  Note, that file context definitions specified using 'semanage fcontext'
>  (i.e. local file context modifications stored in file_contexts.local)
> --
> 2.53.0
>
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

