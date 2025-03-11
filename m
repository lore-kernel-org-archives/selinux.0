Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F51E9B20
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664255; cv=none; b=hbwsqHtymK1T/sQfElrZgkIuuLOm27IYEyOTkfAwKoTd2FmHHSvwKNpS4CBY438/JPYsGPjAifKZOnJAv/KpcT02ILvXkFrhhd6rj/Urj1XDcyszLiqOuofbnkLUyi9MyBVSDCmDOl8I2jYkINXlKZ7hFRetdOBdCpig5oB17xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664255; c=relaxed/simple;
	bh=WJDiIpzPVyWLH5Cn8j/8u3aIFFtw49GPgJTMCyuAZFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/6hDgHdkRJP30MErHUm9uqC9y+oOiqp8s6Br5q+rH1G8FBl2+s7jAcWu0pg5jxkqMBmosmxW5NKExK84+sEgdyhvUypdYqOGr64c03VETCt40eXHJMxDdq49nVx2iAS3PcDr+GRLseH40oromTa5KOd67ThEgLuXujM9DvVECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7r49EIs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7r49EIs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2242ac37caeso56725ad.1
        for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741664253; x=1742269053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKKMXhARfXEwg2PwHrZN99nBi8+39p+oYTJh2YeoKoU=;
        b=R7r49EIsnN7h/+o3taKGdxwyS6LTzYjaMxZ6eza16XBSC7e6lyvhyA8SxT9yNJwZCL
         ftWf4Sl5oO02NYlDMk432YfL2hSTBPQg9mxtJIpy+La2kW2lWlCL8Et5hX9ZTbY5FbWn
         5Sq8E00Vxm/oi7Y1O2qGbbrOGWyJZ5WwnRcMrUPw4+qXnYmB5if25PpKz1Z+qDBRIX9Z
         N84QCsK+9ej17pCRz0y0IsncIfkw6T+yfgQBa+kwHPcSoWpYhtPOuItg38bzg4M0X/uW
         wN4SS73PPN1CbO+P86QekKiH32mdArq9zwiGjDt7sZoeLk97je+nUkNajlz2qVx/DqUG
         As8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741664253; x=1742269053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKKMXhARfXEwg2PwHrZN99nBi8+39p+oYTJh2YeoKoU=;
        b=kDh3Z4vOe22puFvvU1HTYq3gECfwQl5UCE81p1Pf6TtPXd1khzWExYOtso/7e7mhXx
         6IUDcHt424BvLK6qsRlh8LQm3pAF7PtaZWh0z2REFJ/zn7Zgxh4Uxm9hAZpxe/fSwizj
         K38lcaZFlNQd1VK1nO2qhfTyMDMU17eCIq3Jsj1VEEy+V7GOBJaZUikcnJ5eLLLb+FAg
         WUnRmLHEscvR3mtxHSnhv3wwnLPSbFsqjOOFPFJHQDFNXIoL2WyeoiCYuWQrChm5TXQb
         uLl9iG1W01PlUaH4bCfvqXfbBieP4NJA5SXl+tOSBWc/S06A9rcmROsYhv1f9nmXbKRm
         ggaA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2NKUiJsIqYIr6cvsV5L704AmBKcqqmD6pvwwTaCk3CCkfpZiIZmk/bVvMZ1NyezBra6cshCY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OCRE2Vru83aDCRXPo8gXujoNWdAo3bG6T9yzK+dtktreNTIB
	OBJTs3E3XLadClKk9bKAFaGxZGu2WS4fAyjAM1OugTvSEzuxQtefG78YFUujZw==
X-Gm-Gg: ASbGncs5QooqKzpVnxIt8fzkiE0UfOKWcQmOfn1x+szCmNsRjgdRtVRz5LWa1mdf8Kz
	bt0bV4OrIbI5Ehq+gBrXlw5MVMtA6BPK+QD1iAU+l8z0Qxvzm7XfVlwUUgIfsXc8GNf/C4DUksU
	hNWOWWczKvmQ66EChleXDUQsVQESId0MQoyOLoedgG5Nf/VjUWkGBOLANuMkDhENAmM3gNjA68r
	G6t0Te8D1JUbfe3GirZE64mlH/zOuUhXbHdsUUVAepzk7GQvzeu5ykl70W1D9I1e4FInqNoGYtY
	z6CoNzzheWM2Kun4jybPT0sHnQxX9lyJjXK9cMWVogYFG0iAV67XDvA0DO+2ACUZvub7svhSDU1
	qZ9TAOrk=
X-Google-Smtp-Source: AGHT+IEK91Z6kXFaIWJCVbtXPxgiAIU5QooJrJa6uX0FbecTFo4b+EzP9+Bxt6J46OcmUjrvYOGJvg==
X-Received: by 2002:a17:902:ecc4:b0:224:a93:704d with SMTP id d9443c01a7336-22540e584dbmr6561245ad.2.1741664252755;
        Mon, 10 Mar 2025 20:37:32 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e789340sm10752115a91.26.2025.03.10.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:37:32 -0700 (PDT)
Date: Tue, 11 Mar 2025 03:37:27 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	omosnace@redhat.com, shuah@kernel.org, arnd@arndb.de,
	masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
	tweek@google.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	selinux@vger.kernel.org, hridya@google.com, smoreland@google.com,
	ynaffit@google.com, kernel-team@android.com
Subject: Re: [PATCH v16 3/3] binder: generic netlink binder_features flag
Message-ID: <Z8-v92gIPgrxWq1w@google.com>
References: <20250303200212.3294679-1-dualli@chromium.org>
 <20250303200212.3294679-4-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303200212.3294679-4-dualli@chromium.org>

On Mon, Mar 03, 2025 at 12:02:12PM -0800, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> Add a flag to binder_features to indicate that the generic netlink
> feature is available.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---

The implementation looks correct. However, the feature you are adding is
not "generic_netlink", maybe "transaction_report" or something similar?
Future features might use this same interface so lets avoid confusion.

Thanks,
