Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B11D934D
	for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242926; cv=none; b=MDjID4FO4mT/yY3eBkxp+BlqN3puzHHfwkMsIle3HAxI2PqhWY7mT6tOorR6CKDrZx45qBIPZEbtmDI2tX6xLO7yygeqU7824Bgb7UtZYNlp5FrifYk+lii4PnTZyMJYuqqcuQOTy29uvNe6/cyEd7ctePRdRLE/PqfbbBww5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242926; c=relaxed/simple;
	bh=zceAdPhaSCTtexKuoLifqlAqvbet1WNBGfxs8S6cOUA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=GgNRCUWj4yH7MUQQ+AR/F2IcKWvQK4LqgLVKo8pYEsu5XX+QFIRK3l46ag/7S3bhZFcNYPO+Z6GQBXyjGU+fGRdqj7ILKV6MTCez1rGWmVsboBIT6+AMoFK9LStdeZpkqtkHZGVuHs1k4EfPvLyiJUx1pw58eLSFYIGosj9kiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ENlSHbQM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ENlSHbQM"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47690a4ec97so49396311cf.2
        for <selinux@vger.kernel.org>; Mon, 17 Mar 2025 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742242924; x=1742847724; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3yVvtqTsXtaBa+O5aEAfJ2z57v1Ir49y6aZrwtTF5o=;
        b=ENlSHbQMmo4OQE/qtb6GwS6O/h2ftzbtyyBHsO5s/sJwGYcZz5KZV7VgQHBhpP+2zm
         rXxI7Wk9wl3Z3KczjmbpCMFbcqBHAjvVia1vULJwxTLlB+SaVn++N/7vcd3OZ4y23nXR
         DqM6ql+ouL7z2xwp6+gHswnLNF4QPJ8imaAUmlgFfaId0iWkPg3zdHIxyZqj9xy1NkNN
         hQgtSm2436a3EAteg/722MTAuVU4khEKGjJSRVn3gfKlSfsYdnogtYSEdca1BK1ZmyF4
         gjMAivZAtIs24AAjzfXQLgwpGLgbbxF+3OKzPPyB/FNivZBiDkne35AaZdbhEI26EAze
         chaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742242924; x=1742847724;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w3yVvtqTsXtaBa+O5aEAfJ2z57v1Ir49y6aZrwtTF5o=;
        b=Pno98O6PqH+iTQnUiMwnzejkwG9KZDWCwXXdYAyflgW8yurQhkuowl6iwlizXVe7kz
         WE5hWJ04LTwfUR+/Fn9HCddVfigIQOYbkwYPlaO5/1c/gjRfWk+Mnqcws8FOqMrwVws/
         5qqNSpvxDHmuYD4zWgVHNDsBGKDNdgxT5nsUCCzuYpwUQKZbNzi7KF2KV5pHW0+DiT+J
         9UM6u8kP1Aii9tmdO/ZMZJOnSL/jVZ2INdaplzCR4vjTIHBohu4fNYoHgzWAOQGJ54zF
         cstC15jEUPKx6AERevhA8OylN1J6g4ansGVXEduYsTX8pGT47vLRxWobtuCTRQHKVGS8
         uxMA==
X-Forwarded-Encrypted: i=1; AJvYcCU7S0SooJJC7yEnpoZxH1Hm82c3MMi03Xy5V11XnFsCCOIE3pC6jxhoBv5sQzneThQtL/Swwqtf@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6QkN2gZOaCyThXFs9Q79EEmo4/5b/rWzs3ZRuAxzXfXbReCr
	WUrSBT7b5nEiwF6JswPv45u49HYBMI7PlGV22B4kpJNNlr6HzjEFsZxIs0fdUg==
X-Gm-Gg: ASbGncu4343kw340+PnHR8+T2HLF8sj5bavHOm29RjbmBfszK1CNn18PyaEbD/H56oP
	ICzdV2OENWYFYDMgojLj6RJKqi2reW8dSLjHZ5eLl5MZQtor63OrxLgcKXTqOr7p/PIKuIBFvic
	bUwokMow70uWekZMp9wQc7CLOAylTEM6qy9N6ggWiJzYSgoMu5Fg3PWuxTcyjccDkITaJJvAkf4
	G7/9lCPlI3BGVjYInTGGku8Bo1TrseHLkvV8XfmL4BBYY7VwAn/F53n2OM6yNRCks0DEaYGH9SN
	U/zP4r85lqhaONUqF4Pj6ndHqh8igeqUF0adGKYU9q+xt3rI/NmH5ZqPtfXW2SfdoW/oJCusbB1
	s6ZSyhz2689IWslTZFJdkt8En
X-Google-Smtp-Source: AGHT+IFqgRmBiB6XOIfe4MHqkwiowpZO3llF4b+bdu0iUKu4JEaIHtlLhk62/sn9MMeB8Sx4debo8A==
X-Received: by 2002:a05:622a:41ca:b0:472:5f9:1f78 with SMTP id d75a77b69052e-476c8130df3mr130149511cf.9.1742242924031;
        Mon, 17 Mar 2025 13:22:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb60a150sm58191861cf.7.2025.03.17.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:22:03 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:22:03 -0400
Message-ID: <71ac186babee68dea38155b68d6a56e1@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250317_1618/pstg-lib:20250317_1551/pstg-pwork:20250317_1618
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, Mimi Zohar <zohar@linux.ibm.com>, GUO Zihua <guozihua@huawei.com>, Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy  instead of cache
References: <20250312080055.8950-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250312080055.8950-1-cgoettsche@seltendoof.de>

On Mar 12, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Retrieve the netlabel_wildcard policy capability in security_netif_sid()
> from the locked active policy instead of the cached value in
> selinux_state.
> 
> Fixes: 8af43b61c17e ("selinux: support wildcard network interface names")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/services.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

As this is a fix for a commit in selinux/dev, I've gone ahead and merged
this into selinux/dev (with a /netlabel/netif/ tweak) to the commit
description.

Thanks everyone.

--
paul-moore.com
