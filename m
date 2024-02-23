Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00E14E2E4
	for <selinux@vger.kernel.org>; Fri, 23 Feb 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727166; cv=none; b=Nf54X7GQddakWeuipbb1FnmGV0mfQIdlRtlDCCLG3lTUO8rQVr6dKqkcBObB7Hk4LAzUU0c1i5fnTx/tcmXrvr96nHG/E96mmnBLwsiIn7amq32LYvI6pLLFREAKq4A55dj5SrVyB0aQgCpGCbcdd2Oq2Klf9h/LmogRLzPK77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727166; c=relaxed/simple;
	bh=yl6Y8OjqXucNTZvHMl8uXMJj2dO4V7AP0JUis+2Ublo=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=n+7mhTWHmQ4eODLZBpNAc2La0KY33RTA/Y6EDrEl6LtdIyvBerZy9b+thHXhIjYC1Z1dzj3+GzX+4jPoqiwoWGZchLZyf1rpY8YjgFGXbXj29CRfp3RcjpO2xYOaoYzRKtzqAieNta8kWM+YPIfpyQaPrcsoBItIkhNA7cVkw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AaSIGJOX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AaSIGJOX"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso1021826276.1
        for <selinux@vger.kernel.org>; Fri, 23 Feb 2024 14:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708727160; x=1709331960; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/WTiC+xSRhnNhPW0kRXjLIR3j86zQzkuN5JlritnPA=;
        b=AaSIGJOXI22MB91NEXooS1RHhaU63uFiJCGq8E09VN8h/zv8SJ/9PSgu/Lm29zUJy4
         d4MxyM41wbQsZ4fMeWrAZBgIISx+vJHgZbcFqcERXLXip8Ya47p9zDothOtcllPBwUI9
         PCAx7hLzBFwB9t2m2npKjXSHRBOnvOP1OHbIOCbK2Q8frRqqA8aLJNGq0MWU7OXUGDHy
         EKHJPSr8b1gNCNMk1paW80DZSg/qAE+D1AlLAyqqjbfeUEDMsax7QGw9Tt+ycbRSr/jL
         kvzvLk07I+I+hYql7MDU31F9E3xFt1KoZAPm25txuEBX8v6NoBRRGRWFYW/UCHImUo9Z
         9MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727160; x=1709331960;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/WTiC+xSRhnNhPW0kRXjLIR3j86zQzkuN5JlritnPA=;
        b=L5V/5wk8ewWpTD9h0r0iS7mcBf5mN6ehKjgfMDFgEGTiDw8Wr28E4zeFJ3ZyUXI7yF
         9DPDkUZF1C+d106g0abznYrKjoIWYHDQ684wAonRcV8kOPedVy6f7+Es4nQVHFg68oBq
         0exZiPA3PShcF5EgwfoDzHb2D4Mzy9R2lZ8AKZ3OKGiq/tag8noGvnGKK5y94TwfeARJ
         x0nxtSbfvK01wbXt3FCqg7Zv5pf//oZFz58b4IGYoak11BLS+YT3y4ahtnHEHua3TYNa
         hEWQLSpIfMh5+aMeRh8i9v5OSfazTv3Cj/l22f1p7xTyeruw/ckFvUEJ7sZsbR8FIMK9
         UoQA==
X-Gm-Message-State: AOJu0Yxx4BZoHuCP0JF03K5OOQF3hzc+NfT6ojgpRsTk8RbiaSrPLKRb
	ZP+KhPShb1ehn/txX0iBRcEzB3lLTnm9kTzDWq63dY6zt7Sf2vDTe6lvUaRE4kDHTLjKUCuDO18
	=
X-Google-Smtp-Source: AGHT+IG+AcNavNS4MAAmKoDSWNkpD66ST3pbXw3wFRTbVaFv7FH9zJ+uouNAEXNTB917gU/VvqmpwA==
X-Received: by 2002:a05:6902:160e:b0:dcc:1dc4:15e4 with SMTP id bw14-20020a056902160e00b00dcc1dc415e4mr1479249ybb.47.1708727160181;
        Fri, 23 Feb 2024 14:26:00 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a164800b00787b80298d0sm793486qko.90.2024.02.23.14.25.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 14:25:59 -0800 (PST)
Date: Fri, 23 Feb 2024 17:25:59 -0500
Message-ID: <167af80cbe225e4fafbf13e739aded54@paul-moore.com>
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
To: selinux@vger.kernel.org
Subject: Re: [PATCH 0/21] selinux: fix style issues in security/selinux/ss
References: <20240222235708.386652-23-paul@paul-moore.com>
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>

On Feb 22, 2024 Paul Moore <paul@paul-moore.com> wrote:
> 
> Continue the earlier work to cleanup the SELinux kernel code to follow
> the Linux kernel style.  This patchset focuses on the selinux/ss
> directory.
> 
>  security/selinux/ss/avtab.c       |  105 +++----
>  security/selinux/ss/avtab.h       |   74 ++---
>  security/selinux/ss/conditional.c |   68 ++---
>  security/selinux/ss/conditional.h |   23 -
>  security/selinux/ss/constraint.h  |   61 ++--
>  security/selinux/ss/context.c     |    2 
>  security/selinux/ss/context.h     |   41 +--
>  security/selinux/ss/ebitmap.c     |   56 ++--
>  security/selinux/ss/ebitmap.h     |   42 +--
>  security/selinux/ss/hashtab.c     |   23 -
>  security/selinux/ss/hashtab.h     |   35 +-
>  security/selinux/ss/mls.c         |   83 ++----
>  security/selinux/ss/mls.h         |   58 +---
>  security/selinux/ss/mls_types.h   |   32 +-
>  security/selinux/ss/policydb.c    |  405 +++++++++++++++---------------
>  security/selinux/ss/policydb.h    |  192 +++++++-------
>  security/selinux/ss/services.h    |    3 
>  security/selinux/ss/sidtab.c      |   69 ++---
>  security/selinux/ss/sidtab.h      |   36 +-
>  security/selinux/ss/symtab.c      |    4 
>  security/selinux/ss/symtab.h      |    9 
>  21 files changed, 706 insertions(+), 715 deletions(-)

I've just merged this patchset into selinux/dev.

--
paul-moore.com
