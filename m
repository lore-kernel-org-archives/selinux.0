Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285C39A047
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695828; cv=pass; b=HeFXrjyFRvehqSKjDCvWaKRZQV7u59IoEkdXTfqo8m3MNYH17cvgKrvbAjqnSUmwUI0z4yIGx/dgrxCax5WXnNUJ2qfMEtcO3TK34+BCmTNYL24AuAJfrCy+SP0aiGyWwIjnmShd8hPD+5oxuUh7ZWrzUOibr3StIzNjE1gUyvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695828; c=relaxed/simple;
	bh=tOmdfZThQffv1ZuQ+RCtmRhwIYhbjzo1WQO84+4mrag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb443ojWQiRViDUiMMbH7Jt0bSbrPD3BCrjukUij9MQnQnDUPLmfS1sdXAeWxdzpTloq1IlQa46YV+5RidJMazaZUcRTGeXNkyCefvXkEMSDFDqcmxlHOx3mmR8EcrWJc/aCsgbVV6a21o+5PeKAEOewUFxqIwJT+axhmOtYdck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p58/ED05; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p58/ED05"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so36056537b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695826; cv=none;
        d=google.com; s=arc-20260327;
        b=hKZy+uoI8DvmtC3QTorl7bvURuUOYBe3tPYAy80gJjp31OsVK+MDOXFhVuKYhc4dup
         vF/dk2vfkl8PyMLHWs+QBLDP5G4ljm9CxU9tV+yjgnct05k60T/bZ0geX3s2sucivKoZ
         mT01g3THTU2EZfh5JE0q6R7/pGw4aRj/PQ+GkB6aVlfZfLjZOQDvXLA7sBAa351EX6y5
         PIlKeUaixHFpl85Hq+veno/ROHm2uQCYyst65H15gAOlriAvnHzvTA7rXIakmxajBh23
         ZE4U7mynDLAN6fOvx3O7ZB9PrYNH+nxfSj8FA13lzYiEtg2DobSYLrV4UNciHwj8x4l4
         xoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tOmdfZThQffv1ZuQ+RCtmRhwIYhbjzo1WQO84+4mrag=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=IiZm9wlXtPBqsuGq5XwVHC0ceKhxhISu1qlB8Cau5L25jW21yt2UPEasYiCKVxP7/a
         P+2+T/IahEhmxYle/nz2Fhw+lhR2QlbDUW0Qbe+ltk1VhllXvDgPUdRTORtZZfwc0Xx4
         wn0yf+57LOV5VaRuSQfy1f/MQ+GFmB4E0x5t58XlChqROT1yb3Vgj+K1LTJblJsaYIT/
         2d3f/aaRO7gqINoKhU5/FTBswoOBmA0qaP6kO/VHFesxTQhkMwmCHxEl8JIgE3C2zIL7
         TiyKX1+LFbM/saHsWweuMrepjxGmoWbE4BoiZWI/fVCJiv+CH2lhZGrX1J0y8R+lBHtb
         orog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695826; x=1791300626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tOmdfZThQffv1ZuQ+RCtmRhwIYhbjzo1WQO84+4mrag=;
        b=p58/ED05LKZf3aopyvdFCMk2ysI7FMPqHlnYYqRMwmqaBSqamyuQ8yFkwec4aPAkTw
         r1x3wV4rou+HXxPwC2kPms7+cTbE5miX/W3cYnS7utcFR3zTMPFgaJdIZwRVNttRWPhr
         ULwJULg3WND70+eWW1nL37VWxhfzf8jft8jDjug8ySWZ63JHJD2lNcBe3ifCq6MzveOT
         JaT8l//eFdA5KapaMzrDZkqHyJdrIh6kXgq/pfvbYo+KA5s+ZM6+8MNhpym00fSd8eEP
         6Sftq3x41kFvmAjXqc5IvDhVMzN23lbUERPLn4FYKMKvTfx5hodsob4chbJaZIZzwcWF
         sCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695826; x=1791300626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOmdfZThQffv1ZuQ+RCtmRhwIYhbjzo1WQO84+4mrag=;
        b=klEdIdJWDiXACilX38fct++hwD3SoBD6uAA2VPG4Ft9HP9MLTjEKdE55n2AA8EfWwM
         hkSdg+lX1QGlcLmxqxqd8j1pgO4yrdWGKUOXRfEbYC89Br2DJWgDOk5St72q8ZLhBR5U
         4oXKXnmQMDn1MH1fV21z+PdkWpsJEUfi8VRy4G4Huo67MavfevyyUH0nYCbmgFEX5FAt
         JvodyZzveo/H6hsanpw3U1EC2AbU+b4ftDsdntM04zRUXHcDJy4iqlIQJstuObIWNlAa
         VzAx+1U6iXcrEdFN4xgRIR4sdubuM2lWLFkFsPEggyxmsbBO+xEBy/wLlBWpRXpM/lVT
         oaIg==
X-Gm-Message-State: AFq9FYLNMsb+gowg+0hRmF0wNWAk2EpzPxF4zOZISebROHwmJpCgzki0
	4Kn2tQlD3APCzU72h/+Oulp8tKaSBM829iByF1GVGtzrlqdf4ZpxlUnGnkLBnTxiyTZGqBKqJSZ
	YtIWo3uo1+79C+x4AgKSWqodF4m6n0jw=
X-Gm-Gg: AYBFou0wSzfXs+mYuvZ+w2X7H6QL7U1BEWXsL6vZ4xMnjvfZzpoNvRDzNFZf+5o41FP
	KAm5GJgioMsttO9kyIvRx1K7ldoMU+5h74WHm8ywpxhk/l6J/r8qJHOmO/btZHXJghaWDEKUXtU
	IO0RJH3j6SZiCdmtPSAcaxC37XZ7acVSCGxQMdW1EmqS3jwH7rvTxyZyZdqQeOdSd1Z/QBfQZEU
	j+hw80rJ8hdo821ZdphThQdkn6URsYlVJ+CaUIByjGAnOAsB6T2qbXhyNyvd8OXOfHyMqS9yr4B
	Gq2X8NobboBpcPT6EFyP7kXvyxPxikpuRc76sGFlmUO7T14zV2F0JIE=
X-Received: by 2002:a05:690c:660b:b0:887:f4fc:ee35 with SMTP id
 00721157ae682-8a649975796mr78934867b3.19.1790695825951; Tue, 29 Sep 2026
 08:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:30:14 -0400
X-Gm-Features: AclHuK-sYt49IhhXrLiu6Oxlb0E7wOtJbgS0Y9kbdvdBZueVbjPWCSzYeiaXL7k
Message-ID: <CAEjxPJ7EsNi7n75_kVF-b7FXa2oY15Je-UT3kZHz+RazYhf2AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 05/32] selinux: use kmemdup_array() for conditional expressions
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
> Use kmemdup_array() instead of an open-coded, unchecked size
> multiplication when duplicating conditional expression nodes.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
