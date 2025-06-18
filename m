Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FD19E96D
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273977; cv=none; b=kiCxWh56qVkNhuow6noDBo+qfnkHfqnKQcVx6+XSBY5YPU7XHXp7LFYetiMhqjynDZt9u19i6iAO+IDdsME/XiLkfbsL95Zqfj5Bh6AQLcmZX5vr46azGj+Fi3S7WKSlwiMxCr2MWceUSHJSFmNhRgY9o3MBdSh8fJYqkuceKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273977; c=relaxed/simple;
	bh=1GAoAaNne5FvAg4pogL/baWLUU/ER1tHGtrWd1I/U/A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZPG/4t4PB6kObuMtfXam1A4wbYl+HLM4ZTL4JYuqnQRKu6aI98+dTSIkVb5JPy2njA+1vAYanMCQvtQ1sdSoS8YkZmqupiy+k3bu2U9Oq9GQYUzbAa4Q/0gqf/eAC/SW9uNF2T2I9DvPFJk0YqiWf0o605QfJ2MpfgtAQ7u1gTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y7E7ZnC3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y7E7ZnC3"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a4bb155edeso85787301cf.2
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750273974; x=1750878774; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxfuwYQybzRWeyHM6BPbsiw9nivRgN4Rxo+D4xB9ylc=;
        b=Y7E7ZnC3yy4gHVBdX/mqeFg2Pu/MHx9NuLn5aStVNGn24JUFn5kY8avRhA0M1WEVo/
         E3xMEYjQcmJxmqkM925iFhAOWDTDTgmB86fh0mdlin6D4Pp05QsyTSa2KWtaA7gE4wsL
         yJ5dpSORewi2uzSwtJwi79WXKqxbeOyKWadu39TRIrXG7zDY4XZ757asGvL+tvT+RDuz
         XQAZ4/Z41UB9VhqQ4JIbyIYyRwukuILytBTBFq2xV35Vttr5Aj4HgPuydCVspOlD0GM1
         kESbmJf2g5FngKBbmFAEeZEo+rNlD3j6BasYaxxBVrI3FArXsYvF23NpneuEHrlCsEzg
         ca+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750273974; x=1750878774;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxfuwYQybzRWeyHM6BPbsiw9nivRgN4Rxo+D4xB9ylc=;
        b=JLD93cwUrlAHdKqpIcuEJhhCjuYFyo199yUd0kdFE0CIcnogr0LyulO+7W1IR1uD38
         4jBNwmt6g7e1qsV+F0GztQp0l6zrwDpjVxHAKY3+EbF3qTh5L031USeW+cjUWhNDCsXs
         twpnJ1lA6lRqsZyTKGVGogeSk43ndeXStEv6Lb959jtuWm3Bjj3k3yxmVYXx0SL23hUF
         6TTPc+3LWt1RITjRJQ9Sng2HX3p9CqIbpK05mGIZHCVJdhkerKzHBs2L47QBH8ew4/UC
         /xTC400JZSVLhar/POJ3AZ9c3ezqExw/DmlEVknDwqx9hlSt+8l86/9JVC6jdCm3exxh
         h6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUvFWQpJuYmEbP/cCeY2OVQyI0XnP6Xfh6mm1LqxFYgLWGFkUI+rWKzSFJCHf6Cm6TxfV/rpnul@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUh3a7SxL2vfjZgtl1Jo4iVIms9rtRjiXulT/tj51eI2Bj2Jm
	Ou3Z/o8V6QE8wz97r6A9orQ01UAicdGU3z9FXI9BFhO15gCFO1vTzgroBV8R15cOYw==
X-Gm-Gg: ASbGncvIsg3qebmP8aIipDtJyxOg+T5cVnZpFNBh674WYr6C3v0IsnmzMcr6nJlEnOd
	xfuASowuQbwux6WEr7V/xeWTchVaLEeqx20h6Wze6LDMXHa3PgeBPP0D8fv/WnHi/fyXrx4iirs
	2VaDaDIyQ2rmO4CUtHb8GLJkUJ7Htkby2eLLn5LoYZZPhc/e3NCfoXCa68gbQ2A1O9/JdmRDgdG
	uLXLklRBxcKLTpHTtRTI8vgCtkpUcQNXRdjfK41O9siB1npZ8Y8mkqj398gxoxwmm+ioyKesfTe
	TNFg+/Bjy2w50mN+Os99XH/qy9zQuj2kVR6+s7MtTCyqE/ef2I3jpVPbTMa791Q0cdATw9H/uzm
	MMTZNtft3Y4iWY82Y5it+H7zYCHK+Ba4=
X-Google-Smtp-Source: AGHT+IFMy6D8qPgdxp1eCl8IeQKsCoFbPgynP8xBLR/NH3dDorM4TX24f2Kz8lwzGrE03P27oyAxMA==
X-Received: by 2002:a05:622a:8a:b0:490:8cc3:d111 with SMTP id d75a77b69052e-4a73c5fc8eamr319622181cf.27.1750273974062;
        Wed, 18 Jun 2025 12:12:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3b8eabea0sm794852285a.55.2025.06.18.12.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:12:53 -0700 (PDT)
Date: Wed, 18 Jun 2025 15:12:53 -0400
Message-ID: <2de6d4fbc8b5eae256c4dd3a718b08bc@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250618_1506/pstg-lib:20250617_1648/pstg-pwork:20250618_1506
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] Documentation/admin-guide/LSM/SELinux.rst: add links to  resources
References: <20250617143906.22706-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250617143906.22706-2-stephen.smalley.work@gmail.com>

On Jun 17, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Add links to the SELinux kernel subsystem README.md file, the
> SELinux kernel wiki, and the SELinux userspace wiki to the
> SELinux guide.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 adds a link to the SELinux userspace wiki as well.
> 
>  Documentation/admin-guide/LSM/SELinux.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I'm going to merge this into selinux/dev, but I applied some tweaks
as there were some odd inconsistencies in the patch, more below.

> diff --git a/Documentation/admin-guide/LSM/SELinux.rst b/Documentation/admin-guide/LSM/SELinux.rst
> index 520a1c2c6fd2..22b9f91b220d 100644
> --- a/Documentation/admin-guide/LSM/SELinux.rst
> +++ b/Documentation/admin-guide/LSM/SELinux.rst
> @@ -2,6 +2,17 @@
>  SELinux
>  =======
>  
> +Information about the SELinux kernel subsystem can be found at the
> +following links:
> +
> +	  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md
> +
> +	  https://github.com/selinuxproject/selinux-kernel/wiki
> +
> +Information about the SELinux userspace can be found at

I added a colon to the end of the line above, "... found at:", to match
the style used previously in the file.

> +
> +	    https://github.com/SELinuxProject/selinux/wiki
> +

I'm not sure if you were using an odd editor, but the horizontal white
space before the URLs was odd, including a varying combination of tabs
and spaces.  I changed the whitespace to just a single tab to match the
rest of the file, but if your spacing was intentional please let me know
and I'll back out my changes.

>  If you want to use SELinux, chances are you will want
>  to use the distro-provided policies, or install the
>  latest reference policy release from
> -- 
> 2.49.0

--
paul-moore.com
