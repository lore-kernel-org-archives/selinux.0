Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642A3F9F26
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125866; cv=none; b=hk/SlUQLnL2ZuQWeW9fwYM9IRj6N3BmZvpzjuGB1G7EoB7tv0PNb8FO/SmDMmebwtkQlbwujjvK8DLOwkUkMGBtAqku1XA0TQYbd6Rr28bFovMwuvDZdW1GLxRioAb+EUE9kaIrilG7IjXKStE/rnB/q9c0xzOczbgp3lUTLt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125866; c=relaxed/simple;
	bh=dTfnOyCnA7hxdwn+lzetAiaSH6DRBFI0JNJ4cyWnp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIM+7bEtHAhe9XhPuq9Z8T6BoqOtzNpjAFejt3TU0kg/lpcEm92CS2Di28aJFBjUYPRdqxBpFz4ykVhdlttvaAJZecLjzShsFfH5EzDR/JvTBF0mwDM9NAbHlmbu4h92nwSfRyIf+KEHyQgNZrg/NvRkS3a7V+JhtBFKPUJtgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Abhg5kEP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Abhg5kEP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so9940065e9.0
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789125853; x=1789730653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yxMwJEm7jTlZ/4MOIRCMOFi1PHLu4xK9k7RvriEL/cs=;
        b=Abhg5kEPlOZzz61wXw4oP9rE4wPA0mEaEzF7lShaceq7q3ZH1UerVQTWGIrm9A9JhF
         gvTuvkzoFoLJCk2yyIhu+dEs8i9bME3TIT56nmYwsFKs6eqlGpmnToBV8bvLgWBy6D+M
         FfnHwFNlIGl203Wj/Gizw2PLW5QFURhLXASolY0RSLnKPIbniz8SSR/nez3cGGGCpjnt
         buTJN7EXDu/2BIDNBjzfhDCRTVhJbDJGTIAb+an+GPlDN8T19oElChX/QTCRdLNMHrat
         VOqeWiU6tRB37wZKIPvHR/GpbtOmqI03p+49k1sYadnYPnROweYxZIhZ7w0SojTH2hBt
         KB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125853; x=1789730653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yxMwJEm7jTlZ/4MOIRCMOFi1PHLu4xK9k7RvriEL/cs=;
        b=IANHM4CM1UhXDnbF4F9apZ5BD+tFOZtIertIU4oYe54TlMllnbVnMTMR1P7DL53deE
         +xJWTDOwBW+A7WZnnp18M2uiyLeD+HaC6e9Ci8aohjetvbX2BP+xodRaOVWHxXlOsDgd
         I7V9BlH2mGidd2YCY9osfI2iyT9p4YemlkAv9DrSWrNyWzUSG7FnVilNXyw4p0aNzZia
         Nc0T7Z4rspGQBKhL9n0NeWMp7+YO9An2EhSDxvZAyS2gpGe/V1wiQghb2QguJF8HCt8D
         sa1E+cS/FJE8t6povHk50bvt0CyC67jz3nXteEQg9f/v3zSljl3hg2Mhs6fMaiZqye22
         O02A==
X-Forwarded-Encrypted: i=1; AKwUvBxylPlkHeieT1GlCFF+6Ba/FKHsHbAv/0FNUdWhw4lUJC2JHF4aVYOjNbzwoJlln5jLdtA/B+Ap@vger.kernel.org
X-Gm-Message-State: AFuF++kcwYWpiVQG3eVX83wgUbaMQCz0mtfgtIfJofI7AzNfFIm6wWtB
	aEbgFv8KUAKaNHrsfiea9HQRYVh26lOX4576sQ5hcmY8lbeGkwIjRGPCvm3XUCKDrg==
X-Gm-Gg: AYBFou0lWaLUPnXaTF4AnC9BxBnk3WOyQKqJCOKJ8gA/Sz5mskiJ0NbDLsBRy9hRMXK
	4XddIV2cTSdCevYTlcaz+Ho5/NJb53NU1L8zQkoRAnoaoAy+73qf8edcUVTMejAh7RRdbyBh3MD
	T3ha3wCL7pRYF7bM9Te2GeCtcv39A6RBtmWr2/TLHpqwn3S1PgdhVk+vEc/umJt4SIEp86uCre/
	8mp5fElfxz0m2YgTVV6JWTcQ8k6SzZ3t4zSrRyednreNLHGSn1oRn3DmhuHto/ny5QzTimq5Tp7
	2/oEAh76p1IQfiymvphb4e6/ILjUjGy9DPXdeLx+qkMGypS8tmgiicZcCqi2NuRlhVFegZYQ2YA
	sM5oy7+Y9+cbOmh4PK1YcqdN9NnJXIICwDa7PaL1LQZw/xBV95WbOUb2YZuwGK5cSeRZs1SkPdn
	ZmStlSg0i04/kY+0K2T57ZqIXj6m9OmnDhcNYFORI8mJm41LdiDjE74pO0v3LQnk9VLYQoAFX/Z
	wuEILt1G89YZ8BK4oX4qZ7VmhpOPQ==
X-Received: by 2002:a05:600c:6309:b0:49c:ff3c:973f with SMTP id 5b1f17b1804b1-49e619c45f9mr37913425e9.24.1789125852560;
        Fri, 11 Sep 2026 04:24:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:9f0c:8f56:41ab:6c3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm68594435e9.9.2026.09.11.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:24:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 13:24:07 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Jeff Vander Stoep <jeffv@google.com>,
	Nick Kralevich <nnk@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	audit@vger.kernel.org, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in
 audit records
Message-ID: <aqPk1ytxErNcqPuQ@google.com>
References: <20260910144837.381855-1-mic@digikod.net>
 <20260910144837.381855-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910144837.381855-3-mic@digikod.net>

On Thu, Sep 10, 2026 at 04:48:34PM +0200, Mickaël Salaün wrote:
> The ioctl audit test uses FIONREAD, whose command value fits in 16 bits.
> It therefore cannot detect truncation of encoded direction and size
> bits.
> 
> Use an architecture-independent unknown command with set upper bits and
> require its complete value in the audit record.  Landlock rejects the
> command before the device handles it, and the existing ioctl enforcement
> test already exercises the same request.  The new expectation fails with
> ioctlcmd=0xfeee on an unfixed kernel and passes with ioctlcmd=0xc00ffeee
> after the shared audit field is widened.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18dbdb99aeba..1abdcc9ee784 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4146,6 +4146,9 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
>  	ASSERT_EQ(0, close(fd));
>  }
>  
> +/* Arbitrary command with nonzero bits in both 16-bit halves. */
> +static const unsigned int unknown_ioctl_cmd = 0xc00ffeee;
> +
>  /*
>   * ioctl_error - generically call the given ioctl with a pointer to a
>   * sufficiently large zeroed-out memory region.
> @@ -4249,7 +4252,7 @@ TEST_F_FORK(layout1, blanket_permitted_ioctls)
>  	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_ZERO_RANGE));
>  
>  	/* Default case is also blocked. */
> -	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, 0xc00ffeee));
> +	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
>  
>  	ASSERT_EQ(0, close(fd));
>  }
> @@ -7943,6 +7946,7 @@ TEST_F(audit_layout1, truncate)
>  	EXPECT_EQ(1, records.domain);
>  }
>  
> +/* Checks that audit records preserve every ioctl command bit. */
>  TEST_F(audit_layout1, ioctl_dev)
>  {
>  	struct audit_records records;
> @@ -7952,10 +7956,10 @@ TEST_F(audit_layout1, ioctl_dev)
>  
>  	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
>  	ASSERT_LE(0, fd);
> -	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
> +	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
>  	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
>  					  "fs\\.ioctl_dev", "/dev/null",
> -					  " ioctlcmd=0x541b"));
> +					  " ioctlcmd=0xc00ffeee"));

Minor: I don't see much upside in extracting the shared unknown_ioctl_cmd
variable here; if we used the 0xc00ffeee literally in the
ioctl_error() call here, it would be clearer in this test how the
test's stimulus of calling ioctl() with 0xc00ffeee related to the
expected output, without having to do that side-lookup.

Logic looks good though, good to test it more exhaustively.

>  
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
