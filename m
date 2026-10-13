Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA23F58F5
	for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900260; cv=pass; b=aj6U+qFH4iekmYBErKsLKuAbR54qCZ5absYgwDK4yUu0Q9ivQJNRDy8IfcMxioDaFs4QkkmqnZsV8Cov/1ZgCfjmoCJwPR2jpRFjiSf1yCN2XzPO+Id8px1CtI02NoTvKwde78JQKLMmBLTbBFYYkIbVhL8Ikglf8B5dXKc/jis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900260; c=relaxed/simple;
	bh=1C9elWmJ6mk2W7lq2kn6pe4d1bvzLuWDZOrDSDnXKqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbXQaK9GtEyUK+NOp5yvD/t2u/A0JQskHD9U6luTwmAgXLd6vKheKfzJIdJFOedelM8CS5EBgHjq6IfOLx0kRbWDNv6WnISi4fYjlPyEZbp9P7Rp/EvEb2GEn7kOOE7QNlJxiIYuYyyeiOPlYs8dYnQwRP9Nm4fm9H78MIoRums=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDQtY5IP; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDQtY5IP"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67718201466so2191812d50.3
        for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 07:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900258; cv=none;
        d=google.com; s=arc-20260327;
        b=FE5zhOlYveKA2bG3VcoSyaDvp5yfLVVNExNL5+jGafW3qWKrhJxnkNzKA5SmxZxFp2
         UzjxWxxgsR+qpG+5epJCCeHBZxUnMnf+ub7Kbd920EDLjYRa8PQKF4quTpPmjt2SMJTX
         RbPac36BwQzrjB7qzYQfilsmySm4sHJnoOhinR3+xDPgM72MqSOhO8/D04qCMgzPb6NR
         gM7e9J3Hb7AvRgIpx42fxMhu0caGEW0E+9Yq6ZSVlMu+GLp5QpTY6CYFZ/XpwE4fjlap
         hrxO3KUtHpoBq+mDCTgnVWdcDtKDIH7wPsNQ9OEKCCTVYnRwteKuOUPbGa0ZBN0lx/l/
         7aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1C9elWmJ6mk2W7lq2kn6pe4d1bvzLuWDZOrDSDnXKqc=;
        fh=OwAMYJB7jfWJkONZCoaW1jFPjG00CJVq/UYDauTm7j4=;
        b=iJ9/YTlJKVK9K84ANo/fLoulNAotpcUeyQt5SeV41lQ9o/nWnXA+phDMcWBQWSVDSL
         h+ziUnacaJfeSLcesO509HHHcfLrYEEGHwvYDAV4GK28M/dFpWzU7RJRYKologzoc2U8
         n9Zo7XhRfM6YuJG4UAUL7bkxFMuhXU99QJecl/2Qh0o+tuUrwDPPDQ6hY77QnpES0Y7o
         Tui07E2PkYavAuCVoNflOZVWHuojwdq88mCDsurAESGFt2DQnU2Ojt+TzEFRAfB//Jpm
         rnHFkCU6IDCgUwYfulFnArJCQbGZpW41j6hf6+CE6/K1NuYcNNGOimofRwF2xD3UJ8rz
         rEow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900258; x=1792505058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1C9elWmJ6mk2W7lq2kn6pe4d1bvzLuWDZOrDSDnXKqc=;
        b=jDQtY5IPUjksofvToP1Kx2mMcT13a8OH7lCKPIg6Jnd4kt4IyEIKXNqY+6xlkaHYvX
         H4mFVjna2y5TRYd3Vet0hcgGeGnXRsuQoCHA57nAJJ5JvEO7ED4tgT3jb0cpiT6LrEIV
         jQqLY2m7ymwP1BRR02PxAD53EIs7UF9J+FohtNv8UljIc0LVhkk5/T3eQrCJYkf6CfT/
         Yk0EiYtxa4B1r++oViymSwolx8zSAru4ob9LNgcpmHB1hH/N0Zge1Ey1cCNEYKuyhahQ
         vhhS4PMmrCjT4HcuCpDwBUmxQiwFAWfBFFmEf3T7h8bGRq7VadwKKeiESmt6FlU5rLOC
         9r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900258; x=1792505058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1C9elWmJ6mk2W7lq2kn6pe4d1bvzLuWDZOrDSDnXKqc=;
        b=kAdY2EiyIBZbEZeRZa6KdyXU547eAqJFFq2tmuz+o5HZ8uzqFQ5xASN7zuJK/RxqWA
         /piI1Z0OYL8nZg26mpJbeg/m0AdNAOjtm1j6WnzxkuKot7/bq5bUpIZl53NnPWH50Su9
         kmB02qATSrEtjx6/sVxqjdrd1GwEaDMjJpILF7yXKSm1oUGsFEvnVPPXMtZUJmhMl8+M
         sFBIfNfy1eOEtpcY5bjss7SZpTD4ubwzL5dvjborD3ULJsRfS+0RYLZ1zKcikppaDSsj
         qNixjhBFqf68/xbZOCHSEoWejLLkbOPovbQZHfUWszBGJKHa78tNxs8oVQHaAfDDU9aj
         x3EA==
X-Gm-Message-State: AFq9FYLmgk3TZPWZMPriV2VzknWAyfwaeppL7dQrA51vtKup6UxAUckx
	8PoNseExJOspFQFiekV5NFjHi+m0dzGHGNWgntFUekSoC/ZszAdNhfY3QC+mOavSRFKMenN2PwN
	KFNKiR15N8i10npdOGSo7YwFrSJKtg54ERRAo
X-Gm-Gg: AYBFou1ib8nmv8MrzpNwkLwaQ7u0Tx57LmvLmK+NtkAoRImDMpMtQ4B3AYRxnWilUa6
	5b1KvqLb8iJna0EPmWkblTqB7I4D9A9yAF/8SEvcn7e+/kGSHJ7LQm4Hntc/opmbVDt9PET9rSA
	PhSyvnuPFsSjpf0Oek+qvktZgc4HF4ixAMnN98sroLqM5+CdF/ZIHbL27o86qK8+mfAZyf09KWj
	ZvHmMzSXDHE5hZkImjJQyd0UuyG7Y5vJ7YiRj+OZolW1dCZdk7oY82l+J26C6jgaSLpDphG+AZv
	nCh3cKjp16J94jeOz86ovc3uWHpjxnH7ofEK1IE8MGJwlDvfxjqp0AI=
X-Received: by 2002:a05:690e:1685:b0:676:85db:8e3b with SMTP id
 956f58d0204a3-67936a05f58mr5809626d50.57.1791900257867; Tue, 13 Oct 2026
 07:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009123638.182622-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261009123638.182622-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 13 Oct 2026 10:04:05 -0400
X-Gm-Features: AclHuK_OHEbnlohb749q5Tn9aZ_CyCzLZSpIuDd4QxiuEfi-MQx80Vaxmow0zc0
Message-ID: <CAEjxPJ6PyeUEAFk9FF3rUUwEXdXwRdM=2-WwQjkyDNNLCjSmaw@mail.gmail.com>
Subject: Re: [PATCH v2] sestatus: avoid self-referential symlink
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, Joe-Ju-Alpha <joe_ju@alphanetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 8:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Joe-Ju-Alpha <joe_ju@alphanetworks.com>
>
> Otherwise, install will break in customized openwrt 22.03 build or
> other non-GNU-coreutils environments.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/545
> Signed-off-by: Joe-Ju-Alpha <joe_ju@alphanetworks.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
