Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160041A797
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159189; cv=pass; b=sEBloYDC9D+6TMYXkx6cr0UxZI7Rz/5GhHZoe2tYzZIhz8udpbPBBJsxDSLSbw/06EPu3nV7MjkZDYDcWYV8Hkj2UFv0l2ul7bt+FMKZKwP6UbOUvR7+8HoBRzT87x4om3Y8iZcy+j9oVhUKi0OrfBKFkCCk/h3rrbv8hR06TH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159189; c=relaxed/simple;
	bh=gWXTsX7cceQMk33jkjaViwGtO8kOH0OhUpQMnRsiNhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT4P55cIzxFNFzP45ZmTVtWMsZcUaZJv1XALLjj0WazBNI+BxOwTqxPR/Kz37fqk7AsnPpGr77ZsAN+k2Y5e7THuNgyxyDD/UooZ2f+3OfFi3FlIqYqd7lW9hsJEVuQmtxf+Js7I98x0HTcWvJap7UjU0xEv9HihQJwxQtYboMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlI0fZP2; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlI0fZP2"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-455ca262ccbso1469700fac.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159185; cv=none;
        d=google.com; s=arc-20260327;
        b=OrSr7bafC6esMTuLZe/g/A227Yxf8MagZ/h2h6ma/DXtE3JCxvJW1ptePoJZkCY2bD
         /ytrfVF1cXH5HrIGZlEvGgJYX4CfTQ1K7Nj6nmNLFjG0Y3Rcu8pHCbzs2ERot+vWKlj8
         L3rITqtPibvtgy1dfEgqtGC92n6UaxG465zUdNgaLr2OOD3VVe65ZaYcAiSBAh4dFfYA
         NgW9R6zOlhFZOff6WAGq4+ocvLuLKXzl9pK1p9mGBvzqLRKVPB7xX9wF74MYqa399cVE
         7wXkw8BxQ+QV0KBlHx3jMxEucLHZKx93WIgLM5uJkD1U4ljUzBAOSXb2EsyHTqB2Yu+R
         u9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7X2/6IFRlqe5jpIo+qdqs7P9bg2x4dLtPAOAoNlDkLo=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=clFH9+SVuyy/6zVikU0OInGMJ7SRX7DrRbtn3XGMAFsu6O6T66qpEzsVWVTEToy+f0
         33XYuthKUTOmT1En4JyrCqrJLvsW70b4c2Ak3PsrwDS5cswmu26E06z/Mt2pkly5h31B
         /C3PLOLaTQDL//CqnSNvZkiYWtvs5SU3LzwwIUXFZtCqi8azA+gmDh09JEotLMH1DLVV
         RTiXTZneyXGSWlvRZpyuA7fFaLIeZIE07uYa4RBZQNhu5bRnLBHzcNCFL1rnB/6eeLj7
         LiSUzsd7zejxCMjyOHhxEHmPCEW2be1szHOY8GcWrjrHnzw06F1r6JXIDslJA/iGolz2
         NbUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159185; x=1785763985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7X2/6IFRlqe5jpIo+qdqs7P9bg2x4dLtPAOAoNlDkLo=;
        b=KlI0fZP2e4f9tSwSHjP2Kl/Y0mNH+dZuRHggoCQMEAGapla5a5NV6qLsW+wIVfGjLk
         Z9CHA/jt8uEB8nISVW87AeixmXHJbejxkKIwXUVqDlrmR972ag1SqOCEaoOQA9iI5SId
         NBn2ty4uXwpaihkcvjbnA3eFtoyrsZaBR8FwL7QasNWRXhtqa3Kx88xP5D4IBLd29SUA
         gaw0eNtvStZ+OYaeEvCIhKok2sOw9T4SoVfQXKfaX0wAQ9oWqXAey8cuVQIp7CrUPyTC
         fJ/yOVjG35Rlfzv+aW28COhTWrVJOymvF/mkdRHQb5j9zfXuk+HSU4sZXAvjD86QnnqV
         QlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159185; x=1785763985;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7X2/6IFRlqe5jpIo+qdqs7P9bg2x4dLtPAOAoNlDkLo=;
        b=P124Y5mj00znlbOykN25YYAEYd9IebZwcjUAEJ5yd1NMYd4NnorQTGDOcZ4dTUUy7R
         5VgGKUaIkcDmFriV8Z++mMjdI0kRywEhh0Ka32eiG1W9tNUpW53ML+TxOAOy/hAnVIKQ
         hmvsOqZ6OwK4dN+/EIvDSP4V/bkhgo8AhVdRYqGBY+dPyTOSEuNccQ7sSBYtVmO6aG7D
         /hMvEhsXNnPKxlyLU2vvHkWDDermuxYLI0Qilpaexztw3LYbPpVZk5ys4+3nQ+Lg+YdA
         ZSyGd0Kbi+j9Axf6ocL9pA26EhM8/BOnEMlpuhnalyD6QtfU6k5Z/ayrWnDPZNxkomhM
         jzeg==
X-Gm-Message-State: AOJu0Yy9tmd6Ep2U8a0VXadqNn+ZmmZOo1P44a8a07PS8Ifdwvh6J/Nl
	GYWdUma/7SkvY7anqXt/woNnkFQocKbnJv3OdLDqQBaPq0VxfBPMHpiWNg4F2FTlxfBBZu4o5KH
	gr4Z1e5IlwosTExA/KYBsSWU0aPMWdeg=
X-Gm-Gg: AR+sD12MCMz9ZbrktmK+YF265P3sSBQPq9jv9I2jCniZGHV35tDjIGVUxQP7oITswMa
	RJOqbQULEUS68XvisxKc6EON7guk0YkqcwoNR9BEYPdgoWtuLvecVpCivlgRUvpQ2VjmDcOgyBj
	zlPPFjQssQwP9qUBviZlUII/knuPPfXc6YE7mn/KnbOsXgJqBcJxQ0r5pCfZbqc8J6MZomwYctR
	xAcrOezzkfK+ynhzboQs4QsRrEcqqV7148FXtwzYZssrhT23owRD7CGBrGq5g==
X-Received: by 2002:a05:6820:4c84:b0:6aa:ecfc:2ebd with SMTP id
 006d021491bc7-6aaffa1da1emr6706155eaf.55.1785159184935; Mon, 27 Jul 2026
 06:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727073852.283623-1-omosnace@redhat.com>
In-Reply-To: <20260727073852.283623-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:32:53 -0400
X-Gm-Features: AUfX_mxM9KGvMkpITtqrv1MFMJLbLgVjK7gVsZqYv75McnEYoscSGoK1NpiT3yU
Message-ID: <CAEjxPJ6JJWbRtw=fQvydOy5QqGLh5ZGZKCnJB4rXaxqzEddJ-Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tmt: allow nlmsg also to the ssh_server attribute
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Without this SSH doesn't work under the latest Rawhide policy and the
> test run fails to complete successfully.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  tmt/tests.fmf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tmt/tests.fmf b/tmt/tests.fmf
> index fe90c69..08bd129 100644
> --- a/tmt/tests.fmf
> +++ b/tmt/tests.fmf
> @@ -48,7 +48,7 @@
>          echo "(policycap netlink_xperm)" >>base.cil
>          echo "(policycap bpf_token_perms)" >>base.cil
>          # allow nlmsg to some system domains so that the system can boot
> -        for source in daemon initrc_domain systemprocess unconfined_doma=
in_type sysadm_t; do
> +        for source in daemon initrc_domain systemprocess ssh_server unco=
nfined_domain_type sysadm_t; do
>            echo "(allow $source self (netlink_route_socket (nlmsg)))" >>b=
ase.cil
>            echo "(allow $source self (netlink_tcpdiag_socket (nlmsg)))" >=
>base.cil
>            echo "(allow $source self (netlink_xfrm_socket (nlmsg)))" >>ba=
se.cil
> --
> 2.55.0
>
>
