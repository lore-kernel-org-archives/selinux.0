Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D94E66AD
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689870; cv=pass; b=EHPTO3toTe2CamK2a5TQQDagUVo599YLk5NdBUUlnrKxEo3I4LA/g8LBott2kBGgvDnoUrCtmZmIDj/3V9lWYFpMwYucoF/Nm8gWRJqks3wDFvf78JwDTF0mQYECAzOoX+ERoJF+nL7AMZzpdLMx6Kny2R0d8PFbVCKytYyDTHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689870; c=relaxed/simple;
	bh=9L3zmwVHhWaF07RoS7QcIXv7cqWyV8f3h7uHbDSgZOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVErt+KMBUA+Htdt0pI7tim9WB7C9n5pHI6/bW988bKV9hBAjCZhlxCeMVOEqjxM6hFG7Dh1e10mncE52v+NMbc1JgXlY7APbHWPhCcwia99D9se8BXapxzrkMcL8EHOtm4ouafVhqNPAyyD4oNZz/SaUgLSJyzTy8Epdo2pI9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY9TlDo4; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY9TlDo4"
Received: by mail-yx2-f38.google.com with SMTP id 956f58d0204a3-675617094f5so787007d50.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790689867; cv=none;
        d=google.com; s=arc-20260327;
        b=bc3hcT1Nph+e55ncILsx8ed/n5ZohqYkeu4wpsnLM4waCx2zt95nx1OlMCBimyVHGp
         xeSfpiZrmsl9SIaXyI+QbGhgMJZZlVKjG6IMLGgQsV+VCumqi/bcmkmxWbCnBa5HrYnY
         QoUzHx8UkLq6ceUPc0n46yCbZ+8kVKRcBLjAR5VspMOfaBi6qDWRib5nD0J+Pz/HiQUD
         0Kj7yrifKSvU5S3Po66R6wQfo92CoVJ1J7aNCdPgMwaAz2GTvxY6BaXylRfWd3hmAcLC
         VYWkPjwtXSk78o8cAow3nHky35e6pAe7LQCHnvySHXefIhBB0unf+ISnkr1js/a1DUgn
         cnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9L3zmwVHhWaF07RoS7QcIXv7cqWyV8f3h7uHbDSgZOg=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=jkpRcnBENqn/db4mb9tW9eKsJ6Il6x9KzQiP2dd2NWmCReQemJYxt3tGaazakn0ZNh
         rf99SbCjUhrE3q2PIK8ekpPRoo+4c5FEc8zuq7njOZmU9VuNZVT4LxgOj4o0742VCOmO
         QFPpEwZsaNfviJYNHMLi4gixp/QYuSKYUF3D90ZIgZkMxoUdxtR8CO2vD/RoNdpoJkFm
         /61UaGWZLE8cia2QzkSnEZTrZBKVlcwySfzvT39ikiXsOTSZYi0Zn0owlh8Ged7u82w9
         s2MgtRLTtrHdZQunpp6LLGzdZIn3xNB9DJvCMwqS4qSl0OrlavJEaPG3q/fdZmlMGHXI
         eiFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689867; x=1791294667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9L3zmwVHhWaF07RoS7QcIXv7cqWyV8f3h7uHbDSgZOg=;
        b=LY9TlDo49D6NDjJq0cSauzBmo/Y5DzBxm2P+fCI+FGCLMAeRpwTZUZzqy/YMT701Lb
         lS1lEQLwXMNptdlYAQ6GEZKBJhvWjwo1vXnaRlfzY6dnhBguTLAXI6SDDjVRRpSJzgUn
         UaOXHYlzd9B2ZcsX0jeTQpa6mfWOjc3TZegrh8403BNWUdARw3v+xTHRo4ZaSDKa3DZb
         Hos1B0GgJDV3gnygrMfQO19tvQU/cW7r9x9JTbmwwpXTC0aeGLwayQD76GxZVcwumBgQ
         OKZchAhO0w27Dm5wqYYx9YXl/lHt6XUoc06lvRcn4Om059rxC1JS+yR4ZFs6jSB1Llw4
         k/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689867; x=1791294667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9L3zmwVHhWaF07RoS7QcIXv7cqWyV8f3h7uHbDSgZOg=;
        b=lSlkMirSbZAfWOZBZ3ZrZCVtTIHga+4GMUK1uzB2KTSFPUt07wV6PxWd8g/lEIB9xs
         RY5ORqWGgFAStEx8nBsUozxtP+kVCwBWCwneoXy6mw+3pdKDvZfuxzXFdMEGP3ZBFzvq
         CIHfFMpCYW//yMO992rKPJjN7o7F8B9J0lowmIdzU7Vqv/TbQw4vNZNspqvlpBizHnYV
         FvxXmrGlm/ly6y3uIgCVrcmzRAs652YacQmsJJsf8EShAm5/cJmKuf41lf7xD3awdSCP
         kL57tMypo6+7XPqO0y/lICjtDGHyBZsoG13TGD5iqjRT2Clbu7+YPA7fI8LhFvLiDo9u
         57ZQ==
X-Gm-Message-State: AFq9FYL15WDapgAwBOAfvq9eU+HDEEPlE+3C60HnBXKxQlXB7gYggBvS
	4ZE9fUCarkK/BMQAQtWcd8KRzDE7beVXY9jtqJvzUf/kSHJbnsd4oZ9jRv//TR31/eQroli32Fl
	buBAjlClPJF8+bsGhqlw4zGzUgJAsvBBNpw==
X-Gm-Gg: AYBFou3BntcUnDJdSSYdZmJnsWtEStnyub5nPVVVxaNEDIEa+bHz352pmp6/zJwvUdu
	LVZhzEn+Fs877NML7R5jniSCF9MYaZP+hlNpxhcR+cwMyCPPmy1w87vIfAoxDJnTXYkoFeYyILc
	FvcWlxPuRcyKSSyM87JqraazLpUWXj9Phe1Apls/soeaWJzPqzLqDo7uncKavp5f3kUAuwbnpxb
	bTH+w4yw8HAQVwNNDvFFZ9jqpV88+IT2SgPvDuTuq8VcAHswFTsh9ACYMWYmCKcvIX9/3GhCTwj
	3xXBqr9sFfgDhiwmbe7qcgjaaeMmXAAn78NfzsBknEYfQUgmc8LD8Cw=
X-Received: by 2002:a05:690e:169c:b0:675:3507:46e7 with SMTP id
 956f58d0204a3-6753507693amr3941941d50.24.1790689867578; Tue, 29 Sep 2026
 06:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928175830.78464-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260928175830.78464-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 09:50:56 -0400
X-Gm-Features: AclHuK_96a-HztoWv2aXU5f9BU-y64lKWbh7mcwi2KtJHW_h_2OfPh9HSwGyefY
Message-ID: <CAEjxPJ5Hj1o6EJPhwCUL4jRRr=qAkJbJ6U0HV_RDn3fp7xHwLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] python/sepolgen: search fallback location for sepolgen.conf
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:58=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> sepolgen.conf is a top-level configuration file (not under the policy
> root), so libselinux's selinux_policy_open() search does not apply.
> Give PathChooser a first-existing search over a small tuple of
> candidate paths and add /usr/lib/selinux/sepolgen.conf as the
> fallback, matching the per-tool pattern used for other top-level
> configuration files (restorecond, newrole). A single string is still
> accepted so external PathChooser callers are unaffected.
>
> Absent both files behavior is unchanged: PathChooser falls back to its
> built-in SELINUX_DEVEL_PATH list, so audit2allow -R / sepolgen-ifgen
> still find the refpolicy headers on a stock install.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
