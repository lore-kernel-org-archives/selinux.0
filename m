Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279C374A04
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082335; cv=pass; b=Wdc7+yguKLZ+xQ1d6RrR9jRQe2dzRGE6sS/4NvZoCV5QctMIBHGimYtPF0egTDGXdnLfHiwaZ2mt+WP0ltr6g+cXZV/OCINLN13+xvz9jGVCLr/GgZT6MapNB/yr09WCdLZgCsz66z1kGnTMVOq2jzVxsthDsxPj5TF3AP5hDtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082335; c=relaxed/simple;
	bh=lFpdGSEhE0lnJFUVdxx0M7u56QizqwNvTh6Vy9AebIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQ/lrMZ4uJfrj1SXH/qQ75kIhfCREHlxuk7MX+zGOp04Db1UdNinbrcIzuo9EAUV1yJuz7wFFXUiDkEUUPOiS5XHwtf3oKAQb7qe8SLYTW8wiYmac5JMVvlKSlWn/hhEEZmYrGosJfiX7lwZclsTfZHE+A5nQ059W2yp3cCmNxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7SfERMU; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7SfERMU"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44cb057311bso248761fac.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787082331; cv=none;
        d=google.com; s=arc-20260327;
        b=bCjIkOqi1jJ7r0jzEKvdiMCMZLg+JmnuKGvR7UQ3d4QMC0P7MFA0u4Zw+x64FuG++i
         vm1K4xI6qk5/+3rdWobK7a+EuRsp21OjqwiBe5NVffWtUS7RuSjwU+0RZd+RDqOiRiQM
         d06YrWLDot5ZgJYCkXg98Wrbi2quP+woqaArmNdwD388u31ygaWzvJkZIU9XNbfBg8Pu
         VnAZAmckDuBaBiewskYhiA+CD7iKsdoSxIrCP7vtY1LFFrhFmK3Ph9qSTnC/XkySt68M
         mb6vTpJviuJ1VPy7Glw7kNM1IMBEqCjyV7XQg2kpdoW+/cXSMX42azLIhY1NScOd6Y8f
         Mrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xuCVAix7RCgGxWkp0fJsEvgOpjQoI/o00xgHbZYmt00=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=NNTWoBLhq7EwpcT1WmLf4NSlMSHVOCTTrUCR0xvjojJW2R3okAXf396rQawKVDmG4y
         lEl1OAQWO3EUprzLxIE6KBBKMdT/yw4zKZv8hhQWre1Bf/BiyGWZxcY6H3s+v4W7G6NO
         3a/uiNZy3e7ug+ye2jWpvnyWHM+ahs6Jt4A1yKWFa1ynJ8uRGQRXM8TouyQPW/f8tfTT
         X0XornI4WebwkKaOl83zmHNb3qTwalLo4hUNktkkSZs/fc6jTfjmra0rTRTDDNQkYc8L
         u4CCD2k92RmYjeWgPw93KyjKQT10nPemh3eAwJYi/0WyejXkJ3g0BDeUKNpeEOUqRlQn
         ej5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787082331; x=1787687131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuCVAix7RCgGxWkp0fJsEvgOpjQoI/o00xgHbZYmt00=;
        b=M7SfERMUUqMqgKAH1YENL6fXHto4CP9UETyptzZMbGm445quYg47vqQSxLA/Y0M18f
         slec3J1kt3jcsNWLlrQEaD9h+naurASIjXqxdigZsHYXA02kWJ+Bc7XoLKPuPaWIpduU
         1xJoUjAWTo5eOnRGqG1xyz/4tOHfOKh98WMtlDysFbkDizQETnmRnNNg26VzvGGM0Pti
         vaIn+d/JtwgBb8pxz9o2KXroiZUjeNuh2Qh/FpfGVdogYKSnRfc/IOTLEUA1Qugp6Cmm
         xl4RbPK7RhXUDdEcdNkBgy6+HTYVCEsWc3EnCiVxLdnrHQWwOo9qSGD6zAgjwfHkneEf
         qFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082331; x=1787687131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuCVAix7RCgGxWkp0fJsEvgOpjQoI/o00xgHbZYmt00=;
        b=EQCki9Uc33vTR8OuXwR7WjmgGtBYCZAyXkl7lGv8m32mVKvz+K5hskeIbJJGE+ud7z
         Aq/0nXApYEuQPXWW8E4bvGSnxgOdcyHHbZedKybJwa/b747w/uN9jeN7ofjyK87gXrPF
         dyjGPniyi1ZMYvW11bYY0U4svySQGf1g3mcZl1J8aAicpciDdfDkHNuymDPLxdzFAIIt
         Kscqywz1zixaf/8SDwC/GAbU/wjDJ68b0f3mvGqJE1WRqEfWH5Yl2OX1gdAcJkM3Tmxh
         8pgMYbBr4RayNG/4/6d38GMDZt77qn/AQA5onfhAfa7ZWt8z9Z79w5Q5DDMXKQqs1+n5
         LANw==
X-Gm-Message-State: AOJu0YwbKG9S2mkCwY/RcEbK4TTfSgUkNN76W3eS762I39tqOMX9NgX1
	8rWS30NKkTjTX/lM2fx4E+dm8wWKyavhAQEhWARQ3GcbdYfFSd68/B18cZDN+clAPdz7rAD+WGw
	Z6aMsfsU9L9H2m8ZXxPb/vlsM5L3gOlg=
X-Gm-Gg: AR+sD11TtWnn30fJ9Ueu2eOO7cHX3yWzL3pSPBlcVSrHWVvTDbdCzWscWiQI2aghZX0
	v7ZZBCH7DEosvC+Nol8iiXkPQtOpx/P7mFse3Wn4npGVYuMVLyC5oTcbYWrkQ2BfOGuGS0anP/I
	vpoLbQsvliGVmYeP4L1W9iWixyqetrLrnSNuB9Yi8cFx1VSRdjSscja0Ovlq0Vz5ohYxpdg01BF
	VTJv6EA4VPD4UX06Cp6zVELMQRYMsEM76YZnzq3gj83fiuHgSO+elGeQ13p6F+7az+FO7DXRoGW
	NI6pzkf5OPxjURdJH/Nwa1p3tRWks+N2+Fe3fbsa5H/I
X-Received: by 2002:a05:6871:7418:b0:455:a590:7ff1 with SMTP id
 586e51a60fabf-45f377d4497mr8274006fac.15.1787082331516; Tue, 18 Aug 2026
 12:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192203.60432-1-jwcart2@gmail.com>
In-Reply-To: <20260818192203.60432-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Aug 2026 15:45:19 -0400
X-Gm-Features: AcwNN1V85HeCycYhSz6QlheVg5GIckyU6fOubahYDDHwf4YaxD8N6zgue9Z1BHs
Message-ID: <CAEjxPJ6mNfMisiUiuabEpEDennzz+=p5PQxkxn7dWVGwhqg5cg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check all the permissions in sepol_check_access()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:22=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The function sepol_check_access() takes five arguments: a path to

technically it's the program sepol_check_access, not the function

> a policy, a source context string, a target context string, a
> security class string, and a comma-separated list of permissions.
> It calls functions to turn all the strings into structs that can

technically it is into values (SIDs, classes, or access vectors)
rather than struts

> be passed to sepol_compute_av_reason_buffer(). Unfortunately, as
> each permission in the permission list is converted to an access
> vector, the previous access vector value is overwritten, so only
> the last permisison is used in the access check.

Typo: permission

>
> Use a temporary access vector when converting each permission
> string to an access vector and "or" it to the final access
> vector before processing the next permission string.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/utils/sepol_check_access.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol_c=
heck_access.c
> index fb3b7edd..e80d6464 100644
> --- a/libsepol/utils/sepol_check_access.c
> +++ b/libsepol/utils/sepol_check_access.c
> @@ -12,7 +12,7 @@ int main(int argc, char *argv[])
>         sepol_security_id_t ssid, tsid;
>         sepol_security_class_t tclass;
>         const char *permlist;
> -       sepol_access_vector_t av;
> +       sepol_access_vector_t av =3D 0;
>         struct sepol_av_decision avd;
>         unsigned int reason;
>         char *reason_buf;
> @@ -58,6 +58,7 @@ int main(int argc, char *argv[])
>                 char *tmp =3D NULL;
>                 const char *perm;
>                 const char *delim =3D strchr(permlist, ',');
> +               sepol_access_vector_t perm_av;
>
>                 if (delim) {
>                         tmp =3D strndup(permlist, delim - permlist);
> @@ -71,7 +72,7 @@ int main(int argc, char *argv[])
>
>                 perm =3D tmp ? tmp : permlist;
>
> -               if (sepol_string_to_av_perm(tclass, perm, &av) < 0) {
> +               if (sepol_string_to_av_perm(tclass, perm, &perm_av) < 0) =
{
>                         fprintf(stderr,
>                                 "Invalid permission %s for security class=
 %s:  %s\n",
>                                 perm, argv[4], strerror(errno));
> @@ -79,6 +80,8 @@ int main(int argc, char *argv[])
>                         return 1;
>                 }
>
> +               av |=3D perm_av;
> +
>                 free(tmp);
>
>                 permlist =3D strchr(permlist, ',');
> --
> 2.55.0
>
