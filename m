Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267125;
	b=X6FRSEl9kY6HLJeOHjqNgEwcfHFrANoi/ilVEvQcIxGB7tbjjPxYyiJ+UZkMnCQ+bfkH
	 NGcGuLK23eRYo4OYclXfP7tbHSoP0Tg0zYNthQqnH+iHkQVFcVhMHhHVbhR5AHO5Ie30O
	 Ci/nX7Z73u9WQf9MIqOFvPu+YXALHgLtLSB/kkx7s6i1mku9L2KL/d2oW+VN7o5Kx49ge
	 81XOUkoBuI59ZDhwYsMYi42NDYmflii/GQhPda7JhtESrWq8m2G5A+oadQ64TXGgAfWqq
	 E4vF0bofhDYg197vlz82llHsSm9SO3oh83q1uxOgpiOqo2b7H41naUcq0D+0FFCkWvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Subject:References:In-Reply-To;
	bh=NKlzkTcUFCgySgf8rC2LdzE1eRcA2+pqbrJ15QPRa9M=;
	b=KprYet965AXYSUMOGIbofeexOy0dVZyGr9TXovjOhj5ISiBtDwXRgby2wEcsWjbQ60wA
	 70ykLbvjjijtQ7rc4mQLgCNVflsU74fOoFTlTQS5dLyG4R7ALc3V0NsNOefnNtPZ61/LT
	 hd1sN+GfT6CA7kmPIbo6iCsqhGRoBjEtnGHdVqCsnkOXVHPWT0z4IPRoH9rCrgBkjxm1v
	 6dWpYzDoWZ0etw5W7hD9d46GhPgUCSE7ytzcAH1TkBkhsNvE/9lj2h2W9dyh8SUw7YnmB
	 p8e18nnEldBdGW/dKH3lN4d52PSux4t7yOYFCeSF2Avs3wOYlVukxQFII7LxzSrNQkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cvGOVApg;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD77606A330
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 23:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD77606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cvGOVApg
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364648ae07so12823451cf.1
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 15:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794267124; x=1794871924; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKlzkTcUFCgySgf8rC2LdzE1eRcA2+pqbrJ15QPRa9M=;
        b=cvGOVApgn49CqHbiIzfVMZRMo3wG52S08L9NFZkeGm0nQk0wh6eWVlOL/aHWqp38Mz
         DzwNDgRSk/7HAKUNe0I10AUvdGw6jZGo66WIz8iJDZ8bKJ+R/1lkjqzmi6IBUNCcXYBp
         x0WzgKVrNeF8gR86ikaDeMk6dHmKkjoNGothS8cYfw+S3B4MyO4P4203EcK+s+Ynfjus
         MIRQvmI2fdp6pJGeE+0lNCC2fYgRGvyzvnBNgPa5XgoAdIAvvBo794+ZW4RI4AF5N5wj
         gXXq6zhGbzFA7TXFCDuaDT6QdAvBx1HbLlD5LnpZR85oCcwCd9IIINIktHobwddYzLsk
         ND5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267124; x=1794871924;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NKlzkTcUFCgySgf8rC2LdzE1eRcA2+pqbrJ15QPRa9M=;
        b=v0USyw8dswt97KnCqxV/mIePPWuVQVnyfdjUDwzeGrX5pWQIECqgY2QJBiaPssmg9O
         wtk7lGxiY7DITxdgyrwvKRQvaNENeC0Y5Kg/+7Vyocm+zCkFs2EE9M1mHloGRZl59m14
         9lmwUaa1i1f6V3m/5VvB8JupSPh+U83RL42SwiU1r4wIKDbhNrm167acRa2zf8meze/R
         OEIh6aDV9780ZvdxI7izAiKcRaZgBHEMrNq0e/rZqA+lfJbowggIABIGGjHbodivNEog
         6xf+RCofVC1A8ZqBBHhnoSXsTpoo6tIUW5T5Qg4LP8Z4kJIxbBFiiNRoPA4ReO1z2rLi
         8hjg==
X-Forwarded-Encrypted: i=1; AL+hErEFU/fXIHzITwFO+5SbxHA+ACMG4QFlllGVWpx2YJC1XqVfIbqsOrofKf0aYPzLKsvbc1sYkyll@vger.kernel.org
X-Gm-Message-State: APuU4Z+pcCnH88SzuF1/gHHXW1U82BsjXGYoDeJC2+AHljcTlyFzVLNU
	KG2G/YErYZZ9VZe6xwazoDZ0Jwf+6j0X8Pa3Q73ojIou1Qkhx6kVv90PbS810h6wNg==
X-Gm-Gg: AYBFou0d56d+YT5t3RlPZRI2674SdCMuMo4QVP8i4PWEjx96fjoRj8qHhAnysxqZpkj
	oDuxsUQqQNBUT+9t0Flyhqf15R9X4vPw+tFtqmy2uyRPbbThjQpRXmYcIy+blS8liiPMOEO6Cpb
	U6tbgG+e6DDj+MbPgdl6UNyA/ms5RIQIeTk2sHLOMitVI/jYkCBC6+UuKm7tOieaWJ/VM0H57oZ
	Wxqey95msp1N02AQIfTJHWQw9UAo6fi5lb9MwXW+77fsemAPVX6tBye9U33xpyB2VF+FgmixEz5
	OwrbwZLmWBiUmNMlbuYGExOZac3lHFT5vFbuoqMWPGeubckAP/O6oAl4LaTB0ap1SHEQs9QYMOh
	ZyRPLNv0dA0rV2QBgKJTV184te4njzJCpupF7vSEC4iqcuqUfGzOgRj0wNtcZEZvgRg8m8/VfwB
	JROoPvOCmhPAiAQp4eco8sDXQywEVUM76VL1CuuoynP/hbXgWihNd2xu9kcRPoAHLsYxG9N5mWT
	1owg5qnqQCbPPnhoH02rkhyBesYy6uCDuisnAE24/46socwuRf1fI9i1AU/a3XPrX4UDq0ZWTqf
	S6Y7Y5U2toIyND8wX4S0IPmCFC70f9v00D/g1IzcxWFD4FjaSVcRG9ppBQlMq6I0yoBbe1Lz+iQ
	QCMZtnohi1lcjBnj9S6yzLXBbBf8hLQ==
X-Received: by 2002:a05:622a:316:b0:537:cc98:f73e with SMTP id d75a77b69052e-55524cfd8f1mr15863971cf.1.1794267124164;
        Mon, 09 Nov 2026 15:32:04 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm7467526d6.23.2026.11.09.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:32:03 -0800 (PST)
Date: Mon, 09 Nov 2026 18:32:02 -0500
Message-ID: <e7061dccae00ec17bb38894c380abe43@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261109_1829/pstg-lib:20261109_1442/pstg-pwork:20261109_1829
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: check MAP_SHARED_VALIDATE mappings as shared
References: <20261106182913.15233-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261106182913.15233-1-stephen.smalley.work@gmail.com>

On Nov  6, 2026 sashiko-bot@kernel.org wrote:
> 
> selinux_mmap_file() only recognizes MAP_SHARED as a shared mapping,
> but MAP_SHARED_VALIDATE is also a shared mapping type. The mmap flags
> reach this hook before the mm code processes the mapping type.
> 
> Consequently, a writable MAP_SHARED_VALIDATE mapping was failing to
> check the file write permission at mmap time, and a writable
> executable file mapping was wrongly checking process execmem
> permission as if it were private.
> 
> Link: https://github.com/SELinuxProject/selinux-kernel/issues/78
> Fixes: 1c9725974074 ("mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Looks good, thanks Stephen.  Merging into selinux/stable-7.4.

--
paul-moore.com
