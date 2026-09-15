Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32095395AE2
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494667; cv=pass; b=J2zFDmQ5Ff8wcvkW7O1vUsrTk9NM0S4emF8FOdN4TPg5h5O5J65urHq0PiKPV95515kqwzqyY3GBlbHBGVkjoxW4y1UGS64N+5DTvdGRDObbGwsKz0s+4uaJofhHMGP3BJCLahPVuYtrOT5ohpAJhj0LM2BGi98dcV1K7ODx+uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494667; c=relaxed/simple;
	bh=9p84IvVNZBpVKZbDNVo0m+TkBGC1O+GyEod/XJ3sras=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFzLyF/F6kNdmiPGSWHjSdO8Jz1K9JZfgIq3XT71NEES6sVRwN+8idsTxXosvpEmlm5/PEzgcq3HLZvx16/f1Q02rppFfsxv6spju5bns0c9cv1iwZJtTdGv/0B61ZGxIjhzUgKZpixUY39kR630vLWiozLcB8/JyUgrszwfehM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQAUaHDi; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQAUaHDi"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccab774cso51221fac.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 10:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494665; cv=none;
        d=google.com; s=arc-20260327;
        b=luUWEkK4gvDvSjcgD2H7aNsIuhdJkxTViVpV7e44I41vCwXj043oyst2t5vl/Rknz7
         ZnJCViN7dubGmkwQuwXgsYHCIv7q5pQHFmViHOhYtEA/1p/TmZjYwtuh4sZBGigaT/ZV
         RnHCVKoiW3usJMSJbJaTXFtpICO0CWXEUhidpEqWaEEOSj/nSXwUl1GkwK2R4J1kdh/N
         Es/t4CF7W9wgE1E9LpNLzp5xZ3zNBclETwP+XlNPHsz0JE8QRQXNXDmri7hdjAdtbDtq
         uws2BVr4BOMuHkNnZc7q7JALLkEVU2I8ktXw3mKPNHNLwq4BqamIW7UBi+PsBVxorrwd
         MXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9p84IvVNZBpVKZbDNVo0m+TkBGC1O+GyEod/XJ3sras=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=Ff24jkvMMm0wYGrUojOPfKG4FJoalHw7GUUQzYss7R+cTa2/BCmAP/ziBNhatwequO
         9/30j0yCPbW4eaQp/6KRtUTK5MYpqELcv8EekK9jTapzWvQIgJr9fNQPK+K0GKOpoC6x
         f+kkVHsteKWjvnzNNgZWHb2I2i9fLGgMbdkWfSQuVjbtxxqWjeFuYmcs5TmhsQcs0bd5
         yADgrNY6PfT+MEv6+EDW8v/fulBBeURgowXPFsNkvcI7A4ZrLlR18OfjiXnB/UEW+5Os
         2P6RxCEwzrtA16yy9KNQKHgazpaH0P8LUM8GlyEvB22q8nvQyLFW2nzp0ZBJHTwz+YGa
         ZOKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494665; x=1790099465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9p84IvVNZBpVKZbDNVo0m+TkBGC1O+GyEod/XJ3sras=;
        b=rQAUaHDiTSGa5DUyfOBXc7Vmm0asQ1iaJuU6WcSHQSJMOacm4OWz4O4KiAZCudJ5sh
         niw8paKiG5WmNqh4c98rpTaD/bmWQZoWoaDCiBxW0ftumWJFSt/ZSVF/faV3xOcFWzLG
         cUMfNMJqFPX3HwGbqLrHX7W4X//aLd89ZvrNnBZCf2Ejo13Lg5B3BrXm+fIlJbEFGHum
         89He4bh0s8gFB2iGOab3A4+KXgKFgUz/EMCsr3+xl3Kgz5XZE3w4v2aYIwHL/djNR4Rg
         jjOTkudpgtKFusiu4nyn/m7ShY/UvIeRxZfrmzJwui62tOSnrCNshgQG/cfj5QMeLcvN
         mGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494665; x=1790099465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9p84IvVNZBpVKZbDNVo0m+TkBGC1O+GyEod/XJ3sras=;
        b=mjUuh4aS2EwKWc9DGJvCv2Br3x7Zl6w3PNDj4HXM34nz1b6SYZEA0pZ393r5ZY8oAI
         e8SM9HDHraskqWfb9jzJFlOoPSyVbizL/kVJ35pykPgP3qmyIg8FksOYvW3JauzijsXF
         H3qzGEqPLngcbsxzSSHcV3AUamez4yI1XHVf2BEMIRnAVRUh5BhbNtPrhRnwd5C9V6yr
         XVWWCMKWV7WP+buy11Ax9kIrww8ALdxjOpEpMUiNtufIqk91mZA7xJxqE+q103sjyJTA
         j6kqHKx/CJoqLoAvPwhUhqH1+GbI5zZuU6qg2EpWJJCcFCOqU8hDB2GHMAGHG7/L8QFF
         vyXg==
X-Gm-Message-State: AFuF++mjPg0IYYwTbARPudBNZJ88iea9RXPovCwKAVDB/7m3syDz4n0u
	Z7Z5BW3TiTCWK0gLDsKCzkjj7TpgvnxnwxYY3oZMoCddV4xp2L7rbPsoDgGo/YnM8yrpDfQqiJc
	GUlmnYv8gAJnPg129iS5hod1y3cd1exJ2WXiH
X-Gm-Gg: AYBFou0lNyUFO7zibZbjGAK8lWhc8dEr4r/FGG8EoWQdheEVXhf7jKqx6KtcYOzpIQu
	BXAyxmgTvK2TVr2Sm18uNdd7eqLoRhvafUVQNRmWgIc+o4wEcpdwzKYxoYdwLbz0/VGN+9uEgva
	Ose8fPsLWqJzJOGONvmedXa+TQYoJZCsd4V4OudqJjtZIWSrJrJwLyCuSJc+ADgj9fDf3Cv11jz
	1vPHVlmXkHDWjhsxnp3AiPAGkIe6n2ngNVfmPCxF93aR9gNTAOLuPYVAab2Z7MsFgF2p6iM9LnT
	F1RYd3o0q+c8rgcRIZ4NIJlO5yAy/FNL7D26eSwRwwNx38WFoWHqsIw=
X-Received: by 2002:a05:6871:620e:b0:47d:f10:686f with SMTP id
 586e51a60fabf-483d336218bmr2150402fac.23.1789494665041; Tue, 15 Sep 2026
 10:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150422.41797-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260915150422.41797-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 13:50:54 -0400
X-Gm-Features: AcwNN1VLqxSjVyeW8_D5kt2S_DO6JryYwqAIX42ytwBMngC7JK2nmWrb9KlpGCQ
Message-ID: <CAEjxPJ6i_OXATMRMZSMLWKGz+e7Wkrrk9womFb6OmWFP-KYR6A@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: fix incorrect regexp anchoring
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:08=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> As identified in #544, libselinux anchors the pathname regexes by
> prepending a ^ and appending a $, which will produce the wrong result
> for a regexp like /foo|/bar. #544 also notes that we should be using
> PCRE2_DOLLAR_ENDONLY/PCRE_DOLLAR_ENDONLY when compiling the regexp to
> avoid matching a pathname with a trailing newline.
>
> Wrap the input in \A(?:...\E)\z instead: the non-capturing group keeps
> a top-level | inside the anchors without shifting user backreference
> numbers, and \z (unlike $) never matches before a trailing newline.
> The \E before the closing ) is a no-op unless the input ends inside an
> open \Q, in which case it closes the quoting so the added ) and \z are
> not swallowed. PCRE2_DOLLAR_ENDONLY is set as well so that any $
> inside the input pattern is tightened the same way.
>
> Because the added (?: and ) can pair with an unmatched ) or ( in the
> input, an entry that used to fail pcre2_compile() with "unmatched
> closing parenthesis" would now compile as a different pattern. Compile
> the un-anchored input once first and report any error from that; this
> also gives error offsets that point into what the user wrote rather
> than into the wrapped string. On a validating open of a
> refpolicy-sized file_contexts (~5800 entries) the extra compile costs
> ~3-4ms.
>
> PCRE2_ANCHORED|PCRE2_ENDANCHORED at compile time would avoid the
> wrapping entirely, but a pattern compiled with PCRE2_ENDANCHORED
> returns PCRE2_ERROR_BADOPTION for PCRE2_PARTIAL_SOFT and passing
> PCRE2_ENDANCHORED at match time bypasses JIT, so neither is usable
> here given selabel_partial_match().
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/544
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 drops the custom regex parenthesis matching function and just
> performs a regex_prepare_data() on the original regex string before
> anchoring to provide full validation and accurate error reporting,
> and adds a \E before the closing ) to prevents a \Q in the input
> from swallowing the suffix.

The reporter suggested using
pcre2_set_compile_extra_options(PCRE2_EXTRA_MATCH_LINE) as used by GNU
grep -Px and pcre2grep -x instead so I will follow up with a v4 after
further research and experimentation.
