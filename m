Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921445DF68
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697335; cv=pass; b=Yyz/eBtRxP9kQqSa0qraCDLou8dG73vRl7i0Icej2B0RLky54hp4i4s610WeyiGgGMxQNstR58zqCeNAVTrxj7PGGEv0JaHO2tMSqphT5yMHBQnWhX/LJul5TSzrrpPlRQorW5L/FdNvNghIqjeBcL40ZKdQo8ASP+LuzwrpTRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697335; c=relaxed/simple;
	bh=98Us+E5RT/fX+P41y+fh2uRLINzawURSRsgJBBoyN5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQ33FF0oMLN0bJ5j4Y2LmStxr+xTapygyZ1VkKaZumrTX9oEx5IYLHf8p4TfbKjtgEIrmBUgLn0Qj3CzWuBTmesEeqenmB4jCKGkYDMswnREUdEz02nmF3m+dNaCy4rVm2cdz1PsD949kNuo5MoGL+YudpLPyTOAjrPsAKdbe1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8YGVRCA; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8YGVRCA"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8ab748519f0so3573237b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697333; cv=none;
        d=google.com; s=arc-20260327;
        b=pntP2yGxp1aRrOCxQBbqwjMfkQRuajlo5aXx9d2IBVHbaCM6d5QcSNooSBlSVk52p7
         2q8XqOZ7XCgLJoGuSfW9qq1T+BP7TAOEmlr06J5Bs6i12hEpPqOEk/by6MWT+zMrd6Za
         mOb2Ghl/4T4rPIGiyj+EZCYY1IdRHA0SV7BdxFn4s2tRcYAB/JzerLYC6pJJdRv492nL
         LV6s2gv3tfeDUD5yPG2qmW18sHYD4VTacHM/2JTGN5hgxT3zg0zM2RBYTICBbwCfyzGK
         1nLy82EgksKR+U24f8R7nqqtWO3rThIfQnehi9St5BkzJGHuhlEoXgANXW1XD9S3FPrf
         tGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98Us+E5RT/fX+P41y+fh2uRLINzawURSRsgJBBoyN5E=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=UjD2GZqp/p0AJTx7OzoOR09Bfs+GPZjOY9gNYB4EeLirsDqRSn7qE1p/ALBNrfdOb0
         EuPH7D+5dUcSt/ulPuiefSpnjmzYd4VuprcXrHHlrp5AOblxzF/pNQx8InZEP4KPyuK6
         NjdbKcr/OR1h0TcGZSL76B9HUwNeUmM6jCw5QTJjmx63HIzQkzjI5IoL/DZPOtCEd9Kf
         V9Wz1XOwisK0K4XE4IFLveiRU/oKXzT4qA75nuaep3qwYKvN7QDXfaVtfsKRWpQ8M7iL
         8gduMso8WhnhsnOn21g4qBzt0R+G9ZVb6BcvNpdJ6sgDqg3wl7YWWOwSxmH0bnYhXOTT
         Vs5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697333; x=1791302133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98Us+E5RT/fX+P41y+fh2uRLINzawURSRsgJBBoyN5E=;
        b=G8YGVRCAIS+bZKSc+oloeDWKAtu1hXHC5zeQyiaDSS9f3a6JZHM4zhfEGQXVJcN6qg
         78va9YZFHQWG5K2zdEsa+zua/EbbGCA639GsiDFbqf/EjTQMI2s5xvgeHlVSKkz5T+0W
         zGyHZkIqSp7pP2RrTx3kzsnwU03Gmb5DWbnccbt3GovRm9Y5uPe5MYkikg1QlXEdLYT/
         oK0RaqdL3LUKFdi0FoW7Iqq2G3qzsxQE5QVtsfe7Gon518OKZXsVNPanKDk1swgnonMi
         GPUQ0bJew9CRSV41tyCYUSsERBjCWhltYNoTLi35UCBXKxcOZRp/G7TGUXfsRmqvmGMn
         JjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697333; x=1791302133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98Us+E5RT/fX+P41y+fh2uRLINzawURSRsgJBBoyN5E=;
        b=lPIXqJokRN7mIpBHLP/njXqsjVADj21F4rKn2G/FLzbSUBMScdZLQfeR9fuHevXIHp
         Ak9d6KLcK3HFclKwqKmYDiRFypvKSyHr6N4tNlZ4SM0B+FLeAOuK7VEitc6v5QxGlcpN
         pO0gFvUD4GlKJCbSMh2BPF/aWLeWRiXWD7yYdYL2lZHOnsFUGdGIFPvU/lf24rUbuOlp
         eUR4Vt9qmYrcQcSFfB7bpAOEwsgCQvzzNDzordawgbXNjKEgmQo6IY/R5AWL/jlRQugq
         7Bgu2sYIJwWmblz4691yKZHzCRdwbxlVPIiHj79AavQ4X2phd8EpRcfBZxuu4mAe3OVD
         A3EQ==
X-Gm-Message-State: AFq9FYJaDHe1vlKT3mlKNtzzWzUC/fqnY9UwWm6xGwxCpReRZrs9/6sc
	nNFOIHDjieoh43s9vshAk2K4m8iRe2t4H4K+qePkytSYpC6/yd+tPXVG6+/TvuvZxYfApZME0HU
	NdyFpuJQj1Lzbcr61e+0M6PG7N7Fa69g=
X-Gm-Gg: AYBFou3DwfhLwwPhvEALjGl2RasCnswGTuMUo14bcwlaxPgXlwz76q07wMOCLCTOnhR
	IhWTsyVD+aU6L3QtQLsekC47J5PP/trvi31gWYaLteknZUj8it55Vsi1jCJU4k7MkSac52lzS1M
	htbn2r/ROYTNugBKcSabxGzGy4WN0y4KHzdpjPDDxIixKFCtWGOewufpf3YljPvTi8ZKhU9nbIS
	ToEFG3B2fw5XlqyUA9vSCEW4GeFFeUJr1GxpLpsn6CJ2oRAAPqNXrhpCK0jCuy9tyL/ueU36bJM
	0UejA8PjUHpCcFwo49S6WADnHOnhM81nTxs64OHMpQLx1nUCJ5l2mYc=
X-Received: by 2002:a05:690c:7107:b0:870:107b:635d with SMTP id
 00721157ae682-8a64af573b4mr87149327b3.31.1790697333530; Tue, 29 Sep 2026
 08:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-22-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-22-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:55:22 -0400
X-Gm-Features: AclHuK_rVBIJ3Fc1g0aJh7-o-FB2UlxXzBEjJygR2518qC22bMcQLi0ZhsgAihI
Message-ID: <CAEjxPJ5e2v6E705UGV05RhRhtDLGTxbzgTNNd+RLkjfB8Q7QTw@mail.gmail.com>
Subject: Re: [RFC PATCH 23/32] selinux: simplify nlmsg_perm()
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
> Pass the number of table entries instead of the table size in bytes,
> return directly on a match and drop unreachable breaks after returns.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Nit: You didn't rename the tabsize parameter to reflect the change in meani=
ng.
Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
