Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3611CC8AF
	for <selinux@vger.kernel.org>; Thu, 31 Oct 2024 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412646; cv=none; b=Y5IOjAyOwWBzJtf32dhxXOBued4x/2gSQstNT+1vbhpBWjMVul3felWu2zJtJz9XEuSrqXWT8/vTRKRIw+vdjDXDJ1BY18uC8ww2ioWxwCLQvnaA0TzfomYrgMgvQBdPr2T3gCCuVoujmgiYujaWBZas9bVfge8p3FVuCja04UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412646; c=relaxed/simple;
	bh=VwwF1RIshFJLUnIvXKoqIUmBj1Pam67bKWpclBqQ7s0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=AM4ZRTwF2H0nMsIJlN3NhidJnUID/p2TBwofMp7tH7Q+qrAaEPaD7vl0GzT8KtPb+uOT+ceX98YL4QD9+2ESNNsQXlBezEhxErAv7/haCoYAPuOgSmLCTQBiGqTym6+B2YlfKI1WKSMO1p85JBqehVYbW4vi+IizchH19JTx6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZaujCj7q; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZaujCj7q"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbe8119e21so8570806d6.1
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2024 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730412638; x=1731017438; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Mtj/qz29OU74YHAxgLuBRQewT1KUZ4citWETDevIeQ=;
        b=ZaujCj7qk4XSK5HyQSnpX9R2I0H6AW/aplRBhBnBRp8dgaPKVYXgzLFWIR6KziY4uj
         0qnzwURY7gwTF7lGJbBYrcyCXdSsR3TxWuu+1DVWX187Yvq5opxrSe4o1dkthLUr8NKf
         4x4w1Hq4H71ktll9wtiC057gmuKELnuoyUfUGOKy2zpnDFGd5u+vk0DCpdkGiouQtMDD
         H6qCENpzu41VNv6DoTHM0uoNq1hBJpOAu+wIzB/yA8OCsg4qULueXwJfEG5Qm2aWHN7k
         v9uu9ri0a5QqX111MPW/qMkxRM7qiLNoGbMBwUzrs81bxrE+rgpPpd01AxxGm5oSS0kO
         onkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412638; x=1731017438;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Mtj/qz29OU74YHAxgLuBRQewT1KUZ4citWETDevIeQ=;
        b=dm3zOW3b7ENiqEIVe2GgPlSUba35iZ155TkpfNBs+FpjYW/nafO3ELJaw6R6SoMLS8
         5qAqr0ZlPaaIfYlRo48rHFyej4USYKM+3u+lGSlI1QguIMJEyDjdhz7lwCJcu2tETA45
         ++6HPVeFXyCujiGKjtndoUwYaUcsXhUovv1XjEbZccpKuXuNFlH5UtDXuUq1dSD7BV8I
         MtlMDUADzi09ZCAzbi+yFVZKPjF3zYScsZ004OyZnYjdrETWWJ4chCp8s0hJAmbbskxD
         Ei+zIae2MhueAVda7pxSVoVaZQq/mmPDfPGGeTB87BnU//8epJun0qtOREAQzOWeJc5M
         T27w==
X-Forwarded-Encrypted: i=1; AJvYcCUYM0VxW8L+5zXcJXKaZaGW2Tw9HMkg4USxZyxPP/v1NWKjP/eSYufkJStAVeizVuxqFnNSGNaO@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7llFbjaA2+vsq3qiQLFwYndDQeRzYnqsBjzpEja/NKg8by0p
	aLpsszzxbl05gruRIANfzQ4FJqdKFhiRlJLl3K5l6M1aybJwMeho0EMzs5poOg==
X-Google-Smtp-Source: AGHT+IEKr/D+ozJ26ymFNTSRML6ua5ji1QM6DUq4LVNCLvU8Tr0BdQBSfCuhtD8eWN7M3+G6B8qHEQ==
X-Received: by 2002:a05:6214:5993:b0:6cb:e944:c1a9 with SMTP id 6a1803df08f44-6d185717decmr292783216d6.31.1730412637773;
        Thu, 31 Oct 2024 15:10:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fca930sm12457456d6.41.2024.10.31.15.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:10:37 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:10:36 -0400
Message-ID: <0aa16dcb5d0708fb926d8e8128217205@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, stephen.smalley.work@gmail.com, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Subject: Re: [PATCH] selinux: add netlink nlmsg_type audit message
References: <20241022223711.3066190-1-tweek@google.com>
In-Reply-To: <20241022223711.3066190-1-tweek@google.com>

On Oct 22, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> Add a new audit message type to capture nlmsg-related information. This
> is similar to LSM_AUDIT_DATA_IOCTL_OP which was added for the other
> SELinux extended permission (ioctl).
> 
> Adding a new type is preferred to adding to the existing
> lsm_network_audit structure which contains irrelevant information for
> the netlink sockets (i.e., dport, sport).
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
>  include/linux/lsm_audit.h | 2 ++
>  security/lsm_audit.c      | 3 +++
>  security/selinux/hooks.c  | 4 ++--
>  3 files changed, 7 insertions(+), 2 deletions(-)

...

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 849e832719e2..b6544024f688 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>  	case LSM_AUDIT_DATA_ANONINODE:
>  		audit_log_format(ab, " anonclass=%s", a->u.anonclass);
>  		break;
> +	case LSM_AUDIT_DATA_NLMSGTYPE:
> +		audit_log_format(ab, " nlmsg_type=%hu", a->u.nlmsg_type);
> +		break;

Based on the audit field dictionary, link below, it appears that netlink
related fields follow the "nlnk-XXX" pattern, and while I don't recall
any current users in the kernel, it seems like sticking with that pattern
is probably a good idea.  With that in mind, what do you think about
changing "nlmsg_type" into "nlnk-msgtype"?

https://github.com/linux-audit/audit-documentation/blob/main/specs/fields/field-dictionary.csv

>  	} /* switch (a->type) */
>  }
>  

--
paul-moore.com
