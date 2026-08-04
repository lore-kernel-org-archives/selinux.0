Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD042E8F1
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862869; cv=pass; b=n0TC2HBAu9jfdFaKxZZiEk65nqYVjOIJTqgLdtfWSdiBa+R+DTJkgYTnzh2sA8fui/tdYsDzM5uuGHcu2f9CdbUeil739c0+srdx4tGESoCcj39lt72cE6/tOUropr2y2jJuFk8WqlZzIv98LmOpqj5DdMbfrjfYDhVkgNhJ14w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862869; c=relaxed/simple;
	bh=NN7RQwZEWIcd3u0Kef8iTQYndBZrEjQokV6obVKC/Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcdqSxzgvNpHqe9Snu2SR8OUpZmrbeewPiurmfdZ2gdcKx8JfJOl10yWVasft8m3xyym5SxapjrlRtlZjGd+Uufs3/kchM1qe5edhn1HUlaoflO5QjJGT5CFF9zR6EVXKIaGGqNpENKkeeTEI38YAbDO15YQMjzS9EySXp62QMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SZHhjSu+; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SZHhjSu+"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca957432c7fso3504298a12.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 10:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862855; cv=none;
        d=google.com; s=arc-20260327;
        b=iLPzqFwPgAiqlh1jp3GZ7va5GZhFS2m1+07cfhFdr1g1/l9fC2wU5uXr4KdiFA8s4K
         rkWJt+CIEZJPOxirNyw6YuzQqbt38aVJiJYGj91moeL/7rClGaA4hTtkYcslo2OveaoJ
         +8Q/VUIcPyixMxRu50Cu492SeqzpZnhvd0+W68G5KtziHgv28dydesVrG9EQU9rhloN/
         U2UO2+LS0fm3Uf2JpHBVnEMUsU6AoDk4ZHwu10aU/flo6+iGzmamBLhHDXNLUuF/vbGo
         NuCbsPbKiv39bk9zOykmGi3IqKTquHdOQC/UKDxD/iSOB4PPvE/0gQyW7TsAORqFxSBL
         Gx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        fh=tyR9Eegq69BnpMcjE+XItohVs/CAOC4uOSMcm1RFEmk=;
        b=LIqbOw3SAKnHpqnMEU/Zxtd3GJvNONGcChQ4/3TH+aoxrn5yn5YxkDZcJSptDNKA25
         HeVuWJUqOiIkKJOdqhZ1l96lDd6FyHQ6/peCi5B03E6h9N6KJAGKls/HVIlf0rTMqxxD
         mdIpd1gM8PxozU9BdekQ5lGJAM6EzmghHniupWA6lNJarkrMoJ0hs4x5+elFdpaTB8bT
         idLBab4E0bOm+OAjUFcbbdGYQtZ30nf7xZWC+FXnETOAnhni3oRA329xLZS4ZHWyhbZR
         gL5NsOO5EYeOM71TGxntX5EtW1dAX/wZqfNKkJBT6RV2IC9Xky5yqB3NtvG8q2sr4o1F
         3BzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785862855; x=1786467655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=SZHhjSu+914kO7qex0mPblU4m6opNNQ8SYzai3bSARLJLgxVPtp34YzgW7oNbu+Fuq
         4k48OU3THdvgN3jqv+jM8b9hg4IuP4x5ZijnVcsu409eI/9qvBshVlFF9iR0I16pcYE9
         8EkVEiEQ0LZ4BthS/SlV0K0QhtVk8no3npBUgkYyjDuhrbnahz6Q6mEKaxT+xuEvfw+O
         HGBFPVy/uByJ5rIO9oNE0+N946LUW2e2Kdacwu07ETwulGTTUCTxb1+jZ4znPHIPIpVC
         FB1jraJdPJh9m/LBOHcBHjtCTxZu8G794pvx/MD3enegq88zBZWC0w0rApfKO0ybDjfA
         3Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862855; x=1786467655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=E/tPGqwWaQgq4SyRmR9PuwEAyHg7DfSS6XMR5O6cgdm8mufUnj4qjSCOQaRUWML7md
         6ket5AFcLtCv/1O9MHQyzrtKNLkbfANu9EPLKsUfUAdo9oAVB/iI9ImVQIDJ6+/M1Yy5
         g1KQNgLWRWnBG9M5NHfD2dcfVHYpreHvVbMMftMNt0wc5wG6sZHgZX6/igPGgj2hw8HH
         BDNFn5KkOlUnAe7kKqB5IBLXTIM2OLJtrUyJ74h9cHV251p6mjIAYj6qLSOEkPLNGcfr
         EWS+HRFL69XJK0H34+7EGGt+YsDQzjH3ywvFMAu95wbqAvjcrPf9fGFM/xYoTs4EpHcN
         luSA==
X-Forwarded-Encrypted: i=1; AHgh+RqBF82esXdKXfn2gFQ3gEVy4m1WrzZtrv6G4dH9uJhRlpNG9zxiZMhOJmaHaieE2ZjPd5IwcXrc@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWEuep0YtBaIPnqRPvU9V5PkItZxb/HBM9RYaOwcR4JHiCfb/
	hko/G+/Owscxdua14jjkFvHmGYyHJ07fS3r8k8eGJSj+4T9O6fo8iBaqy/4IHcPANFfl4LutcA9
	SXqZq3wMqwFZfRw7xRSP1yG/kZeBAdnSyfgmm+Aeg
X-Gm-Gg: AR+sD13mc5rptO7p7LPcJdvTxK73kj0V2Ry59Sw5iaEcut95tWrVnaDpXkwv1IeT9ir
	zzsAXN0I5Nyql04KnqyTKBBoakgloN7BiSX92OR0cuPjMfVQM/5slhAkgAqR2NBTpeQpzuK/yIf
	vQ4plzjtKCMz3aahS4+8ZsQrXGzdn52onatni/4DzWPywd85NPikd5Dynt73CvcG4KJuh4hHWgP
	37e2jPvefDoYYxe4bRe94X8n0knPdJfSL9itri9f0lVQ0/X9MuEwQQhJCL2Xzm/u+P1vuUwvYIy
	49L3vFVK/xqkLIXkOd0hKJyaqAysiT2AkPhHfQJr5/Ua
X-Received: by 2002:a05:6a21:3204:b0:3c3:834e:89b9 with SMTP id
 adf61e73a8af0-3cb85e7370emr306570637.17.1785862855065; Tue, 04 Aug 2026
 10:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Aug 2026 13:00:43 -0400
X-Gm-Features: AUfX_my2GHODSgWpz7u9PLF5sftBX1mO9fjStT4uqGF3r0dq7sFB5ilyjzEJ3cE
Message-ID: <CAHC9VhTWuX6D0yeBKr0bPbJ_mKUdiLYRtQpcwq-jJgovY_akDA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix user path of nested backing files
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, serge@hallyn.com, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:42=E2=80=AFPM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> backing_file_open() derives the path to be stored in the new backing
> file from user_file->f_path.  This is incorrect when user_file itself
> is a backing file, which is the case for nested stacking filesystems,
> e.g. overlayfs mounts where the lowerdir of one overlayfs is the merged
> directory of another.  Since commit def3ae83da02 ("fs: store real path
> instead of fake path in backing file f_path") the f_path of a backing
> file holds the real path of the intermediate layer, not the path that
> the user opened.
>
> Commit 924577e4f6ca ("ovl: Fix nested backing file paths") fixed this
> for such configurations by passing file_user_path() from
> ovl_open_realfile().  However, commit 6af36aeb147a ("lsm: add
> backing_file LSM hooks") changed the first argument of
> backing_file_open() from the user path back to the user file and
> derived the path from user_file->f_path again, silently re-introducing
> the problem.
>
> As a result, files mapped through a nested overlayfs show the wrong
> path in /proc/<pid>/maps and in perf/ftrace mmap records.  For example,
> with two nested overlayfs mounts:
>
>   mkdir -p /ovl/{lower,upper,work,merged} /ovl/nested
>   echo hello > /ovl/lower/foo
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/lower,upperdir=3D/ovl/upper,workdir=3D/ovl/wor=
k \
>         /ovl/merged
>   # at least two lowerdirs are needed when upperdir is nonexistent
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/merged:/ovl/lower /ovl/nested
>
> mapping /ovl/nested/foo shows a disconnected path instead of the user
> path:
>
>   # readlink /proc/self/fd/3
>   /ovl/nested/foo
>   # grep foo /proc/self/maps
>   7f6e2c100000-7f6e2c101000 r--s 00000000 00:24 15813027 /foo
>
> The bogus path is derived from the f_path of the intermediate backing
> file, whose mount is a private clone that d_path() cannot resolve.
>
> Fix this by using file_user_path(), which returns the outermost
> user-visible path for backing files and falls back to
> &user_file->f_path for regular files.  This restores the behavior of
> commit 924577e4f6ca ("ovl: Fix nested backing file paths") for
> overlayfs and also fixes the same problem for the other
> backing_file_open() callers, fuse passthrough and erofs ishare, when
> their user file is itself a backing file.
>
> backing_tmpfile_open() has the same pattern but is not affected: it is
> only called by ovl_create_tmpfile() for the upper layer, and another
> overlayfs is rejected as upperdir by the DCACHE_OP_REAL check in
> ovl_mount_dir_check(), so its user_file can never be a backing file.
>
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/backing-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The selinux-testsuite runs clean with this patch applied.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
