Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344692E62C8;
	Mon,  8 Sep 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315981; cv=none; b=YCv7b2swAt9peJPMuMbWfroBOx9wMKB7SFob6RppnfwMct0JVtJhOONcmkquAObx6NdGJnGW+VwcLU6FT1tubkyjHpq25x/9XfEkBdcQeuz701RRBoUg/tyivVWd1DQQseEOfffWp9Ze7QNJc/wui1s2pHlAywYaPxnv9bsBbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315981; c=relaxed/simple;
	bh=UhcDRmH8ZVlg+Evip09+ssNhAPTrYqoMlqk/l3FeugU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+Wv78zxNAXWplUUTOwzbYigrw+9TphWdDL0jVK1KyN3Y670DSvfeTcHpu2m3OHSKmu0FkXaPcZJD3oiZA9QoasoINZWlkaabbaQuuZIotmXGl2QzT5SyHcdxHan5pjFv018wRUtmmMXJDPM5ZW4Go39SrNPoa7pRVMa1y7hgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYzGPntm; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYzGPntm"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7722c8d2694so3474549b3a.3;
        Mon, 08 Sep 2025 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757315978; x=1757920778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhcDRmH8ZVlg+Evip09+ssNhAPTrYqoMlqk/l3FeugU=;
        b=gYzGPntml6XvaAbNFLAa302qxlIMSoyUrU5Qav1xpoNDQFP9FeRONwUiyNo2Lx195K
         b3oNAwTh3wwGkABa09kS/UmpEz24hfHiZLGy36Xt5zU+0gqCJdL89O6t0YmWrYHQZtWn
         nje14hxL5jNdrYNFy5iVvQnvuEkb2h9SKMtSWKriizr0eYlZ7n9vkSa935e26EUIPXKe
         JAo8rA8gTv2PF+xfn0sNgyNu11HojQ2SflKEWjtcbNefTnCaDZLCH1lVKxU7LA4GZUsO
         lap5qJDmfxC71PIXKc11iL6FSN/OkSuOy/UNxu0QehUvq3s8QXOcY3D4DBPcAossdOND
         aevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315978; x=1757920778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhcDRmH8ZVlg+Evip09+ssNhAPTrYqoMlqk/l3FeugU=;
        b=pac16HJX6dRlF1aog0pryfeUK4MqSPQbCwj8uudeM3gw3GvL/YLxHVGfRsP0BYsMbP
         fKtoA0YikYLcrHXqynOPMkMhVZq5zcKbrCyN97N5rbnfK7DLEoJ5wT7TCNxPYWd2MKQa
         crvY3+obgbNbVPXYMjmyfwpjd8GeNIZ4MfKH1/RxWFG4PS9XO6qW343jbTrsU4S6kkOu
         PbSuwkALehd+ORjK67VPhr9QgJNeFO+HPQGCTxLdaqb6sjVn+h+SypVl6xzTUSwCV7LK
         YRdFfXeYTU0iTxvbfLrXhpC9bycQ+ag69sSFkSaSp//4TAcPexbsrk/jq9DOzeINbXwr
         DgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZIhSJNAEctUk5xGYyjoJCMoOGe3pbV+4N7Tk93DYaLgoT+K7OpCeuGlMMcHBRdyu7tTg4K0+/@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6gpR1vmnqslv9QOedWEglaAqfvdwzqvjSVQS4334pIukyzpa
	XTHP0UZKEw1gNalGtmL64hEHeNDThmO/9Ml3qXT2U18o6vPzSjVN9bVO
X-Gm-Gg: ASbGncvGcQVeFBaSrhcYAvfzjqeU2Jcx0WdkLVEfR+4k+tE+bZpX1P2n7x5nAcHuXZ8
	maOkogDHjNwdZwuGTw8ulCl1tLR67uF4dpgE7aKxY1f5Dz7Ealeq8ilx0R3A1HCCXem7qH+gCNI
	sgYp9hZZSRCZZc3RsTIPBaonwKeLmb1/6BjhWwlGG5qSgZ/Lv7jj+4/SkRrQuvbof6IV1Y7m3Wo
	94nfZgMKKItEWvPG7lllHya8dju1QCWjr079Y7vyunrGZMPfIxBuzEt1GEUNZigEW7CUrilDuqM
	tcIXGyvlof9B9ia8tDHawR87i5jXc/8Bh2hiCpQOqhXqOUONNN0lj1PHxuRI1EmVH2tqSbl3Di1
	ekqKQ49diBcz1c02SNKGxJSZvwhQEfcBpJPRCHzeu6r7wh4yDT8WAzPE=
X-Google-Smtp-Source: AGHT+IE/LhwcY3G2UrWPSLBxBEy/834kFowCIFQddipKGcG/qLZGkfRNUXLRizohVB+NEmAxc9jpkg==
X-Received: by 2002:a05:6a20:4320:b0:24c:cb06:f0db with SMTP id adf61e73a8af0-253430ae888mr9895534637.35.1757315978448;
        Mon, 08 Sep 2025 00:19:38 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm25587173a12.23.2025.09.08.00.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:19:38 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Mon,  8 Sep 2025 15:19:22 +0800
Message-ID: <20250908071925.294803-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHC9VhSW69hmvduJK1cKt_XffiDwEeHUKAtJ3YLbohKWff0+bQ@mail.gmail.com>
References: <CAHC9VhSW69hmvduJK1cKt_XffiDwEeHUKAtJ3YLbohKWff0+bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apologies for the late reply, I sent the patch before leaving work on
Friday, and didn't check email all weekend.

> On Fri, Sep 5, 2025 at 6:05 AM Hongru Zhang <zhanghongru06@gmail.com> wrote:
> >
> > From: Hongru Zhang <zhanghongru@xiaomi.com>
> >
> > On mobile device high-load situations ...
>
> What are you using for a SELinux policy?

Android app smoothness test, testing metrics can quantify app smoothness
from the user's perspective. The problem is also reproducible in
cold-start test scenarios. These two are widely used testing model.

I generate a flamegraph to record the sources of permission check:
url: https://gist.github.com/zhr250/9f4415bfdefc8ff0d64e78d96351fffb
