Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250C30BF6D
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638366; cv=pass; b=DXkdcAop+5kCaajQqC+jzyIENvzKf8e38Zab1HSE22R2jIBi6Qiiq2ZAGjL1NNXCJ53xTOebHk+mUN4xxk0rAEu5cY9Dm7o0D7rEGA5Nf0PX/Isrh7abXmxQNh5i85DwcwN2m1WRtztXwMM2e8MH+Hza78sRxNU4Lb8EdWoQC6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638366; c=relaxed/simple;
	bh=KmJop6w8sAuVHb7kVT73p5RHVcMrslNqooDR8rvQ6wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hime/lUlr71u2WSvl5unv6Ed1LB8RtIzRw+T+pMdT78iF+U+LS5Jm1lwnndGKfHGuP21sE2s2PsNhEke08EPRnhLD9Dw+nMQkVupiqPV3N33E/2zDqqfLnp7H7K1Z4CRcHD/j2wpVZRyDsgjtHYnQcQJp4TztgTpFQHz7XnR3Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9eG1F6F; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9eG1F6F"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1468145a91.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638364; cv=none;
        d=google.com; s=arc-20260327;
        b=dIDidGpUxRZlfEsTAk3H2WWLTA1mMBD2is29noTDrA/NAoe6KplF3r8WAhzln8K9uT
         DNKSycqxurhq9JOPcuAhaLsAIu2rAvovoc55HHrSozZJ6dcFUAgEwhn0IkHzuPSPEc7B
         d0pmBR1Tlc8TMWuWbwMvaVMl43I/smSE5Chbz7pqVN5vucFeKO1MlUhiAEf8GP6ACbGe
         eWvq14HyTH3JzsyfgHhP9FVU8FL37tebYDWMSaqd/1iZvO2gh+SMjbCGJmlV3CLc2WCB
         7ohRmNqdiUMxdEEa3sPlttulyQwcJO1qyyFGZK5sqiudg0EdLgsRNavcOWaDpnwDhAor
         eGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pKrJmHrytbE00EC4I4ogMTZr/GfWrAqQY9UZiZ7Rn0M=;
        fh=087wN1Ya/oRI+I7bkzE0JFBI0DIANAah/fyKi8ntC3E=;
        b=lvaqlrYmH+aQ+yAajwp/gHvKitP/P8By10b3cSQLyusQaQgeRc5RG5n1EDBWN+mRhf
         YPSrNkWmoQi39YlfufGoTdHARA4kQFRdYKSNLnQxZDJ0Bo5SrFoGxTadk2NlZ5CXhwrm
         qz53we57Nmcdy5t5/rsu5w9/8nRTf/q/S3uKwlqX9+rnJr9civedI2rgw01t2tYubhcn
         JppWeaH593es/bMKumC0KwFsk03x84n/yM/a5v3QPLApfi/N/HhDK9eG7vGCo6SVjUNq
         Dhqi6N60rirFtj1+ggStyYHoWcRGVOvGC2h9ekfQUaHU033Mv4VLskwiHKnEelooTEZp
         nyLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638364; x=1785243164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pKrJmHrytbE00EC4I4ogMTZr/GfWrAqQY9UZiZ7Rn0M=;
        b=O9eG1F6FakQvXmjJxWECJxK4wxUfCSsY1JGrtpBfAgZaOTzuLUj5RtDdDQUUERuo+w
         dxcu1iFMq7oGdzvLkqc00Lc8vGq5g/Ia4QNE09yFLGjAMOnZXAfdyLCSnPaoSfQkLer3
         OD/aNbQFgc8/O+d277eBL+C9heXes/bCP0XJGryqZ87+GM3ejQCRBKoVEiMLn94FBk5k
         dT5pWtZiamrbCZ+G1D5ZLTaOerXCKsfjGyEKTUs+NZtRqALackCF39GGpOmABLjkfmNh
         +F92gl7zrCbzuO9zLowcEPElC9HB3I4umW64bLCEl8iEL6yd1HHgGjDHat0SlE4Eqjkl
         Dslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638364; x=1785243164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKrJmHrytbE00EC4I4ogMTZr/GfWrAqQY9UZiZ7Rn0M=;
        b=VDdH85+/u/OfWW0XUAIxn90OV1udU18TbCCjuTOTGQQrvpTvwJ9DjYUk8zYoGIYAZ/
         RNMXL1HNjy/1rF8GuRvBomk0r701J1K29rNFJmcwCN3CM6ipZM+zxHZizLpw2QGH6Vdw
         rKX2lTvTnEQq4AMFJpz8GizpPOuHpUXjDhGvWiO5r+rmbFUPInKy4yPUvWjHxFao6lm+
         Gm7RjyZj7E3FqZFSTu2qOM2UQuQS71K91mCuGM48hUquRano774wZZZvVScciGvfrf+b
         UxxvnY0Wbbu7BR8sHxW4s5G7b5nF65/pX9/Hempmb77W4BR0giQFfHexFL+eAULyVaiu
         OlNA==
X-Gm-Message-State: AOJu0YwtZgB1Z71M3VAf5res6DhwLlmyHtbBjhR9K+SjYT+bOMz1d6+N
	ZMnt/WIrZzMTBkXUg6WNFSd9sBnYKo9AhmOqdT00iCUTzCA5aZGCQrX+xWQEp4+RVRXcItDG5iz
	td9MiStxCFIdMc4efKZjjYguRDeRvRs5XmA==
X-Gm-Gg: AR+sD10RtgaZR9GIMhCWf7u1SdkfCtl4AOqpgSYyLJz8qnwm2ROB6dLxBKPetQdY7WL
	P2hPDxN4S99ESUNKQDo82CDYb9SCanLlwiF7cm0iTytIW93XUNi/ciiM43kj9NFOSQl23P7y2Pv
	ooXEYi6FEgJeJeebjqDc3dtteTCObqI/ssP0iZn9NIqB1dyKn9Sg0zDJqdsr32msQkpS8Ng4eti
	nU4OzxwoO1ifQ7724xjFEe8OY/6m9B82wwSW8TWzGp8/L/n+hs4REYWy3nQG8486wiO+Aq8
X-Received: by 2002:a17:90b:1c86:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-38e4b41fda8mr17068452a91.6.1784638363947; Tue, 21 Jul 2026
 05:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716184844.10348-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716184844.10348-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:52:33 -0400
X-Gm-Features: AUfX_mzVg8V3a006U_FNp9-7LDJhLdIue1peQ7Vx32rFA8nPlSi4kpKFBPNI5rU
Message-ID: <CAEjxPJ5qa0dHV1bFUasRahwma_SpzGODn4iAgvtGNQryKwCLig@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/scripts/fixfiles: drop /tmp cleanup
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jsegitz@suse.de, russell@coker.com.au, paul@paul-moore.com, 
	perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 2:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The /tmp/{gconfd-*,pulse-*,orbit-*} directories are no longer
> created/used by those daemons so we can drop the old commands removing
> them.
>
> The find commands used to find unlabeled files under /tmp and other
> directories and then invoke chcon on their pathnames will re-lookup
> the full path each time and is therefore subject to TOCTOU issues.
> Since some of these directories are tmpfs on modern Linux systems,
> they can't have any lingering unlabeled files anyway from a prior
> SELinux-disabled boot and we can't restorecon at least some of these
> directories because they have <<none>> in file_contexts. Just drop
> this /tmp cleanup altogether - it is unsafe and shouldn't be needed
> anymore.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/scripts/fixfiles | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index b7cd765c..b5f193e1 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -288,16 +288,6 @@ case "$RESTORE_MODE" in
>         if [ ${OPTION} !=3D "Relabel" ]; then
>             return
>         fi
> -       echo "Cleaning up labels on /tmp"
> -       rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
> -
> -       UNDEFINED=3D`get_undefined_type` || exit $?
> -       UNLABELED=3D`get_unlabeled_type` || exit $?
> -       find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINE=
D}*" \) \( -type s -o -type p \) -delete
> -       find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINE=
D}*" \) -exec chcon --no-dereference --reference /tmp {} \;
> -       find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDE=
FINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
> -       find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDE=
FINED}*" \) -exec chcon --no-dereference --reference /var/run {} \;
> -       [ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${U=
NLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference -=
-reference /lib {} \;
>      ;;
>  esac
>  }
> --
> 2.55.0
>
