Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831434CFA0
	for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857007; cv=none; b=M+jufKa/MOmDaqZJCQS9rtiZxQgIwqhHHi28kNcFZC+femW2WhqmZwDqQ9J8CKs0I1ZA+4BH3GCtwgU0dwgjNpKh+WHwyXJNMs4WLf4PbhVgTYD85/6nMkAK5KWCA+jtI8M0NsPXFkfDUEfr/YdOxLDnsDD0czXciqRF66KhtoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857007; c=relaxed/simple;
	bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO1z4s15oDQWDYmM3n4uAHh7lSHCbYdpUj5pAUjZBome8fnzHLT11cZJpS6Ihz5R8aKcdPd9HVejk5t5YnVxYWlrVxRKzg3IQNiJSCkNBMsKMEIbiOK3Cbq4S2bxbSBaM1/51bD9QhOC8p1B3Nn5U1bx5eJ4JZjjHoe4x6vAZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q4HHA45X; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q4HHA45X"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4edb911661fso18901681cf.1
        for <selinux@vger.kernel.org>; Tue, 11 Nov 2025 02:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762857004; x=1763461804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=q4HHA45Xx0xTDskll4DjSU6SWhWolRSlpTtA8cDnYPTI/9mbRIiB52rjVByj7Xz8ay
         nFP0//QDDttEQdXDUPTQYuhtZxg4E9Z6etcMAQhjvLkWtzN7d8du6hlQT4fTRYhV57g2
         fSGQ47hY+Biwn3/0+lGUjV8ol/iJevVJFrQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857004; x=1763461804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=l06K1sw/erQo88LnMxvpHafmT9wxSQEmN5UHTHSx4OpR0jwJuuCyq6ga1LQL09MrET
         qFYtliZt7m665pqg+28Wl2d3JnjjqPSpHAh9J2AGhJKe3A71MBMIjMpq5yr2rsh0O8wr
         MhnrHlK8MohP+0pO0l+WFAfn51zE1LBuYx3/v5YKfRw3jbpR075IuF5yjGFIvBXxR5ie
         Xv+PUWhJ24VreHNBjnC5RCBYYf/6ssXcM4MVFnC8Ortcj4y+lsgRj3D33r0gPF0lGxd/
         M86E66J7isUtVLGXu8z+aCADMfRkPaeiZz/dpGwmIcnqCTys39yb1uMDWuqiv0t/B/Iw
         QTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+TaBv9QqNcNW+qmNYneHg0A+nPGhZ7lAkH7qd3SMezlxXHnAYMoOSLSIqDBG/ho4WtOTzkl98@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0Vyypa5rdS+mxipqOHtYqBW2njwzfscyj33c6juRIFtVkH8Q
	BPH1aJ8Xi/R4z6bhLF57ka/bVImJjCiD41pegpzt22P/ICaj6k/WJF6DGxRWN20D/lIqs7EjNvU
	4KU0YCUrSQWpco6HsmUZnPc7QMe5XKCjKE+BKNLXwUw==
X-Gm-Gg: ASbGnctodmsnKss5eh/i1MZFR/hwNz5UdnI6wk8di1oxtGw9fhQ1CyCApqz3W3VhxfX
	zaf1yrHfRCN1QSD8gwNgV5Ltc624w/OejLwcpefxuU6vdy7b3yOerh/dU9MTNCkDps4qLulPK8m
	ghmnuSn4XJXb0pnwYt87X5Zh5yEnTrSPz1by066rxK9A3E667mJ4w5kz6J2bJuYyjjPaouVFCf/
	jRFiaVOnHI1SHY9P17dyUErqPr9fo0/2txytV3lPGna64h1iX/+/zJkbgaoLN1LZrezJg==
X-Google-Smtp-Source: AGHT+IG1vPc79jE1NxMTWUcAkMOFXJ1dO7xwNLHncVzXeQGMi6M4ZcaWG7wZ9Wn4xgn8RqaQcm4UKxcrnMz8XFw/71I=
X-Received: by 2002:ac8:7d8b:0:b0:4ed:b378:145d with SMTP id
 d75a77b69052e-4edb3781c5fmr87056701cf.45.1762857003684; Tue, 11 Nov 2025
 02:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:29:52 +0100
X-Gm-Features: AWmQ_bnbS5BGnOdlDcNli2J3_mWe2QdNv2AalQvWZZg8jjhCbQzLKZqYiVdFPQQ
Message-ID: <CAJfpegv5eZK=70GEdbofg8u-CKS7gL6Ur5PD86Ay4h3Z8D986A@mail.gmail.com>
Subject: Re: [PATCH v3 03/50] new helper: simple_remove_by_name()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> simple_recursive_removal(), but instead of victim dentry it takes
> parent + name.
>
> Used to be open-coded in fs/fuse/control.c, but there's no need to expose
> the guts of that thing there and there are other potential users, so
> let's lift it into libfs...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
