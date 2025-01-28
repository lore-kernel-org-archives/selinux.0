Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBC1A9B2B
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078018; cv=none; b=UWbAuZq12V3BYy596Bm6l5vWMxJeEYDYDbivkVHqyogjsP93rRcWkHIFDr3JNZzq9QuCQSjZkJlWI+Rm8ii9fTAdECgSpqg1MjSqAD4YnaS8PgZwTF1Q2z2wnMIYIByJ3hNc0tq7i8i+2QtO4paMuAqZRV2Z3SWxrQNGG42tlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078018; c=relaxed/simple;
	bh=hcssVgQaHFlAHV9g2+ZvbnCRIboIBAJw7sCXZhQtLmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idaVNJzlg4a1N2L35EG7C2dAiAnBADqGf0gTUMh5HFvdbrEXbYbRwqmue2Hjm3yCaubNxzuEcug3Qr0SKW+F5fXh2VySbOGCsRlG0WooytvJDA9XO4ABwynw4yF8bm9+m5wgQvGWa7VcwUEyU/M9uzS1YTbtz8UlfzGuoHC/ads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUzI+yJD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUzI+yJD"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21631789fcdso91040745ad.1
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738078015; x=1738682815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcssVgQaHFlAHV9g2+ZvbnCRIboIBAJw7sCXZhQtLmA=;
        b=KUzI+yJDPRDVfX2BCU2woLW7Jbe0+s+VtBsC2A0euWp2Cw19OU+HU5+xKHxZ2O+QCX
         GoycCADhd15qHWjLdl4uGtx9AlvWsqyd65bEgHaF8DJLybI9W65tW4eF8SfFhCc1zLzx
         Yaq0hO/a9nuTjvVEjEaOAAW+PJhTfwq5oZm/dC+PwBJvizzZpiN4QkzmREOaEjbGbgrZ
         tN1yByTfVLpa0eQ6CKr3+aK8+O22oMHjsUmuGiQ78QdV+mJd89dISdG3r648oWv7gvH2
         WyhFaZaDQDBtSQCG2/Uq1MAnVoR7aJX8EuovhPMl0e9BCer+ya+l+5HMPVrEscJf+ueY
         zQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738078015; x=1738682815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcssVgQaHFlAHV9g2+ZvbnCRIboIBAJw7sCXZhQtLmA=;
        b=scLBBw5MpXvfFd8TeduWpNIUfJekneShOPbCNg5hYR9oSWxfLsXGdU8wZVTrMdmUyX
         CeOniZ5eef/4DPNYtKPcIfFm2TeiX7ovypZoBYIUhvtsIAPyzlDag9JpFZIeiFLeFUEr
         SATn2TobB14+5Fl2T4Yx6gfKD4yzbZCB5m2IPktfQOfxjhnoGLepIWZXIUyCCSRIjQZj
         EZkbFtPYsorP8xSzEHtsPoHei4S4wqx1jOwZJEGazF7e+lK5dRQBjfGpVrYbou8h9h5f
         RT04bLQDAxTiNPDROpc73NdDJZjaY1f5HvBAk0lTqAfrpPgQ5rLGUY4TMYxNhriOIiWV
         zfnw==
X-Gm-Message-State: AOJu0Yw4aFCNn3ZMOzNO5NW5ihmWIUpEj4XyeCzmI0N/91sjI6EBUJYx
	e0uHnL67xXuwPtOo25Ksv/ivrbFMOYSqwzvPZHrDKuOiEG51vCsHTZe82buu3TycyatBBXQXxxi
	Y1G9HfAyTzdYKXHC164G/1o2QQAjhNQ==
X-Gm-Gg: ASbGnct92uO1TtT9PrtzPywYw4GyY4cBoa5ap4LechvQAWkU9ZDu+Wjfy2FAh5L0eQn
	9mRiMsjdGv6mzIp3avoBJAHRF2p0rnOyJYuxnfzf7gJcLtlZtdqqlDa4T4jhwOXkqytzGppnk
X-Google-Smtp-Source: AGHT+IG50Et3aRU3Uaen9g0ZVnHibNkIZrqFzQqfWXLAsaxrWeVTQE/KgSR68Ys9axiTmAzAe3YEjJXyuR/y7wUoBEI=
X-Received: by 2002:a05:6a20:438c:b0:1e0:cc01:43da with SMTP id
 adf61e73a8af0-1ed6e4706e5mr5256353637.0.1738078014653; Tue, 28 Jan 2025
 07:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com>
In-Reply-To: <CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jan 2025 10:26:43 -0500
X-Gm-Features: AWEUYZkLDYkeeOjtEg5Rj7E-w108NYw4rBxOBHTFCYgDtU5bULAth4evU_ZFdoo
Message-ID: <CAEjxPJ6OrkBiw8yAzpV6_B7a5kusTYHgvGs=H_f-qZhNRNR-dg@mail.gmail.com>
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 10:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> Hello everyone,
>
> In a recent commit [1] that has already made it into the coreutils
> package in Fedora Rawhide, ls changed the way it retrieves security
> labels from files, which causes the SELinux label not to be displayed
> with -Z for some files. It seems that the key difference is that it
> now relies on the result of llistxattr(2) to determine if the label
> should be retrieved and if security.selinux is not listed, it just
> prints ? as if the file had no label. On some inodes on some
> filesystems (e.g. the root inode on tmpfs or most sysfs inodes),
> however, security.selinux is not currently returned in *listxattr(2),
> so the labels are not shown even though they are there (and would be
> returned in a *getxattr(2) call).
>
> We can of course ask coreutils to go back to fetching the label
> unconditionally, but perhaps we should also/instead fix the
> *listxattr(2) output to be correct? IIUC, in some cases it's a matter
> of adding a security_inode_init_security() call, while other ones may
> need a hook for listxattr that would inject the security.selinux entry
> when it's not returned by the filesystem already.
>
> [1] https://git.savannah.gnu.org/cgit/coreutils.git/commit/?id=3D4ce432ad=
8738387f1b2e80e883dc7080df3afabe

There may be other side effects of that commit, e.g. loss of context
translation if using mcstrans or equivalent.
WRT to returning security.selinux, selinux_inode_listsecurity()
already includes the SELinux xattr name so that should already be
returned,
unless the filesystem implements its own listxattr handler for
security.* _and_ doesn't include the SELinux one.
