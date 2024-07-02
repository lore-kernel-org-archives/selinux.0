Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F316C69A
	for <selinux@vger.kernel.org>; Tue,  2 Jul 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934868; cv=none; b=PP82QKj21x5MoyMChxfa8kzEyQfOYAsl8jTLfwJ/poJH12UfSMp4hzBnQ9sNFgxEVgJRBnTVow+97b3Y4OIEztfGLXb5s+VoQJek7U1pcsmYdkXr2bl53iD4mDMx8XxKxKJv8qXvf46IKIOpBQBd2pw0Mpc3poTSRC1gO6TLPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934868; c=relaxed/simple;
	bh=3iFFFMShLQ1EZrUtj0wlYgM/8EAXOVw7Zi303LuWzBQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=JOcqacNQKyehK5/OhT1o4swG0/LiVIzwaHmqWjC7nFfTJelgPuXt7Qk0coVNs0QonwXq081rGEBXjy05rAqZujZHUwJj+gE5eO6CWSXBqn8snZFE29f0kNX1TLbRbhan6zILjbv/+Qu2Ec/24d9ATAQqlr1MCeRdaUqiDJVfnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EJlo0la8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EJlo0la8"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ad8243dba8so23679096d6.3
        for <selinux@vger.kernel.org>; Tue, 02 Jul 2024 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719934865; x=1720539665; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OP/DQwYrCVrITtYRx3Ev8bw4+QSb5aJdgZyh0buQtdo=;
        b=EJlo0la8WdzZfM/rr5q9wWBfpNnie7SvB7W8xfh0TvWkSvX9zn3BZD9KgW+TkEBVfu
         TWH0Zs8pPxPkF4hEMr9irgrjMP9m6q2lUrSETtF7niI4pZla3gRd/mESGHcNrfh5Wr2A
         P/+3zqx0Ic3fKGy+oBZJ/60pNf5BvbVSv3BMTIwrQeyXIQgxlXUBb/uzp1VMU8ImlVa0
         vGolYCBKcqSd/vN88USWD7t0uzSPJOuCEB9iJV4MyeAu+BGPJucFZKMhbi/agfLWQH53
         2uyq/XcgcZho3oXl8SwzQ0kbvHN8YOvKhyNjVP63Slk2/mifWPZNJMO9HssFipNMx85J
         qCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934865; x=1720539665;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OP/DQwYrCVrITtYRx3Ev8bw4+QSb5aJdgZyh0buQtdo=;
        b=TsDpqLPk+w+KR6fFSuWGqunTVrjUHiuwBXqPF9yO5u4zyulcAUeX4lwQ5khwfyEEt+
         CmX28dHkukk1QlX2YUnBQDoOGBUAUdJ3bO6Xf9iAGkHIa3x/tXo88lMSjnFcwt48vJ3b
         IqYDbdX85syfcAHrchelr3GL7Wa5BDV+Atg494nb87CekE0eSCnMlZGJLSidO0njrq0s
         /Z/Q8QPQstxkahXK2oAZcWUymPPIad/Y011w+Cy3orhyiWHaYA8Qj3WPzNxeEhXiI7n/
         J7XDMnkylLbDxKJcqDDNa3JSjFkj8NyUdezBdVabhwk8Ef874Trejy8uJOpfQknHY78R
         XQJw==
X-Forwarded-Encrypted: i=1; AJvYcCWWCU/g5y86Jhcf9aQwufrmYn+kKUw+ShnLeCtIkaPMEsBuO2LUbIhUVCbdOchetPhYDaeRMOgA2dih+FmHhHm1bcpdHy9GiQ==
X-Gm-Message-State: AOJu0Yw96C19IOIMset11bZ/P+oHjOGHhSuR5tcMYCFiQBsD5D9/U4Yy
	HgvjOWhvUbdlxMn/qeq4ZZtOnqSaPomX1xVRb2HuThBaCMfr8rxqKI0AyKt52A==
X-Google-Smtp-Source: AGHT+IFo837CZWVrAhqw/4vbVYvDWAFGqECphXob0gkVGdbXPaXQhe/r6vlQz4h2Yib18TcMgO65/g==
X-Received: by 2002:a05:6214:212d:b0:6b5:26f7:76b5 with SMTP id 6a1803df08f44-6b5b704eafcmr144055546d6.7.1719934865537;
        Tue, 02 Jul 2024 08:41:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e721e9csm44805766d6.137.2024.07.02.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:41:05 -0700 (PDT)
Date: Tue, 02 Jul 2024 11:41:04 -0400
Message-ID: <d5b7485edf9a4cdbc85b6b191b00e572@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, Canfeng Guo <guocanfeng@uniontech.com>
Subject: Re: [PATCH] selinux: Use 1UL for EBITMAP_BIT to match maps type
References: <20240629041012.156495-1-guocanfeng@uniontech.com>
In-Reply-To: <20240629041012.156495-1-guocanfeng@uniontech.com>

On Jun 29, 2024 Canfeng Guo <guocanfeng@uniontech.com> wrote:
> 
> This patch modifies the definition of EBITMAP_BIT in
> security/selinux/ss/ebitmap.h from 1ULL to 1UL to match the type
> of elements in the ebitmap_node maps array.
> 
> This change does not affect the functionality or correctness of
> the code but aims to enhance code quality by adhering to good
> programming practices and avoiding unnecessary type conversions.
> 
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
>  security/selinux/ss/ebitmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this looks good to me, and it's trivial enough that I think it
is safe to merge at this point in the release cycle; merged to
selinux/dev.

--
paul-moore.com
