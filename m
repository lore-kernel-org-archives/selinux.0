Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4DB18FDDB
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652360; cv=none; b=t4Jzzdfd/f6soNCXGWN3Git1mWiipuJs5dCFk9ziPoYD7dOxYFq5Ctq2tekA9jLyF4gPoGA1dX7ljjthyDgfKMGOf1RYOAESTrCHGT8UBZoxSQT55jLkmYMSJm2BBLsCBivs+28opNIfua85l98lAo9zRgB7ZF1FrORjQPUd124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652360; c=relaxed/simple;
	bh=dImewWyTRki9VVpC15iKFcWOUgpXXeLEslXif2eWbfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dxV6W4osgApwMGYaOPn7BOxPgdxEh+sBgioXSQsLZfvEJ/5ahQNyPL0/8UXJ0G7IU8IpzbPvSMMrMkJSKm5DJrR41Y3OeWVgujTqBa87ILhaiLY0YRzP25CjihJFUhVeynKpSBOh2XxZvkKCMzUFgiD586DRNVADPMPOwRyxT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaPdXRcJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaPdXRcJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711825a02bso2263605e9.2
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760652357; x=1761257157; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaG5jD1Ljiou+nsuG7rfBuJZBzDeB9iH9Dck9hwNKuw=;
        b=BaPdXRcJUXRyZdLiY5I5nbywhOncbNJ0MARMd3BRXXNwHgRWt71uexFZf0jYwnAE6m
         HdHQcAUN1RgV880IIzgLEJsnDsZhDJ41VU+XHsn+Cv3dPYIfC028OSVyb1JXQ/7cIBkK
         ir6KGq6y06tuHKX6/E4sOLTWKONx3sIUoPnq5Sl/nL4Xpig9JvSnlYTSdKSkZf8vlI8V
         ecUfe33BzyqHV1leyag7Pj94/UDK+n9lC3q9vDTV16GyhNVOTcoINWfdG2ZfYChFMwUQ
         sJ0g22gWJyC2zh6lbCtA8jCEQiQjgoXoBf0Wv80E09UbByPZu/oQq5C6vALNhp+Epzou
         9DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652357; x=1761257157;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zaG5jD1Ljiou+nsuG7rfBuJZBzDeB9iH9Dck9hwNKuw=;
        b=Nt81n+ypCbiU/aOOQPs9MShTEpwZEbM9Hjt3bebRBLrPZSPfNp6Gr8wqg99sKV2EPh
         u2Mz7eVQrvg85uqvQ5TcJT7oEh24roSsiigc1jB6P6MeRSfTVOG7wCgNGT8qSDeX9LrS
         XLLbGFcZAGbQdnsL6phi7AsVWiXrr2b/1Yhuey7KgurmD7eSNXhxD6JV2z6kYRKfCSZb
         twaH83HWmC0N65e9TWEBoBa/lZGUiz8vKOy7Kxb8hgBV0RA6TZRsIKKts1NzOVooht03
         QM6jnE2KCMIYKTUytxA6sokp3dgi+Yq34tqJhopbU2QrND/GxQSri9OG0HoflWD6JlEj
         bTZA==
X-Forwarded-Encrypted: i=1; AJvYcCWaCnkO4OZr/SHUd8PdberRWwvhc5Vz6/DT8ZwZ4xKLwkCws/0QUUPMlK7Hqi57PyOd8Ukrx3GD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lZGj3od7ug+N/6gCx6KjctneLo/01C5xOSd3/YFwV0tfhP39
	l6qLTxMGmYykXShB0EIMvGTSRNm2WU3UwcqsarW74/2ikkRuCFkVaLML
X-Gm-Gg: ASbGncuUONEwCbWoKddWvVFOQgItUun/sV6/SJFUu+UjPxOaJd2cTq2U0G21+mtNrW+
	4M2tHDfWSFi6KhPzhYcCBrzH/FzIev7sB/LVO/mxOno3eU/gUcnqNe/9Ogqr0/D0ONbTE5uiWey
	o0zUksLf4yy1wChE/34EBnLdGzQ2r668J+HYs+swYr/dn/abxVdFTvbex8gBHm2x2r+qMKjDCi5
	sjLeDZVd/ymmVVwMSyafrzHuPTI6bOp/khgZkrN31wHZu41kZEDiYFih5PgwZGpv4jtbFuDFKpP
	rAehIJ4nd7pUu/Q75azTVg5vp8lkQfwLBAirW8TQe4vLX5cqRMAA0a4Yvj+zzIDy3/FskqJWYnV
	uDenbMREenPi3puoHMq/Uq8gOvfmdRlu0Wxg2+EHWFRBVulpk7FWIxOyxTTbXl+al9RHQ1w==
X-Google-Smtp-Source: AGHT+IFXgVVkCr10LrwFVR0GUDVWTIQ1w9M96t6D6Vz5dsf6bz9EzUOSlpbr2wSNTNAEolNRCFcCkA==
X-Received: by 2002:a05:600c:4e0b:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-4711791f4e1mr9900815e9.36.1760652356558;
        Thu, 16 Oct 2025 15:05:56 -0700 (PDT)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cce5sm37789529f8f.1.2025.10.16.15.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 15:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 23:05:55 +0100
Message-Id: <DDK3662P8K9T.RXDV7DIQFPV1@gmail.com>
Cc: <lautrbach@redhat.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] treewide: add .clang-format configuration file
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: "Stephen Smalley" <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
References: <87ldln43to.fsf@redhat.com>
 <20251007104656.479127-1-nvraxn@gmail.com>
 <CAEjxPJ5cMQb2DE37BnzrDQYars8eRfe4VSfN_4mwRQAhj2nW8w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cMQb2DE37BnzrDQYars8eRfe4VSfN_4mwRQAhj2nW8w@mail.gmail.com>

On Tue Oct 7, 2025 at 2:21 PM BST, Stephen Smalley wrote:
> On Tue, Oct 7, 2025 at 6:47=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>>
>> Currently only an RFC.
>>
>> Add the .clang-format configuration file, taken from the Linux kernel
>> repository. We don't have any official style guidelines in tree at
>> present, which makes it a bit unclear how to format C code for new
>> contributors. As well as this, different parts of the codebase seem to
>> been formatted with different styles on occasion, so using an automatic
>> formatter should resolve this.
>>
>> As well as this, replace all the existing indent targets with format
>> targets. Commands used to find and replace those targets:
>>
>> git grep -l -E '(\.\./)*scripts/Lindent' | xargs sed -i -E 's@(\.\./)*sc=
ripts/Lindent@clang-format -i@g'
>> git grep -l 'indent' -- '*Makefile' | xargs sed -i 's/indent/format/g'
>>
>> Also add some empty format targets to Makefiles that previously were
>> missing an indent target so that `make format` does not error.
>>
>> A few other things to consider to do in the future:
>> 1. Reformat all existing code. I understand this is a big change, hence
>>    the RFC, but we may as well get all code formatted if we go down
>>    this route; afterall, it's not like this will cause any breaking
>>    changes.
>> 2. Possibly add a CI target to check that all code is formatted as per
>>    the new clang-format configuration? The options `--dry-run` as well
>>    as `-Werror` can be passed to clang-format for this.
>
> Yes please.

Should this be added in another patch? My concern is that CI will fail
should this be merged without formatting all code.

>
>>
>> Comments/feedback appreciated, thanks.
>>
>> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>> ---
>>
>> v2: remove linux kernel ForEachMacros and replace them with ours
>> v3: replace the indent target with the new format target. also remove an=
y
>>     mention of `.editorconfig` from the commit message; those changes ar=
e
>>     better suited for another patch (they're small and self-contained en=
ough
>>     that they're a smaller thing to merge).
>>
>>
>
>> diff --git a/mcstrans/Makefile b/mcstrans/Makefile
>> index b20279ab..28d8c7bc 100644
>> --- a/mcstrans/Makefile
>> +++ b/mcstrans/Makefile
>> @@ -21,4 +21,6 @@ clean:
>>
>>  relabel:
>>
>> +format:
>> +
>
> We should add targets for mcstrans/utils/*.c and mcstrans/src/*.[hc]

I wrote a simple check-format target in the Makefile:

# We shouldn't have any unformatted files in the repo without an explicit e=
xception.
# Given that this is used with the `check-format` target, which does not mo=
dify any
# source files, merely checking if they're formatted properly, it's fine to=
 rely on
# find to get all C source and header files.
CHECK_FORMAT_SOURCE_FILES :=3D $(shell find $(SUBDIRS) -type f \( -name '*.=
c' -o -name '*.h' \))

check-format:
	clang-format --dry-run -Werror $(CHECK_FORMAT_SOURCE_FILES)

However, after running `make format` and `make check-format`, I noticed
a whole load of failures caused by a load of other missing targets. I'm
thinking that it may just be better off using that same find command to
get all c sources and headers, and have a single, global format target.
Afterall, in pushed code after we've formatted it all, I don't see any
reason that some code should be left unformatted (especially as we have
things such as the clang-format off comments for specific sub-sections
of code), and while working locally if someone wishes to format only a
specific globbed set of files, something like this should work fine:
clang-format -i src/*.c

Thoughts? Suggestions?

>
>> diff --git a/secilc/Makefile b/secilc/Makefile
>> index ef7bc8cd..2518933f 100644
>> --- a/secilc/Makefile
>> +++ b/secilc/Makefile
>> @@ -87,4 +87,6 @@ clean:
>>
>>  relabel:
>>
>> +format:
>> +
>
> Should add a target for secilc/*.c

