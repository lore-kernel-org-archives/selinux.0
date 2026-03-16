Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11618357A4A
	for <selinux@vger.kernel.org>; Mon, 16 Mar 2026 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698382; cv=pass; b=cqJzcfXzQ62sWVWO267kx1qLX4onDHPjwXzLqbJt1gl/3DGucDEJRq/CFhVqXeegYVqXampR1dQd9NL/5wz5E+X02R3a48a6jhWx1+o58+jkxGHuLbnKckmFmRxnSy7uVmyK7OAyI3RJypF7Gw+awSlYr+l+Hld6VjjMYOKxf04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698382; c=relaxed/simple;
	bh=9QvEw0u3gRMsyoZyk+ByF8/LpMUDYgdZiDWMnaQ2/XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRMDgeEuPZrtqpvTk2QBPmPTYe/+sOfchOEUJ8M+QF3+o1Q3kJa7OZRzRnS3CBr4BZZN2hs3XU5BsxM4Hgeep1nLM9EiODuc9xDfRI15Dhyb7+V/A3BnHsI0WdUU+lAdkpfIouqUMqUHtztHuMQOyrJGaNnVwbxNlkzvt6OB9oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HU2mPT0z; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HU2mPT0z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3371525a91.1
        for <selinux@vger.kernel.org>; Mon, 16 Mar 2026 14:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773698380; cv=none;
        d=google.com; s=arc-20240605;
        b=flkd9cLNfFsk3rsfciESa5cWV1MehvSKXXNQ+68aAh7dNnU3b8VtrdGo/b0rjlUUM0
         OGaPXuA9p0q3mQg0GRV3SD6HSHtkeM9MGVokSp0V7kW+Uui0WHvi0UPCn9delXG/XhiI
         vcP+E/2oSKYXKrwkUojgA9a6ewXwKklAwPw/FDjg8AXEwwwDBsxZjKPRBZjPH92qYd+Y
         bG8ziXrnwPDARtvjKjupahTNos5zokLTKbKORWM1MqoYh4V9Mtdk8eggfO1PxFpo7fd1
         OH3RNxDj76qbCXa1f+B61VIVXTcWqgbRcj7GjuBBwRShlVjrFSGzZUkmCd4SuBhbPHwO
         SVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        fh=Od5t/aAFDPZxcG71HXXLo2DPh42CF4L7ZnHkdUn+Jtk=;
        b=MQ6/bhfBsuIA2rgaQzM7obkpdZHZ36dn0nk3L/Goq10HSt17ooMnXyNKco+R6WNVl3
         9GkvfpEXVVZF7sFyqBmhvimj5wqoPcvFM6zrDFLabxCJ/mBjxnM8aqoAzsy4C3q5467C
         baqDGMajtPyrcvrIe/FD15+saseM0jWD6oMhJQtEl6pX3/zFJJvvZrhBy4C4U3VB96xb
         b2cbWg2W3bipTrst+bIWcfbyGUzFOgmvXVqeqq3zQMDon7JG2Y3OnRMspQ3bJsBiFz/H
         4e5am6boAcnK6q1RN4hP/llJeEGMMq38qWnvpLD1lyEWwM2dJKDIzosl1RbCa2SlTmYM
         9ZEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773698380; x=1774303180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=HU2mPT0zGfye+/qt/BFyxrPvSX5E+ihjGJ8Y4InhP0ZJvO9/oqaVYHe81A8EqMLY9n
         xU2NJ5CFZsOcC4CCvwcMIJe64nzNIJ3kfF0ugjwfI7/ilGdmaz1O81K2ca83xOXNx4pG
         u5shmfWd07pd/6yNfyIehLkq30Hge3Wg9NaaQq9/nvH6FqwwR2qeJWI0JQn/EaJCjLXs
         DGiDBStBpweklzGz0rVRg05tkC3XSxE/ardUCgHyB+UYg/TK7zsISfRzOaa51T/Pcotc
         FUvPsuHniOQUOd21OTKKY4quYDE2SsUUG/cmse1HPkElVXGLqb6iVgnOyGsjlncONey7
         qQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698380; x=1774303180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=PfOpukHg6zoyxYcN+ymZLtVS8zVDjMw59ZN7Zw6RmJdryp387MoM7lG3kN3gnh2zD0
         kjBtBxk0SWCc5xJRPI87OpMNnQOPhPeJwlefxW7gckF84+K7w43cAw6HNsi9dJMO3CGp
         X4n3wp5OPzEzmguYDrWKrQ180gnKF2iQS6BV+iYV9xZBYxLDgEONKmA7/vPeeXTJiFB6
         47OrfOWleyO1jS4J0CU/h298/lgmXHKmHaWaPvETqZfTq+0ptOlsc+Fky5Nk/dFv09MZ
         NIE9go4giFsh1hZkK6kQG9FakkaAY2J5GvGNXBUY2v2XCO/yGfYlB4jtEHis6q5G/ab/
         g74Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvMAc02OfGQ/7tpQtLFNQsfPfZlDvyTvB9kI8TQavqLUIUAOyn/0hOsQF5qWxe2vxHnBnmMjC3@vger.kernel.org
X-Gm-Message-State: AOJu0YzikvJLVzm1udOFEBrQbpbBP98gCfms1B8uRLVtKQNWKecKoEyi
	Q1138NorEJ5d7LK0FP7GsjUEHqbXxfT7pEpJCH+5EHqvMcBqMgE4QehrddtMz+PeBw0u1IxpTvA
	Y+meZ3ncjnPXdcxfPOYMaZ+4HwmiaB814Lsz1m5sY
X-Gm-Gg: ATEYQzzR05QHOJkt1Lc0KYpO0ndtRrgNK4uQ2ZBmmVhw8qn1YF/0osCiw9OpmrBUdpq
	SO+RLCU2oeicPLSaEMQnzaaS8nLsqQWLgXzEhGoZoU3CKdPA+OuY2Br/Z3Kovyq6yQOf39kQzoU
	l2/mSTJAwsNEhKcyYvAgriAJB1iGmxPcpQUeHnnwdu0D0j+ng+H1oV5Q4nk17DIZOYHtciAbacm
	iFi0dF7KywaBfIrMWxOViBRKCWclqRptCQlcgIcLA+iNA88GP3D5iRhf0wOfXU4TaaEjjRu+BXm
	cmEZVjg=
X-Received: by 2002:a17:90a:d60c:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-35a22081eb3mr12428760a91.33.1773698380402; Mon, 16 Mar 2026
 14:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 17:59:28 -0400
X-Gm-Features: AaiRm50Q0DM9xRE6xrYOCEeiOu8cKoO8ieFIUmC4mYeVLGbPolGQ90N17nL41QA
Message-ID: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing mmap() and mprotect() LSM access control points for the
> overlayfs filesystem are incomplete in that they do not cover both the
> user and backing files.  This patchset corrects this through the addition
> of a new backing file specific LSM hook, security_mmap_backing_file(),
> a new user path file associated with a backing file that can be used by
> LSMs in the security_file_mprotect() code path, and the associated
> SELinux code changes.
>
> The security_mmap_backing_file() hook is intended to allow LSMs to apply
> access controls on mmap() operations accessing a backing file, similar to
> the security_mmap_file() for user files.  Due to the details around the
> accesses and the desire to distinguish between the two types of accesses,
> a new LSM hook was needed.  More information on this new hook can be
> found in the associated patch.
>
> The new user path file replaces the existing user path stored in the
> backing file.  This change was necessary to support LSM based access
> controls in the mprotect() code path where only one file is accessible
> via the vma->vm_file field.  Unfortunately, storing a reference to the
> user file inside the backing file does not work due to the cyclic
> ref counting so a stand-in was necessary, the new user O_PATH file.
> This new O_PATH file is intended to be representative of the original
> user file and can be used by LSMs to make access control decisions based
> on both the backing and user files.
>
> The SELinux changes in this patchset involve making use of the new
> security_mmap_backing_file() hook and updating the existing mprotect()
> access controls to take into account both the backing and user files.
> These changes preserve the existing SELinux approach of allowing access
> on overlayfs files if the current task has the necessary rights to the
> user file and the mounting process has the necessary rights to the
> underlying backing file.
>
> --
> Amir Goldstein (1):
>       backing_file: store user_path_file
>
> Paul Moore (2):
>       lsm: add the security_mmap_backing_file() hook
>       selinux: fix overlayfs mmap() and mprotect() access checks
>
>  fs/backing-file.c             |   28 +++++---
>  fs/erofs/ishare.c             |   12 ++-
>  fs/file_table.c               |   53 +++++++++++++---
>  fs/fuse/passthrough.c         |    3
>  fs/internal.h                 |    5 -
>  fs/overlayfs/dir.c            |    3
>  fs/overlayfs/file.c           |    1
>  include/linux/backing-file.h  |   29 ++++++++-
>  include/linux/file_ref.h      |   10 ---
>  include/linux/lsm_audit.h     |    2
>  include/linux/lsm_hook_defs.h |    2
>  include/linux/security.h      |   10 +++
>  security/security.c           |   25 +++++++
>  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
>  14 files changed, 231 insertions(+), 60 deletions(-)

Due to the nature of the issue, I'm going to merge this into
lsm/stable-7.0 in a few moments so the changes can get some testing in
linux-next with the idea of sending this up to Linus' later in the
week.  If anyone has any concerns over this patchset, please let me
know as soon as possible.

--=20
paul-moore.com
