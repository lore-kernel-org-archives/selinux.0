Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7394F472F
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697694; cv=pass; b=jh2x/ABFmYuVPMD5S1aKeomXVY7JaybouEGQ20NaeoTqjsRU/VxVpi+QUbSBx5Bpr8CkmN4pNyUUPCEnAH2VEOFevg0xHhu1uk90zGIjQQ/KpYakE8odDu4JTuHO4Yhwct2Jiy5zQSjceaCha7/t++fcgd85egLjM+KHJcmvpr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697694; c=relaxed/simple;
	bh=029RzYE9e2lZm/nBfwOyS0H4XCBKoU6jCwxJjLeZaEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGXxRQkjd9z68mrZJ0qTeAKoILG8BQGayVAUkooXxoU74CrPmVmkRSchN3kB4VfpfGzCrznxRZNaliLvkqo904G7UcyXpveu/xXGLP1dpjXwFBHdYe/9/y5N1rZj/gzdxZBlSyDKOekeBBvlIr3xxYlQAdkrwAsjumcu1gv4FOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjAhx0FH; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjAhx0FH"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3fa8a788so11308177b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697692; cv=none;
        d=google.com; s=arc-20260327;
        b=iPCroxAdGMrInWgwVmurbz/PPIkRNw6L4wMkRbFMjOqaBOB+LJdT8aXSqD1G12E0jX
         ysQBSRSWPaOmC3Sw/4fV5eDwMclwwwOXeRpMYBcLsVDh5DiEI/sKKxqYRWgIdXNgfci/
         qSNFSTy9YnMBt3pkn4/SfXu9wmsWzmV6MZy8FAlyjWn8xlIo4V0VdE6z2AitqU87HDod
         tOvI4L2NTmVSIgQZfUi5hh8OZNm3PeksutkDM8zyWegi4oyXRopST2Sf/aDfN44rjERA
         GpI250yDfUQj4Cp3gGK6ODenCcXIkgOOdqdRuKgZ0uV+8PoOqrgKK6ckL7tem43UCp2N
         igBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=029RzYE9e2lZm/nBfwOyS0H4XCBKoU6jCwxJjLeZaEg=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=iw0j8kcaqXabuoZVhM0SHgHIt6RdfCE6PAH6X/mkIJomji0vmTR00ZEoOz+Yts3qZQ
         I4aIcd+UILIjWsCTId/Kz/vYOdM+NAVf8ja+9yId7vlVJffykgaj4f1siH5D26AXtRZI
         gVMVq4MAe4OG9SZebDdvvIITt6xft0tWLYwAN7Ew079wKEBFaFUlB/zDgedvR+YEpqtA
         I+BtQh8W8jvChB9gwhAYe0ieNeXtlH7nNlwdJ6XDnLGQxHcgfvYUN437l5JRWpkL/d7F
         CRGvTdxaiMP2nTQXovFvRwNLm+icj5mAUidFkzA+Lbv6sltJhOeCY7522ALQlmKVy9lB
         tSaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697692; x=1791302492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=029RzYE9e2lZm/nBfwOyS0H4XCBKoU6jCwxJjLeZaEg=;
        b=bjAhx0FHV/XZ7ouZOrdIqHOJbG6DyMxAx35aodSFNiKMw44uCFge+AGsvaJLYaA4Nm
         lXPv+XSDIHy00Ap4ksymQEo+bSM9XFHajeg7FQDU5VIxyo2qIa2fPWQSW1uS3GtX8ffc
         J4OigtJZ2LJvea8sPSHPoU2rVqgIOpeePLG9tsQHkhZ7roO0Z4i9bE3nAD3UVkETDF80
         KQ+YdB6nmJJk0geIrQWar6JKWYoWZ+zQofq3M471z68QohAxxB1WtiwGPxdbkAUP6eYy
         ycRHIVDo4aL6Zxp4XmEpXp2FHOwynZurC82WfAUDpQjGT+qSYChomLyAXhLvvt+P/Rmm
         OBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697692; x=1791302492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=029RzYE9e2lZm/nBfwOyS0H4XCBKoU6jCwxJjLeZaEg=;
        b=HMi1HAip/GtpapAABGf8JMUWg0y89uY6JbG4/K7xRbOmqbSgBfVuaMvcig5MAAyTv8
         lwXp4Ozj2LeTwql0zVX71pDTeqe53xcKMFDTwbl6VKlx2zwIwotoRV07TR3/zMj0pz0T
         DDWx0ofsqZ8JsHGeCbumwcHS/EEnKqWz0gjV06o27ivMOjyYHM/3oVQoJMj5x79RkV0v
         8SB4gMgZQC/vwQ2qdQekH4ZX+jypXAR4GMDBXPMB5mb/FD7eEwCkKYANX+gQ/vsk1IJQ
         636YOsf81IQGB3pU4tcoFUWpIzFbZimsvdN9uTP6RaP6csSh8ZL/2Cqd1nlgb8CfTeoR
         TIXQ==
X-Gm-Message-State: AFq9FYJ0JEos99j0+5RMe2fiCzbWo9PXXx/UIId9mWIPqNmpzKP8/f0S
	kvJTNdrdCe+RDwrcBNQJ1RJDr7dF3j1bkNmUMhBfT3q3nezLsGlDUl5EXJl9N2nKmyBWSHg8qVN
	YHgpwzcGSmgPQa3uZW8ABu+jIsQ1pETA=
X-Gm-Gg: AYBFou1xjH5oQaTVCMO9EIH/PIcdZn5LYqGZ7kDdswxD+qPBimtqoC0vmh99XlnYH/a
	XsCPyVeq6J/GI8h94hmaZN8T+KOoUoEe2QYCaSoNY59cF2XN1PTV/TL53S1FWZFbp/6YULLjGWE
	kpG/JforPKvsD/PDJbfZ8MTXa/9APxkder6MZ9wxboLJ7wZErpMkIGb9GSmE4DldfNlKMtNEsM5
	XID9YqzKTa2fTvK6rxOTpBgH50t0NYm6wE5mlJPvGvQGvVeJ5LCCr/bHIVbkRH/mAvI5CkPLGgM
	XKvPdrPaKlkSsL1kVewV86JNVdGCj/vXzKeT2qFAc8ORgzm3vYKYJqg=
X-Received: by 2002:a05:690c:c513:b0:8ab:41a5:637 with SMTP id
 00721157ae682-8ab41a51511mr9080527b3.86.1790697691711; Tue, 29 Sep 2026
 09:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-25-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-25-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:01:20 -0400
X-Gm-Features: AclHuK8zJWFJ4TQqsOLcsuLDhjVOKqq84_mRlRf4LjvzUR7d0qePj_wEXD4uyZ4
Message-ID: <CAEjxPJ5BULjtwQUSHuaKfsecg+FndqW+jAho3tpUDZJ4PEaVHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 26/32] selinux: drop page_mkwrite handler for the
 policy mapping
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ->page_mkwrite() is only invoked for write faults on VM_SHARED
> mappings. A shared mapping of the policy file can never become
> writable: the inode is S_IMMUTABLE, so the file cannot be opened for
> writing and do_mmap() clears VM_SHARED and VM_MAYWRITE for MAP_SHARED
> mappings of it, and in addition sel_mmap_policy() clears VM_MAYWRITE
> and rejects VM_WRITE for any VM_SHARED mapping.
>
> Drop the unreachable handler and with it the FAULT_FLAG_MKWRITE test,
> which is only set on the page_mkwrite path. Write faults on private
> mappings still reach ->fault() with FAULT_FLAG_WRITE and keep failing
> with SIGBUS.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
