Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018C509EF0
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467056; cv=none; b=tRlIFVpR6phP0G12K55LojriSEYnMzTddqHK0nfuJIJsVKZxXIGRokE4SdOKXu0jIm2wqdfZuGQFb0lVOFCPKBWX96VNHJwd4Z+KbVYfeYdMtNKppZsg9tn74vJLK5Kw0IhYG7EVh0QRUm6QwtAdkcEXoppF1tkNyx3+hsi4W7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467056; c=relaxed/simple;
	bh=lovyBWo4HbHG9IAJc1682HSdnTeu5LyLU45uKHLvmeE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EWmOs/3kcfShRCacZpCxgxXKPcTnmPP4H+h+yDdWqY7d2tJdiYcnOzoL7YivGg75j0RELaCqrIPOrYLYya2GCZpMjeCVMKy6iRFtkkEK3gwOZR1gjg3NmAqyT5U1it8YG/2+Y8rbr5GNICvzbUlJz+9T2RKhLDGqNzF3y7RSq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AdSsSsoN; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AdSsSsoN"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-529a1ee0e62so4643881cf.2
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788467045; x=1789071845; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8uOzk5kbNElpXD3JZXWiXWL8uLf97nPgxHodv2izOs=;
        b=AdSsSsoNkR8xZ86VkSDiP/2Hb8TXf2szTrC7SOhbCflatvm+ErE3ngJLYkfJQgmkoJ
         hHXhA14Oy796z0v4bq+KENmudoQ7O8YMHdyFx/g8NbphhGTy2h3/CNEuehe1UvSr8nL2
         ckrcxWV6zC/QS/qcQ8XrJ4uJ4JVFhyvxxocxh2uHPSll4i2jCxVEKGenz0zFp+z9Adlt
         /gp9WXivzjSo6CtxgpguO/HRBXrumfEZlMpXHvoBJR+v835Ze4FN5J2CLLSDvuU1EkoM
         WTb6UgBRnsbZiWJ6XBfrS3XPxZ7VwLlEf4n4tHR+Dbjehs9xilepDZKYJmyVzDBrPL4o
         klmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467045; x=1789071845;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8uOzk5kbNElpXD3JZXWiXWL8uLf97nPgxHodv2izOs=;
        b=CfwVxpt4bBU2pSeeBPW1SDplLzZlvTTwXcbN7/fDXsw3Vf/M9gZSTEzMIi+q7dKoXC
         H1GuUnuLWHG3C7H0+h8iKeYd6PQmqa4RsNWHBu70C69Hh1aWjIiKi+/96MltNyM3ka3o
         edN8RwNWCnyMgmQ5HkA+iIwjJAdtY0Ezvzw8C5O/uxNNdNn9ZLjbSdSEJ65Bi0Aem85v
         j2r/mHi0x73MczH1Js9j347GcMdZv87PID1GRRYCAcPjdW9mSHW4nUCY06xhkM5Onz89
         BhwMGMwatJQ0BcM4Raa7+LnXspaNNOn8VaZQMLmzHgQY+7KjPs4ucpO+mRp7cpt1ROCV
         2cPg==
X-Gm-Message-State: AFuF++naK9Anw+M8NDj6BVWGDqTEnyNu61cov0gpUV4kAPjUMvpjsnsA
	zgxeoRwKUcdj0HyzTBvReQrqPDCnnNjYeGxFbhrmfVZsytMdmpRrNQJ0yLzQPaf6rw==
X-Gm-Gg: AYBFou0xCaaIEZeLIGoQx/r96YyLAA87+H8F3BKF1aVYMmSHvqxQNRJ9BiubJrA5nkD
	bj+MJL8bj4MVi4rnzr5srHao+41+NYer+EYTulCHAbRHe2WJzbJRNI8iFmWSdoTuHqoRCUrDvzK
	HAJsDnRPAj+APaCmNracIYLoDPqte9Q6adPyIsLTN/OU9i+otq6nXnibpf91ERFdZ6hZZ+PX2Kd
	tkeQgMsvK5Hec1QOaMRUHANHNokNe9r6Bh5Z4nyL5/7UdaikGpYMhAwD8g2YCnmJ76UU+RpTfjk
	nb7dU3hNHAq19vTbUoPTio9LsW8xz8Mr5gPufYNj4TtQarCJ0Wj4a3q0YoT+Y7ByUa4pC/TDEq0
	3LQ59gAhW+O3KqCjbTut9SqKJp+HehGkprlGzo/+MaM86NEsT9yQk29nBm+Pna0NEhnA6N9EDjQ
	7dw7qzN/LCgfpUy9txI31lySfrfmZCAK23z5d/LjiVDFjuVC+tTIBag2XNM29/Gt9ggQVV5aO0A
	NBDt4cKm6aMOcl/RnxN+ZsZpdys8hWrqQ==
X-Received: by 2002:a05:622a:114:b0:530:42e5:f3a9 with SMTP id d75a77b69052e-53054a10750mr15915981cf.44.1788467044885;
        Thu, 03 Sep 2026 13:24:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406871b6sm3176156d6.32.2026.09.03.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:24:04 -0700 (PDT)
Date: Thu, 03 Sep 2026 16:24:03 -0400
Message-ID: <763ef0523ed8e2e25ef5b902e21b0c53@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260903_1622/pstg-lib:20260903_1620/pstg-pwork:20260903_1622
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, mailmap: update email address for Ondrej  Mosnáček
References: <20260903155615.516010-1-omosnacek@gmail.com>
In-Reply-To: <20260903155615.516010-1-omosnacek@gmail.com>

On Sep  3, 2026 =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com> wrote:
> 
> I'm going to use my personal email for kernel contributions from now on.
> Update MAINTAINERS and .mailmap to reflect this.
> 
> Also switch to use proper spelling with diacritics, since I normally use
> the full Unicode name with my personal email address. I'm leaving
> in-code occurences unchanged though, as that would be just unnecessary
> churn.
> 
> Link: https://lore.kernel.org/lkml/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com/
> Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
> ---
> Hoping for this to get picked up via the SELinux tree, since the main
> change is in the SELinux MAINTAINERS entry.
> 
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Merged to selinux/stable-7.3 and will be sent to Linus shortly.

--
paul-moore.com
