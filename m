Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0E33A014
	for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749389; cv=none; b=sUb2CmMCnKyWDLbx0sOs9V741xdgz2b/+WTa1tkv1ZHzxkiLfxhSaBg1Fj9TBhROWHQ1MMQf3DOR5irMFxuxl7MzK8tKvqUqvjgeLVp4lxWVYxKOwZCwklP9VqygCH/gaZoKPld9j+b6dFx1mlfuQ3yI0K1mODFV9wX7uaUfywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749389; c=relaxed/simple;
	bh=N/H9Hc3aJwCtzPmRJOck3fIp82+NkA0LZ9tUFRkG0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7tKharKw7ARa5d3KEe004pslVoo0rYR5xoxfcyj4K8gHX9kS1JOsrkMTbmb7Rq4c6eh8RpoygN3Ia2br8p3adY2pwy4gy6Pij7NtJ8ddFMcas/m77xlXmqOMJ+5iFAWo5BQqFJKSPUJGreG8vcbcN+eqW1m6jjCqbg/jEL5q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQrNdVj+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQrNdVj+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32ec291a325so5742511a91.1
        for <selinux@vger.kernel.org>; Wed, 29 Oct 2025 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761749386; x=1762354186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=fQrNdVj+n9mN+TjKgSWKOurWOx8bbFjjcpGc9rbYoX0l9pVxeVS7dwbebPzO7EyMNY
         X2a6Ew+yUq3XXoV/wDq9lkypSK+BYom/rU7WeWRWYvwk9ud2ZvZAMsTQBqg7to0voVyE
         NWPDqGEFI4ycZ4bfSeWBglO8aPeHliM7090p3jHq/UYBn2TX8A3J0QsThKh1Ht7dMrwU
         sdWywmc9wuO5fUMz26trsoLjWgo5P7gJSrB6Xfqf+DBYqgz8bPGcaEGWivFwD1drHXXf
         CRZ7/nRNpUUvgNm2zoncIx+LpnHqQOmwhHcuMIuiiS88r9eKzaxFewWxm80ztiA9EXIT
         k9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749386; x=1762354186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=e7titl4OVEwuWWJ8GQjXenaUlb5lNL84T7F0O70S1bv+E5w1TmtgOpytz6ThE+WgqZ
         N+yNdTKPISYty8dBktyviE5NmB9VgpaT2fEcAsPCBz//JD2OsUH0/0v6Srm4EFSHAPxC
         f3QL9qAOFP/BkowSFvVcHxP3gSW1tjDIKoDO6ewh4FBToBbh7B86c8HDKUM93YSS7fvN
         Kmc/y4vdKanrGM0O2oP6nqsxm2o9H7NVmGUTDH+oHtBXcILD+2ujfcySOT3WWOtDaCY9
         SfoojoGJdchc7dwYxkFkjdMSOzQx/uBtOF6q9UHj8N6Ctw9mKnSegW/n45jbB/y56w2P
         zR3A==
X-Forwarded-Encrypted: i=1; AJvYcCXwYIzzM5IlbuZzj+b5+dLv0VEe1kdPZkmIPZqz9gsqdr1seUeFucnuE08YEV+HctY9OXvmNRUV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HeovVgyGvGc1hS99n/DqQL2H0EYyj0KpQZqcAY4x5Y5VcnLd
	bP5xoGOkctSKoH4xw4uSIwfroT3UzsajoYt3K9vsfPaca/iBYWnMA2VEYYw5l3+uJYob7XngAbW
	Dgi5Ngnk46YUuV4YhlNynIs/HWy510Zs5bOsCOWUs
X-Gm-Gg: ASbGncv8MyEcja03y0IuT/je4VTpthc0FzV1F586mZ29uIR/dPXBZcJrj0ympVy3fWu
	thJIyx9Zr1kxJJDV4YAR9AjU0MYNcDuCcdn0ktQQt3dgneqamNYGhsvvS3ADRGQoDmO3jO1iRxy
	cpgg37si3ZweCerzcFrh0KiHUOIFaTC9XbCc3DpNb95ESbCMQ3UkFg6GH6P6sehPOPljNuWqkS0
	YUGQNwWXMf6KJ440982so/fuGLqRbRuv32Vv4e0cWMt+iVDkGcKBtT7y0JQ
X-Google-Smtp-Source: AGHT+IHiN2wVay8qKwNUCQNQedszNEqWD+gbH8QhJy+T+EtTl6Gz4GwA6YgaiehmmoZJBoAentF29nQI5J4sc3vsbuw=
X-Received: by 2002:a17:90a:d64d:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3403a302f52mr3761415a91.36.1761749386246; Wed, 29 Oct 2025
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-36-viro@zeniv.linux.org.uk> <CAHC9VhRQNmPZ3Sz496WPgQp-OkijiF7GgmHuR+=Kn3qBE6nj6Q@mail.gmail.com>
 <20251029032404.GQ2441659@ZenIV>
In-Reply-To: <20251029032404.GQ2441659@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Oct 2025 10:49:34 -0400
X-Gm-Features: AWmQ_bkw5gzRbiAC20oxF8nOixccAI_lXABYmuYCSfnezye7FZYc2Gs15NqnG0I
Message-ID: <CAHC9VhRefx4MBDU78Qob7Pe2pDLK=1HK4b2EuTtENVssntHecQ@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Tue, Oct 28, 2025 at 08:02:39PM -0400, Paul Moore wrote:
>
> > I suppose the kill_litter_super()->kill_anon_super() should probably
> > be pulled out into another patch as it's not really related to the
> > d_make_persistent() change,
>
> It very much is related - anything persistent left at ->kill_sb() time
> will be taken out by generic_shutdown_super().  If all pinned objects
> in there are marked persistent, kill_litter_super() becomes equivalent
> to kill_anon_super() for that fs.

Gotcha, thanks.

--=20
paul-moore.com
