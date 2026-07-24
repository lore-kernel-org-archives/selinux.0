Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A74908A0
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906623; cv=pass; b=sG2A26SOX5DskskeUAmLa4ZPw+VjJRwb+qb3ygAm73ggrAlqAt/nYiFO4UCQWOLILyGv8EMBtuKMIFQKedOp9Ru0kpguMcf9+KKlRfNUlVI8D7ItV0fGeFWeO1d/tyYuPOYpKB6GfxLjX5RtuYA7nXDKIFiWh20KrhWBksZICgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906623; c=relaxed/simple;
	bh=5NG8fmp4aMaSdWZ5/l8mAYf0HcXughtaaCKNbJF5Xxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxsnFDM5EDhejcDWCbLAlsIm113CgMdWhlmSvYbGnFm1tiUOV1faM9YWqcxlv8b1wbNU9d+tRMniG4687DANW0Yf0vwBZ+eMUCz8RInHgmueAVF2It0+6K9RkQu3BS/zYell/ggo8VoRr9vIYIHPkNi/bcThUOlJ3zzHJYXSe6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh/NHSQd; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh/NHSQd"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0e5e36912so4584616d6.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 08:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906621; cv=none;
        d=google.com; s=arc-20260327;
        b=Xypv1hgecmcjXNXYj/BMFu+GQGRNgaqqd3ISrwNQRdJ5qy6lZO+9NMfnMh+ua6BWXJ
         rh1N6baNcsyOO9JQrvftNPZASAEEv8UhAZX2hGngVs9xf+9fiO3Xzlv3DnRjKRDklE4C
         Ndsd2Cx3r+RBXnpUJ+wpoG5siPYhwtAJOh+SZeqV5K1NL2wZuApFpBXpyG4ZN0Sa/hr3
         gF6UhOnPOK5AUxAqkbKWh7ovPgoYwBTZxD7ERJqnxI+zUr5pfgv4reHxwRJopbTIA6lR
         qV03NPq4NsiZED0kpwMEyO36AXwkSscOuSEuZnNAV/1O8TR2CzKIkxUTgZEieYPo6Jpp
         X+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=06X+5ZjX7C7GkQGKGqa1ZOto4qZgpwRE8aqzk25dHAY=;
        fh=Ru/hByWDaUvuUT8xzuXdLe6dpiwTzVTdh+cdCRRS+Og=;
        b=fCP/Sglmvx7srLmT4XxJICGHDtZFKeA5f3nt793o8j+Cc0/3D7zRzpDDQsxokA1muQ
         3eyTx/XaxmAf3gIrP4iPGk2lyhcaYop6EblCc7H75aFeCQyYq7Uceohz0/s+HJAnUBkl
         svFi6LKEJ/+toDYylr1soxjQGchZey5ery6w0tlXngnvpCokVbbROHPkn5n0OgS8bs4Q
         28o2hq0IqPGRbs2FMlT2JPO7QO9wNxA5y3l/hExvz7rDeAzf8vnPM52BB/N6HAvR98oS
         Q6Gx0QE2BrmkWNUOllEd2HfMTmxdUfCAi9H5W/Q6LOE4/K1R8rRVsx6/dkh7wa8ARvSz
         6ENw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784906621; x=1785511421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=06X+5ZjX7C7GkQGKGqa1ZOto4qZgpwRE8aqzk25dHAY=;
        b=dh/NHSQdQeXz+xHQG+jzfXtKDqOJvxgpITKSPfCFfQSSbZnXB9J5Xdz7/lMiUbMmKS
         qCWFSADsIYuPODboSVXEl2lyrsiB3GAvkk9la4ac/0TIji2/trjiLlDtrnWoTgc4HWS+
         mDjG2/pZJ1CgkEm451kpxVgP/IXm82szNex2hfAOE0q/4Mcg+hg3diRnDm4cK/eJ7jlC
         K6LS7o0kSdEqv/9IeGmr+cn5f3mEYYFyCxcHmUS295bMA319W7cgL5i1rUycMKXknRxE
         EoxKvcqTYcXWYpNM6cLEAzWPyCbEp1awJEO8eHr3hVXxm88LXUhpgqEE7fXab9O3I/2H
         9KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906621; x=1785511421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06X+5ZjX7C7GkQGKGqa1ZOto4qZgpwRE8aqzk25dHAY=;
        b=meQaE8qfNCFC5/ZLBXfI4NO/NYMLWycVw/+4FAGvRymc9zE6/yKH8pv4nJlcd6wCCk
         54/MkmjY42DTfcH2Ow7hEYglBaGsIg4wokIaEBXDU5LEY9ykEPcTX5EyJ3qGNKTyMla9
         pMHungZAvkSp1ooOgiKAHFHFn7alBWYzIvJlf84rpor8L8wB8IQN8Ic1sMfQR0fy3ziY
         SF9Qkchf3cggWk3obc7PrEnvShbYHkQwxOCBzzsJmgTIu42w0qEWr6Qh/oQ+77Q7gJD0
         vujOG5n/2PxfhdmB/mkCX0R5ZSu9JlPexaE0Un2Q8E3GDNcE6P11kLmcURFSVZeOwBVl
         Sblg==
X-Forwarded-Encrypted: i=1; AHgh+RqhzTDKHmBMIIRQkaiXqHXivjLJ+WM86ICdN2gNLN65ReV9Otu/TP5qihDGSoC9REqOQUrx/1bE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50sJu0KwRbJslXfKT0YXBBVdDK2PAZ2k6DejYYCsFaZRyjO55
	9KT1OFVcEVauYoa5IJAhrEf3ow3GnOU4vJzc/fd1GeNrLgwoVwaBmtvE5VFJ9JGb6NSxbMr3a4g
	8OaFQeNMZSyau6393wmw0FAwYdfvSdvw=
X-Gm-Gg: AR+sD13EO1ZcoKN2uQpuMyn0fhv1HEnv3WGxwkCGeei/aRrs5tRZifmE9BDDCjTXQR2
	XjmtY+1dkFxkb+wRLUyIn5rIKWDOimEw3Drzip+mY9WVTTXgke4t61VmkwMoBbQdfQh+1csQKyU
	tqGXE0GifvNb39xHKiYnzxuAlEP18eiHTXBkDRZQn4BPoTV6IEbwfadaLQV9egtSr7+IlbQzx/w
	jXeA2JGXBEwbkCfzcCPUldKcdJ04ndHmwTBF7S1Wc7WF4zn/2rsxMv/cv35uw==
X-Received: by 2002:a05:6214:212f:b0:8f2:5a3e:c5fe with SMTP id
 6a1803df08f44-907ca637687mr89589656d6.45.1784906621175; Fri, 24 Jul 2026
 08:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
In-Reply-To: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 11:23:29 -0400
X-Gm-Features: AUfX_mwf4lso5HrfW56yM2Xlt23dL-B2F2u8d4FEN6V6ufCPFUj3ko9EODXhKNg
Message-ID: <CAEjxPJ7YRgtOXrbPYar0qXAq=wNbOTTMS-EsU=9HKR1NQ3qA1g@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:47=E2=80=AFAM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> perm_read() bounds a permission value by SEL_VEC_MAX but never by the
> owning class or common's nprim, which is taken verbatim from the policy
> image.  security_get_permissions() then writes perms[value - 1] into an
> nprim-sized kcalloc() array, so a class declaring fewer permissions than
> its largest permission value drives an out-of-bounds heap write.  The
> top-level symbol tables are validated this way; the nested per-class
> permission table is not.
>
> Reject a permission whose value exceeds nprim, which is already set when
> perm_read() runs.  Well-formed policies are unaffected.
>
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes an=
d permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Reproducer and A/B verification (below the --- so git am drops it):
>
> A binary policy whose "process" class carries permissions.nprim =3D 1 whi=
le
> keeping its 31 permissions (values 1..31) is accepted by the parser.  On
> load, security_get_permissions() allocates a one-entry array and writes
> perms[value - 1] for each permission -- a heap slab-out-of-bounds write.
>
> Tested on a KASAN kernel, loading via /sys/fs/selinux/load:
>
>   Build A (without this patch): loading the malformed policy ->
>     BUG: KASAN: slab-out-of-bounds in get_permissions_callback
>     Write of size 8 ... security_get_permissions()
>     (followed by a GPF once an adjacent object's pointer is overwritten)
>
>   Build B (with this patch): the same policy is rejected at parse time
>     (-EINVAL); no KASAN report.
>
>   Control (without this patch): a well-formed policy (nprim =3D 31) loads
>     cleanly, no KASAN report -- the fault is specific to nprim < value.
>
> Reachable by a process with CAP_MAC_ADMIN writing a crafted policy to
> /sys/fs/selinux/load; SELinux policy load is not namespaced.

Thanks for the report and patch - one point of clarification to your
statement above:
SELinux doesn't check CAP_MAC_ADMIN for policy load since SELinux predates
CAP_MAC_ADMIN and defines and checks its own permission checks (in this cas=
e,
security:load_policy) for its operations. You need to be able to open
/sys/fs/selinux/load
with write access so that's typically uid-0 or CAP_DAC_OVERRIDE along with =
the
SELinux load_policy permission check.

> ---
>  security/selinux/ss/policydb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index ead504a639e3..6973b68d9782 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1175,6 +1175,9 @@ static int perm_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>         rc =3D -EINVAL;
>         if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
>                 goto bad;
> +       /* the value indexes an nprim-sized array in security_get_permiss=
ions() */
> +       if (perdatum->value > s->nprim)
> +               goto bad;
>
>         rc =3D str_read(&key, GFP_KERNEL, fp, len);
>         if (rc)
>
> ---
> base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
> change-id: 20260724-b4-disp-ec8ac9f6-576c3f177a04
>
> Best regards,
> --
> Bryam Vargas <hexlabsecurity@proton.me>
>
>
