Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABA51814F
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073640; cv=pass; b=XOFItF2X0SkLe3qlNJcEtZIKsjWp9B/fFud8+CNoIyzcBNVnB1fDIxss0bAc4MFWThxy864m+GbKugYRoYu2xM4ffNw8aA6paSJYuqoR7koPSth4bVhHgxEfqN1G7wETz7aAkPa30MlNRo/HgpNY/657VknmuW5iMD9R5ecKzII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073640; c=relaxed/simple;
	bh=HVKzghCDQl9ijc6bKL0Jhm1/VlHv9SFLYAdlZN6Ckao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd1zaisT58XbgBhycUAIwcyuHxtACe030pP5R5vx6jLnxHshFkXsHgJ+LBXYC+FsoV4T5I//FMQftYeoDkvPxISsjH7UsXa5M9YSZkFInAMNCp1Safm8zmSKJ/5PnLi3t4WrlP+NyI+5kLEoyAd0rvAXJD9DIB2Lq0GosuY2me8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2Pl+XBb; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Pl+XBb"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67989a2f9bfso1236868d50.3
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073637; cv=none;
        d=google.com; s=arc-20260327;
        b=LWS82KHmcc0T2zClvi4UkD9jqqtBrdKBf4BjVH1Ltw+tiEwK3KO1jrMAYyg9cXOrHf
         MxxLV3qN2L07ed6FlfhDxc7ec6oYZBtcsLp4PfC7UMFWJeJQnUmkZ/91OwbHYmq4ujfG
         xf7uN5hvubHVivC33nPL4nCbS4y1MDweNVLhA3Ga1/3S5BF7Lwok+zCQuI93rYbW16qM
         u8I4bVmmNFmt7mOAjSf9RRzFCA/IzHYT+l6fbGOqGcQA9V4Hl09kMLBU5VIIhm523MAP
         JxNkjob6iDhDNeOcGUuAZJ7UbUDJ/jplc/dp2I6ykh8FibWWITumQGsTtXBe7MYqYk91
         cQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVKzghCDQl9ijc6bKL0Jhm1/VlHv9SFLYAdlZN6Ckao=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=mfIw+EEhOoplMyJN0eVu4EtmKoIZlgcY9ef/Zf8VDsbFCloHUQptaezsZhF3NMSwhV
         DTKXDbxsI4yePK65220jiYWFOB/ExPmYTQ/YXoR9AZtaw9uuJeD4Fc1n7pNAhrNQCPPb
         KvI3Yh447yxL8v0nndW7OLFkNfnSY2j5KdmHJ6NeTfNvHf+tAv7l7Nn4WA4dazRoUZGK
         03UGS0jZO6LZjPHGMvhRFhZMAYicNTo0AKOVQozTG5aqB4U5H0yjkoZoE9Zwh1O2lHvX
         PjEfuZN3zEztGEicKKuWG54i+KlQ3YOq256ihDCZhbi3LVPMfUreu46VXeHK/0IWMVBM
         iKeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073637; x=1792678437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HVKzghCDQl9ijc6bKL0Jhm1/VlHv9SFLYAdlZN6Ckao=;
        b=h2Pl+XBbNXAs3ejgBMkeYs9r9RKt87+Pm3c/7riqDyCGevhfZ1ufrgdMBvXOAvdYw/
         9RKpfPTRGX2KA15o3iCd+KzkqCd28XmMZxTy5Q+MfhKyxVNVUUTBDp7ec2tmOM77ST79
         992y7gvnat+0FRGzzP1jZjFyZYSeDo/7bHDcR9m49lz+poB/WcIIUpstuvYslnxk8Std
         PjNQSabvmBxMj+icufEfBC2pRQugQz02AZglma+M8q9FBWNMssHfuDY9Z24FqUPmSNtP
         b+oXRQFPt7h8fqeqmSKB+veF51yDfzSC/l2JpmFCCck150087nUos8+AhVW0BC7SHCAF
         Fq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073637; x=1792678437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVKzghCDQl9ijc6bKL0Jhm1/VlHv9SFLYAdlZN6Ckao=;
        b=irRU9ovxvhyzAc1+OPtFuQL4SvFDKCh1vfgam6nvL6m5YGMCv0KZcDILlyIHni52I6
         NBIkYzKC7SVzXmOFB1XfqohLimbhcWwZXdBnRquuxaQTvfOrQAZ4YxTFRaop+MEJbtLY
         hyjW+bW6fQEH9ZeovZvj2le67wS4i5Trma+DTqMRON1VN4btMxGmpzTn3pFagpWZxKM1
         xRNUB9R8z2xffpRvl0sqpDHkvnNaVbCZ6m0ZPgPuFMZoRPHAjgWlrPAy/Yk+D+ClCfiN
         DijiOZW5CUUSqVbSiDiBmzO0ok5znkgmbAbi2o4vejXZgeeSAn5kmX9rVD/zla+FMpca
         Wm/Q==
X-Gm-Message-State: AFq9FYKsM9VWyDlkNvh3Q/Hcr3xGeAcejjk6ddhHA16E6cUIRtxgJyuJ
	aUHTFH3qnhUjkVGncuC5iOCTmjEtvH8MogGhXjNRTOmzPmkHHEKPZmqk/+TG19XNGUTVmQVGjAy
	KYcpqPiAlV4IUrqAM0YMMujlrM9S/5Zeu5hTFHLE=
X-Gm-Gg: AYBFou131tIZuc2pVcj/6pwWL0cyktD6f6JdFedUB2lPZUMT3eGG1rKxfizHWh7f2IF
	Q/WBWGF1Or8lkBn/RFzyFa3BaB/vlXmImjQs4YGHQ0eWR0CE7rT9vUpOBV1J2jhjvu1vwm1npW9
	Xxx1sCgdDp6NiVVtr2wkSN35IsGEuYJnK/OzWS5eRbI46Yyzjj03SqViMrHBciHysyOkghJubNF
	uasJm29w0FC1klLWy8BPYT3y8+uPpQE79sj5vxqIgehGetBcG1uGd18BsK/+/gpQHUeo8HQNmc+
	5uNJv+c8YK95bGv9Y9yg5GaGcViPE0p/xRQHl8pk6EJGj/RqF9FuzmE22WJfjPfC6w==
X-Received: by 2002:a05:690e:4082:b0:679:a692:630d with SMTP id
 956f58d0204a3-679a6926eebmr325826d50.86.1792073636955; Thu, 15 Oct 2026
 07:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054932.845406-1-omosnacek@gmail.com> <20261015054932.845406-4-omosnacek@gmail.com>
In-Reply-To: <20261015054932.845406-4-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:13:46 -0400
X-Gm-Features: AclHuK_ZWOjeOHWoBQrRja3bS3orwNd-kKAqGNPiTV8uPe4ZJAWclQ6wCACzFrU
Message-ID: <CAEjxPJ4Ko-htFiQKEVqH4s6E4ieAqNi5E4a8uKov5u7xfjE_4g@mail.gmail.com>
Subject: Re: [PATCH testsuite 3/4] tests/filesystem/statfs_test.c: fix a
 compiler warning on s390x
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:49=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> Use the correct format specifiers and casts to make sure that the code
> compiles and works correctly on all architectures. This particularly
> fixes a compiler warning on s390x, which is now treated as an error.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
