Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07542210E1
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908098; cv=none; b=uB7ftzx3Ggvkx5HcL4RivOoU6sPF4+3HZTCp50y8cPJOI2ui/VIyUNfYcT8ol1zZldfe0bBm5SDs2e82sOiL+hyDJdqJ21riN/Ew7sveXz1p4gbXXOf8BHMKXHMtezzfbvtcd4qNb6XtpRkZoV+FTFBWWxR/4FUbqy3GP2bF9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908098; c=relaxed/simple;
	bh=c+Ih3/591XmQDiBmSH0D8TX2Lf3ziMcYCL4pLG2tk6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeUBnVbNaaFaZFZjtGbkk3zH1b5ymzPQfI15/KwtvZu9nLDajPUfpQOVYFJfmh3sIkgmOZi/AMKoqyWtLvK+4I9n4EHvKMS8mFdMkyv/dMylJPuW/Gzfdx30saO3Ttc8SsJ4UOSaTeFI/rgEb5ktF3OB9EnPaL9skS+QSGJsmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b7SXZdWM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7SXZdWM"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3022484d4e4so29124281fa.1
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 01:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733908095; x=1734512895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JHcXWCR06VYeDXDtMZgh3ToCqwBe4lIUStcb5vijzJc=;
        b=b7SXZdWMnas/Wg65fiqxco+k9sQl++QRG8FnKRBFL2T0RbQbqJepKngjpJ2iBczAXb
         n6kvINLUPDn7V2K+7Z33Ip59dSbPiqpe7jdSB+HChfHnNkwWI9dSNBocJvEQddR7jjqG
         MM9uoPfFgX0KQuyCIIHfbCfQmmyhRjSkzJf+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908095; x=1734512895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHcXWCR06VYeDXDtMZgh3ToCqwBe4lIUStcb5vijzJc=;
        b=PcymgmrpWVFirr/s0gmXZwY/JNLZs+0TehRQimASh4PzrEWdY3djzc7IokzlTK+BSr
         y/8gdgjZ2IzeH3QRVUrChXqGZ36K84NWyXBhEIJkj6R6mSyjG98+NAUzp1Xc/UA0lHRa
         etR08adntwl4rkMvFnUlnLk2u7Y2uikMrhtiInCh48JgRk5hRmiUiKaWOguHVTGkxx7S
         kmgnUwuV9bIhQOINkY5Rt7UbURn4zRzOr/xMrS3nURnlWZvwdxtBbTVend2A0LLIRMHo
         ydmTfbASq0zyIqaEw4fgOC9b/3SGQ+LRhwrNR7T/Cr2OB0QdMt74fDlyQHnzvXccYfsJ
         DLmg==
X-Gm-Message-State: AOJu0YwBqLslAdAXlCo6ZdUIGEYoZ9/1qyCBZm+jZRNZPlAXTb0UatQ+
	jmhqVn/7JMqZfhPhsLAVLQb6lO0rvUvhKD4EjtX97Xngrm7E0uNncCC6LAGg8wfVo3SZwXfmqgV
	5gRjJAPvQzA6OpcLFvjZKui7vlpeibNQGDRY=
X-Gm-Gg: ASbGncudDpUQzX77pNdpX4ePqsJ+L5dHs58ltD5BYTJDQ/sW49abosjiL3FCQyOFS6Z
	dC9klcx3+su1yhNcDL89DowDeVtMCPSzsRvjdNoR7XLUk2f3D4CTn4uz0R6jDslrO
X-Google-Smtp-Source: AGHT+IFN+/sStWNzrqqh1bMxVmonV8i92azeEKwNBXL1eayVCHggAPhM+jMEOA8C/vkI1uMfilv19vLvPlxmD6uvn3o=
X-Received: by 2002:a2e:bcc6:0:b0:2ff:c95a:a067 with SMTP id
 38308e7fff4ca-30240d08829mr6317521fa.13.1733908094726; Wed, 11 Dec 2024
 01:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com>
 <CAJ2a_DcWjVFkAysPtuswuQ_7BExcBHrrS_783CK7WoL_VugVCA@mail.gmail.com>
In-Reply-To: <CAJ2a_DcWjVFkAysPtuswuQ_7BExcBHrrS_783CK7WoL_VugVCA@mail.gmail.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Wed, 11 Dec 2024 18:08:03 +0900
Message-ID: <CAH9xa6c=jKj-0pwCT9sx-t25ZkN_g6nUmi85KYd-wRSTt5SVEA@mail.gmail.com>
Subject: Re: Incompatible file_contexts precedence in 3.8-rc1
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com, 
	jeffv@google.com, Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"

> Thanks for testing and reporting.

Thank you for investigating this as well.

> > Before 3.8-rc1, when multiple rules matched a path, the last matching rule in
> > the file_contexts file was applied. However, in 3.8-rc1, the rule precedence
> > has changed, and the chosen rule is no longer easily predictable. I think we
> > should keep the older version's precedence rule to avoid breaking existing
> > rules.
> >
> > This is a real-world example from Android:
> >
> > > /system(/.*)?              u:object_r:system_file:s0
> > > /(vendor|system/vendor)(/.*)?  u:object_r:vendor_file:s0
> >
> > Before 3.8-rc1, the second rule was applied to /system/vendor because it was
> > the last matching rule.  However, with 3.8-rc1, the first rule is applied
> > instead. In 3.8-rc1, the rules appear to be sorted by decreasing regex string
> > length, leading to this incompatible behavior.
>
> I can reproduce the behavior.
> The precedence logic was based on the common and (in my point of view)
> standard SELinux file context order:
>     Order regular expressions based on the length of their prefix stem
> (non-regex characters).

I double-checked the behavior of 3.5, but the precedence rule was not based on
this; My previous explanation was a bit simplified. To be precise, it first
looked for literal rules that exactly matched the path, then applied the last
matching regular expression rule based on the order in the file.

> The precedence logic was based on the common and (in my point of view)
> standard SELinux file context order:
>     Order regular expressions based on the length of their prefix stem
> (non-regex characters).
> See support/fc_sort.py in the Reference and Fedora Policy,

If I understand correctly, this means the libselinux behavior was changed from
using line order (and exact matches) to this new stem-based behavior, aligning
with Fedora's policy order? This seems like a breaking change for non-Fedora
libselinux users.

For example, this change breaks the Android SELinux policy, which relied on the
previous line order and exact match behavior. Now, many files are not labeled
as expected.
