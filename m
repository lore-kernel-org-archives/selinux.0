Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A527E1B0
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403378; cv=none; b=U20X3+RHtwsOATKU2DUIybClp9iEvNhTIv6jey9l/JF6FOHtzGH70D6phSUKAGLa0fwwXmvjTG+qzRDyr16l4jhk7RgIS4Epq4xqQZpacGlwNpfzp7YvNmvj5qhcXcKKsPHPr/yo0SjiA+yUrQjQRnxXRrrtVo8I3NWVG4diD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403378; c=relaxed/simple;
	bh=uW11GdA3DGPiV0lk8DuiD0kJ0dA4E3L5hWHocaEQ5Qg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=oXOgKRMQqfkSHKvpGg1X+j9bcJt1cz2XbdodgcZVdx/GRMlPqnx5JT4377lD7Mi4tz5tYR0lt04lR699RQf8KOVUjHWPLXykk10j3FuayFtSH327fdFFIy4oHhgw2g7Q8MYBJF/3PDOBKxZVRqKXN98m9+Af8eq8eMKl+EE7nK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LKcaBo2C; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LKcaBo2C"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8ec399427so18896636d6.2
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403375; x=1745008175; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SYCthPWRtGoMxgrDOkbUhL0n1dRRfJstAoyhrfgyGE=;
        b=LKcaBo2COZCHAjTZjf38OwA/3Hp6eEE5JU85i8NjqExBT3XV05FVQveXVCvknSMKGX
         47TOfpYmGBUnyEvBsyJP3Uuqifu8H9HiKkTtl/jcKcEM3gpOfw7DvCGYoxeynFlTD1jq
         edy5KVZwEnjhDfmVeMGlxQ12Mx82MNWoGX8cQ+MF17q6QPUEhWJxb817Uc87KZfwiFbG
         r910wrR/78ZAaiVJOZy0Bem0xSmm/8zoIHJAlOjRLWIioeEui+L0+6f8H64nOLSz7UBL
         hDBfLet6nAtmtHG7cv+dTC65zuzJ07aIP3EfdH16Al5RxCl0XrKon19NEOmB3ksV0PIQ
         3Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403375; x=1745008175;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9SYCthPWRtGoMxgrDOkbUhL0n1dRRfJstAoyhrfgyGE=;
        b=Gc8+z3lgSuz6FLjWajBeIE6L3/i30f0DgJnGkjVdNCkldNTqUVOOAV1bEGwTZT605V
         BCOJW0d+do9MfGIQVOgsc7IASaPPXOREMcBA7+XljSUzDc4PnrCKNhmwo3lfs5KrmIwR
         Jgu2ckS9tYHQJgwvsOO6z8Bm2xVSkfswyMkrEFI59rhgFSgh9zBC5ZsDJOvh/qJY1Ugs
         ajMFL+61u/sR1JoMZ1V2hQWFD1nbJz1aQDn4/Q5VuujKvsFIB7RWhDYu+c1MrkTSmrHR
         evzMwYAFxzO7kX/RrgN3Wop6EyJtH0f4JtC1Xf0CEr4QqWk143da1qX+yt/SmQIaUqoc
         aJSw==
X-Forwarded-Encrypted: i=1; AJvYcCUx+q9U//O/iw6t1425750sbxmZ+19on3C7pnJk2+sPoiwHoAL//3fAzcLxYmUyjYY0LDfLTDEI@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEKU7dlgrgn+ONtuvjNgYCXYv0by8C+J/P5h0Zox6nZtD9tVv
	bYHBTXkMJE0ny5zt0JABkgV67YALl/px7LjOdbTW6qa0qa3T/TF7QL/UiGaQAg==
X-Gm-Gg: ASbGnct3qtql5SMzTMgpmvINaDrR8eTISjZMN1es0dNnq9BaeRFeUvEakIniEUtn/pT
	ucNlg8O7uE3fvoSZ9eFTuQShHnHOO1fpGWUkDo72xfHu4Tf1x/41OXfwLpNlpCDwOvYuN6K9Iys
	bVwFHkRUiAsyKbOILaKdj1qJKgLur1bHImRqmDFCOEAuX4Tg2nsy9NBvUKwETdvx0StfxS+VW1C
	S7G0dC4Vm2h/8/SUYkhHiyKxgCwPxWuRLEPspwusSF4EP5fGCb6IIUiuwSGKZYgm3jfCDoE5uYq
	+c51A8+TXjlheyiN+VIgecKvHq9AMIkw54HhHxw9zRYEu6eYIevYFYdgIpQh5vlYIWB2W78PVBg
	fQ8lfce3kmu0lHz6+DE3Z
X-Google-Smtp-Source: AGHT+IFLF4YtunSYQ7QNejx/mEZrANwUXgF4hDAisCDje3rzXzdymZjJ7VbSi7PfQ7RsDv9kFE3EgQ==
X-Received: by 2002:a05:6214:aca:b0:6ec:f0aa:83b4 with SMTP id 6a1803df08f44-6f230caf44amr77622196d6.8.1744403375439;
        Fri, 11 Apr 2025 13:29:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de970e34sm41121236d6.32.2025.04.11.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:29:35 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:29:34 -0400
Message-ID: <ec975217c9bc8155f454a1dc7b3341ea@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] selinux: contify network namespace pointer
References: <20250318083422.21489-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-1-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The network namespace is not modified.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/objsec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
