Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92A3F4DE9
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697389; cv=pass; b=vEixlQEmhljNJAaNZ7lj7jUodyi95rQeubSy8no9kJRtXduTwIqjXq8Ysg02j9oCH7WXgiPs/ImEwFPeJ8gZ0EmdOE1mnkiHokjp1f5hg4mf1M3Bz1yJfMXYt0tttpAFLeiJKbrZbTI1BexmYL1sUQuF3aJ+K8gR+Eput2mSH0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697389; c=relaxed/simple;
	bh=8A4Y99WH0dO0Ok3t0LaW1MGBNqrrUvRVT+Ql0yIFwAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF0oZVUTyrAk+L58ejZQ1mGIkedpc4A51EUPDe4fhIPGV9pECg7ranlb+SUfHdFlj9GUS1+jhBvI6mao28THVQHlGRaw6D8AlOkTVR28ofF3arQxb0qlCbFz2VJ/jUGU/88q07JKqR1UUkPfkPxyochAuoMalQ3zJkib85tt+GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuOsxfKs; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuOsxfKs"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a8288165fbso41314297b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697387; cv=none;
        d=google.com; s=arc-20260327;
        b=FGIMtCSEWmPCC4h96Vm+84kpQNxuE741UihWZRN0qZioFlBbT6x+u/ieARNRkky2eL
         /WjN3ykccDlpGYe8uyUvBjtmS4kAXN2/RflhuGpJDBXwxUPHL4R7XTiPZPav9HuSE9Z0
         ZNprpB8o3eApfEbbAFEkSQuPTwkVy7mL/Lk3JXM/3PaggvhiBIuCxydR4BsfN6wOY2m3
         uppB+QELu5u7C7BHvP5jQHMUsOIuj/5SY0AhmNW7L+kZPbHLKXyssM1i7RVB3mZlr8Ri
         J8vOkLgrCQu7x6Uq8TKqOTbTWmQjxlZwpp0KoE/zfLVZdU0b8KMrge/MAzMlmeIs7oTh
         rdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8A4Y99WH0dO0Ok3t0LaW1MGBNqrrUvRVT+Ql0yIFwAU=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=YQ+ZhXI8ege+RKnCBAxvNjahQhJW+It1aztb3vHvsRCxdX43J2dT0U2YLy+BaXmVGd
         Zq2zd5jm0oLEHlZ7f55OqNwDNNEzt5SD7knxT1IknzgHxQU2JRYyKtJmARYHKzX9WnCF
         hNAWFTlnsvRBd6Q6f3NgoPD9riyHdAMwqotWyocv77rIXPDLwj1kry97/pAc4xFmHlkQ
         dVIcYdJat9iRLqjT7ahZulPidmZQe5rpLQHASpMHbwNHNMf2r6raiY+EbB/+nWYCIR/A
         TN89i9qrbl6umkkbz3TzgqNATAN6e8JXa5LOSOXj3S5ZGIuwPZAa0iiLlgSOUrrtWCA2
         gRGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697387; x=1791302187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8A4Y99WH0dO0Ok3t0LaW1MGBNqrrUvRVT+Ql0yIFwAU=;
        b=kuOsxfKs6hqInnKBcciZV9YIHR+8kTDT/cOiI5LJZDJ+zm0q1p8nS8LnmIM4CNSAoj
         EmI3FAfViywWQsGhI55Q/BpEXWQs0Wk1KFDI7uxQ0cMW1shSgklYyGt18Px/+3ZwA+Ja
         cxaa6p5gg1T2dBKimQd1MYhJfofYmf1hp48hwTPa0/W+3i9WRH6M68b9lnci2HTmZFa7
         kHHpAmEDmR0W8WM/6Lnjzh3YaXfPAWi9rvfhRxLfW8F5elKCDsbuWBKfI/ev6Pq2XniX
         YqBgFn+e1aqDMqnDzDxxBAK2Sd6GavuS9jgWmgLwkJkG9cFPgDHIefZSGDzuvOFKDBB6
         bzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697387; x=1791302187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8A4Y99WH0dO0Ok3t0LaW1MGBNqrrUvRVT+Ql0yIFwAU=;
        b=szyWVWhiuIEuXO/hOflbBLW2iG49/6Xqm3xw7RQ3SEufB8H3XOux+Jf+7xEGk8z6ny
         qJQGvbfh30VUYYA1o6PiS4qWvvbOitwVSSX6kLhMm4orGIWzgRBmpAE+a1USk/gAai4G
         dRA7pUZMztV75GV1s6/UhI65/MYlAiOMrgCPUikGm9jqGwO8Wx4Rs31ioaeYWWSmHAUZ
         dxncsFAa1ogqlN/BqflONUDOxW2F+Q9XNq66j51pypJkVOIz4IfT62qb5EizEXiKxvYS
         28BXOv0FF2LoMbjtyC+N9da8Fo/pzUOp3qdxxHwAyrxBxJCOTCZYgv6544sOM2bVLnyX
         MDQg==
X-Gm-Message-State: AFq9FYIpbKgpV7osHYCswm4psinrpLN8z/teWHqPwOWPSRexDN7zxwge
	1GJJILPvRIfqqhrnmmihldFLUb8Trv/m5hFAPNW3yLix7Aqu4Qc4mYympX/5i7AveuzmwwG5UWd
	3+9rPxQxgqoEpe51t0IwKQkZVpWu+S9o=
X-Gm-Gg: AYBFou3ZRTEIv9qpbCapArsLQ7g7RAnpOwcycH0OaZ4IybzA/7yHLttzpJcFqgdbBpd
	vYU+YiF3NrMleXIc64CbKTarMQHoovSQVVpqLbK/FHxGTpE9HeABdE99lTeWf4EYFW1pDZcgOx8
	L+hO7m2S53DuxPpo2DTUORNAfBiZjrJyrEwAn9Bv+QNK+882/jXREjGMUBfH5B330G63z7H2R8Q
	Muc8jwPYd+yZIW/Zv7JA6NqZ8t9bH/dWtX1+MEZttdzRHZNbJtu3bzncMCqPySasCSmCIMqtmzk
	nvKGYpHgeBLGu/2Dz/Lu9Ue7t/wEcgQkjIKmn25vs1z+D6Yrm+nCiJc=
X-Received: by 2002:a05:690c:399:b0:879:44a6:1076 with SMTP id
 00721157ae682-8a64af573a9mr91362217b3.32.1790697387184; Tue, 29 Sep 2026
 08:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-23-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-23-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:56:16 -0400
X-Gm-Features: AclHuK-RrTQmu7FG20oPf9dra85aSlB-Tv_OpeUFV5WhOlwGto1H8NrXV3YkZ34
Message-ID: <CAEjxPJ4OSm7LVp1AY_Yu0DWc99tmmGOcsP8jkrxhuQf3kNyvFw@mail.gmail.com>
Subject: Re: [RFC PATCH 24/32] selinux: factor out sel_sid_to_payload()
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
> The context, create, relabel and member transaction handlers all end
> by converting the resulting SID to a context string, rejecting it with
> -ERANGE if it does not fit into the transaction buffer, and copying it
> into the buffer as the response.
>
> Move that tail into a common helper. The values returned to userspace
> are unchanged. As a side effect an oversized context is now also
> logged for relabel, which previously was the only handler to fail
> silently, and the logged function name is that of the helper.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
