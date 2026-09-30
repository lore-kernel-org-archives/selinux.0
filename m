Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D93BA253
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805984; cv=pass; b=FeuXAqrMCK5N7JD6kDPKfR6ihAwQFq4r/VDTfqUbAg+Ws/iOTTwBSh/NQ8MfXFp/IsldGv70epVNxuq4C/YZCYw2wyJWnklMSmDKE6cDc8wqCVXLbYhk6unZmnfm622PNP9GjI9SWL2QTEfvv7P9u+SBwOrUWBdFaTdPDXZCEFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805984; c=relaxed/simple;
	bh=Ts98uJW+KVA95G4Ynwq+tDyF9eSDbpg2JptonmtWflE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKhvIM0B0yl7MYcK5Ddr6/uzWdvflXXkJbdaSy4w3zG/YxgYFhfgrYq4TF01wXl1MWe/LIwitEjBNeqOoFCuuq8ALyNn18+jef7fNy00uscup+cKfBjCU5NblkTAMzl6fYYtGEpEsVf8Y710gvecd1yW8/fnH57CLOL3o3IjH7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1iEt4lR; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1iEt4lR"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a7af43a358so56384287b3.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 15:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790805982; cv=none;
        d=google.com; s=arc-20260327;
        b=K/iOhbEX6WRw2WhmgzUeq6knL0Iv97eDBzz0FdAymBUt8vG+NAZLgHqX+Ns9WGOJ/4
         ueQFXFb2G0nWRQs7oyT4L9Ymud4njzPCQSL2LwJLSBYhlFXVPqkIavhS6ewmyjGPLZIv
         Z5ZNVYoqv7DIAfNGjxqGuaZQvR/i23vnGCRjgUR5sVO16ffWWNaH/rLa9ooGE2Ig88Qn
         czePE3pfKs53onw2eUVHoTWTBi+zc1GrY3V5tTS+UYTpHzeOWxNYLRnMnW6TVvVfnB/x
         CYdEMm1bTQ+6qkVvihN/iT2wIssX3UOcTJPx7aTzwgQXonrM5Xx59x1LycZdNmNQciKS
         bwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aB+1Ro3E3wbpb34Z+xq2WfQP3rueQyZJgtRYO7Xnrj4=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=fdLQG+mN4bZ6ZiBL03nxMAn6fSX/Lj4bMbjtrnIbqOjZIMlAVYpvP978zzALZFHXuk
         R9HLM/RL4LVvGuzNBLCaiUvz+wvm8TJHokh2qk5opUZ+UMHkP6PCOr/giFWta4ddroOe
         nEDJ0c2br7iGxy6u/4fMCellJBVNok55A3/yAVTSKCy1qMqxiKetpPao+v1iSpm/rvp3
         xQs1fCb2yqSl04XbTPAgUFjpzoVglePV/tbED7/HGL89WJ+kqJOdbWcvFFwwe62689pl
         4+PhVaWgCffsxZaysop+AsVpar//T0UgPytzWEU/pNr5aQk+4v5o3PCAXQJawH002/WS
         W8CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790805982; x=1791410782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aB+1Ro3E3wbpb34Z+xq2WfQP3rueQyZJgtRYO7Xnrj4=;
        b=V1iEt4lRVhOqn4mKEBCMAte4yqS0KEgh/AhZ4M5RCrcy6IW8sXzSsgxMqiT0vTgFij
         h+JCWkemJlbWFaJZw2k9jrX+7Smf0C7ngYCoD2OD9fzIq5/sAwG4ZcNJFSD6d3njki+2
         TCqFOJ7MaqVoSKGqLe38wneYRyI5QWJc1OpDCDOl6ReAo/zmqkqU6RkkcQOEQy4/kgdD
         OM7ekB9aUiQ+m4rMwjlDYtsx4Fueqx4mC9na6z9jrZ5A71xdY1EM+W4GFlNjb/GjVFFM
         OJvKUT53lrJkW1YpVmVKlNAVqyHTMajlc6UhkHq9gFgjYO/d1fAODabeLnG1cg5FLTbr
         /kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805982; x=1791410782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aB+1Ro3E3wbpb34Z+xq2WfQP3rueQyZJgtRYO7Xnrj4=;
        b=w/Xu2YctVC2Du8XkD1GaplQlz8MgBWVEBoJXYCCSrrNIJ+avxsaNcOVKz8G+OG360t
         xnOCnijky087XhakYdFOVHYo5PkX6zKyoyQHYqKDotxYubsBIx12dpFOFv21Q/j56f2i
         kOASEP/yM7kGRkMInYStU8URakb3uIYJPoJueNhgEUqz5ptBHLe/BV9erqh/7bIXuWq9
         Tn+M41VTViCmWfd3ylBptAgT7OA3+pFwMxyX3209QEliyyVq7xzIN4TWzUmIn1YxOhwT
         3xOSXICvJWTv8mR4QG+WlS0HftfdRQxiKzLowcki475hA6XnYzdGkf1SGmYOjnRPQ0lt
         EvHQ==
X-Gm-Message-State: AFq9FYLrIFITte3qbHK1sTV52caOgzL1Rl5C04GzKCkTOIeN9STvGVB3
	WG38QXlPq6TeV00/M8TYdtw+ss9uvWUMglTKWrDouvyuTydzXK6bvEtx5mo0PBYV1b2jPnruI1/
	3W5k+8ZKJHAvX5E1x+KEsGdVRmibjHK4=
X-Gm-Gg: AYBFou1630We2A4h7rImWKWQE6mSjzJSeLmndcGzgo7PkVUyZhw7zMWmxRd4eJCoRis
	fVoYrtxmm/Ep7xOgyx2xhCIIW/lkC6k9+0ijcZf9vlfETVwT+fHUXAywsaJp3ihPS/dBevOpPqH
	BTcj+Q8baZE6Z5LnrhqDdG3RqizRZuOfILt3Ho9/fOp3PWafYs7zFQAtUekAXH9SWtpfLSnl6XL
	ykCDapjGql+rWlUpuVuFD9Vta310zpRHctYC7vS2zcj6aWDyAocVMy1+v6LEu2l2X+vomUC6Qvd
	VKDuRVz3XntyHChy9ArD/QnG1BKQp6cXFcPXuSBjTxa7trMxV6s9fW4O
X-Received: by 2002:a05:690c:1e:b0:88f:b087:c109 with SMTP id
 00721157ae682-8ac91ea303fmr20507087b3.16.1790805982144; Wed, 30 Sep 2026
 15:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-16-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-16-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Sep 2026 18:06:10 -0400
X-Gm-Features: AclHuK97xVnU4Aznmt56PhV8hKqmkoTTxLhBbQTA1LGffb6EJR-MxEVJGfWz7rQ
Message-ID: <CAEjxPJ6yXjtB3qzhej5Pp=p44wUmKxfB3C9HZtmVvUas5p2i-w@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] tests/inet_socket: skip mptcp if not supported
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:55=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> tests/Makefile only checks the kernel version before running the MPTCP
> tests.  On a kernel built without CONFIG_MPTCP, the server fails to creat=
e
> its socket and exits before opening the flag FIFO, while server_start()
> blocks forever in open(2) on the FIFO, hanging the whole testsuite:
>
>   perl inet_socket/mptcp/test
>     wait_for_partner
>     fifo_open
>     do_dentry_open
>     ...
>
> Skip the tests if the running kernel does not support MPTCP.  MPTCP
> cannot be built as a module, so check for its sysctl directory instead of
> trying to load it.
>
> Also fix a typo in the unknown protocol case.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
