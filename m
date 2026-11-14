Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=Pb3BXJCB9uDttes/wQhE7mPZ22SVCJq0P7uykOvmKluuKg4bTWuPXhNHNK8bka1SX2FE
	 yOWo0yDyJHZcJMFKGb4ahy/l/lHvVaxnexPCE+thAmWwd24sNIog02PIlumSi1deCVkgI
	 dIjAiLNiPCOF8sg9t9oV6ltQm144q4rFAeQKa7stJNn7dwQ7spdkz5haj/L0eltB++A+9
	 hmXv+Vz4cxXrYAsmhH+IbUyPyYPvmo+Q80G3cYApURW4AyIOtlyhKB1ZQ9nwIM4Mi+eYu
	 QzYNIJem4w7hWgBEhBNd3LmFy31A3E2NnfuDwqAeXOcYONTPeBx1/2Uhvj8dfiBwFWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=GJovdMGTi0XxWxmZ7U+MXxqdRuypWerPzhkEyzXQbJ8mpocL/ktUhBWmUAm+OTuS+5GR
	 5zp+YnH4FX1zmOlFs40CMvV2GBJHGyNUtIbinC6GfEPqxT/FXLdzJzDaGv55d7MZjt6fU
	 WloJbOB6r4nUyv8Ti45atG1aKKcXnvJG6cGfKf6+D3w+MlLTj1PSOpxmJ9PKSPVHO1hlv
	 RYr43oqe0MpyZrK3oxDVDoaEpdRh4i7r+rmF6NrIwD/lKWwMsHerz+/i1wjqslRweugpS
	 764Grk4ZEXCh9LQ7jl4dvJda3HDTMP42/joh8bMNXQgogYDMAO0uYUuRN7ZlkRJ+gKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADF606A338
	for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8ADF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1463752b3a.1
        for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=0Jr2RMrURElLq0E4CYEmFPXTyzHscEFJRB1Ejk3M7kp6oDaGjveBY0EgAG1dUo1paN
         6ghIDLMufN12ReBM41CdfwjIAci8KZh6iMW+mZK+oYwcg37+mrP8SCMvxn+StNO7T1Co
         q2z1XgPtGXLaxnJi3PNi6dXqCxf29UieWB9GNjWvZ1112858+oUDtX3TgRakDwZNqKJA
         RatcT51HUtFWEs9OgBliSXVPJTkP5aAR4sOpq25YoDw/qLzqTvGDuo+CAYrdG1QrxcXx
         55/AXfQWu08pAiLbXPN1CKblGeLQ7cs1qUP1eDmSAw+h8fReVdcMLWwgr5QflN7tfxBN
         7YxA==
X-Forwarded-Encrypted: i=1; AL+hErGqXHo9OlYuvPegehJ3WSK88gyHvPy1lE5PEM2A6UtEpomUj09Ab95dNypsYDvAO2Ysr+Unk606@vger.kernel.org
X-Gm-Message-State: APuU4Z+VuZv+uzZpia9ytAEHLHgk7jcJ714MFPagPHxLIRF8K+OWXdrR
	I2XgddDF0WL/LHsqotS8dBQSRd+Q+Bfv84m73WHYIyK66fx/sbdb+0ZllK3fWPNDn74=
X-Gm-Gg: AYBFou0LmVzHFWA7ebUIK8Y4q0BogfxLc0Skf2FP8ZvQqQIyXdmBYFYpBCtSezoEoOS
	SYjiG9wRvzwDjwjGklDlz4JYGStIIfSJJdDtB71+kupfvIru1aeGj1AEIlJ5nXE6umA+jqlMeHU
	IkrLe2ixSFWnR3Gm7UDtt8oxuhr8pwhHfqC0fBpNsXoTAXvMDdkfcvyhZG8nt/ou9vKJ1jA0Qt0
	NZhidy6rwbrXF2LXcAlnVVUSFFkoTKs6obp9hwL5fbV/vYZPNtImubm3rG1Ubp7Gzlkz8rYo0Ij
	GnMJyz6/BM0S2i3e0WcI3RKfjTcpPstf4ql1d46uHfzs6NcogXiRH2yqp+5i3Aa2FnQqg6tE7gC
	Z0yQBKgi7NmMA/ytpSt0UkglzMMh4YwU68MnnGonMLSv8Ni/Fksz8a6181aT5nSJWMea+SnZFV4
	8osYzKRBTmZjjByHAifjbNcOoQfk8UL1Glcwv3q9yAumc+0o+e/JqHCpiDQRF6GZE9Fjxzfn+6q
	gs5InFyQBmhujk1MGsRzMR8I8YUJ93f8bw5rHO8tdDIdCIHoUVB7PaFwQNdGP5tuzT6iW8NUtDA
	d7lIDU3Ln3y4NperVNCTw8j74PoPnGiq8m9lWDWfiKW++ex3MDl+Bp3MbkWGOQ/eKiCR/65LRlI
	RJgcSpjazgDp0nJboM2XI9R2eUFwjje15nGgKtfLvTBtG/dnkvijRyFizME5QfFOE2tKTDa4G10
	R9ZKdRJX4XAjSbtXzm8B3ih10VHQeV2+ZD9UuIpKlmpep7OzSqUJcsUQSf
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris
