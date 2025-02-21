Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C301BD9DD
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117153; cv=none; b=ZWfSuOzdpi+0UicXG4iPyGjFYs2XXpaHvrDT5RiKXlzSg3uY58cj6dvqQREcWB8F0In5dy1bGvuC7StmveYxK/lCLZREHXkzLJ7lEnD0hTZRMOuRE9B5Gt2Xsc/oE5Wd1UFJJi7HvJrLl3cq534FJ4DU0gPxvsce/Mz+223NIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117153; c=relaxed/simple;
	bh=cNzEjFLDoQu2Kh9QQgx6Jh3Q9RCNefa1fiFl3jOui7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=iseTAuof7AD1NYVGrVEj57KxxM6JqxFf63Ghk6v2YhCiz+wPBNOUliBjYRt5K477bfRDHHQG6gsmtap6V5rPsrg3GefbqF3RDn97LKbkAE3wuplLJ5B27WRx5UmfOsBum6iM7WkT8Cp/MT4ZOWiAUdsbJuA/LSyUaGuPAmL7X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQl0FraS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQl0FraS"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2f391864so939109f8f.3
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 21:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740117150; x=1740721950; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBU2exOWQb9B5OqveJPnNET2+fUMjHk7VsDM+Hvgh5M=;
        b=DQl0FraSAFq1CxexT3vJ4PPPluGExstB2SkOQlrpX8haVIhfW/TKXCs0MViBdaXPxs
         I3wuy3ehX3Yf4M+yTrHX49mjfsW9pHCl3CUxxs7e0HzL4Yv9YdUPnS8pHR6qJh6bpfdm
         Q69WhqpX11rhHdEaY7CpqLTN4i0u1Th8GoQBC182YNIy9IHpsBgOkeawoIG3o40BDbKl
         H7pVFvzSZLF/+HncVkHB64jt+JbpUTOig7ETXubdP5PjoTHta5tMVvo1vbV6M3GjHo0a
         akVfpOjq2j5Xk0SEkbDKO1cOy/zJRwrNt7iyy+L3JIc0ksT0WdRM7u62GK+YPn532L+D
         71XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740117150; x=1740721950;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBU2exOWQb9B5OqveJPnNET2+fUMjHk7VsDM+Hvgh5M=;
        b=xHN5VfEcbnp29guZo1jLaZ6EGZsYZujmAOSxQBt1WCHZCGL/Ic5EG/+TnqTmLUZ46a
         ep8+iAdfI6i9ZpiBzQiGxa6gpS/WxwXBnCVupxrMNZRAHQ0JKn3zv56ZzNzCVwuMGyBm
         bGR17jHN6bDB2uMK1HSrlXo7nsKI05MLzcAvIME9H9IQgg0AXS2g2LWVq9DLwyBq/cTy
         dzrL6vTO/ZnwVXFj9nxd6jy8h/vyJW4FhNeKGDORugMr2781Tx0hGqZqOFUJi1gMNL66
         iNEYknOnAU0lW5QS1x4OP37PFoeQEv0xlnFVE/Zy5E92W5S8ohN99NouscYs+j+oNGmI
         JwkA==
X-Gm-Message-State: AOJu0YwqGSWZ3CflT6RHNJzzi9tEq151unbMuufdGgKDxga36ocht74W
	u8zyFb3p6UMUjRwfxkwYvTVdIUl3vLkE/equYTx7mxOZJ8sV1M3q
X-Gm-Gg: ASbGncsRAK8gtnz7Y0I5M1da6a/wVms4yKESs7yCTFr5IKyN4wgrOCNJlalMNe4mIZB
	q4AWTHvlNUQBcCkla1MgQpYJBp7NYKvgl4cb31TDa2Q1rWrvt445xGtFqCT+sEWLUooF7mELfrB
	LP8Rth8bTZTPbE1hGurqYJKNewWd+f+P9wJM0rUMsdJ4a2gVturOX7bLcVrQwiWKsiJ9/mbiwwc
	1VkMkqOXzEkxLj5q5BHsUj9K+3h/3McohLejYKoDXuaM+GXAWw/iSS1Z/Tk/qM1bztHr2OpoPSv
	QkycloYN9I+ElS0h
X-Google-Smtp-Source: AGHT+IHbjRCUlCVgqMGjSeceLCJAZILs1GOkD75+SU+DYDfZOKNhyrpIVT17Cm2Lu0zxhu2HxXq5mg==
X-Received: by 2002:a05:6000:184b:b0:38e:dcd4:a11 with SMTP id ffacd0b85a97d-38f6e97932emr1042715f8f.30.1740117149872;
        Thu, 20 Feb 2025 21:52:29 -0800 (PST)
Received: from localhost ([81.79.13.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm22054011f8f.85.2025.02.20.21.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 21:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Feb 2025 05:52:28 +0000
Message-Id: <D7XW1Q3407I9.2LRX5QH5BAHGX@gmail.com>
To: "William Roberts" <bill.c.roberts@gmail.com>
Cc: <selinux@vger.kernel.org>
Subject: Re: [PATCH] libsemanage: define basename macro for non-glibc
 systems
From: "Rahul Sandhu" <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250220211249.574456-1-nvraxn@gmail.com>
 <CAFftDdo6SvOE9+XZY3bKidFGz_So6_N6jNxxSyB0OPR8thSY=Q@mail.gmail.com>
 <CAFftDdpV-dnLKVTDACgm2RUG8gnBU=3YnJDp5_ZyvR78p0eZdw@mail.gmail.com>
In-Reply-To: <CAFftDdpV-dnLKVTDACgm2RUG8gnBU=3YnJDp5_ZyvR78p0eZdw@mail.gmail.com>

> What system are you on where you run libsemange without glibc, just curio=
us?

All Gentoo machines, Gentoo musl. :)

> I am not opposed to adding an implementation for basename where the
> input can be read only for non-glibc, but this patch doesn't work:
> Per the man page, https://man7.org/linux/man-pages/man3/basename.3.html,
> basename("/") should return "/", this one return "\0"
> basename("/usr/"); should return "usr", this returns "\0".

> There are two ways you could approach this:
> 1. If you wanted to do an implementation, I would add it to
> utilities.c/h and call it something other than basename so we don't
> get any odd issues with it choosing the one from the headers over the
> macro. Perhaps libsemange_basename(). On glibc systems this would just
> call basename directly and on non-glibc systems do the implementation
> with your own logic.
> 2. Just copy the path into a modifiable buffer on non-glibc systems
>
> I would do both approaches. Create a utility routine that calls
> basename for glibc and for non-glibc just copies it to a modifiable
> buffer and then calls basename over rolling our own and the bugs
> associated with it, also add a unit test for this. This would keep the
> logic in one place and be dirt simple.

FWIW, glibc's basename appears to be really trivial:

char *
__basename (const char *filename)
{
  char *p =3D strrchr (filename, '/');
  return p ? p + 1 : (char *) filename;
}

> selinux_policy_root() returns a const char *,
> the usage in direct_api.c path is a char *, so we only need one spot
> changed and that can just be a simple
> copy to an intermediate buffer or am I missing something else here
> you're pointing out?

Oh good point, we're just missing a header (libgen.h).

I suppose then it is just a simple copy to an intermediate buffer, I'll
send an updated patch shortly.

Thanks,
Rahul
