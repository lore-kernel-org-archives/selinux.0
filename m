Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDC4FDA42
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697939; cv=pass; b=nlwgRIxA8wiBKesNQC6OH8xUOmPBL2P/SItVTPyS8Z+oz8s5Pc+sDHfE3M4F8N+NxpW59lHBwF1urYyB4tVMDubuBpkDyJqhFNPn4aTNvo2Nr19pMgRoBY4eOHiBzAn2ghKPiTpdDwTsvU9afBSugSkkfN5q+kSJXvaUBavw/4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697939; c=relaxed/simple;
	bh=DoInOO0OhSDQA+BrDi9dt4ebqpo8niHBuYySMUeRo/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLmSJYfxyuXZsH2skYoeqoaOvaBMeqn6lvmjPazHB5akWoeZ7f6/y8Bj9yt+I35uBq/0x7fLuvGwlEiFr/sCDPD4B5WoK/ZnO1HUqMzLOGiQ7iGlQaxNn6oJhirxvPaIMLVzKrC3j4cEhnvm7SvT8353XOlMpK12dtlb2Lisi0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKQK5S+M; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKQK5S+M"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8ab4b4f3d6eso2782257b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697934; cv=none;
        d=google.com; s=arc-20260327;
        b=Opf4YHwsNyXxUc7mifn/srKY6KIVW2wIKoNIdcqLQUW+v6OhkZS1fwMQ3D7En7h1WF
         Px61A3zfBy8CTG7nXMOi5GbRMMp9S1DWlaIAUF7niTsPyDdAXiQr3oVIAufxJOp0JDR7
         Exm2hXq1dCsfOjvcaCkkElTgozT6fNxT2kh9oY8PpJ81GFG5u0w9H/TDAUCMip9r1mdy
         MDDLvvuh6kuuFKRqaL1sX/eTWmebMJOzeuaMOR+q3zV8omTrtInBZ3d9fD7zAiEUTubF
         R2vfa8O5KqWqsm+5+rLeOWyYp4WCOeEzNMt9zIndLes1w7xjynF6HYPDj2wa3IWinYQg
         XK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DoInOO0OhSDQA+BrDi9dt4ebqpo8niHBuYySMUeRo/Y=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=qQfMjATH/FaaiqcJwpbkoua3FclSchKmiO1rlnhPwBQS6vqFeo9H98AIsOI803CEIr
         bPEqSTslVO6b77JTJnb/XLFFK0AnKYTsbDuNernPyU78XNa41LjfjGTgjXc/igrrLPJh
         zxnsT9cy1hkn648Sr+QfDdW92j1eGWujiFI9sdnczDf3ZnypGBXQPkErC/hnMns5Np4X
         pHZjCpBjQ8yNji+06WokoHZqDZ6XnxuVyFppwmix89qZa0nBEGhL8ktMTNul/64lU68k
         4LGAM7Rwb/d077rjvMD5n9NM28TWmMl474Ch0zGqo1+Az87U6uxQDVJ6fdYdYkKpYdNs
         Kvwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697934; x=1791302734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DoInOO0OhSDQA+BrDi9dt4ebqpo8niHBuYySMUeRo/Y=;
        b=hKQK5S+MrMEGBLXlP5wijk/PwBeQs/2PTPPvOJh26oHibiPh+jB8Qn3NlD65IWK+n+
         7F8c6n34L0ItZFGBJ2lsTsbbbZoXm4vWhU+xyBp+TBatsWxfnXN3Ls9B5jeW5qs7cy3x
         hBKn4AYMP80ndaXocDfP4SPpJ1zdDW2cYpsr8Blkp1gFCgdllcHtEwjVrSxZ/saGg5y7
         RC0IeJbIZmcTrMlDJuxNJ2iTAT+Y/SN1Qopml9mXCAC4puemIoZjSN3873D2rSowjxx7
         ryVDQSEtAyv5E5cgsSV7Q+4e6bQR7CbQBCQaLxA3mGYTBAonNChyEcoQ0hIlQNOPqnlF
         mixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697934; x=1791302734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DoInOO0OhSDQA+BrDi9dt4ebqpo8niHBuYySMUeRo/Y=;
        b=gcuuKMu1car6043nNw11QiEo3Aaq1N238GOrm8lU4ZZu2oyDFaKIKfp9JBEAwSLeXu
         1SeWRGdrXzUeOcshgtc6+fTXPDjpSs7xdnREKIjPo3I4KHegGFbT1WaFSM+CfpK5nIie
         yPLaMsoCTO7g7LmL14oTUt6fzkN8YgZltjQBqL8wThO30qUEPLFCJVOG3ufzYa1Chqr5
         QFF0mPvidk5rAIh9lowR98br9lnaaNiThMUTjniUAIrRYSexycbd4esSlk4oB10og8zr
         rt7jugq1FCnYfqm/q+ZVyLefyYQQhacDvxNdNQBXQ6Knq9gsC1Nlwq+iypwSfAExdyzC
         co/w==
X-Gm-Message-State: AFq9FYLwIITkUH6fh0x2f4br/rEd6b/R5zzwaEVTONQpubWMAWZptCx9
	Fn/acdGuNo8td8mHPyw4YiInlQxfdL1KuM/WPN2/pAUFpihmzo2dNO3AFLx4XAai2FEzJ7tmaKX
	8p1CVixLxGczfpmL0iEdkehcCQ7MFIPm4C4DE
X-Gm-Gg: AYBFou09hj5rjsgq4UbtczxsEiNhaCUMhzMUkbMkzvZ8u7xb98rX8OuA4jic/lTRWHE
	Jiaii5bCRv4IsSx4MQvscbeVfxzmFLmXUXxP1YrJDwbNbeE9tOnWIO8wv5rA7gT+a8WS9q+0Fm8
	ZizEvKMHTEWF3PRR8n3k4AvQGTvNsRXX06qntLiKFG+DXyhiuS1dw1WrR9NGKyLsGSf0OqgBcOk
	luM5kr+gk5V2MLvT7a9khmqQQYGre5qnUYbkAdJyxmNZVl2yZIDpTr5Kd59z+y9iARWtGjFoQCt
	Zs/8U8AnjS/Ey5c84P7G5B0Nd1PnPexIY6y+on1tXN7KMvfpvzYszgId
X-Received: by 2002:a05:690c:7283:b0:8a8:90d6:5746 with SMTP id
 00721157ae682-8ab3c9d6927mr15247847b3.6.1790697934591; Tue, 29 Sep 2026
 09:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-28-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-28-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:05:23 -0400
X-Gm-Features: AclHuK9mzl9a7KtX7GevaX-i4K_-HeVLH1bJiFI3u9UR2WVuXQal40a6DTFBmT4
Message-ID: <CAEjxPJ49kqU37jSwFetiyaWqawFDqQQSsxR-mydk3MQx9ofR9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 29/32] selinux: drop sb member of struct selinux_fs_info
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
> The back pointer to the super block is only used by
> sel_make_policy_nodes(), whose sole caller has the super block at hand
> via the written file's inode. Pass the super block instead and look up
> the selinuxfs info from it.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
