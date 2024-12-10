Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965D1BAED6
	for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848984; cv=none; b=V96e7ftXT7B3lN1F8nHzavSulhJYr0EQ2FwxvMG4RgdM32KlTSxYvtB8KP4jw8zfAwcpUuboVjlsqNcMxJVVctlPyWt7zre+E3k88TKPBA3GNrBcedidiXC+beC9wGXc8sGFSLqPv7x8ecD2+gC/kBT359jNN7thT9esFJwFGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848984; c=relaxed/simple;
	bh=Pbiok3bC45s1DPaeHsKqRYhymNlYpeOMgo8VcMnVwYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGT3RCT7ms0iXe8MX2NGQrldWvfllaFYfiD3vorqdRjVKmpenEtOfAGij5lvEpGs2CB2/9+doaRRrpedfHwIaB3bBInt0CA4AGyaxguiSecvVYYqmeGyGoxeupLr13vYEeew422a1uxw9JUosjJTxsTBw29yrIeSaBJkhJ/zjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PZ361dPZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PZ361dPZ"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e399e904940so4520324276.2
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2024 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733848982; x=1734453782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5VkYNQorzqgCHWtTFIF6y7M7E9WU94ksIE/hu7bpA8=;
        b=PZ361dPZ9u6uvf2luEngdx/HXbjybpEbgrLxtAvBDRsVAZaiys5L8vN1rSN76znjUW
         l+HuYL2a1pG3t/5VOUxAaBpzck/JSJ4V3IMihHYEw5YnioW63Yfr0DZI6a+W6yIci5p1
         q/JID12YyptXsRAl+l71TA2IeBY2otn4Gyi0s1jmDjjDuLzi/v6T0zBKdLvQKjWxk1cg
         yoRbCrPW+vyOn+rXF6pwMFVW7HJnBCQNkRj+1ldaIFADdBfWPiKWoy9wHMpVuMkhj4Ug
         LlomFitG7Tlq7Lsh3g3TTrPFY9rq0hRzmpDD1/xQijo5MOP8hFd6pNRk7ZwKyugIgJm8
         JvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848982; x=1734453782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5VkYNQorzqgCHWtTFIF6y7M7E9WU94ksIE/hu7bpA8=;
        b=vKXEzU0PUqoTW/6o7mm9gi6zrVlpLZhTIFwmcRj1ytkiAH7aRq8o73txyWOHK+A/wO
         VpyPHiC3lRbgm4+wGiqZlzz0VDSQQyTeGYn/szEAfeChjiFwY/FZpBjQUoHhfTw3Zkw/
         ov3wucYR28GYkN59w0aS/RO5wHovdiZCetheOVzWqlzMv4InQgFrDaD34Jnc4T3QBG+t
         auee2N9CLUrDV5bmy0vzWmvLUi/IuqiwGTJYOGIsTv/GJihq2N3Jrg98uJhESSk6pIkt
         UNmfBoG0AIYyeqaSjrU/omhzku2MiRl3IznF2PGXYngFqbpjCpuuSsqq/RejHBklewGX
         LgzA==
X-Gm-Message-State: AOJu0YwFCGwxlY2MtzzYuXBtZ1aar7iS5i5kHfvtDNsnRhEoiJ54l+qq
	WgvQ3UfQayJXY8yYzvLNoG4KXLbrpxpsRKE9xvqc0gEhh3sR2IiLZpYyhKTIdnyIOJm5o+eb6LA
	zerrqC0gPSwvpHfUBptPsFUeIB40=
X-Gm-Gg: ASbGncu1vzP9RI4sJ7Owgv1EI+5s+CSwFhFYWIYATNP3p2wa3IYVerV9AUu9aw0aSvL
	0+SbQd7AQnD3tc9kJJ6jrC22H+MBRhcI5
X-Google-Smtp-Source: AGHT+IEobSby2JIJ/jRIhC45qavgyKMpBOKkmza1138+qMemWeTZvMhvLbSniZkuScKf+1nbqbyKgWHx7nvE+7qtpVw=
X-Received: by 2002:a05:6902:f89:b0:e39:8d52:e308 with SMTP id
 3f1490d57ef6-e3a0b12ac3cmr13437425276.26.1733848982144; Tue, 10 Dec 2024
 08:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com>
In-Reply-To: <CAH9xa6eFO6BNeGko90bsq8CuDba9eO+qdDoF+7zfyAUHEDpH9g@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 10 Dec 2024 17:42:51 +0100
Message-ID: <CAJ2a_DcWjVFkAysPtuswuQ_7BExcBHrrS_783CK7WoL_VugVCA@mail.gmail.com>
Subject: Re: Incompatible file_contexts precedence in 3.8-rc1
To: Takaya Saeki <takayas@chromium.org>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com, 
	jeffv@google.com, Junichi Uekawa <uekawa@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 08:57, Takaya Saeki <takayas@chromium.org> wrote:
>
> Hello Christian and SELinux developers,
>
> I observed 3.8-rc1 introduced an incompatible change that appears to be a
> regression regarding how file_contexts matching rules are applied when multiple
> rules match the same path.

Thanks for testing and reporting.

> Before 3.8-rc1, when multiple rules matched a path, the last matching rule in
> the file_contexts file was applied. However, in 3.8-rc1, the rule precedence
> has changed, and the chosen rule is no longer easily predictable. I think we
> should keep the older version's precedence rule to avoid breaking existing
> rules.
>
> This is a real-world example from Android:
>
> > /system(/.*)?              u:object_r:system_file:s0
> > /(vendor|system/vendor)(/.*)?  u:object_r:vendor_file:s0
>
> Before 3.8-rc1, the second rule was applied to /system/vendor because it was
> the last matching rule.  However, with 3.8-rc1, the first rule is applied
> instead. In 3.8-rc1, the rules appear to be sorted by decreasing regex string
> length, leading to this incompatible behavior.

I can reproduce the behavior.
The precedence logic was based on the common and (in my point of view)
standard SELinux file context order:
    Order regular expressions based on the length of their prefix stem
(non-regex characters).
See support/fc_sort.py in the Reference and Fedora Policy,
semanage_fc_compare() in libsemanage/semanage_store.c and
cil_post_filecon_compare() in libsepol/cil/src/cil_post.c.

> Furthermore, the new behavior, where the longest rule is supposedly
> prioritized, isn't consistently applied either.  Consider these rules below.
> Even though the second rule is longer, the first rule is applied to /foo/bar.
> This is because now the node for `foo` is processed first.
>
> > /foo/b.*   u:object_r:b_something_file:s0
> > /(foo|baz)/bar  u:object_r:bar_file:s0

This behavior is intended since the length of the prefix stem of the
first entry is 6 ("/foo/b") and the second one has s prefix stem
length of 1 ("/").

> I think we would want to preserve the original line numbers of rules and pick
> the largest one in each prefix node. After that, maybe we should match
> remaining rules of the root node to check if there are matching rules of even
> larger line numbers.
>
> This is the regression I mentioned in
> https://lore.kernel.org/selinux/CAH9xa6ct0Zf+vg6H6aN9aYzsAPjq8dYM7aF5Sw2eD31cFQ9BZA@mail.gmail.com/
>
> Thanks,
> Takaya
