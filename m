Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE0156880
	for <selinux@vger.kernel.org>; Fri,  6 Sep 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633462; cv=none; b=CSkfv7Kto5sRYnrIxjknOAxv1cQxXaJs6ajk5TiMfM4oTYnzhQqWMVeaNDhCQ5mS55WHmVofGsLa4sxmYoRuaLkQyCtc9AV3BOdRzopkB5A9EAjDULKpwGHP6W4iRRNbZ8z5AhTrHsdNXZ4ReNp9mGF/cxaus2AFPNEr5g5EH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633462; c=relaxed/simple;
	bh=tLdImPHJWJQnYLhgjqOnUpGfHYQ3QNxlC4031giDAeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Erc2oL5+MhElksKaH8NV75JN8HVL25NQ2hAO/6AtfiYKmyWXp/WDTDq7rUB+oelaNN0yfT4pVdYkKyyVjdtBx37n+9UeFYTn+0vZTdqSDKUoMKVQ+mE9jKg7mGARYBkfNt0T5S7NrdZiridB6SEi/9QQ/Qg19pU1z86alwsyCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BCur1MPl; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BCur1MPl"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b8d96aa4c3so18430497b3.1
        for <selinux@vger.kernel.org>; Fri, 06 Sep 2024 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725633459; x=1726238259; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f9cjM6T/7yT/ne+hV849PS0zrRAZfhJC70EeA5cyq8=;
        b=BCur1MPlRmYf4meK698V6nkMqVLKsb0XZ42+pK5QojoOenB+hdNOgVFBOgSoSNq0FN
         aWSfm/hxKkPwGyq14k1Yi6GlTYuoq/Sl5VEydxiE3nwfvaDPJA+gKuIZY59pkJNBFYtK
         BhAGdUb1+B+RtqCd7nQEVRZJGG30w0fzvpnbSlCL1naNYZqP4gnUiiBK41q99KdfbrCl
         i1P22vOIP0BKpuCvB+Mjk3uwZJmq8+2kK4vYFmbMQqmI0s76QfqGLt1P6Jt8kY43UKZl
         sVTVhWdD4949rUU8D0abDTwSIvCjubPEvbxoA8Mh1QyTFLozmJEEZtRJxG+NmpYlxyeB
         /S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633459; x=1726238259;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f9cjM6T/7yT/ne+hV849PS0zrRAZfhJC70EeA5cyq8=;
        b=VHwxoWUZSFCYpInIaqu6gybravcrtxbmOdYH4XuuJkhN++1WdIA9dSMHcqR7jHtW0d
         sa4DOBK6j6wm+QKZ4euk7ze/rqlyrH/zT0/AbLb3kMXc+I/3X1nke5h0B7/POmH7dMPW
         hxXrkxnqR2Kz+eLB8quGiwXSQ4Lsn0UGZcgTHWEwKwMh9cgOoiRo4rZEwurcyc7g8/gM
         GVOtyMZjt9l40LjmWm32q2JOB80GQQEMEp7v8g3FbIb5TFELsuw5p0eMPpcLId9ymVtR
         OFzwSIv2O00JrQCTxDTWMRaRY69rQ8mm0zGKtIBSSvzTPI7YJq3KCIJktpdbdEfDuBVS
         ybvQ==
X-Gm-Message-State: AOJu0YzXcWO29R6R8P/bduP24nhx+RMI1XVrX5mOGoQXTjSCtgovBFL1
	PFh73kGYGgEZbYuXaRKV3jVyMRn05eXRq2wGtuQCySw2cIne6Rb8cMvfAUaHu3ll7RyUgWWW/Ux
	0TUelGznUopOVid9UiXLR/YA8Mx2gwkmao85rlVsg8KfT+ZY=
X-Google-Smtp-Source: AGHT+IGUt0LdwUAsThQu/MlP8nUUR4DSYRguby9RjR8XmT7TXRV8SmWgMhJWm1H+kuYdLarin8JcIjkDFZM+S6hqErs=
X-Received: by 2002:a05:690c:ec6:b0:64b:52e8:4ae3 with SMTP id
 00721157ae682-6db44d68ac1mr35363007b3.3.1725633459399; Fri, 06 Sep 2024
 07:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903225645.282250-2-paul@paul-moore.com>
In-Reply-To: <20240903225645.282250-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:37:27 -0400
Message-ID: <CAHC9VhQwRwGtwqpAYHyAxigqKBW=3E6CV=KUKa4J5cY9+ULucw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix style problems in security/selinux/include/audit.h
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 6:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Remove the needless indent in the function comment header blocks.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/include/audit.h | 46 ++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Merged into selinux/dev.

--=20
paul-moore.com
