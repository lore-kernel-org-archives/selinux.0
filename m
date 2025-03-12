Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD141D88A6
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766178; cv=none; b=OmBbDQbarfLYSfXYmbm3Zuz6jEa8K1BNaksndgxXvWuUaziHNAdRSR568DlSdrvS/vMGaemruYCng0BWctJQUSPC79EePv1fwUmwhdTWAC1gmQl3Bwfw5vOsm9xWCc6X0r3IiAE2XxidoLgNrCLn5P68N2iONHsBaWvjQWFZuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766178; c=relaxed/simple;
	bh=znNf1fAMzmCgbuZtmtCSU65xdGJmcPGnA2pGzlkz1i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zc6/p8TvjJ9otRhvKIMjdjQqFACpPQYhGnqiQuruhD9vV4mM7MwosD1TVDuw6EgNc2+u/Ut6XXohNcAj3YFMX8/hAfzMey55y/LRQaYJKAiC8MoEW8TWeLjMAnnPKvn9Jw/qoqZOTU9oA7kYH9UKJyBj73uwKpXrUsW148e6SFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NoT9QhJY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NoT9QhJY"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54957f0c657so582866e87.0
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741766174; x=1742370974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7LXRptCi3W3HPkRnBXDsxLRWEGvWpGC6c/1OJFUi5I=;
        b=NoT9QhJYWY8THcMnupaTC+ZB0heGnFiLl5mCfhUwzkZxqpQ+5gj8Jy3qZZnpl3I6iM
         BvXtLGe3FhWZst8Bchuar/MOMjgrBOZY5xXyiNIpfVTb7UZbkf7tf7bjcXZSFdBix+os
         HE1b3sPgP4votHJHxboY+6L03OmF1jyo34d78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741766174; x=1742370974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7LXRptCi3W3HPkRnBXDsxLRWEGvWpGC6c/1OJFUi5I=;
        b=Y6AQDJUb8GY+nm6dIB8km6V2A2pDoHkmI3cXjJp8CAYWFa62P+lkZUGRsFUduiPcaB
         aRY3suoYj25A+Zbihoih5ApSNeTGeulIaxy69P1i3LHB5lMrRgcs51JrXNC2UX0zvJK0
         JOZ3enUThfYv4F25nwYqYrDW1EIyDPkm97dGs3RT9mvf29wpIYUQg3V0pS1AoVIoWISF
         Z2UxFh72CFb9H2qf3C0FmQddhsB04WAd14bOyFTlwKAn2Q54DqnLXVsejz3yG9E0CKdK
         H5b4mzzV5s+c1oOzUVBeWZFUSzQgKeFDSIo4IYqzf9MHUEzsGSGEmmO9VxN5nWaV2V5v
         jCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0bKdm3FFhjIMU7+2bZv8bpZrg1F5ftEFdJNE9awX4eBFZ+CyNDdUH+Byxnqs/oFyibsjsp253@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBXimA8eCcuma7CsMnAA4uQWIIetQsl3cISRLuHtt1R55JQi1
	b83u7rmLRhWcNz1nY7nWJTWFjpZEHcWYEBq6vx2QfRlh2iIqCVmqpouDCDLNQKuwcpb316ZF3AM
	tFs9gWRHbFh8QiZHgwO18z/PLRr7SiRO9AdQ=
X-Gm-Gg: ASbGncvPi+uPoktgzIxX9JH7ssl45tQDqbNcnMVRIod91myRhkISzKEoocZSZQY8l/p
	Ysr8jh/c54ftjOoHXfGXjE8RvDCWl+fAfJkzO6VUbxm43DOmVvOC7iT8/a4W+rKLo4V/D0YC8vg
	puWuxbDGDzCi0PcQCXvVNrOyrc7voSRdAntmZSF3seKyR7tz2+iwwDI7c=
X-Google-Smtp-Source: AGHT+IFf/2jMBxJMq7bA+qgCgSqlHobuc4JKog2m2C4xhOJcspr6bWB58MMs0jlxDxPGarogazBbBwtX3Cl5r8U2wMg=
X-Received: by 2002:a05:6512:3a90:b0:549:8b4d:bd47 with SMTP id
 2adb3069b0e04-549abd14b52mr2407678e87.9.1741766174239; Wed, 12 Mar 2025
 00:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311092920.1114210-1-takayas@chromium.org>
 <CAH9xa6dtem=xKPZhF6s+ttiOsQRyz63Je=Qv1m8edxCV1hE7Lg@mail.gmail.com> <510029be-c806-48b6-8d8c-f2ee47ce15b4@googlemail.com>
In-Reply-To: <510029be-c806-48b6-8d8c-f2ee47ce15b4@googlemail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 12 Mar 2025 16:56:02 +0900
X-Gm-Features: AQ5f1JowghCzcFF6_Pk7EsvvvDWWpenO8cQQ_zC5YTibXCk2OuUxxftHxWohx-s
Message-ID: <CAH9xa6eJzCgOJO_wKDyeeZbv9AXMoANt5vFvsqDEtAH_o2oQWA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for feedbacks.

On Tue, Mar 11, 2025 at 7:39=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Mar 11, 2025 10:42:22 Takaya Saeki <takayas@chromium.org>:
>
> > Hello, now this patch no longer appends "*" in the kernel space.
> > I tested this patch on Debian by creating a modified SELinux policy
> > where all genfs rules were followed by a trailing '*" and the new
> > genfs_seclabel_wildcard cap were enabled. Both the new policy with the
> > capability enabled and Debian's default policy without that policy
> > capability made correct labels.
> >
> >> +       bool wildcard =3D 0;
> > I overlooked that this should be `=3D true`. I can fix it.
>
> Or maybe drop this assignment, since tge variable is always assigned late=
r on (and modern compilers are good at warning about uninitialized local va=
riables).

I agree. Let me drop the initialization.

>
> On another point maybe this feature can be combined under the new policy =
capability netif_wildcard, to avoid adding two?

So, do we rename POLICYDB_CAP_NETIF_WILDCARD to POLICYDB_CAP_WILDCARD
to control both wildcard capabilities? That should be fine for
Android's use cases.
However, it will mean users who want to enable the wildcard feature
for network cards also have to take care of incompatibility of
genfscon at the same time. I'd like to ask for opinions from
maintainers.
