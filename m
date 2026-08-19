Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76B476CF5
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151256; cv=pass; b=obzICIGjQvK4T5IcjqB50Srv0/Coozo0QrEjCx4XWBUw1+GcqnJCOY9bcoVhsxIU9UeV8nVU2zQqcW7tXRDAU9e3a837vhAn3Rt+87Ou2YCriOdMdBtB4dVb8dpxdcW4Aou9LFLOq4ea99PSFrOn9JIZaoqEgbvUx6YQv/LmnX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151256; c=relaxed/simple;
	bh=clj9gVhyrc3C/LsH68MWAJPwJ+bILDAgRbfld8wd5YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQoTy5VKj4csxnrueYJrI3AP2AzhGxeF4NfsIn3V6k5/x/JxbDuvtW/LHVIqfd2hjWQhLfHzjn/op4fp4CPiY5CT7EEf3TU7RvAyLKUKuafv04JZePYZ3/nlG+z/LvZS9FOj9IdgHA7qbkmTgGohOCtD8B4Sz/Dt/arOdBPSOPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEJnXZ+p; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEJnXZ+p"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-456395f4e7bso644824fac.0
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 07:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151253; cv=none;
        d=google.com; s=arc-20260327;
        b=BehWxrWUpiOxOhCgIjGCt4mCUYZ6Lar3sQwxVT4ACJA0Pmd+4C86Wg2SMH8VZ6/+ZE
         QMuqbd6YhdXXcZ17MBtEHBrEuv3xmlWtsq2EMm7rtFaBYDMrFtWvCCKPBz5opV6K1x5T
         djF48F9Zewl2medbo4pPE68hY1WPL4g86tR+szFiPQA+Vt3vtmq8LN4jZ5urnJB+9JWF
         wb4snSn7u9xd9oVjbyWmCHSHNhFjpjtsqDOm1/sXh4Cm4P695jiqFkYMojEc1Dc8zbEB
         JFODDLoS87h42iiVRex9te6EViJWxHKXXCgOhBeWdtd2sVqb7BsLGH2LCPaQRto1AZ2l
         SW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhvw/FgE5+XsocfZbB7wjswP5NddcYAmLYZePhCxoG4=;
        fh=xoxIIyheempzhFZ6DTqUboEb5IaEB3eAu1Uxv59ZTxw=;
        b=J1mznm8NLg52sLoO/7dMHCY/XLiUNNmZ9/LwnaqZgA7MojPsnz1FSFc8HTw/Ft4Io2
         /ODM3VJYTm9MoHSMW5LsoTIKdl/iIYAryObwE1YbpW8y/I20g+1fAYX50ZVLe1GaFigQ
         m+1Dcx9K7RISLm0ZKGHXswXwNkJjdPd5MPvSQPYjBYfUJcxnWaba8omkPDThxPvuS6v9
         OHHWwHGZQrnhSN3TO1ZGpl1iyPYVziEqZzEzDagMgluj0p5VNg+22+yzGJpHMVsfOO5s
         7Pv4DFPmyxRIFToXP0sidZpnMoEr2d6T1Ph1UnrGlsCLiZ/FM+TBhw1JCLdJu1CF7hiq
         6Cbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151253; x=1787756053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mhvw/FgE5+XsocfZbB7wjswP5NddcYAmLYZePhCxoG4=;
        b=kEJnXZ+p3aEgGtxvkXqv241S8crYaqUSvDgZ2N/hyIR1C3FR45l9KF7LYgaHvla85S
         eRTQ3bMK1JZubAirYheCrnIrQz5suHLxyMhenkXL+NBeXVjxLgHBrZyWgVjgOQZJ3mI8
         /9G+7Vt3bXl8JpFELV8SDHAg2gXHhFyJTkJAZv0v1pojM7q2NEUQmgT+P0/wLDUx+MNr
         h4mfdWI5Ren3y3bMnCNzqZUIBIzRrviC9bFe0axEgesJ5umEa9F/+aFZpJg6hpEE02Ju
         1Jy9Jk1wewUStOCxGyep7fKyeNh93rrFR7/7bS/V9OYNiqyH6hyo0jx/NVUSJymB0i8G
         3jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151253; x=1787756053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhvw/FgE5+XsocfZbB7wjswP5NddcYAmLYZePhCxoG4=;
        b=kDLhv2RHopx6sJJGxUZl1Zynru2iwkaASj7ULvyQTTswBidel1kH3v2uIPPIvpiaXJ
         nnaXtOLHS/KuCIQ+ReuKQNLmDfUUuMBxF+bcepV1BE6OhcG+EE6ad8/1cBSlSZa/UJSi
         3H873vnTyx7omgFQ9YtVnrzeXtvmLMG6u82o/XyIb2MbzbtFs3+Qo63M/rpvwT35adTM
         BYUnBrp5zN8tPu1ib7W8mvKOhx9T2e4TZFQmC86vpAYPby5Z7zHMFHUx0zqWKTGdSggD
         EcKHZJsNX0vbXQfeFRcwhRwsJB6zImKDUU6q4cq9JMsuToucTCNF1gq4j4eUBXeSb35p
         03Qg==
X-Forwarded-Encrypted: i=1; AHgh+RryhKlIWjqt5G2fbPj7oAyJFE9DqCfQ9bgpq78yUxdePyMiy3+zFPebhdVcILk0M2YStRZN+pQb@vger.kernel.org
X-Gm-Message-State: AOJu0YzizCdF9jhD17FRLrtSHadS81todixGzOseKYXb7SCJkJ0eDkLO
	pwZAISGpoks/cyPCb7Wiw8/oxSh4pThkg9KR1HjvKlMC+mLxOERqBLMoG/e/nozsgo/ys+sWpoP
	o17rfEfCBYNgFE0eJZfT7/7aY1ABZ16A=
X-Gm-Gg: AR+sD10u8IrC5RmJFa5dVFlZhxVHzN+tlUz6zep4LiHCv4osJvTijwiIl8ypfMGbj0c
	SnxDHLCCkt/I7M3+VznZDQNaLo8mQ1tNDB1rYWAPFQJM3s9LSfgR0h++RqZpvFzjmLxR0sFioeW
	XEgeO+wFBkVU2+HZ6qlHUaPZKyvIPS4MyYrtozweLu2UtHrX69LjLcPoEA39MJ8alnSR73tk7QZ
	dkmnMMlnkKqgw6/mCwaGj15Z9IiwbSU2PbOVCyeC3SgYgLlUvRWKwqoz2K0iAycyW3eMjnI7S+G
	mgwCGGic+ovU9pr4oh4Fn0BIfJe6ifHQBIhkT1ZpgERR
X-Received: by 2002:a05:6871:287:b0:447:a201:4a5a with SMTP id
 586e51a60fabf-462f64be287mr5194131fac.8.1787151252623; Wed, 19 Aug 2026
 07:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com> <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
In-Reply-To: <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 10:54:01 -0400
X-Gm-Features: AcwNN1Vv0YORuTgO6puZkVyho68XY6ndF-y47mMS-AkDlVErDtFxI6gIHPST0Qw
Message-ID: <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has one
> of:
>
>  - EXECMEM (like for other methods of creating anonymous executable pages=
)
>  - PTRACE (like when using /proc/$pid/mem of another process)

Allowing it if _either_ permission is allowed is unusual in SELinux
and seems prone to errors.
Is there a reason to not just require PTRACE always?

>
> This closes a hole in EXECMEM enforcement that Project Zero has used in a
> remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without EXECM=
EM
> permission to overwrite executable code via /proc/self/mem, which made it
> possible to load and run shellcode with a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..905137c47321 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_stru=
ct *parent)
>                             SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>
> +/*
> + * Decide whether it should be possible to read non-readable VMAs and wr=
ite
> + * non-writable VMAs via /proc/self/mem.
> + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, a=
nd only
> + * triggers on accesses that are not visible to selinux_ptrace_access_ch=
eck().
> + *
> + * This allows a process to overwrite read-only code in its own address =
space.
> + *
> + * Creating an audit record on denial doesn't make sense here, since we =
can't
> + * tell whether FOLL_FORCE matters for the accessed VMAs.
> + */
> +static int selinux_introspect_mem_foll_force(const struct cred *subject)
> +{
> +       struct av_decision avd;
> +       int rc;
> +       u32 sid =3D cred_sid(subject);
> +
> +       /* Allow if the process is generally allowed to have executable a=
nonymous memory. */
> +       rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__=
EXECMEM, 0, &avd);
> +
> +       /* Also allow if selinux_ptrace_access_check() would allow it. */
> +       if (rc)
> +               rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, P=
ROCESS__PTRACE, 0, &avd);
> +       return rc;
> +}
> +
>  static int selinux_capget(const struct task_struct *target, kernel_cap_t=
 *effective,
>                           kernel_cap_t *inheritable, kernel_cap_t *permit=
ted)
>  {
> @@ -7558,6 +7584,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>
>         LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>         LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> +       LSM_HOOK_INIT(introspect_mem_foll_force, selinux_introspect_mem_f=
oll_force),
>         LSM_HOOK_INIT(capget, selinux_capget),
>         LSM_HOOK_INIT(capset, selinux_capset),
>         LSM_HOOK_INIT(capable, selinux_capable),
>
> --
> 2.55.0.737.g08866a6d13-goog
>
