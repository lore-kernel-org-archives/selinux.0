Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E72D7D3A
	for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300014; cv=pass; b=VScyjAI0Y3+KjeoML0rgRD/tqDt9SorpzQOBpbyHJI6+dqZLUZo1pv5Wy6ByFkZ7KUMevanp+oJhvlG5qDf/DsNlV3Obpclzx+q8SMotWwdyotWVIxfGaZcwV/seF0fDU21COsFONB0a6DJbuORYpJaqMAMktVMBMh2u/VNG25E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300014; c=relaxed/simple;
	bh=lj1WSksNK02aO4n5dob09BxWp5H6I1TYco9D2RasOo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAFFWjG96DsAsyZIsbvyGztLj8/x7REPJDMwMzMbjdGAlzi+EuPcCjRGVOIbFxXHuvaHQnRsqsxCow9kiP+E/ozpbfOOn5gwen7nc2iSvB/EXFCgzyFFuV1QW8gUqu2Y47fwuj/yK/kopPW1wZSgtkihmFfdE6YCvCRjepkM+pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBtcS8Hv; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBtcS8Hv"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1330021a12.1
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 14:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774300012; cv=none;
        d=google.com; s=arc-20240605;
        b=W4ofKWulH5wfMfpNnDEf8zeOdlqLfBG+QbOW56n1E+Q2dgAXoF+sDOoHf9mJyRJkyk
         g8/48+HTBasLfGhPLkoQeGO19CcYlEwwZklurdpRSdoccGls+49VOG7hpKWEmSrvm1QM
         sORMxEtkcYIwyFp73G6U7e0Y59qIC7Y70Ev9+rx2S95ILV6dIFagYp502wEU7MMGNp0X
         U7y2HPUOoJ5FTSxGpHv2frNX8cijUn7KeBo0KncReL799+wKSMpoPNVdd6NCbuF1TNs0
         VnvYmlDUnhGXwh7NeClG+w3JC+PeeLlhjWC4bTkao9tMPFw5NOQd0oA66iT5rY5YPelz
         FdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        fh=GFstXX04doMu9oqUhj1udRjhBwQrTWo0CZ6DkWAALaI=;
        b=NN+SJedB6Aa7gfpl6gVj2Tq0xh4c8BxCE4LNE7PSKxvZaOCGvna79ChiH0ykJIcrMQ
         iyZxbDjiLy64KSOTWyMyjEIDfqKnwfI9ieVq8XbLKfhIukkJtiZJC5+h2kiGk3g5CvDQ
         6IBzGr0vdabfXJ5Qq+PV3GkTp9bqEZTkduZNNDdcHgHSLoDhqrAte7530uTMfJ6pjoxJ
         pCIDTTJVLMalDJxx1jaZGE/GmYS1R/+xqeMIJD+iKnt3HG+rAdouAYCDP0nOawKMW9yI
         U1kkaKJR+wFnasWffKIUwHl8x9O3Q5H2w2JTk4EpMGSMCtuURBQC32imvcCrax9W7gg6
         HSnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774300012; x=1774904812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=QBtcS8HvpXO9IbViIwHmSUEd1cdHjK9S4SFD+KrQZ8bhDITcqbTe3aRVCdBgTe2A3n
         yPEMyrAXW1HDf/yOqvfhmV0UV6nsguDlNnwsiu12fdLFTcyQQDeLoE4ppjSujK/vYbur
         6Vh4bHjxQOGvJNvQcmIiGYefdfM6j1bAXms/E3+nKb3ABshNU1uhN6kg/vVgaD/GcP3E
         akpfjZl48gVESxxOIaGcrKwYKHddzWZAykOpSpFzHdXM1Jum5FB6rgUjQu+UPGDg6Q7/
         V9guohjp86bKIOaGeatTnM/vNT8vs82Ng13J8AmyBqJbn+u0bMDJq0vLUZtTY+smpY03
         GnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300012; x=1774904812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjsO6wgNY9CZeU5uk59dSPA1jA8p7uootZu2+ykxgC4=;
        b=oX3VIONYP/jCLjg+f+xDDhGHyw7hgaAleJo6odb32ZmPE6EP/IWgsiTqRT+avpR9ek
         +HOrKA0IJ9ipDNirdVtxlZPWVg2/rU2z5hyxqNaKt0a6wvg/nrtwGgAa0sdVXR7UybFF
         Uu7DVSGncCEI6OP3LEyAO4iQR11aQxRHpODspn8LFsD+CkpREd1GdMEmLrVvz6sW910D
         nEicYSvCSdMXrqU8N1LzIDyReBi0nwG8r6KP8SMZQb6vQ/vjFGKZV47VKIs7G2ykWGlY
         fmT8YQhvqooGWugOEuee6OKVNm0z0sCUwZUHz74sZcf5rSZX4RAbMq2U1DIqTMH3tDuT
         53Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3jq7W1WT6d8V8AlmJ+UAe8n9eytKPPXLGGjQrfrkY16QP22i1oAy5B0DQFD9jFMfAZMlqSqc@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkvaYS790ktk1wEp8J4OfXsW1H1xmo73RuojQWhU45C7yO27z
	x/1oEWRTFl4h3xMnjR8aqRA+XN2ucMWTO3HIZec8ujPcKMVTOIuHyS9IURJCMmyqdvok4GrOWCD
	NGQMh2FNTdPAEvMsSP0+Q1VhWiyMWH5BnBMWDAktW
X-Gm-Gg: ATEYQzxNBPvHpH+2B/iv20Hd0rhU6tbLwiDs3RRhNH6i8rCb1lxZc0K/UsmU/22kzXt
	8/CNwfLHVpCAMj+9X1eqb3vh3wk9gQDDxHKhcKdYTxFKILQ9ehh8AlAecwidowKnUdn+sQ4SoKG
	Xq8HrLXFrwnvIKwDmZpt90lfStlTECfv5i60b8RPAL4yKiYcBLR6XzVBy6n7w5JUVAKXOB8iRDO
	95EZ4TmQFQQGoSspwt5LqWipsZemd4a9PuPDG2Bm60bmy3dfFd4Iw+pz/n/DseOVzDXceG3PPSd
	6kCy/9c=
X-Received: by 2002:a05:6a20:a124:b0:398:9923:749f with SMTP id
 adf61e73a8af0-39bcea1d2c7mr12205176637.20.1774300012580; Mon, 23 Mar 2026
 14:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-6-paul@paul-moore.com>
In-Reply-To: <20260323042510.3331778-6-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 17:06:40 -0400
X-Gm-Features: AaiRm51oMol5rD-3lC5JmUxYQEOgP29lPad5MhWEYDTptj6N_TPcJrob_X8Dy0s
Message-ID: <CAHC9VhQJcuA0VTpGSD0-x+Z5a__SQBiYfwc9zWwLMDa6THfKPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:25=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c          | 252 ++++++++++++++++++++++--------
>  security/selinux/include/objsec.h |  17 ++
>  2 files changed, 200 insertions(+), 69 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d8224ea113d1..2a3d524dce24 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1745,6 +1745,60 @@ static inline int file_path_has_perm(const struct =
cred *cred,
>  static int bpf_fd_pass(const struct file *file, u32 sid);
>  #endif
>
> +static int __file_has_perm(bool bf_user_file, const struct cred *cred,
> +                          const struct file *file, u32 av)
> +
> +{
> +       struct common_audit_data ad;
> +       struct inode *inode;
> +       u32 ssid =3D cred_sid(cred);
> +       u32 tsid_fd;
> +       int rc;
> +
> +       if (bf_user_file) {
> +               struct backing_file_security_struct *bfsec;
> +               const struct path *path;
> +
> +               if (WARN_ON(!(file->f_mode & FMODE_BACKING)))
> +                       return -EPERM;

Based on other code paths, we should return -EIO here.  I've updated
the patch, but I'm holding off on posting another version for a day or
so in case anyone else is able to take a look.

> +               bfsec =3D selinux_backing_file(file);
> +               path =3D backing_file_user_path(file);
> +               tsid_fd =3D bfsec->uf_sid;
> +               inode =3D d_inode(path->dentry);
> +
> +               ad.type =3D LSM_AUDIT_DATA_PATH;
> +               ad.u.path =3D *path;
> +       } else {
> +               struct file_security_struct *fsec =3D selinux_file(file);
> +
> +               tsid_fd =3D fsec->sid;
> +               inode =3D file_inode(file);
> +
> +               ad.type =3D LSM_AUDIT_DATA_FILE;
> +               ad.u.file =3D file;
> +       }
> +
> +       if (ssid !=3D tsid_fd) {
> +               rc =3D avc_has_perm(ssid, tsid_fd, SECCLASS_FD, FD__USE, =
&ad);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* regardless of backing vs user file, use the underlying file he=
re */
> +       rc =3D bpf_fd_pass(file, ssid);
> +       if (rc)
> +               return rc;
> +#endif
> +
> +       /* av is zero if only checking access to the descriptor. */
> +       if (av)
> +               return inode_has_perm(cred, inode, av, &ad);
> +
> +       return 0;
> +}

--=20
paul-moore.com
