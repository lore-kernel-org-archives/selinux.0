Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2363254A0
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452698; cv=pass; b=dNYFDDnRA60JAq+C3U5WYKBpIMaHK99HA6zGyL3V2AX+qGK9tVjxum5kOjaKSg8vaD88sMfaiFwdKuarUGOM6gwGEft4PyTs920+toDIHtEeRMAH8qN2viPZV1jMhRSLRFLvop2bdtsQtu27ogmbO5rlZx4DIWLsWkFjXil/FCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452698; c=relaxed/simple;
	bh=0W2ZkFOYJrBM0VdHKhvp3lQC1z5IVshDXAPIh60hvBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrArxqYtGe3/hcuGld66KkFcRr+Dj854F6tCBHNF2u+sLq0ge3XnNI/2j/sAW6Pqrz2nI4Sw5rA/ITo+zP3VBPGS7io5VHgF/CguXxyki5dEHTvG2iupSlRnlHQ6TYepkAxDiyS078Za5EUldkAnEmyskL6ksoFM/B/k0hP+RS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoYj3Wf/; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoYj3Wf/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52eaeddc837so938181cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 09:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788452695; cv=none;
        d=google.com; s=arc-20260327;
        b=pAbZXoPEUNP4uy7OT/rhyDoNsIi7CDm7ERcJkGFAFAqpnZbOm1Ed1OF5QEbckRGned
         Eysx32relDOVB7CuhIWwAkx4MTX0aptsCTcDpEkycVFcnnkPdA2DJmxzmPYMlUopEqmj
         vvfRfwp5EaZEVGheYyPovKN41nReYHZR9ljbuQw7QC/0R1+qFAOxbJGB/exbYeChl6HD
         SmwJAXVS4pmjE2hl2b6SpsPxIe2f0bY3SgeIewh4Sv8BGdILl/Ct1BYIuvhyOVw62WPo
         7P9VrNaK9Jy8mk5Kmhj9j258CzBgCVgMUqE4xBc/KjpCyRZcrBQyjny6XxEt5xHbNePt
         KE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4DOdCGVodjuZey00PYRiYqziz8tDUW6eszW35mNhEGw=;
        fh=AQnnUcjcUYpWlp25yduSBOrX2TDQdvMOewmYwjwwoqA=;
        b=h5/SKw8WC99xE6wLc/186vNzVHygNVC7W70tHxEKR4G1GP0H650h07OObcAUxKbxZw
         gblWnl1Sliwm1qkYXfoHaFXkLFZqOjwQCB0C+WCB/Qnu+5gyNEgv92yfFHtF0LmFf+T+
         zxs7ZfklTGqRLIsjrQ69RnACLpv2n1AUPOpPhOIDz/ZteW28F8u/pnA5qmGaRSPgKndA
         VEWDuryI86lVclh1VwAf6ss2iYX5c16Z5KmysNvyk/SneFUqrAEGo9s0Qs7dbVy11nAk
         WGjqU/oxhxfQB/Zu82/+jJwgKB+g4Tiyeu2EfadR3/KWW6Jr7iF+81HlF3zullhL6eHH
         wUMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452695; x=1789057495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4DOdCGVodjuZey00PYRiYqziz8tDUW6eszW35mNhEGw=;
        b=aoYj3Wf/8+rlBUo8Out0rtKd0zw6BquLT8hxYxmLks28pmQgiYHJEe3q+OStR2IoMK
         fsJusjbanatAqgNWfAAmlJ7ZjVrY+laxM0XRv+1Fg+YqnYHNEf2O5UvcX2cuCvHTd+Ck
         b5ppbGJ4sw4E0fiLbkdELznOtsC+mq0D1da/busqXDYejZ0FTFFc4ch7CL+y7cyuogJ3
         uCZthPxgzcdDopETlaREz9itmd3Q0vlTdkBHggazcGsRfiGBp6YQl1TXzGwmqUgCylOF
         F5vSeK+TlT65XNYw3nXqVD0axJrLIasVqb70KVAZRsJd6JPG816GaYj//4zx1VIYTmxR
         Cmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452695; x=1789057495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4DOdCGVodjuZey00PYRiYqziz8tDUW6eszW35mNhEGw=;
        b=bDyVZgzkOpyLD21yhp4+cKSoUd54jMR9sL38eYUJWGcgX5ZJg28ubqylvx2fMrUmHn
         AKyD+JvyjlNtovDZkEEUN7Dr0cdbQ1Ik46T/BbvdGy4ck2DmA595sWtV9V2OEJXKP91r
         byLMHAEuA/9uLgVw9cCP/kxv3sujb0Ztj4RHNUKFalmdRIHblbFBBZBwFoC4XPrgSUGU
         IUEHlYLlN6ipU1MXqBO5zuOTVN7HVj9sVxyJOGTv18wFoEIs6z6Vq3cVc6GQjL34mrA6
         TDywRPcnyy9+ibZsl5x7X7sYQp9jLb7LZZm3dYvRXgOMTZdmTQdPR+MCIle/NTW0FAvL
         EKWQ==
X-Gm-Message-State: AFuF++mfPj9JsRgsuwyFs9QwVTfzZOHQFHz4ZXjpdpvoFmf4PmhU2UsO
	BKWTl0xolSFfp7CzYO3WGZ8oZh1uyhy9kbV/IwcgeyDTT9mAJhYInq2dxPop3RLrcMIALi0rRNl
	lp5wHs/JDKtlNoVt+PIa128TXgAc9e50Vjg==
X-Gm-Gg: AYBFou3QZohqi2XIlU6o98cZEOncgmp4AdLmyL3ufUT2eu9AKXRt/p+UZSBm1i2WF9H
	HE2cMEoVyhRk4KIuSMDdS3RDEKWWbImqCJdLF85ddi3+X3Fp0PbVHunJLaA/qa2OGq/XWotZLRP
	ZddJwOT7ckLOwIV3dnMGyuYyO8cY2LcEvdgFvGHEco7mx30T4FFzKPuYSULpVafHWLcw8Lr2RXt
	fjg1P6BpOuREwpKvJRTo1v8rcoERUSmVEYAr6timIOygz7T7TaOZ1dKjapGSC7d3QBLdrB0+w/C
	jtY/uYhxwlbRIg2Y52ooB7TfNnskvPkN/ryaFLvCjZGZ
X-Received: by 2002:ac8:7fd5:0:b0:52e:12e6:6d7b with SMTP id
 d75a77b69052e-530524d0ed0mr22507001cf.39.1788452695394; Thu, 03 Sep 2026
 09:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903151347.1513631-2-lautrbach@redhat.com>
In-Reply-To: <20260903151347.1513631-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 12:24:43 -0400
X-Gm-Features: AcwNN1WHj-OC-mrtLQP1I1vGMWXhidwmqStWk8HiUzrzWQtQFgKmlslnNjx5mqQ
Message-ID: <CAEjxPJ7isYB2FekKMubJrDgdCuaRc27w6Rwfo9==BPe0GY4iyQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add support for UTF-8 in file context labels
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:00=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
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

> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index d6b5bf0252ba..f632a87275d4 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -96,7 +96,12 @@ int regex_prepare_data(struct regex_data **regex, char=
 const *pattern_string,
>                 return -1;
>
>         (*regex)->regex =3D pcre2_compile((PCRE2_SPTR)pattern_string,
> -                                       PCRE2_ZERO_TERMINATED, PCRE2_DOTA=
LL,
> +                                       PCRE2_ZERO_TERMINATED,
> +#ifdef NO_UTF
> +                                       PCRE2_DOTALL,
> +#else
> +                                       PCRE2_DOTALL | PCRE2_UTF,
> +#endif

This causes pcre2_match() to validate the subject as UTF-8 on every
call, which in addition to incurring
overhead on every file would also cause regex_match() to return REGEX_ERROR=
 and
label_file.c:lookup_check_node() to fail the whole lookup with errno
ENOENT. Thus, restorecon on a file
whose name isn't UTF-8 will error out instead of falling back to
matching /.* and labeling accordingly.
If you add PCRE2_MATCH_INVALD_UTF to the flags, then pcre2_match()
will instead treat invalid bytes
as "cannot match anything" but can still match literals and character
classes and will return REGEX_NO_MATCH
instead of REGEX_ERROR.

> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index e504b5084c8d..04c86053b2c8 100644
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
> @@ -564,6 +565,10 @@ int main(int argc, char *argv[])
>         struct spec_node *root =3D NULL;
>         struct sidtab stab =3D {};
>
> +       /* Initialize locale for UTF-8 support */
> +       setlocale(LC_ALL, "");
> +
> +

This shouldn't be necessary with the dropping of mbrtowc() and using
utf8_char_len(); what still needs locale to be set? Ditto for the other
setlocale() changes.
