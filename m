Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39491946DA
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806287; cv=none; b=PSdFjhpOTvOVHypNs1kcbkTT371VOyuNFVhKZWkPlT4vXB1aF6S64plRjb4588aral2MpvdXd+q2QCct9aaTSOF9f6F7jHJG1nE0sjciiUw8BAgWVuZX3mK8IuZhFVAp7YDuo+OWBYPf8dAQ5yulJlYv/muOatUem42drgg7MFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806287; c=relaxed/simple;
	bh=ZjgBRVmacMq3m/8j2tHZER7fznlErM8dyVvrWaoAq8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/s5Nmg0ct4Yf6aXkJoZ4wphZlMnqe8pQiL8RA+wLlURSFPwQeNwSQNSCu2eaITwO+0+pMS5hdJMgaRcybTaJmy0dZYE9cTLjYC4bekfEMI2lXnlnQ9uOZLF/TlrzZN5kwJy+gIn6klo895xxK/YQX2Xocx7zIwhocSXMRQ+0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxGbSKR5; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxGbSKR5"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-25669596921so10330125ad.1
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806285; x=1759411085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A59+KnWgnRDWwCndYO/bgXMX9fVVd9cKB2EbYw7Dlso=;
        b=hxGbSKR5oXgRxi1vKR0edL07F0vQVDFbm9+gBRFw0inx94MpPdDqb2XS3BPATe47tw
         8xOwV2z3iAygwx9gQzap5ffuzNDXj+NzB9VxzrXymm1ARjzOsU3AHrc2Nhg2C15HhdpP
         EgNsnhOcqJRvSVm+iMBJCBrIkX4YsaizVYS1M6PzVwS4RsldfMGGlC453b3BAgiQ38AW
         wzr2MdBF3ZVuoRbV3dKS+u/Vv7VZyobedf+YPamc5fc8pw4PYGD+n8XcNLsL2zSN9Ouq
         +/WIxm1BJyHnWvQiulKWMtideWdwH6DmLaAEc7XxF7rP7XXE1i7YqUdk/0jLppjtPFsc
         jlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806285; x=1759411085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A59+KnWgnRDWwCndYO/bgXMX9fVVd9cKB2EbYw7Dlso=;
        b=nzyXkxmILCDCp968oMtpA+jCC/SENMD6J4DhippFTeG9F/MhJRXE+tacFqJH3BfE3L
         Uki7j+aHTSGlWaeWal/wHp5nVbdI80LxPBG36FvnWLu/6u5Gaqh9+lTurhA/A/jEd375
         DCzRx2U7nhkfJJ0bdmHfQsDZGuyTelwmTc/feW4qXCh56K3qAc7NHPG011/6XpJH53vv
         LrUBGAkWzPGafsiCMhA6ZYCa2El4mzjHw1zHoy9+M17BC2bXFGZoY8bX6/tz2AmlrI+6
         67v2BQG2KtaGyc1VmncZ+JEraw96rQmykKThoGJD65q2akK3kKVFGnNwWwOL9X7bEeKY
         sD6g==
X-Forwarded-Encrypted: i=1; AJvYcCUZFhG0XNHzBQ0CAdnrEL3doq9Mx4ILj7ne/jr1TCeP5Ca5fyU0nR5jXdNZiSzs+poEw9T1aR3s@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsBUs2Wmfnrg6MwdSiNMoMrm5ROFW5bYxi+XesoVRNWIs5gOy
	ge33EAH05Ze2uHtEpRP6ysPU1iQ3lXlHS7EtRrQAMQgKlXVdjd/SRpej
X-Gm-Gg: ASbGncsD5ctX87ogQzRQkeQFjW5tKoFbkoPpob3advY1e4q6FE/DxHcsu8gmdREy/wL
	BMgxyrAJUr+u9LFMEimG30FV6axXxjpV6arAs/IRa1Jad2El5hc7YveNC3SQNT3Fr3gqQuAXG4n
	JIDbTQQDD2ExsFVcW4nffmi/4M+p+1kfnlfLw8F4Rm70aYO+Y6gxriOuIx/zzhfqb0nBrSjWep3
	bK9CcjcCgM6TVbc21sd4+MNiMHP0OV1zKBqXbVGTt4H9f8d1mMdw5OKaO2hBagl5S4+ZKDlY7Y0
	6hKcE9L+oTO4p82ufoxT3Vd1Uz/xLLFLyBIYDhE+d7trrybRL5Xd9eqifeTuRDicji4Am47l5nF
	UREu0Qu4O5WYZRLefU16u13g0kYNPC+LEWQ6FaaoZYz1cWJHllw4=
X-Google-Smtp-Source: AGHT+IEhgxDJV4w6LBxDgIxnPw4Cz47WhRViG9/189lIlyezvLBhTYp5XVfc0KkFSviOi5iDQnOxuw==
X-Received: by 2002:a17:902:ebca:b0:269:ba77:4eea with SMTP id d9443c01a7336-27ed4a92b47mr39911855ad.46.1758806285150;
        Thu, 25 Sep 2025 06:18:05 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882232sm25121035ad.92.2025.09.25.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:18:04 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v2 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Thu, 25 Sep 2025 21:17:55 +0800
Message-ID: <20250925131755.13203-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ7DgWyQYwfR4T2FZCw6f5SLx0O0jgoW3oyoQi7G8dsWQw@mail.gmail.com>
References: <CAEjxPJ7DgWyQYwfR4T2FZCw6f5SLx0O0jgoW3oyoQi7G8dsWQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can you re-run the latency tests from the 1st patch and provide the
> results with this one applied?
> Also, checkpatch.pl reports the following warnings; please fix:
> WARNING: Block comments use * on subsequent lines
> #47: FILE: security/selinux/avc.c:160:
> +#define C1 0x9E3779B9 /* 2^32 * Golden Ratio, classic constant for Knuth's
> +    multiplicative hashing */
> 
> WARNING: Block comments use a trailing */ on a separate line
> #47: FILE: security/selinux/avc.c:160:
> +    multiplicative hashing */
>
> total: 0 errors, 2 warnings, 24 lines checked

Thanks for the suggestions. I'll update latency results to changelog,
fix the warnings, and then submit a new version.
