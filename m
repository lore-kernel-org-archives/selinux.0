Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950001C3C11
	for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258268; cv=none; b=to1KjWnRzqrVsapmsbAR/X10yNyxp0WUiAa6yx/Q78oyttZ9bFgYkI2Zdc2mses2ytbBC5uUlx8R9Pud6Pvecz8mScXNbJHiXK82WL4bEL2MnsRZMgSIzOCrzI6dJfiaiNrM+FpaH7zqVwla+gC2RmJqK0VC9dIn8hzG7ws1XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258268; c=relaxed/simple;
	bh=RI61nj5Xpi3g63pf6MmrqXj3YI71ZQ8vNKUPxwaYJkY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=pVXz4QFUDrngBzMmQT6bqP2v9ZqV9i4nCo60TXTsPrtUkYpCLurTYcKfyHhGRtqk7vShKe+CeHdjJUDanRRvNODCTHcvZGNv5g5sw4SmFzk6SqbM6Kka/NwFz3DXQazWsAbIu4ReMqIlt4PkuJEqLZpebb4q+pXDhdKSnffDUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZX9+ush9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZX9+ush9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87eed34f767so13304306d6.2
        for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761258265; x=1761863065; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ltpHz74jq2314hEgAIMxZgJUxyrXRNrY30m3sAX6Y0=;
        b=ZX9+ush9E9fMDqGpCpziy2RhwCNo7k1a0fMcmSGzSAhpwHNDe+ZTq/TWZ0Gzu0aB5r
         mnqOQ5Mee3TenzjjSVj0mz7dN+uPOTjrdoQZqH6E33LftU+PVmxEqm5qdwlngN67Vwmk
         PR2zgZkfRQvuOwx0ohwrpxgKWafXtzAajDXDGihCoM6P3LXLGMiAsM+MRM7Xzl2NWKxF
         +yxnjJx9rRfPJFbQm25+2Rc4PRoWb9CIY0SIvOJQaxm7Qf2xmZqWMUs/mSBwkeW5n7BT
         dLfveqmGlKoZG6k79VPFrpCz6FjwPjyN8oaeLcBwY4b1fjy+mWoqpmADlK1Y/Kcil/9M
         Huyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258265; x=1761863065;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ltpHz74jq2314hEgAIMxZgJUxyrXRNrY30m3sAX6Y0=;
        b=nVyH0DfnARgyWW6II0W3slZSxj4p2vEyIrSNKRVCpw8CpDZ4M+G7wwo7B2Vjn31q5T
         pQSnX1NVj7cNiRPNdTpkkwKwZyWF7v/y9Nu70b3FAfwj0sKbkbDOtQ23MVEtHasPRF34
         xiU1Eq9/+jZr8TYY5WLnV94QvgS6wGWDLOYppbPZuAA4Tb4ygm19X39dI3cOsRkHCkoA
         BRgeqF18e9Qft0z6uTd0iurfo+Gk2PO0jBPfezNACQ1khh3CJoec1h1Knxf8osbgRZyj
         TLse3rtek3R3Nc0qMV4ubs6bVhe6E+44FDN87qCMsbYH/Th8hn9e4vPqMJmZkBtajWRE
         v3hg==
X-Forwarded-Encrypted: i=1; AJvYcCVEPjgpCVflInotdKKI/OjcsUlnH6CNsjmPpquJmFQBXyZardWuAHFYS+fNXtb8l7sILYWd4+OL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ydoz9/Uxfuckg3p7r0X+20FQ4T61CFC5MmBAAAqXZtEr0rb7
	np/VJPYykRjfSnMTlBMN0FR3HIhpomUcQOcKACdh3+H/6ncrKuS4mCnrTtOlg7WChg==
X-Gm-Gg: ASbGncthBUDG261Z9ieXajbrpKed4AQFYTrhCJL3lML9D0/gQYC9S8xCvIS4Z3FWVBO
	1j7aELpkEIHq9zlK1phvGksL6hSueCEe3LMv8dV8L51+Can2JQrV4Ddy7d+pvisH9E227ZsSEmN
	KPBQxBaexxir7/rYvvkd3ZnUzhMTkgIekdgNonZo8qJpzRUiBBSJ4azuBbinF6ilL1VIg06xClg
	3J+DJ0QGoILmkYY1syupk5/gLZU8rK5asEV8wbqOpJktQ+wzinthBfgju0kT8kFo8wfYJn4SxCs
	MVngmR9iQZj+57BZzLlnFPdfPH/QK1nw5DK7dhjH3olX/DvCaiz9ehAzzKZJ3MAo6mrNTDl1CwW
	eu4yCLrbJ0zgL/p03SddJ55+RvGjbV9HJ7fLvsn7dp5PoNFrqLnK1kMjVkk9MSWp4cWi284JkAQ
	tNG7AfEsbAH1cDpMZ9OrJffzzVoqJUWHnFGTcXIN7tpWRpcT+wbMeXKDs4
X-Google-Smtp-Source: AGHT+IE8jv3Je8Ul7XlJ8/oqI6J54riHmM5iZFaCaN+Iyggje6kxt1OT1o4JcVmt60o1zEpBWQteiQ==
X-Received: by 2002:ad4:5ece:0:b0:878:6fa3:842d with SMTP id 6a1803df08f44-87fb62a1d27mr1305436d6.0.1761258265418;
        Thu, 23 Oct 2025 15:24:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f9e82908bsm23214256d6.58.2025.10.23.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:24:24 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:24:24 -0400
Message-ID: <5364449d2011c1d394a7bb30109b923d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251023_1801/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v4 1/3] selinux: Introduce a new config to make avc cache  slot size adjustable
References: <cc48748e9dcfa63fbbaeabad0b2536a0f602cb1d.1761217900.git.zhanghongru@xiaomi.com>
In-Reply-To: <cc48748e9dcfa63fbbaeabad0b2536a0f602cb1d.1761217900.git.zhanghongru@xiaomi.com>

On Oct 23, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> On mobile device high-load situations, permission check can happen
> more than 90,000/s (8 core system). With default 512 cache nodes
> configuration, avc cache miss happens more often and occasionally
> leads to long time (>2ms) irqs off on both big and little cores,
> which decreases system real-time capability.
> 
> An actual call stack is as follows:
>  => avc_compute_av
>  => avc_perm_nonode
>  => avc_has_perm_noaudit
>  => selinux_capable
>  => security_capable
>  => capable
>  => __sched_setscheduler
>  => do_sched_setscheduler
>  => __arm64_sys_sched_setscheduler
>  => invoke_syscall
>  => el0_svc_common
>  => do_el0_svc
>  => el0_svc
>  => el0t_64_sync_handler
>  => el0t_64_sync
> 
> Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
> to mitigate long time irqs off, hash conflicts make the bucket average
> length longer because of the fixed size of cache slots, leading to
> avc_search_node() latency increase.
> 
> So introduce a new config to make avc cache slot size also configurable,
> and with fine tuning, we can mitigate long time irqs off with slightly
> avc_search_node() performance regression.
> 
> Theoretically, the main overhead is memory consumption.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> ---
>  security/selinux/Kconfig | 11 +++++++++++
>  security/selinux/avc.c   |  6 +++---
>  2 files changed, 14 insertions(+), 3 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com
