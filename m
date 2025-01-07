Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535A18A6D4
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274702; cv=none; b=nBAJq4ToZet5hsI0QN8guEGoCHtx3nNLOZLQnBSbAOvWs/EE2y9KHTQTcaIAWCCuEsV6DY7ivG+RFzK/LtGf0VR66DQy8xV+q6rFN4X94SlaHYajOPPkQz80+Fv3uSyg1mG7G9FeQR2HB7claXP8FG2yhqUZVVejnry7qTgu37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274702; c=relaxed/simple;
	bh=taG9SanWeLVMrVH3HJEJ9Y68WDBKGzbGdgV9HsIndkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aebPDRmWlCBr8jZhvlw68Nnznxbhi8KLyqXMZkHHZqYXtEyf5sdPyPuQRVoS4xprfzdxV57AqpOsDQKBCEFI+SCqoNAxPzZj0nTqdYFmCR2L3SkmR1V3pzsoJSwAR956T7SFvkRmVnlehwcv4SkUuoniFhSVlssgmY0uOAjtM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmBSAGag; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmBSAGag"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so17893001a91.3
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2025 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736274700; x=1736879500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E46xFUC1dyNnoHtb/eIBmGy4LwsZKNmqD0kTnLLQjAg=;
        b=fmBSAGagKyF09Hwg0CYCtjWb50K5mNYR2mvoLsfTj4OqVM4MTvOtjjaalJ6alP/OvG
         3KzqM0Z+70TMx/kwQFTjUvAqpz/yDhJBnqiInN/FI4QLcWho7PQg0V2bbXcvACljZwdT
         vRZKrnYOrU70BmyfOonsA+1yBBdyf52YwJTqKsH9oQBykz0RwMeJHW4RvtV7LltNdez0
         XMepT5fcVv50BB8DlBF+gl1Eob1EXkj0nvBPIb/iVs0JdDS7E7JnrdmaisemK++6utql
         ppKEB3ojgsz8gnPu7MLxx15lrDqFCrH11gURTQtPh6FnvGzc96q3Tqak6PTCRwClxToa
         uuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274700; x=1736879500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E46xFUC1dyNnoHtb/eIBmGy4LwsZKNmqD0kTnLLQjAg=;
        b=jDwVJ+Bxa+3YpW53++/73ou5A+/U+QLM9MMKRWPoBuFAq/oG76b5qxiu8fHGjfIjpq
         EOS/8KTiFKoARisDQpEEcMSmxF0IMsGvRP5ugCiP0orZld4nM3Bt2FiL3u/XBwKJbxAi
         KE1PoCtnVfCniJid0XgtSh3Tund5QQ36/0QRS4ihgWFGrzNk+8cnISkBp8Hxtt17Ovlf
         VfomX9f8lo/Z/7ua2S83Ic7FXf7U68DoJLn0/+TjKK2A17pVxdrLXucddtDuIAEmg84j
         Hz4qV2l7XPGLPmSfyo8T/9uImWc/rIkssW4+QU1okH0bOL70Q43+Mq205veiRbFdWBHD
         1Vtw==
X-Gm-Message-State: AOJu0YxEGdimM0XQL9lw+hSG4W1H88/HpUm6wZb+GpGU6E0V2jA4ELUm
	fwYvgLJFaEwD87389gbdg/ko1dkSCt6aH00+18xAQrdnO8702vqvAzyKwuyj4ozFxcWnoi7TcAo
	Gon86IDhAgmtItM+sucnMYUYJwQS3+t89
X-Gm-Gg: ASbGncueSRkLTn+5EmgZBZK6QEAFXBBmO3BHMNQTkpjLLEdvHAOu2gHGE6HoCKC8L0G
	qIkqnV/Ta3dzwKKctPY+7nQpYfoUIrGpK2AEj6A==
X-Google-Smtp-Source: AGHT+IHh4DA7oP6DuUzXCF4CvuF5dIdvH9t5y/90YiNgH6zqVD7lR8w5WOO9VaJH29CpJ4TZlXnW5aEX0yVjQvAv3oM=
X-Received: by 2002:a17:90b:5245:b0:2ee:ed07:d6d2 with SMTP id
 98e67ed59e1d1-2f452f027c4mr94844123a91.37.1736274700112; Tue, 07 Jan 2025
 10:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com> <20250102164509.25606-45-stephen.smalley.work@gmail.com>
In-Reply-To: <20250102164509.25606-45-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Jan 2025 13:31:29 -0500
X-Gm-Features: AbW1kvYhr_qYujpEZJ0DKGnRwM7qmtZJXekuBbpd3NvTHoKYn9DAX-CxKkoDOQ4
Message-ID: <CAEjxPJ6aaa9t7uZ1=FSm6C6Xy4z232UNDPsSbDFz_pEORjKFFg@mail.gmail.com>
Subject: Re: [RFC PATCH 44/44] selinux: fix inode initialization when no
 namespace is initialized
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit e8087cb36d3d2c6eab77 ("selinux: init inode from nearest
> initialized namespace") wrongly assumed that there must be at least one
> ancestor namespace that is initialized. In the case where the init
> SELinux namespace was never initialized (i.e. no policy loaded on the
> host), then this assumption can be false. Fix the logic to defer
> initialization of the inode in that situation.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Note: I've squashed this patch, the cited commit, and its predecessor
since neither of these have been merged yet and they are bug fixes to
the earlier unmerged commit.
Updated on my branch,
https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns

> ---
>  security/selinux/hooks.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a6c980f9117b..da8f76707c8c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1441,8 +1441,14 @@ static int inode_doinit_with_dentry(struct inode *=
inode, struct dentry *opt_dent
>         if (isec->sclass =3D=3D SECCLASS_FILE)
>                 isec->sclass =3D inode_mode_to_security_class(inode->i_mo=
de);
>
> +       /*
> +        * Find an initialized state to use.
> +        */
> +       while (state && !selinux_initialized(state))
> +               state =3D state->parent;
> +
>         sbsec =3D selinux_superblock(inode->i_sb);
> -       if (!(sbsec->flags & SE_SBINITIALIZED)) {
> +       if (!state || !(sbsec->flags & SE_SBINITIALIZED)) {
>                 /* Defer initialization until selinux_complete_init,
>                    after the initial policy is loaded and the security
>                    server is ready to handle calls. */
> @@ -1453,13 +1459,6 @@ static int inode_doinit_with_dentry(struct inode *=
inode, struct dentry *opt_dent
>                 goto out_unlock;
>         }
>
> -       /*
> -        * Find an initialized state to use; there must be at least
> -        * one or else the sbsec won't have been initialized.
> -        */
> -       while (!selinux_initialized(state))
> -               state =3D state->parent;
> -
>         sclass =3D isec->sclass;
>         task_sid =3D isec->task_sid;
>         sid =3D isec->sid;
> --
> 2.47.1
>
