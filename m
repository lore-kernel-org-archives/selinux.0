Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05E470116
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293667; cv=pass; b=VarIXxlAgURIX5JzWBGFXq7r5g2DwiCLA30VL7Vfh9AReKHgdXWwPThrXvuUX4l2FTwoVVrliNhqQqmFNwNxN5s/FD/GE+9ed0lKObkTDlHhrRqXDgkZgUs2B2UPQIkj9GhaNocnYZ9ADSSiR/I45y2qi1X1rO5Z2bGBLh4btDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293667; c=relaxed/simple;
	bh=JXAnWiiVs7DSFOcnGoZQbYbvS9+ZU6WTSNOdIl8U3lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVvOgLlJrMnIFEF/3/wUlCxmUoSfy2RmZUursqjre6kt7e3CxQe520N5Zn4dZNKg5e3jqVdzE3mH/HaeGurpHOdOIQeFiEgtCxpgIOWJwMclwwB4Xxd9q997AwL1w7GXlyy9tqzaHATpdL8ZCMKFiVrbyfuE6QyzwjKTYfXY3CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGrpn8xy; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGrpn8xy"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-465cfc7e33dso184872fac.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 13:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788293665; cv=none;
        d=google.com; s=arc-20260327;
        b=T/Ilq3UaX9kxlH45hLaaBFzeYBxTc4Rn5lqqqrRkPt+GQeU8+hss1YpHEwyXlG2xX7
         gV5MH3LR2sJghelmBj7POoVWI6mxuaKfozMYu/rlMSc3DAomsC7f2XGHc6ZKGJ6fNYff
         ttlNW8YNRwJ6QfyzdE97QZmkLZCu5oUQ9x9hcJ2xG9sNJp3+OXxWhu2r8wJGKOz8GnMu
         y5gy2aGTMdovIjTobU/UDAVOhgZpYhqeHGscJmwIKdkt1qlUt8k7ikibsn/LjGHZJa7S
         nlGpkKl+bZTEMPKCk+u+2rzzPb5iBfGWX/TWQtkuA2rg/gtkreeFBp9C9KpjQymMGtN3
         Qb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JXAnWiiVs7DSFOcnGoZQbYbvS9+ZU6WTSNOdIl8U3lk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=OEto8dYOM4tBROHQllwrxFOvmZTj3hWPCHl085zVWIl+v++BciBW0m2G3RSThUBME4
         ajXrLWP+2qOmyMRagHrEMbnAy/S0YaMLUJ6lsXYmzekCLgM+K0KU9O+l+oQDidpUT0FJ
         himNqU5HdHn+D4ZDh1HAKdYd0YEAjVvDEBEiV/JGjQ7G8df2z/OOy22fmq87PP3DwKwN
         +QbH4b+pLz67aiVoX8sP+OCMNBZykZMFR0QHzbhWls8P7MOjl79GvtMIG3qJET2AMRUM
         HIn0HEV+YZjhqJ5v5YiABtLaKwZHzFzbGD2n0UsZ7DZUFXCPuzHJ4CoeobAIL5u6WTWW
         ZCpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788293665; x=1788898465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JXAnWiiVs7DSFOcnGoZQbYbvS9+ZU6WTSNOdIl8U3lk=;
        b=fGrpn8xyq4SB0T1mvmf7UmSpDJgJ9ZapQOcwtjDOmi8eqGAzuAJqWV3NgKOe1YT9u3
         EbD+brQJO/tao/nLj+bm3sLajN6hMryTov9rsC0GyCd5dH8RvrZ3sXYqjo0Z19SAq5zv
         BvrWFOCG5LRv93nniChvZtsx4cgZwpdpAtvAW6Ghfg0dFmKxSDDe4t3uDYqNxNVPoLFZ
         scbMDqRY92SCO7wyyg5UE8TCnRCvQ02TL1SRQAFUQwPFzXlQC/0JN8WDRVP1D3ha1GEX
         t2vNnhOlmDsT7MTUVvQdi5dD+y/3Tdl5j0nRYZaxvRrhXb2Flb3TJXn7JKkGZe+fcrmK
         EIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788293665; x=1788898465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JXAnWiiVs7DSFOcnGoZQbYbvS9+ZU6WTSNOdIl8U3lk=;
        b=Ovaz7AkrG25+cbn/q6VLQTohT9n25G9sSJ6gnwec3dbJwYKb9VUhleq71/p2sNEgE5
         W3dqABVOcUseMIQ1pw4j/eII9J6jRZ5LoqkEIT4xJfu6gyZh+UXnRY7Cq1tgHVwLSKGN
         QnWYqs7kspP64iUKd6YzSFy1COzC4mvC8rvCmQXmROAdEhKPUclaLwGf9nnZi66Z91A5
         L7+jwvLR6QKod+lrcxKJ3WGzOqHf60y9iKAOXRilXIOkiPPGrDJTnpDvsNCowLL0PmKG
         snK83emgCWTHvAtkco5jpwz7XwXv81wnlSS2XWRtqbFtTtIuku2v9WP1gJk0for+5kPn
         wojA==
X-Gm-Message-State: AFuF++kKPZ4IIlwSrdqT+eUE1kau7UK3dZhFE0+SmfrE5vIPCvYTbSdf
	3p8tKUloC2xgjIefylT9NWPkjelPS1Jf2B3TxeK5TCq1YejButPVqkUBCMhOuZYliO4k22ywKsZ
	oUoyQ7oQ0kz//stDTdK5r45K/UhkgM9Y=
X-Gm-Gg: AYBFou3K6kLzoLIaOnDmAljFt5pZ6cKAIZag+emUwNChCeevHzbmifFSZcYXHFowc/G
	shbZHWsX/bCaP2YErb/ROa53+eNNQGtf/jKKEbkzIRHU86kS96OFYC9qK3monZPv+F5m9cgNy/Y
	zoqHErPPwKEL277wVoyOV/u3ME9jLyP2wvBeJ0xWZNqwm4AADlXCdxHq4J7oo/LIbJzKrUnAJX8
	3hNtD8/RetWwNVsvCXWBr11MrR2Vl7i8/DmIXJ1zYbM2hee3K3xHoX8F0Q/YnpABp8Ui2xePZ+D
	S7Tj5g4oY0a3HrtHzHURUBYiusIQ6dLu9je9GoSCw3FE
X-Received: by 2002:a05:6870:e44e:10b0:46a:5d14:b079 with SMTP id
 586e51a60fabf-46a5d14bad8mr15870921fac.7.1788293665442; Tue, 01 Sep 2026
 13:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901172127.12583-1-jwcart2@gmail.com> <CAEjxPJ5z7BQaQNjwGkKiPTFbUSeTz8UK1kpg5HgEfQP-mzF40A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5z7BQaQNjwGkKiPTFbUSeTz8UK1kpg5HgEfQP-mzF40A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 16:14:14 -0400
X-Gm-Features: AcwNN1Xq4ohURew0VategaKoXEN-Nxdvc6CE7z9fuoICulTf7MGHstTKzFPFarA
Message-ID: <CAEjxPJ7n4GAqT3y2k0YUdq0c+Mx0LMOxVUZ0wjQW3OLbd541aA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Validate the genfs file type class
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 1, 2026 at 1:21=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > Like file contexts, genfscon rules can have an optional file type.
> > These file types are mapped to the value of the corresponding
> > security class. If no file type is given, then the value is set to
> > 0. During validation the value is verified to be either 0 or a valid
> > value for a class, but not all security classes correspond to a file
> > type.
> >
> > When validating a policy, verify that the value is either 0 or the
> > name of the class with that value corresponds to a file type.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
