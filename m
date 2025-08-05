Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918D221FBF
	for <selinux@vger.kernel.org>; Tue,  5 Aug 2025 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428942; cv=none; b=Tc0JKU/FO3BhDuC0rxJr2maJ9a18mgIVYxbrLxG6Ly2KPyZIEuw5a55IV9iu1Q1JkTQHj1hRNbvbnrSKaG1b25Zlpt296CEqYK8a4NnwN6MBjaMIcvT7nyxnQPuqC6nLqnumeg+NYmcxJZM3yjHV7d6fz01lH9eMXQw40faLxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428942; c=relaxed/simple;
	bh=VEYrrDZbOZzcqselE3enFW/VmNg859MFte0n3Jvt1kU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RCqofbQPaoYAae/yvqbEFPhKPOAOy+ONkKuq0RBCQaAykMY2uozdaEkNfFD9qfnfYsMqQbuebdsQm9CQDCYOhocWdV4zGpX9n0Gq1jqdRdhuwg287U2wGk/VRfuvRSL54p6w+cyrAMLhF+BbA4vSn1ItfXuEDtz9VTvaOX8ZW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RkiHUbS/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RkiHUbS/"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70740598a9dso42695796d6.0
        for <selinux@vger.kernel.org>; Tue, 05 Aug 2025 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754428939; x=1755033739; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/WIMAsJLS6lq3guoK7qgX5VwdaiZFYEEVoK/VK6IYA=;
        b=RkiHUbS/qLK8ilyZPQeocRrnAtYwXQL7FDU0drPkxxG7jc9+kvBlmSnwj4A65NS30T
         IbUyspMKxsMVebLqnHg6sKdmiYKCAfc3mv7hq5jw+DWxcnnlodGSjRzzxEsMBNj0kxb0
         GbEBinRgIoUSwld9pgEinFEVkX5Kwl36Iv/S9W4v8ieUIH1wFCjPkBnx8ZSwQ2JtFdn3
         UpaSU5RD1CUyTT0FNzz3Fum+p/Mup9YlJMfOmdLMRV7SfbEoT8yj/MdRcJidc+SlRltf
         fILeoQvl4x2rvavdgXuHA1E2zwMT6PET99yvBFB2ANXdeMW9O1Eg4jLltriNEymD2S29
         MsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754428939; x=1755033739;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/WIMAsJLS6lq3guoK7qgX5VwdaiZFYEEVoK/VK6IYA=;
        b=AGmRm+HAFjp2Yd7hEifgCwoQJqhtALKgUhbqOuCGxqCjJevGEd2Vhgg5ZYUQz3pGFA
         iihhDsx1SXpqFla7qIjWlBmZb8P5Hn5Up1wUSMp8/oTydAPFCBaig5nRj3EJouUyi0wk
         TBYrlGCjkJCDBE2HUOWAFs4XIJ4T3lWinG2DN/MM1qO6xa91c5ZCwGo2dc2T287kHZJM
         apnzmu3DJJyRxuyjT1oPtJpppf1mZFNmDOZdm/wG90N0RFJsSci6O5H5pFJ5D7AdBPRA
         Zmt+JcQi+lyUxJLCRFW9yxWEu6ayntJZtxKV4j02mVS1uNczZqrVe313ywnTKbUTGWsU
         zTCQ==
X-Gm-Message-State: AOJu0YyaI+uehP1/tigm28S8B/ddUfHETuidFKvp71i31y/US9+GdRY1
	fxphBJoUEI/bIAt6MSDba9TW+0gdVhyXetcjAmcLksK5MtgvmTaMKtPbTa6QsP1jMA==
X-Gm-Gg: ASbGnctTajGW+FlEmcxZAR/URgT2j25uYj9geOgsSurl1LLap6kldYlyNN0eK5dGkdI
	MZXaBh3zgeT4TGvY7TcHjxppd1r8wO8dQy62j66fiul7hyK7OutjiONhFmj1cdDVRCggNtfPDkI
	e/2lEDRRVcEwpjWzufh3jaOpBTYytc9WpI8wArRV9aFKUkuaSW2xJlkwWs9/PnMHDNbyHD5ML57
	GHIkOwrmZ/q8BgrtBbqbL2Ywyw2KYQftGjqsbg/l11hwIjaKVWtFP5qNQ3xy+5W7tu+e73WvTnS
	dqIQ+xtTGoEZCU8QNZH11kjV7sswAXjZrCUjgDroJ3U2frLMSN4YvwZSe8gYqwym4KfYSmR1NcA
	sn8erfTkOPa0i0kWhpgzIulRjVJT0TtQRWoeTqrc6bldq3e6//5Qo7zUtCap8/F1KaGw=
X-Google-Smtp-Source: AGHT+IFMarL0V8vF5yt+ZnsWfT31K0Y4vayuTgbQn5WaROkr+RwRruDKhNk43lQFY3AMqk6bxFLR+A==
X-Received: by 2002:a05:6214:c2e:b0:707:621e:6876 with SMTP id 6a1803df08f44-7097af7c197mr2730686d6.50.1754428939371;
        Tue, 05 Aug 2025 14:22:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077c9d6d6csm76494806d6.4.2025.08.05.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:22:18 -0700 (PDT)
Date: Tue, 05 Aug 2025 17:22:17 -0400
Message-ID: <55eacb468bb0868fe2552944d46239b7@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1541/pstg-lib:20250804_1752/pstg-pwork:20250805_1541
From: Paul Moore <paul@paul-moore.com>
To: Yue Haibing <yuehaibing@huawei.com>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>
Cc: <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: Re: [PATCH] selinux: Remove unused function  selinux_policycap_netif_wildcard()
References: <20250723122304.911130-1-yuehaibing@huawei.com>
In-Reply-To: <20250723122304.911130-1-yuehaibing@huawei.com>

On Jul 23, 2025 Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> This is unused since commit a3d3043ef24a ("selinux: get netif_wildcard
> policycap from policy instead of cache").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/include/security.h | 6 ------
>  1 file changed, 6 deletions(-)

Merged into selinux/dev-staging with plans to move it to selinux/dev
once the merge window closes.

--
paul-moore.com
