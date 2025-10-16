Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B918FDDB
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652521; cv=none; b=Qw/VgvCo4aPr2tn4wPnS1b49xLyGOKx9Vw5EdT9xwOPTJ9aIw7H2nljt9WMHY0NCopZ+lMK/PcKH4viKV7yIyhdl+7/ioD8YUVMPCDIW/kNtCVotPjM0IwdVpE7liW3L94iqXQNcrztdHQk50nykN2DL6esFQJBV4RlHbxXR77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652521; c=relaxed/simple;
	bh=dImewWyTRki9VVpC15iKFcWOUgpXXeLEslXif2eWbfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 In-Reply-To; b=LYsG2XwP4iNSPwJehsqJCKjyg/sGF8sAKvnTm7qkwwzc1lsIcDBT/+ak59PvWNsWftocc4aVSf4FDNVT8aKcKsaFPM44BRlpsSrfeeTcDPw5s5jWjgTPiZM9OAinBNnJsWbhXh4ZNN8VWuyEhm6C1SKgZ2s7Wv8K0Rh9EuWpAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/hOs+GL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/hOs+GL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4539dddd99so218212866b.1
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760652517; x=1761257317; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaG5jD1Ljiou+nsuG7rfBuJZBzDeB9iH9Dck9hwNKuw=;
        b=d/hOs+GL1b96IXe00oSEGoVFLUzRQLt5RYVoQdefBUHDxf/VWTAPiLMi7kUIhedwm8
         XnvrFQ0EM2g6MCKzqEEoip9ENzWXJAEqW90Uvnb3TZ80j4ZOId6sZ+V26W4BATq204sd
         D3NmpMZTQMmFUz+DlZ2+uggyCHAgNJV8dhHphYxNaUrRdjoWOjJZ0I+9cTVMMbkWndj8
         JsXnZ/N5dewkUlLPWtvw3r8QWttINyK4kSUqckIi0fVjMRj3YGAqpyRbyCTOoDYRf3vY
         Fmf9Nfar+tf11qipHbhmmB8IcnnSQ2y5z2TXyw4p/QneG58QqSz74Xh/VO7paSccjIvp
         SWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652517; x=1761257317;
        h=in-reply-to:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zaG5jD1Ljiou+nsuG7rfBuJZBzDeB9iH9Dck9hwNKuw=;
        b=PhJkmSrNJGLNRfTB4rYpvrpLBPPfdZxHNPj41dxAExW/GhfKz2kggZNJBAjIIDXD8m
         a5AZ3/EWD6S71Rb52oq58h+2gZyW24T+l4ewVOWI9ZVZfKRLvx3bCzhaaOrjrX56J5Kl
         BBV3r09uCGr3F/ADSwN3HfQUGvHK3d54pWABvga+OgbUzKO8zhuq0b6nvLc61P+Li/mc
         EmHg0tFmfjrPxnDzyOITbOBB2WVNZbvRm0lMS20JH3mP3i8N87sq2FvR083zFJcjLbea
         KCQyeITu2UmAO1Qx8j5/8OCmwLRa3GRpeEbpcRRc0Yii39qb4/XRh19EX+hWzR7yRYG8
         gMhg==
X-Forwarded-Encrypted: i=1; AJvYcCUDGkYYCFXyUvSeVcbuDxaudgGZGv+TfxWmk8fzX6dF39THoaiH8Zyjog0Y5PMnnX3SXeBhPxg1@vger.kernel.org
X-Gm-Message-State: AOJu0YxJS2oswanlQyUtkCFbJYnMSNJR8IZ9KJeBmAdnMC3U4Ys3Bg2Q
	5JorBWNxyRzPuHy1NpM+3/Muwl7gB8h+ckP0FjH/IduikJt+M+pLXIy0
X-Gm-Gg: ASbGncs0Bd9ieTTwZaFCzwit63cv08RsM4FjEtcOr5+62mczx2CmaCfjNlg+KwMu5gv
	hiiLGn8UusGRuuBt1AXNXsRCQUCZ8WYuLwxQWqb2BPJFFTAsaqCfdJ2ZG3s8pMxXiN9oRHfexr0
	16LTGi96hJqfie+pS/0fdinXzBo/wkiVRMP6jEvAT7uUt5EZmkJfHsTuuWQkk1XbAsojZD9nDUW
	2PQOnDZ3l4sK+YqBVGnXNwGNV9F5fCG2KeZR2SDaiCrsGbv+RWVxMhZRMIzGnWvnZbrol2vfc+T
	CrDpnCgwIMa2A6+xc0maeDeZ1Zcl2UKjJd1tR3mWCQ/6JuGYPpX3robIdXq8JpUnpzRpa/QZt3y
	GcyrCzrQYCA0wbSLQy8/WFnuJgZIu9lSyzlZ3spkBfTwtKDt56jluNkW8BoCQQTI/065m1t/YSI
	x6ZGFt
X-Google-Smtp-Source: AGHT+IGwyptS1MjUlW/h/14yiMYcVL+vX2Y2dcI8xm8eyo5FKH8rbb1bUvUrvqPP5ZqWMQ7FDpRB3w==
X-Received: by 2002:a17:906:dc90:b0:b3d:98fa:b3fe with SMTP id a640c23a62f3a-b6475510fe2mr170377966b.63.1760652517400;
        Thu, 16 Oct 2025 15:08:37 -0700 (PDT)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd7b202dsm644558866b.82.2025.10.16.15.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 15:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 23:08:36 +0100
Message-Id: <DDK388415WIV.35N1AYEULEW45@gmail.com>
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
Cc: <lautrbach@redhat.com>, <nvraxn@gmail.com>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] treewide: add .clang-format configuration file
X-Mailer: aerc 0.20.1
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


