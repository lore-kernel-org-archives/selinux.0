Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113313;
	b=QGx+X4EstDpalZm/AQvnBJNMGoZNgadwK5vVZVJda0eC6wrmtmYoq5Vx4f+OPm3melYf
	 uAxuw84IrdEQat2fgm1SIZ0iY+nEPr82SqeVoh+CGxr2beOgEwxmkMdRe4fIBLy20ZLQZ
	 RJWEBg9jwzawIdhfKGi5/KX5PENnuKqMuluMH2BOO2tg0K+TtoehFcZiV/F0ZMSQajCj4
	 7vz3EfMfZCxaKtBoeKGVEpQvRt0qKyMKHUTyKXrqiAQsY+6s/6hST/jJMsSPL2drrPUax
	 udT7Yfs/ObOp8H1lav+WC4VAulX+8YsceVo+WqDA7bPrA/YFn4W4lhfh5TyuwSnQwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
	b=UI3bYAI0Q7th7GvimrWPWYORGcUXAtNNqqhyHvubxtSmvRDT5bL42qZ0/va90Y21z1qx
	 6DJydKcwsnHjU4lmXoFNPadz88Mcxmr3XFGvO25eusU5wfY9molLYskQIMw5xW/7a0IMq
	 xsosnQE6MlyIgUZQd3H0pvCoqWG2jHItvkTKj5oXQhYYoip8i4g3BKcMWoZqXh5HIANIF
	 b2FKId9sPTq8FP24cn4Mz7z21kpwTOlybqzzsDbWgSUOujEI9IuibcmT1XG6OiHCFdU2s
	 10f5k2DVLzyLgHkDZdNUWIVCq1VbSllAA3BzeNkS/x8JP+CcQMTFL3cAwfR5GEHLsow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC4606BA9B
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49FC4606BA9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso8645a12.3
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113313; x=1793718113; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=Y4RCI7rtBOy5b9y0FhCXLw7TxjLGKoqP7U6NlrFD6q8Ld/t9Vb2wuRj4d5nvLDYNmW
         zMd4eYz+V4fCXjWsiScL3PR0/jOkJbs4iZB/1XrWm7L4dnIYl6zkHE/78s3Hrx1q6Waj
         oRJIZTMGG7SO+raSfVOtWoAkLKKYIlEQb+1KLlQzDppE2+agB1IrvZx0fPK0fPBmKjT9
         tmPkvXERI+kZg+dU9H69n1AXCmu2e6B/KgFFjnm96LtaYjcsqwxw+UdhXxmTEqT0+3z8
         iwxmEvIrStDaVsjlO8tSuKQpCLA7DgHptE2QvFviEIcgFaBknjMXm9B00tSUipyu0hGO
         dOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113313; x=1793718113;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=t0S6FP6wghU1IrBujLM1+sCRNxL6hC+rVhfqeKRxZQlHm8YSftzx/I3IuTlYgWHEXS
         BpeCW9wp7RsMm/6RrRNbjRxepxO/Q1NhFb7fNnBdLInyleq7/W0Gc+GLV4+RCm7a3ZCs
         ivYJ/mAzyEGcQ88B/lpdnYWxpCqWK240ZkG/k3DXusZxpzV8kTdt+bPe8p/Frb+jSshu
         3HDe6omJHPA97cIXNt7EzyxDgjiYMMH55p2o1Cgh3wMg0MyrIvgxuL6eWvTq0AndpV8C
         4uRc5XE3xF2UhQvLyya1LIuwhLkYTzlZZI9HNbIAJujStO8WB5WeuK6xeRrynCiJZxN5
         PrqA==
X-Forwarded-Encrypted: i=1; AKwUvBzkznC47qPoKA6z3/yAXOC5dGOjgIIrSv1melfr06hv7VqCWuRVk5WK6In0twSttDpZXVDuJ7V/@vger.kernel.org
X-Gm-Message-State: AFq9FYIrtm2/tvgtRV4DtD4d76nxHD2tDAyVWLsUxXNkHOlLc1wlm811
	BWzZOHJDZqEobsxwT09rtrlb+e/qvUSgbiPZHlIrfuhUMmEmF1bEPf5o
X-Gm-Gg: AYBFou3yLunASbBv+o+TEMhAO04G7jrzLpsDaFI+V5XGk4dnCctyh3Yl76OvpA2LsGV
	7Or1h5JwqxEJ+F4AtZ0kSQiPfZqshpoX6ftQNHSUjujcwWEipyxpbOj647GXmtenrpD9Uvfn0BK
	9JnWmSmKULFdtTrlihNGV+UddBSCSAduZVzzUEoiWvUxRQgg/x9dKuvAn+a4QuMjjopLPAeQPng
	AbUSZiJ7L3HS552xVfk7IMoAaR41kuUrekUt6DvZNPREdG2mmKztP8wmIOS03xdnBVsUu7yqbZn
	HNO6f/MDDiYnhbJGBi3aJ/XAr5Gvi6jVTAKSOz/oDvsjDBG7SLdIHXsyNY/8aTJ9pxbjobD4/m+
	JchbGnb2Zm21hjMeTvEt4qOndzKRBe3zJrq/EGuI5LCwMCRe0qu4cPwOKJN6yMVmRCTETqM5Iex
	+IDlQT1T+rDsqHfDCyX4BiomTOioBghT1NDmX8KwcvEW9Ek+L9rXqjdSoyLHR7AjvwuF5uYqpXu
	uiKtyyQrdktThLO1wVoTB1Aimcc3aonINnouAHAbGGSdb4lgyTLDSqSjopY9upN091gg+r62KQR
	8vqyMzcCWupJ5ulaaDr6DpvmF7S1MBj1EdBJTsFzF2jk3oLNrX91ZZ2cQRyjk1Is2KbXU4VAnoN
	dRvm6NVSyYSp4kaKu++3gDtFs00ua5HcR2hgqCLsn/TGvzy9sLCnGT/Q=
X-Received: by 2002:a05:6a21:71cb:b0:3e0:c102:33d8 with SMTP id adf61e73a8af0-3e7cd5014c5mr6505768637.56.1793113312516;
        Tue, 27 Oct 2026 08:01:52 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccd63b6sm2848985a12.29.2026.10.27.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:01:51 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 15:01:50 +0000
Message-Id: <DMFPMAYUPSDU.2AW3225P0W0ON@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Cai Xinchen"
 <caixinchen1@huawei.com>
Cc: <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
 <dsterba@suse.cz>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v3 -next 06/18] LSM: pass struct path and struct file to
 the inode xattr hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-7-caixinchen1@huawei.com>
 <sashiko-outbox-186599@kernel.org>
In-Reply-To: <sashiko-outbox-186599@kernel.org>

On Tue Oct 27, 2026 at 1:02 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] bpf: missing __nullable on file arg in inode xattr LSM hooks=
 allows NULL deref

bot is correct.
Please see commit 94e948b7e684 ("bpf: annotate file argument as __nullable =
in bpf_lsm_mmap_file")
and add to kernel/bpf/bpf_lsm_proto.c when args can be NULL.
That's how verifier knows.
