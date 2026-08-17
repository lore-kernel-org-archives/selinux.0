Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077E3EB7E9
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997654; cv=pass; b=L7PGDEXbrV6KuSCeM3LEkqFKOsgzBJbFTV1uKkYCo6u5fAMV83jfeF1KU5BxceDO2JGyYV7js0mveajP0QRE1msOznClQlfVMMncv4j/L9FHs+KEGb7AEfDmXa13BEF/xLeHk0s3q6qf7nNoYCL4NI7NjG77WcK+kpJz51ZS7uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997654; c=relaxed/simple;
	bh=QNa08Q2Cmi6ATecl9mIfiKwnYfF/Mj5T+Csgd4B4DpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7qFGRhDnad7tMl8Gjw7uAMWF33w9rspDZ9A2Iamy6MJToa+Q0Sqt0JCmus7zhNjqSeZZ8NpoesPkMPwUCjsg4FKcfpeFyEIjjuenNCKJYSO8tlxms3GDTDZ71ooP6RJpZXiYiRfqafJFE06pXDW3FJB3zpwGzXjmVYQocK8GtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbMLJO3K; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbMLJO3K"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso2482603a34.1
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 13:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786997652; cv=none;
        d=google.com; s=arc-20260327;
        b=SsReeJUVj1rWVAZfFiAZn55jXDgytvG/VY45mzXjZkRyI+Vi0iyn0bvPn7+tzaLMaF
         ju5/uI0BmlzzzIk+H90LCIUHRBjD5MM0+q+Lzi14QglPjnaS5m/e3raisSacrg9vlpzw
         NfTybwaE0/vx5CHpS0hNgyzUz1gTa7REJme8ZQ6bGN1jx0i8u/3/nkX+PTstDN34pc2a
         oYvO3q/6vhPA1GURKnf7PvE4IkFObFTpZ96wjFu6AsvI+UHr0jY6Ft8GHSQhVkx0vQ6l
         5ufNqHXkH+kz9O+uTFzIz4/n/nQzCO0dsoiKWExczbfFSn5VflyrrB6DP90/wzHC+7JE
         Mxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCxTp1qib5FUKWwJZWRNU7Qfw9LQpfx9Wn4mSgpF4qc=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=YTdu+oijjRuAfRqdn5N4o5o0uSG6P1kWRFcL2ODN+xd+fMaCs+bf6MmZ4kpPLRZZNO
         hnATBDU4rznJuAXhoz8xzDHO7QQGglOYYp7xjVroekSWnBy15QEZkybQkZD4AdXUhRsk
         +1XnHQ3lsQc8WFi+TtJg7wSsWWlovR/o83fALZv3O1tN9d0hR6tGK1zGyiDB/RGUYCqH
         C18BGDuouHvyt5XfkCfmozJdax+yaGXMlBv5gZ0eUFRoBQCEkEakGW3X/AxTU0FlNgzx
         OuZuvmYNPaAqdfK0h0gctuh8wFSDYn4T2Q2CH2HyJ/915GWeSLMAlutjrJUpoA07nDwL
         ntnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997652; x=1787602452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xCxTp1qib5FUKWwJZWRNU7Qfw9LQpfx9Wn4mSgpF4qc=;
        b=PbMLJO3KLN+6EXOJ7G2acdRvyzxYH4G9xagZKvf5CTq3eI62N1WpVr2Rj0k9EJxchc
         3hiW1LC7zzZseNaN/2jUeXZXTd1NS4nRvheXH/rlloLpQG61RIhVyKbjF0rMGCgMrleW
         r2nQbRMn1UPcGzy+dKFgdVUGuYpOdjOTBvl6EM9kOP5b4fENZLgO6i8dxGazq8Jviu/Y
         32h5Mj75JGgK070/B+2C7KMuNFqw8q54z+2varWYjIz8HBx0ZQCgz5NNR0SEKPKig7sc
         NCX3wRww11NBbdxzPEpDrBE4P7k6bVW+AaCEcWpv6fDOzlUlgdeB3SXoLcinLPlqYFas
         L26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997652; x=1787602452;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCxTp1qib5FUKWwJZWRNU7Qfw9LQpfx9Wn4mSgpF4qc=;
        b=B39aDi0GXuhMLo6lW1vjWlnL4lUeGhwrJ8vbaIUkl3PnuMNzAFx5KHk/3HwXO/x601
         dGN3rYCwrIJXVhEdlEkZsfkabExIzbZn4K6sIXn0wvMtoKIp+5Jrkg8M9Jv1ivCLHBbj
         KUCyYCKE9Rc1KRa88VL/f64vR6BhZixPqAI0k8x6vdqunBICYKDURWnqMS4pnMbBFmf+
         jJMsqu7PHMAO+QQFntcZYCL2X+X4z4j2Nwd6oPSRJ8T3ocGRPs7PLUZO7luXev6wBSFa
         NBgZYl6s9ZhbQBpyCp3bP7g8Y+KY9mPo4Ey+nz6IPyVPdgWzvzBGi32y1AtTcrdV4MIi
         bQRg==
X-Gm-Message-State: AOJu0Yz1NMcZa7kp8rXPyTFdl6B71LLqkqaZiGbZlacrCWjS6PRUVoMN
	jH8loeJuoSK870u/wyIbB1JVZBG/CMQ2Uykl+fDxkjpG5yFSNSFB2Yt6CMBXytMpZr7NKLoxdag
	GWeI+jsdy0TCzJQjbd/LjujkbReWoWq27Iw==
X-Gm-Gg: AR+sD10BcbJwX3xfA7w3U/cWWWt2yHLF/85y3OMBK16cSdZLSS6HIAdteJaJzB2qgIR
	9a17S/laLBqf5obz+lzyr570mn8msVALLzCSPOkt9Qz7H9P69PkYqj+u71tUGoflmir2aWdYoEO
	ViebJlV/LiIm9ZQhb6MvizDD/BTSHtIZNDvDEdfRQ87eNQLltNEBPQAPDORh+YKEj97Bs/eecZ8
	MDhq3yLJl8JZTKLXVLPsHVnJKH37p4ylHehzLn9RHzzgK8WduAE4eRLzOb6YomhPAlfcXlHtPB5
	Y8TL4FFukXY2RvDv+9SM4OfWC/Hp/2htgmOvOYaBqBZrfQ==
X-Received: by 2002:a05:6820:1c94:b0:6ac:b80e:76b0 with SMTP id
 006d021491bc7-6b0d5fd2c76mr22900475eaf.3.1786997651993; Mon, 17 Aug 2026
 13:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814142717.204397-3-stephen.smalley.work@gmail.com> <CAP+JOzSLLAAWHbQFvj53F0uN1B0VYn2ZM=b3=jF+n3dXfx3LPw@mail.gmail.com>
In-Reply-To: <CAP+JOzSLLAAWHbQFvj53F0uN1B0VYn2ZM=b3=jF+n3dXfx3LPw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Aug 2026 16:14:00 -0400
X-Gm-Features: AcwNN1V8ruxZtE3qKWjLF1qlGU7dF5Kv_PbhMLeLVn77iC5rX6IwtjvyVubKp4M
Message-ID: <CAEjxPJ6fP=j9+YtoRoZn7O0WC+R29Mk9bMtCDWvzY0zxkqfx6g@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolicy: add missing socket template attributes
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:05=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Aug 14, 2026 at 10:29=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > generate_fc() unconditionally reads template.fc_sock_file for any
> > path that stat()s as a socket, but only var_run, var_lib and rw
> > define it, so selecting a socket under /tmp, /etc, /var/cache,
> > /var/spool, /var/log or a systemd unit directory in the GUI raises
> >
> >   AttributeError: module 'sepolicy.templates.tmp' has no
> >   attribute 'fc_sock_file'
> >
> > The tmp template has no fc_* attributes at all, so any explicitly
> > added file or directory under /tmp fails the same way on fc_file /
> > fc_dir.  generate_te() and generate_if() likewise read
> > te_stream_rules / if_stream_rules for a socket path, which var_log
> > and unit_file lack.
> >
> > Add fc_sock_file to every template that already has fc_file (using
> > the -s file class), give tmp a full fc_file / fc_sock_file / fc_dir
> > set for TEMPLATETYPE_tmp_t, and add empty stream-rule strings to
> > var_log and unit_file so a stray socket there no longer takes the
> > whole generator down.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/379
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Oops, Ack'd the wrong patch.
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
