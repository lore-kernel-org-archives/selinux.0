Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88E30FF2B
	for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465017; cv=none; b=bFcxiDJHjBVmWcA2M8Elbp57pV9MgvKbssg6PxI44/IPiFTZgc9nTkFZAgWIohp5UKbM3BA+3mzuMainLYK/Z5f4umIR7iUOFjlwGAyzTLkRlaNLeJ9TybXGcC7KW/NGweAYummO6CeCgunO0lKioE5pYtXn90cb3fz7sS0JBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465017; c=relaxed/simple;
	bh=4JhnELOzvG8e3FT52auD4scH9nQubd86lYx6BkLcuWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQfeb/gHH27C/7OTKZnIseVEiGF7lolrTUgVRNcypKo5i32rkS0/oSquMyjTEpfY7A+8TixyU08ched66V7UOvCtgW5ygxrw21eaL44RsObYsiyauCLyh9Ln3RJGPQzo2unAcfRBrVzMp8hBULnbGJIsX9nJZ5JXzT6D5Fl5Nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W+mcKVMq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W+mcKVMq"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so628795a12.3
        for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756465015; x=1757069815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6MPSbkVIlc+V387DVzsSzTxYHOue4NoSXRJwOKRRC4=;
        b=W+mcKVMq+nWiUQA68i2gIqIOl0K4KWfARp+OVsi1I2sDcmLkkOXsewgYzs5PChRSKq
         x8xxtTqW21eQqjSAGsjjA0NapSNsq6XbS6ba4r9j8X0YT99dO1V/rIFZCOE/iBgAxuF2
         bxxJ5SXxoUTX5hu2hOMJjGpsjY0ZTqbNQ1XFdgYyVU/nwEW8rzZiJYItSxilp5GBshIu
         K1fPVY3pibILmSfsRyJb2cFMMl8MIRSrZKRT23xrMnXsxzdm/wVQvnvcLvVfnw5Hagdf
         1I+CutVJFYSRLOW08yj7uKd7aEuhu9T37Fdremp9xrKVArLaGnErDGzRAHvNnbLpsSz7
         3mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465015; x=1757069815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6MPSbkVIlc+V387DVzsSzTxYHOue4NoSXRJwOKRRC4=;
        b=VT8I88XyTSXg6Mi0mKQHZlcvfkG3snH/ZBXQvOiD2xVlKY5esFoiVsISdeMV7Nqx4q
         1wtKhXYCRtgJt9zghTkgUE2LB608V5Puas8le30/hZsvMCfLAv6o9UdgbDZ69sCCExDR
         6RMnCa9wptpfJdbTY4ufM9wuNWXewHLlEZIjo17md9ZAjnZLyt83SQPrDg+F8SVY3+HB
         Ak960bvLoXcFKIUtJdLJUQrZuCqrr4U5vpHWDoUFNIza9an+GZpqDRomHyKjugSJGbOX
         5ZKqmN1JLvG7WwYEA4KaLAxuuv2IoMzAindBi8hQgywXZgveg+/+jlD6weYUhNAD2rdb
         jWGg==
X-Forwarded-Encrypted: i=1; AJvYcCX9VODEfhk3F7TRm+o+CkMNlcJ7MDFptSXV7ojbkMM4Mb9N+LYXc+Yu9yEYGlrYNDGk9u/hkGNV@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFP9xmaq5UqGK8dXHxMJIc0voA0cQGXMgsBJdBEySCz5qQdu5
	XtvmpXcosVcMxl4eBNCrE1kb3ip/kSny7djF6eIfkjeU4VZ9I6PU6CU83raPrZAzxO5yWXgx98p
	mp3+Ys1Xz8Wx2UjCjGP/9hXh+/RH5gYpNxhQP+w96
X-Gm-Gg: ASbGncuifmhvmhDYW8zUCPP8Cb6ETYeDO5geTGVVLGwawaOOroP7kvn4XUUfq2D+ls4
	MpzP9Pzk96igpv1D0sqya22Rv7u19RohWFhYbgk2KNrXhqWGnqizFEX8zy4b0CeVQJ+DGwQo6UO
	6ohZMceMHJQSziuICxHZGYY5Qb4GkDZ4JPf+TxgZXqn3q+j5tMv8AQ+mb2cproV3J0G6dAmX3HY
	jc6CHiHSMqauaoeKeE=
X-Google-Smtp-Source: AGHT+IGDPrqU3qCXUsbx1z+D7spAudal7m6VvB/YAbl6Q44JNBA1bTqtvYkoa8fRk6dewuZp4Ua7WUer9nRt/kc21go=
X-Received: by 2002:a17:90b:2f87:b0:31f:8723:d128 with SMTP id
 98e67ed59e1d1-32517b2db8fmr34283941a91.34.1756465015189; Fri, 29 Aug 2025
 03:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <CAEjxPJ6G2iK9Yp8eCwbwHQfF1J3WBEVU42kAMQHNuuC_H5QHNw@mail.gmail.com>
 <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ70O5SY=XYJKrQDLkHOO3spD4VSjYCv0LkhYKCvK=GP7Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Aug 2025 06:56:43 -0400
X-Gm-Features: Ac12FXwA4RT9c8sFjxx8AgkdJv47bPShawvWIx_UbmmXOiQU9WoRBN8gx-RGKJY
Message-ID: <CAHC9VhSkBSyHRRimb0Br9nJD02ZN_wgDY1A7uWuMh9rXhFSuzg@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	James Morris <jmorris@namei.org>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 27, 2025 at 9:23=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Aug 25, 2025 at 11:18=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@=
google.com> wrote:
> > >
> > > Prior to this change, no security hooks were called at the creation o=
f a
> > > memfd file. It means that, for SELinux as an example, it will receive
> > > the default type of the filesystem that backs the in-memory inode ...
>
> Also, we'll need a corresponding patch to define the new policy
> capability in libsepol, and will need to de-conflict with the other
> pending patches that are also trying to claim the next available
> policy capability bit (so you may end up with a different one
> upstream).

My apologies for the late reply, I have limited network access this
week and haven't yet been able to give this a proper review, but I
expect things to get back to normal next week.  That said, Stephen's
comments about a test suite addition are important, and I would like
to see a test addition before merging this code both to ensure this
works on a wider range of SELinux based systems beyond Android (you
should also test this on something other than Android, e.g. a modern
Fedora system) and to provide a reliable test that we can use to test
for regressions in the future.

As far as the policy capability bit offset is concerned, don't worry
too much about that right now.  Allocated magic numbers like the
policy capability bits are never really fixed until they land in an
upstream tree (technically not until they land in a proper tagged
release from Linus); if/when a patch is merged that requires a new
capability bit I simply assign it the next unused offset at the time
the patch is merged.  Other approaches either end up potentially
creating holes in the capability bitmap (yuck) or creating merge
dependencies between otherwise independent pact{sets} (extra double
yuck).

--=20
paul-moore.com
