Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA43D413C
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226230; cv=pass; b=ElMbwZq9WdcBmbqj9ukZwPbGyhTyS8xi0LVl2towihzFKiYfh4eje9fx0yyjfGVQWD54a2LfEnpv9fGxxxR69vMuluW6rLUU0aDJ6NTJ3+mU6Dz0B+nPay6kXzRICnDObT/yEYhmxCbMFm+2oBul1cBw5Sur9k6GRCSvWfaeuLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226230; c=relaxed/simple;
	bh=GPVQcqO9R/YCvggcHCnI3a7SwbohaoYwBnCcXJW9Mm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiY+Gjd+CtzY3LwtN7zexENGTcDNSZIbSl6H+9jGAposA5Skf5HKRx2b8/dLBK8rRNqVdP6Nta1tv6GumEsFTqYKv37parXGk237k+XLTzgncaNxA5pJojzp3MySiHRCowYhFwhiKTNlrCAmxcH/UijxvGufoYsnU2bfDjgHX7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5GVw/nr; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5GVw/nr"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so5805155a91.3
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 07:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226227; cv=none;
        d=google.com; s=arc-20240605;
        b=Ry2rJJE5YW0i6iiB7+oIOj76U5qrLqVJWHrQJyAMZJh6iXtRF8NAOHPEwzev0LZiAL
         gZtKaY0Ctlbnx4kDEPNepD8rWWFtuzeY/kaeFSwQvNH0Zub/1V7DYR3Q4GIJOrB5n4dI
         i8d7Z0kI86KCQpt4zHCzUvKqOMqzz6rCLQh1AqVIP34boe151xoTYlS2De6d1f9o+N/2
         I6r/CwvCIjkR9clp4eKrAZ+jCIfQzPyayaqSRv1is/pITLiRK9cx5Dk/0hmt4Bpg6grQ
         jma6D5gpktBykhTbNOYS2W05/gnPiMAbsRta018yQp/fRQhNBwoeojtnFtRJr0aVjuui
         31Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Ty8IQp1/lbOO8otPHgdMxRqC2JrmSjJLPHQlvIxwhw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=NqL6Ns4sirsu4rWzXIHBCpdabLB3tz5kfjWTtWjCwGt3t4SAvNkrvpSbT8Vrjd5pAG
         xIZb3nNGwySu+/e6qAJ0vzNS/uA5EXhCN9xxiYKzfuc1TFQRZiRR7aQSlb5sVO4jpH4d
         ulVRyWevCZsG0NbwCFojvwpa60bRadgTp7RxpGGiiywsBl5Z23e1pAhLiXkw8jiSCwzW
         XAYIVT0BAGmJQVwXtSGPcachgjn/pMjVhYRYnfNa52dlmyPd2wHy78i3JssUC9BdNRJi
         itJaoawpj7i9XrxTVbuJNyuwZxhrokaGotuCcmB0A3UhaqRymvSXey9uwyOoO8JmU9Ry
         eiEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226227; x=1782831027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ty8IQp1/lbOO8otPHgdMxRqC2JrmSjJLPHQlvIxwhw=;
        b=b5GVw/nrIXiGfcDCuwJXXJJZuLWeWH0KUmAA0IpG8Q8M2vPC7y/OtydQ+N/VmEJRyg
         F70u2IguPoxLVUSNFWepNVrkO46gd3VuvkO54lBYB+A8wwP2uxs65Yb9lTOYejpEVFHj
         EryLEetAhXxEnEtUF5RIdtPIx2F0rjWDTNyu8L6gJSDSy2wZ7y2do7nnrboPxidQUBeP
         HvmnkI5XjPNSf2ZoF5EC+a1MAufENYzTRTXlSd6l/Bl9Lqpv5DrNbCZBzSnhsyupQPjJ
         Ph8snZpHBQ+NBcJIid4VvG/mTC68n27+Pfk0QCAM7uPw74EkdP2yoVqlQ0wX4pQ/oL4E
         l6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226227; x=1782831027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ty8IQp1/lbOO8otPHgdMxRqC2JrmSjJLPHQlvIxwhw=;
        b=MXlo65/dXzYMIUL5wRxDVRgNG9cBNgv5sMg9IxIWD9qUyvz/dJMwyUZMqt+vMiYklF
         7ydXCvFoaMQQGvY8yOqwFsu0zkUASxY1QelClXrNUktCaHvDNGYiBjTdpg4XiXoLwfmX
         7t7CymEB3HVkNYSYn5Vi5sYOiImsE3qbqhMPvlfomnt66Nx2VLNtejazQ+A/7CQU5LDd
         juczt2kgaPRKdByWrlo8Qrusd8z8cDW619tTS8JM4zVGjcLHur1r8xFBFhYCWJa+Fgh9
         +u3HlrFvQf0VifcEowHKz27c67rFTBDz8Gh8DoaL5Fg4CRUrh3AcoX+yKtVyUdE3Ya7H
         sbPw==
X-Gm-Message-State: AOJu0YxOfq9y6KYveoc6D02eN/sqaBfsxo8zeCboCv69csJ/+6E0kcfT
	YWGmXRnOYRSHA2EvqcjBG6KwIahQuCKn4drn3ASvWD97YnlEqJgn96dKwyfyZ+tetGwsm5prbde
	1WqPGAabm4G51xylrI3qyhbpcyeDjuUcGdw==
X-Gm-Gg: AfdE7clMXUvW1yW++c4wyMgEfF/7JmSVoIPRt/9tYYLprmpLQOz6avYmolFiBHimf8c
	Mv12J2AIQaag43TYo5E/FyaqBMbXCQMPIFyGQFG5Gqo5c9CG7hsF20SAaSYArGN6T5Md6E5c6po
	L3qB7QZN0od7iagAuMHS/1A2JEIAujJsFIFduqQtRg3tkant06ciDWT4kUIRUK/8eAu6M/sLh6F
	tdUNpyKmg6x9pVolP6/8DFq2SZjaUNhtlmi2Gv0itfvAeen45x1p6WDePN1sH/uuwy2M+aH
X-Received: by 2002:a17:90a:d405:b0:367:d850:6a5f with SMTP id
 98e67ed59e1d1-37dd17b6cd1mr3362078a91.25.1782226227066; Tue, 23 Jun 2026
 07:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-18-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-18-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 10:50:16 -0400
X-Gm-Features: AVVi8CeXO0TZWb3TfyPbRfbFRhGEhKzTQFFcSeYByaFbIvatwHm0kd1Gio8DfSM
Message-ID: <CAEjxPJ6aT5RmZvFwJpnDAw5K2qC6psj--gHZQzXbUGQ3L5Gt_A@mail.gmail.com>
Subject: Re: [PATCH 19/24] libselinux/audit2why: check CPython allocations in analyze()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> PyList_New() and Py_BuildValue() can fail; their results were used in
> PyList_SetItem() without a NULL check, which on OOM would dereference NUL=
L or
> insert NULL holes into the returned list.  Check both and clean up on fai=
lure.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/audit2why.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 3c3aa105..c6c4c223 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -417,10 +417,19 @@ static PyObject *analyze(PyObject *self __attribute=
__((unused)), PyObject *args)
>                         }
>                         b =3D bools;
>                         outboollist =3D PyList_New(len);
> +                       if (!outboollist) {
> +                               free_bools(bools);

You haven't yet defined free_bools() at this point in the series, so
this breaks bisection.
Move that one ahead of this or fold them together.

> +                               return NULL;
> +                       }
>                         len =3D 0;
>                         while (b->name) {
>                                 PyObject *bool_ =3D Py_BuildValue("(si)",=
 b->name,
>                                                                 b->active=
);
> +                               if (!bool_) {
> +                                       Py_DECREF(outboollist);
> +                                       free_bools(bools);
> +                                       return NULL;
> +                               }
>                                 PyList_SetItem(outboollist, len++, bool_)=
;
>                                 b++;
>                         }
> --
> 2.53.0
>
>
