Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208D33A01C
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598681; cv=none; b=EbaUxX1HvjEt+HNMk+KVRgOpiXbZaGwzkn0HQNTxxlADY608uNv1owRcIXrf7GXJOhHaOIYcUqI3CTyiyiijn+61t/74sQ00oAnmtclGNjZP2JBDODnAIKmsL3LDnqZp/v8j05c4zJqVF2QN2NgiqikxTO/sTwhcId0atIvzRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598681; c=relaxed/simple;
	bh=+rG7B73pCvsOkC+P5mnoEGYSO/xVNiTWB2VKXQ2FZnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxCwUIaktNQDindtfbgi7MSOu3MDzqDhPqP0W9s+SofRSvELUVydNYolKFzk47SLPT4013kn5pGUAPLIhZDGV9qvLZit1V1gsRPLfUEicFAE9MdBVWaZHJj6eYW3YMa6zupCavbs6xXtog7Joso4VyI6UrejPtmZca0nDGScW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbKbX59V; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbKbX59V"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-55f98e7782bso977051e87.0
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598678; x=1758203478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OQy7rJoFuAWQwpjr4VyV3/+ffXZmbIP8yKYaS6DUiE=;
        b=EbKbX59VxeER1urgveVlbKgHxoicweWk1DQALRODnEYL8cINszU2CjMtMZGfXYw5hc
         Aon+hOZWimei2oqrPf6cwjZIFWfe9ZHTs1wWxNAgTqV8mpQHfzdlv1Y0QHClQkNJpo6o
         wmFzQ6BZEuAxOutqnqbRYKh3K3YxR56W5LnsgatAAKXj6vC+FcudojUu6IazFJU5NFPg
         amsuYuzoOeKfjIhjGi4HAO6sbx5XWEGbjHty3oByYQs4JIQv7k1t3sb2ZotlgZsj1BCU
         lQ+I2wH2b+uFiU7JcpG/dHC0ThlsIQooG8kPIWkYcTYraiyhmv0iLEdOzIZd3mczjb4T
         jMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598678; x=1758203478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OQy7rJoFuAWQwpjr4VyV3/+ffXZmbIP8yKYaS6DUiE=;
        b=nkzy9olMCC48x9pbjYNwMiLXhzInK4I28LQPvvuHwdQSAvoVVdyaKbj0QevssV5CdR
         WJsqwSmiE7h8R2RRnnXFqGGjXzMGh7FN/qK/3z6711KyhoU7CxBGEBxsFqDakSpm2krQ
         Hi8bDNWJ/IyIuUrOlcKy38qK0uQPBPgs53vy4LKiDadlf+HsgmkGxcbqxrE9vsWdfVVv
         3Y/WkfRWlFHpz+MUnkQwYeS42282l4GBnIQdO4tEcgnn47WUWA3i6o6tfoCwPEkmDm1e
         q1KEL0HYmYntcYrzRqXFB0UCcze4+vS3yFRl+zmfigr5SBoMA8EfzSZ6iHed1nKXmfuj
         r5ng==
X-Gm-Message-State: AOJu0Yxvfg5rSXTphKWvfOxd1Qv+S13tH3Hr/yD/apRr4TICjA2pn38W
	DFfVD+zbzUzg/lwNI+LYN2VcET5FZ2EOSBQ3tSQuDxiiFA5isfxFvDEhkdV+FH9L2mIJ/zuA2hl
	jl/1C+SldDffV7J5yJdnl0/9iLHzI3Xm70nF+
X-Gm-Gg: ASbGncuMtVLURfHgkvqGpXdZzsuiyNGzVwKDJBTinQ+HuP+EKJQERx9gYKyxI3Gn+gs
	Sj0qH8Y2x7YlSY+JbNwtn1CIxigmZIB62Gdz+pa2Qg3rUGNnYX+q/R4pyxUyCzFZcQLcXE1w1K2
	ZgvnUQYRgs6H7O6FgqwLnKV0HFp0x0o1jzfLwp36UgUw0XqZ213Wdr85TKTV36DZaKQS4j/RRh4
	pUKzLDKiFSgQ6xtnA==
X-Google-Smtp-Source: AGHT+IEK2EZh/uh0Tw8xQjm7lrAV8o9aX+basidtlyViTBko3A5NF9a6oibUEr2YWLrHt7WuP6nJdhVV3rKqY20oOiI=
X-Received: by 2002:a05:6512:2396:b0:55b:83cf:b260 with SMTP id
 2adb3069b0e04-56d77b56170mr1260845e87.11.1757598677788; Thu, 11 Sep 2025
 06:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905181314.59-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250905181314.59-1-ericsu@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Thu, 11 Sep 2025 09:51:06 -0400
X-Gm-Features: AS18NWARBzv16MiafUvR3sAY-7VXFNed3e-0tnG7WJ1wOte3vkcfe3iG5Bkk7js
Message-ID: <CAKrb_fHc1gjJ9UXUt0dFfG4TroMbinsgw4O+mN5nyCbD+OqJag@mail.gmail.com>
Subject: Re: [PATCH] tests/bpf: Add tests for SELinux BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:13=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.co=
m> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.micro=
soft.com/
>
> Note that new tests require changes in libsepol which is covered in
>   https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.micro=
soft.com/
>
> Four new tests are added to cover both positive and negative scenarios,
> ensuring that the SELinux policy enforcement on BPF token usage behaves
> as expected.
>   - Successful map_create and prog_load when SELinux permissions are
>     granted.
>   - Enforcement of SELinux policy restrictions when access is denied.
>
> For testing purposes, you can update the base policy by manually
> modifying your base module and tweaking /usr/share/selinux/devel as
> follows:
>   sudo semodule -c -E base
>   sudo cp base.cil base.cil.orig
>   sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>   sudo semodule -i base.cil
>   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>   sudo semodule -i bpf_token_perms.cil
>   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>       /usr/share/selinux/devel/include/support/all_perms.spt.orig
>   sudo sed -i "s/map_create/map_create map_create_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base bpf_token_perms to
> undo the two module changes and restore your all_perms.spt file from
> the saved .orig file.
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>

Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
