Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BF37A4B8
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689793; cv=pass; b=Msm3AaCST8pFWAi2Qa7OtdT5aHc+utEGoQ4vKB8VrRQAAR6NjWpj30nHUjvzl1gZKNc6s9UhnU44qFKaBs1wMoRvpvAjj+FmsSVd96ILbEfZdZT5FBWw+d9FhKnDOQzTZSU5Z2Pr1bdWXcn2C35zJOybcxhkff5U2QZg5S++9IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689793; c=relaxed/simple;
	bh=u4Ogil55q0v0TRl65wANrjve5Kr1CqP2wbBO2xX1vzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvpAPmToT7z26ZHhiSR/Vil4oyeah2AisVtIKq9V4WujLzW9XXdZ7A6SVA+vWTAF0yI/p3NgGN5K0ke2VHfbLbXS306xJeBkaY9ugnTnEI12+pSW4frGvKwUuIXJzdoTz5PvdQLbv7KhfZNSobwrhSTYXsW+BfO1It9T4TX8Ops=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X926xLwI; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X926xLwI"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b338d6so19513157b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790689791; cv=none;
        d=google.com; s=arc-20260327;
        b=DZeG/rXLaiRbvexjVJTp3S+UzXaFxLbHoF9Hn0prH7NgSIGjrByFERWEpCeAWdNBom
         quHCRqB8YTRCaOUlj3tsHW5oAuDdJoqPcjepc56MvObOU8ey16dFpcm1QaxAaOpY9/mg
         VIEsia7a7X+aQJwzApGor24/lNql+oCJjjWSkJmNN+elQh4cqaougSAIHKHH+b1p+FxP
         9FA9sV9VRsHPXvDMBgCtjkt5gt/8i2hwXHmaghxEwZC+1i3pGfNsZeBwRhlPLS3BVsEL
         dwCfQk8RLMbO3uh5QOTyRUQYryAMg/c9jVO9K89yM28H1xgNvKqtvvFK2/KIICAotEMB
         K9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4X/wpKu2HNY5cEEtj1C1C/zlTj/Bz8rXYpg7CYX1PHI=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=JJPA4ePcUx5uIizuIGdWDk6tJRtScrZClZNBuU3AYpyusMOVWrN8yHn/ySxgP0m4Px
         NXteH+Qh5sa3fSGmslyBjEayEvN/+bN49sCOakgCqZJqlMPur5IP36cHQV6Gr3ZpkEv2
         aFvv331R3fPkTKFHyy8qyn3qc2bCAkDRRZGA3LAt45dwwvCHV4oq4qyyiRtBrdiLuUyD
         FE8e+PNP+hUNetDjCdtDKSDAAfO99M1YvxExDjjKKQr5qgb5R8zOmNxOCwZ2NcDonJuS
         BcZAsTBbX+v/IXDE6fmUxJRqIz1WJXd+gahE8xBWLSn/Vz0y0W28YUtzD3iFk/foCVjU
         PoZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689791; x=1791294591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4X/wpKu2HNY5cEEtj1C1C/zlTj/Bz8rXYpg7CYX1PHI=;
        b=X926xLwI6fBLzio8TXAGCqPT2yVy0FefkZW9XJpDnUGhkV3h4eaNtPpOe0wmcyXXIs
         T8HuSbdzUNa5ypXt8HrckqP+twtMwh8Tb/0gg37XLoWl7sOlBWGxIjU0wkLx9UnBx1x1
         gIDPdDzQZMmSZzfRw9eMzRvV8eDYJL2wLYhLo+sctLdSiigJ9CAr0bvuwj85tAYHzz6x
         ie8m89DP4kEoS4VGgIqL/m7bCcySJrS/89ea6q18MlgApGnqd1m+1B3NmoPijP7T/EUV
         W1UeroJeJUdVOtZQ88zRhicfiByoYwipSnxJR9Ho0Z3KwuRwxy2Zjp+kqetv2r6rSC3A
         TdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689791; x=1791294591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4X/wpKu2HNY5cEEtj1C1C/zlTj/Bz8rXYpg7CYX1PHI=;
        b=tgZLXtsx0OhjH4egMGtgO/XnP8gmXDJeWZbZgAIWrr0xLK19Hf9MmoDrSiai26LNDs
         6/vb2etboc/rsPnycw5vvWQ8fSIjG5DUrL1UvH89wwCgKTtSVY+s7HDEm256szCpQs4s
         1fnz25KQG8fSyARn3jQrrMQqPF5Gh5jcAfY1Gb19xFjEHjRZ0DGGiUdGvM+lrxLBrXp3
         NkG5SLwwQGplSJ0qDKKxM4ZswBeYzEN13Dbq114k+ZwmWY9faJhAx87kQwZa9R2joJN0
         gFaD01+BvMXDF9cbG4Dz/1UvULFDNSW/iaEBV0yeNRhowNG4EqPVzBRUBfUXRE/k1Zxg
         cYyg==
X-Gm-Message-State: AFq9FYJKNxcG6/EZG6CbaTTJKKYpVzMK0HV0OJZjjcH5jQ0yeQmOXPWE
	Q8yNO761oly70fTjIAbSVXH09nrE+TQfLEqwIaoOwm8krNv/MSa/3ogu0jxptHztj7KssCdtSHa
	kdxnYlrPV07zTCy0KngoEXkFTIwj09RjNOQ==
X-Gm-Gg: AYBFou2HkAJZhM+mKdmKlWvyQp1bOv3Agq7pqpAmNNsdzDFs71LyAcZIGEiBOcvsrhT
	xzy/CeloalenjTx4y2rDQMiPVHFm0BZjbjh/coJDAPYQE7m3uNVqoPMFNiceiRpyiVKhCv3Afmd
	FbGWHbrGsQlyXT4Pq2V0FZrhmxJQIF0pX5oCPi1AXeCWLgalw78NDt0j9EAsedCh/yP9USRxRwZ
	3TcJ5VTpcARRRLGCL0mS7oJPKGAZrq0haL6cvgijMVMg8vcaIoQUg1OC089dmmtOBQtjK1DkfE1
	z/mwFsMoj36y52MVEOj/npv/j2vJqeHarOY0zXP4F3nl40A/53mTT3M=
X-Received: by 2002:a05:690c:6605:b0:888:7a02:2800 with SMTP id
 00721157ae682-8a646d8fc6amr77255487b3.16.1790689791079; Tue, 29 Sep 2026
 06:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928172330.77970-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260928172330.77970-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 09:49:40 -0400
X-Gm-Features: AclHuK8seyGVhLPfdpK5xlqUm5FwNJ9fsOX9USk95Io-LyVnvJgIQAu6T-n1ZCY
Message-ID: <CAEjxPJ4xxyS7BjaJ5xRhqxguAGiPegQA423VeBE6fbRcMbfs6A@mail.gmail.com>
Subject: Re: [PATCH] sandbox: shell-quote the command written to .sandboxrc
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> sandbox -X writes the argv into ~/.sandboxrc as
>
>     cmd 'arg1' 'arg2' ...
>
> with argv[0] unquoted and argv[1:] wrapped in bare single quotes with
> no escaping. An argument containing a single quote terminates the
> quoting and the remainder is parsed as shell, and any space or shell
> metacharacter in argv[0] is interpreted rather than passed through.
> The same string is also written after "#TITLE:" and read back by
> sandboxX.sh for the Xephyr window title, so a newline in an argument
> turns the tail into a second uncommented script line.
>
> This runs after setexeccon() inside the sandbox domain with the
> invoker's own argv, so no boundary is crossed; it just means 'sandbox
> -X -- prog "two words"' and similar have never worked.
>
> Build the command with shlex.join() so every element is quoted, and
> derive the #TITLE: line separately with control characters stripped
> and truncated to what sandboxX.sh's `cut -b8-80` will keep.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
