Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59761FFE;
	Thu, 11 Sep 2025 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596026; cv=none; b=NQFmoO6uZtn6geuSIMaajd/iKRVIrjr9vtGbps/sQeQcIqDeAeqbgaQO3gaguxw0hUiB6VB0U3w+fds1+JIIJb04kU/UqUNoLL+bCsdQCikqTV/OMLJkUxeSSCP8ooL25FDPkhryZvTAo4hPsRFCCYiri9JSUo0OqYFCVk6XkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596026; c=relaxed/simple;
	bh=hUIlfLdWs8KrHz8bnt9UfgV74P5yJ7K2YZbNpacyVZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnwoMLk+C/5v5nypseNT8+ObHE9mMohbDccb0tcH2LdoqO3NXf8npSawUZtSE1gLNoxMNAuyk8wKjX7ek9amEXLbwUkZ6W4ikORgTDPUe/keUfVurkOxS1ECXMUoEG2xT/edkO9TfX5pO6HbKaIUwpWG0Zhp1j0ZYUkb/3mGUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKj13BX8; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKj13BX8"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-77287fb79d3so581392b3a.1;
        Thu, 11 Sep 2025 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757596024; x=1758200824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHm+I2EmjAjANzed28NlwQzUNIuNjC1w9Dx1d+YLRi0=;
        b=ZKj13BX8Gnj4eXNC9H5dsMU8ZB9TRQED8CRKWDlQrrIvnVumfVSrX/vK6u3uX0PVUf
         TJLwg/Wph9aGF//2VWvwlYYRacVUN7sCUxu/IBxWWmRUjwLTKIvBjLwnyXeCK2u35XfR
         7GDY6YcbwIja2oUJ6/ZwX5uUdMGAzCjLONS1vTwHrtkdAbiFEgIktqHlKueIgDJGFv5r
         k/6WodSWvE+I/4q8mCI9izNVCrLWjRdeakdwONkNQO9UPyeEik88TN6pK+hmnU86V+hc
         phqernfz7wI3s+KzPvP5SWW8vHefUiCmWvommvxWZWM9Jg+QtoehLWniKDCKVejKs6Zg
         m/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596024; x=1758200824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHm+I2EmjAjANzed28NlwQzUNIuNjC1w9Dx1d+YLRi0=;
        b=INc+wOh9HIrYmqyfc5wcg+YRxVV0G9mfHneFMYDFJB8cFIi16GY4AOfLDXB3wpGgPU
         8dHwQSpxU7XIQka1uVUdZtYcRhUpxsMtooK2VInEg6owJNDX1CiYsGmAWfs4IwgfrbLY
         ygbu2TzOmaBVYGQL1ijlnsAod/6bCAXYO4FUVn7veD6pP7zemXdhJWtUdyB1EpRjEtRM
         AQD3dEbu7GFG6P05pooKlvFOvNRZqiw5rNeVm6w4tWQo0hmL4qGlvZUowi0yNq/4DW80
         6OBiQfl3i6sWrJd524cOItP++QKzMvWTUOWBsOZEiPSqDdZMhcnwmREmE7IIptO4lnD0
         csFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhvj8T358TsGE1jBFIdSG7SwzxVbPXFAcQERuJM8dzuSHCcvYndHyrqTj9QkmiPYjN8Vu8Mg9c@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBqldH+9NMFEDsC4511lwfb9MGTPgEv5+GV6FmQFRbsfj/ggJ
	OXrvsoG3/LloY6eXB4aokzVIArYhc/nmMcIo3b+pKGP9IMYnZorMCrqO
X-Gm-Gg: ASbGncsk9eprDh/cyBw35fehLccwvhmOckPlPnZBE6PcVEhwaO9hGYlI7gD7teqq8r2
	VHbqvrSSdh4a2w//dE4UUQX7h/iPeDxDLxwPDoRYEc4kAmhGY6kc4QUkiBSvWraFA2OqOsh4yPB
	ADATH7Nft2L3PVse3r4wGHwCjkxYusSAWg4yrMOeHVCJcGGWrV9tDz3iq6dO12yfmZKpEyFfte+
	PQeHl7fgmVc/24KlE462SwUSAeBQ49bkjRYGpCc0t0D2o4cm0C68/a2vNRj1OMAr9JRWwwoxf69
	UPJTQ7OJ6fYDtD5bWfG78tGxFobL4F+8VN1unTKyIDVRFFjvRpCuvjuhId0Vr5rdw2L5mV9ViPn
	GnY9EKgu4VKXRc8fQ9u7onxDF8cyV8id/PkhzIhwwGEPF6NIF7KQ=
X-Google-Smtp-Source: AGHT+IF6OeRpInObyiPOKH13KWd8a6xyOTlxGrdUC++H3qdAy4kDLtxwmAOn2WxMk97ChRbSbgZh5A==
X-Received: by 2002:a05:6a20:939d:b0:246:458:8531 with SMTP id adf61e73a8af0-2533bfd9437mr28380664637.4.1757596024114;
        Thu, 11 Sep 2025 06:07:04 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6b1sm2077519b3a.20.2025.09.11.06.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:07:03 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Thu, 11 Sep 2025 21:06:53 +0800
Message-ID: <20250911130653.967139-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ4-+WfGPLev5QU_+_NgBx68zdBBQ6x_+aonzbk4f9BNEw@mail.gmail.com>
References: <CAEjxPJ4-+WfGPLev5QU_+_NgBx68zdBBQ6x_+aonzbk4f9BNEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> >  {
> > -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
> > +       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
> 
> If you are making the number of buckets adjustable, you should also
> change the hash function to better deal with multiple numbers of

Thank you for the advice. When running the test model, I sampled
/sys/fs/selinux/avc/hash_stats once per second for a total of 1800 times
and analyzed the distribution uniformity of the hash algorithm using the
sampled data.

Baseline: 512 nodes, 512 buckets
Comparison: 8192 nodes, 8192 buckets

Metrics (Average value over 1800 samples):
* Bucket utilization rate (higher -> better, same chain length assumed)
	* Baseline: 52.5%
	* Comparison: 49.5%
* Max chain length (lower -> better, positive correlation with worst-case latency)
	* Baseline: 7.5
	* Comparison: 11.4

Experimental results show that scaling buckets and nodes from 512 to 8192:
1. The distribution uniformity under the current hash algorithm does not
degrade significantly;
2. The maximum chain length rise significantly, potentially degrading
worst-case performance (ignoring other code in avc_search_node function).

Details:
url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b1795

I will modify the hash algorithm in the avc_hash function and collect data
again to see if we can achieve performance improvements.
