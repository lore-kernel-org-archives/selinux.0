Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B04503FF
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526005; cv=pass; b=XyBoKMAAlliOVrm2BgP1HOobshzV0PYRpZ1sHbPoOue0fJS1Jl0m7/Ftd1O7SojMdwliCo6c1tWLDXEouHNJZh1VSP7pgCtEsWbSTASTSDkRN/HC7FUI2UkmA7Ct6jdnR8Y4K129bZ74XNW450iH4cYPXTNdaph4p9YqmYAgIcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526005; c=relaxed/simple;
	bh=3tnZJF0J4FIVh2V4hNGiHlt0N6WOS3+qKRNWMuI0vpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAWJh00t7jbh5TCG9KEA9fa1ww0aDJFWg8s+V5f0r5sROiPNzIFxFzURFQXEthwQZR8mwe8W1da2n4RxqVbQC1BtIe1EE0cdyfA5poOoqsCbPy6C6F/jaAh9vo+ExvioUF3vKL4AUL0gREIhyPSCObI7cA5scE45fpuBg4EiRfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCy+FBf1; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCy+FBf1"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-448de0cc236so1072075fac.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 12:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785526003; cv=none;
        d=google.com; s=arc-20260327;
        b=HWG3QgkcOxxbn4hDXHjWbPWtvdSpuZielY2h8wG1Evv45GQ3vXVNCwmBdCvkbWP6f5
         1WSHJao//vvC7O/GiEDbAOEJGMW/OBVuPYCddSkFAlnHt6sogSdHHhCS3cQlkwykhQCS
         QmUlDkJeXv2AxGRV+pcQ6q2Q+BlUJmOuqJSyevVVludQ1JKUFLC5CK3iJbf2qTWqpLrB
         bXwcABv/xxXD/NCB/UP2MV6qwgu6cuUIOhi/uYMvxaTsXQL3ApRU7+ShKP9pRlCzrvh1
         COORmz28Oh/URrBM68E5YiJscfIbq1ccAjvGcnNdnmhU5bA7XNkEkff6QUfYDO32sLzC
         O40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3tnZJF0J4FIVh2V4hNGiHlt0N6WOS3+qKRNWMuI0vpw=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Qup+ZqS06lNKSYFIEXfKbAIXXmqWyB/vdkoHrWmARc31/IEAgRc4IDYkgukaTPmcrA
         B3/+vi34qtX1Yy4+By2wkG3KAsmUGVUucVqQBdxDo9lngvlpCZsSw76SGqxBuvHK+rny
         SDKbGlyyafpef8yGxTf+iC0ay8siRiTPFhkU1IM+EMH5/DxQDYb90lC3G5gvdMzEmQrn
         lK9q2iN3Ib3vTWEDjT4DR0UxVtPZcxCKvoof9465L2e2gBLDg9sI/OGWpTqWoZFOHNXv
         drLvUDSEsu+ih5Evbljsn0ni0Nnl6iMW+mW0MNziF9EiEsHRgxxeRUCbDp+pj9dXSjPF
         eh8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785526003; x=1786130803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3tnZJF0J4FIVh2V4hNGiHlt0N6WOS3+qKRNWMuI0vpw=;
        b=YCy+FBf1vFU3pFAdm4r5Sdptd47K1ouEKWto6zN3jmMHKwFCkB7yJKIeUj2LbyuAwM
         QP38It8+NqjSZoc1+A0mTa1ovvkkR1PMQzOJM7B4Qdsn8Z7pS2LoJIAsaBC66cvZaArt
         H6AUYEjK47lKQx8+WL26RUJK3+o18/0W2uaPp9Hau6KKU0UjQJmw9SJBQOCsSQ71ZH6g
         vTlpbSkxz/utzhNb2XqbLxbb3ju7PvvduUkTm+zGyJTiGjf92OGX+8lVx/ur6YZP2ckw
         10qu7CaZ/96SPyzeZ4iEffygCFR/9CS1L+Nt0g3ttY6MTRg+sX5XKBSnU88noNLIRSEr
         8CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785526003; x=1786130803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tnZJF0J4FIVh2V4hNGiHlt0N6WOS3+qKRNWMuI0vpw=;
        b=arjzIGB7nmIFvcAFIyvNq5Z2wVosJcxkXoaSP8hsr1AkcZ7CX6DuwzG5JpuOvH8ejM
         k2zR8bJK+l9oGzUA8cOE0VaWGZfDkkLLF1Ve+qDD5shwAM7NLE4533a/TGa4TWVKOMTP
         bqFbRx00ZPD7k1+xWEH6EuvBKSMAY8PCUrTKuY++e+wAAhW5CaL50AVfT0GI3uJnOij3
         QyU38ktxVGs0jVnCs0vso0QPsFsAfxCQP9pPsR+yoDy9m6L1e1UCkCRhY7y+l1ZCJOGg
         1HX39+olRICxbFyhjlzcEEt7xVWEMJoi2dBGcjZPwWoJdpzAIVTuGZDppZAgpaZdwLz/
         9mlg==
X-Gm-Message-State: AOJu0YxgTBe9GWcOeBeYnhAbcinbmT85h93vrl7/Mi8DttWFw8UyscQZ
	PtO5I+DLAQ/DjtXfI6g+Qz/YEy2B9dAHxI3Gv6wuaEAXCiuRiqcF4UKwWVl6VouidphpcI2svf5
	D11V2CIRpKaKwqdass3n7i9Wqr14XgniBow==
X-Gm-Gg: AR+sD12kx1Jt2dIveogvIDEDSNp9r8Fgk2tp9dsLnHUeBcSUnvPrhjebBJdZ+FOseKE
	PFuoW/mYW8VwErwrNyO3jKVOPEreSA0HmwDfttkAL3jSWRx7CVauTet8l65uQH4dW0c4ZIfLqCM
	/XjHHR0DOxIsENGaxS3uIHkbLZ50HD/1+YcMhXJvuxZxGsIMnKOlpbchEwuLnxKJU6SFRki2vki
	DiYAfbHO8PZs3th+ze7VtH36CPQ5PeAhJA8gL5zhIvHJCu6oHyRUZJofVMbJxdTS045LnasTWkP
	Y4x1v1/e7LXxjLFN+RC7OxcfS3p9SYWhDylIKvevdRTd
X-Received: by 2002:a05:6870:ad0b:b0:448:c946:9ae1 with SMTP id
 586e51a60fabf-45905d7f837mr2671048fac.18.1785526003117; Fri, 31 Jul 2026
 12:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175123.52557-1-jwcart2@gmail.com>
In-Reply-To: <20260731175123.52557-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 15:26:31 -0400
X-Gm-Features: AUfX_mzyxxZuZvbXBg6imfz9vT4Z2ybpW5IRlcuQKoTILM5skKTp_ajOY7myPGg
Message-ID: <CAEjxPJ4sSm_jEd5MvziAqVGLMZCv91BLnwdGTpKEvACko8BMgQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for zero when mapping identifier values
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 1:51=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When expanding a base along with its modules, the identifier values
> of declarations are mapped from their values in the module to their
> values in the kernel policy. A maliciously crafted policy could
> create a situation where there is no mapping. This would leave the
> new identifier value as zero. Identifier values must start at 1
> because "value - 1" is used to reference zero-based arrays.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
