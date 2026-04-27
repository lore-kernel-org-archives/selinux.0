Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75164191
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328178; cv=pass; b=Ygik5yS4JZB3ern8CItDL8vINNEwKDIP/08owKAF0huTd1KVm3txz3nSRPjcPCr3otUEzYqjvHJKW7SNmHuBXR9lQpRf3l/IHFPGRGCCpAFpGTzvc9ZJw6yMbProkRPvadqGwaLE1IbSY96JZbGWjX+ERwR+3A5OUGh+7envjQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328178; c=relaxed/simple;
	bh=ZRmwjBDfyHNOPRmfSSgXa3uqDpJ7TL3h7PIGws1daMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUMyhrLSFuJBoAVkQjZJIGbhvYI5ypbCu9WtPZsceNlZ4U+fbX/Fm7SzYBIozWAN6Tn6YGAlI1XOr9pqMzy8VsvFTiG07ecSb0/fk9CmQCDD8htCfq3qillI1XhgC7zbKpSwNeM6HDA2lG/U3rMLRZgXVJMmjJVAbzTbmrpbqh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CqlpKvkN; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CqlpKvkN"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-356337f058aso6738615a91.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 15:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777328177; cv=none;
        d=google.com; s=arc-20240605;
        b=PBj6lEiguZ/LcjznOz4YEtXpVKDGuIF7Ks7InVFycyu8xfhmHeyIUBUpFz580yW+3e
         SpTmnMLWBA5cWvXbg4f7YqO1YrIJHiVxoWs9L1ZE2x5oecSkRrW5tcFwOyeYGbkncIPO
         qNX/kS9znkmavjjfc7V7CsgK10UdOSoR4AH7B4Ge1Lk+F6dwyArZhI3oi/Abcub24xAU
         EwfXdCU7+xOM1mg0fr4Kb07VQavrTNfpUWmsfJFLj29S7JosxCQ22Oxmpf1mwYFJe3xU
         OpkcjPglZNWuK+FN30SYK0am9VmmZNYUc1WTSmCQriC/yXDrNKQ7jRQACp+R3e4nm0KT
         GHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hYv2k09gfSypx/C+QZCPEJMHygfHLE53dSPFH/RWc0g=;
        fh=GLZbGmvNcl+bIcpCHrBONbB009gFrsN3tp6LG9VkZ4k=;
        b=F/jmyeXtwQpZlFKrtRiK7U8VnrMTibwAxqaRW3SohuyawaKlQ42f1Chu5FBsdjBgak
         vmcclamtUHQUgT4UTNDAe/8msezdLeo+TviYS6zBohDgou7Ydr4p9KZe2ABedcRZSFwl
         qNjzaQNxHtTRphAwAaKxIMUmhbiBm4fgbgjsxglSMGNA12Tcl8QrTClYQv6SV3lpU9/u
         fJzPt+x1jQJEK5v0tH3hGi82l5rLgZhc8QkqWjUFwmab+fL9sUNzClg8pUn7ND67uHlQ
         V+DlQ2Z8vbG3OvDpg2SC/K+M8p/Nm5o8PJFDsHRl2QTSNdkXsL0xT7M+CvfwfaCoGaUK
         EMiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777328177; x=1777932977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYv2k09gfSypx/C+QZCPEJMHygfHLE53dSPFH/RWc0g=;
        b=CqlpKvkN+rVZoGKRr2xfg84Bqa5+OQTdjYaI4g0X7lkllAh4XG4p/8OZk805xSB12O
         EVWLx3+yTbhJH4cWL4JKsuQCVhfX8iLgf7mb9KbF3dVrQteqD9xyHtdzuYxG7hTbRbnT
         aRlqD/Of8lHqRsqgTUhgTqU6parcZoFxqJacZo+wUzaeWOlwvJQvYQXmfjZZ+MUYjqI4
         3YYkyQeeB9urF4/SPKpzcVuemBoFBLR0pvFSZa6MLKbloNT5Vg7W53xOePiyQZA3Z113
         gvvxPhvXrWZK6et28NEA7OrfhI8ewR1F918tGwkcOt8lRjzdz7Ejgwul0A9A7Gao3U7N
         4peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777328177; x=1777932977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYv2k09gfSypx/C+QZCPEJMHygfHLE53dSPFH/RWc0g=;
        b=NDEk7GiPEbhTo57L43VEJ85MMoRrgTNVrGmzY6VN5v0YBHh+JoamgHiO2uwwdRsCcX
         1qBZ2757fMSVeJi4tjKxglCPZdFajbuyjvurTxUeeKLMpOA9p8LKse+2FsbAsIP+kZfa
         Z3cXFeLssHo5ANZuQJLOTjR52DENCovl6dOvdU2Z/d+UN07x1f9AwPJEJ1dZ72EeOl1c
         utJyikgKunNo4iFjPR617UjOFugGYSQyhLHFSRtzCaQytEH12WF/aEK28QehzhA3bDxb
         F+zUdq8wW1c/0rmq9Ti0kEvTAMWy/SyPNvhdeBQ2SGO1eeNTSc0RlkV/nXbc0a1IWiaW
         ZnyQ==
X-Gm-Message-State: AOJu0YylBI0y1M9ZMJnLJ8ZwhReZcGslU6M1Vajr933IorWRAiEmLysp
	nCEk7QME7RdyG4aqyRxnodSPuUD2CM6Jro3BIZKaKNND2mytGMkKByTdi8kibdcRnhiNUH5RFR6
	zzeKFtuy326klOSWRf7zU7R90YFaD9LUDI0GwRhefLbZSDlVPN4cW+w==
X-Gm-Gg: AeBDievbnXYDc/puuY3NxaQ3dm+M691TWsDz217k1ABT9bCnpKmoStyrfmrSB6DpAth
	BUF+/QKQlI0m92GNtIaF8RDo7Vw6Q80sOmuA5W7ZmtBwSfFT/6Yi/xGcL9lS6nENjdMWRafE12R
	xzxj+O9LMVcXwSMeaZR93cNERs6t57Sko99vUvTzm/XC+iGSQuBiEbRjweaP+1GcmMix3XO6Mdo
	ug+X9b6IcIb54hJi2HxOUL/JpGD5d/3mw4bcv70JzyJSeRAu4336OtaI/ES6YKTVeoXMuv/DpSk
	TFozzi+Emif5RPd6lg==
X-Received: by 2002:a17:90a:dfce:b0:35f:bcc2:c351 with SMTP id
 98e67ed59e1d1-36491fa7a7cmr414768a91.6.1777328176923; Mon, 27 Apr 2026
 15:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202134822.67476-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260202134822.67476-1-cgoettsche@seltendoof.de>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 18:16:05 -0400
X-Gm-Features: AVHnY4IU8bvqBvbJUWJKr4nfPuIjIvSYU8nq-oRA_ZRo22a1KC4Ss4D__2rTY0Y
Message-ID: <CAHC9VhRr5K9Gtefzpa=7YWeXHX2WhYaTROt1+r787Ysfi9PrQg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: fix data race on AVC latest_notif
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, 
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 8:48=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The latest revocation notification of the AVC cache can be bumped
> concurrently. Ensure an atomic read using READ_ONCE() and please
> KCSAN by using data_race().
>
> Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da7f7cb0737bd91aa698c
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 8f77b9a732e1..fd1f9486fa98 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1204,5 +1204,5 @@ int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
>
>  u32 avc_policy_seqno(void)
>  {
> -       return selinux_avc.avc_cache.latest_notif;
> +       return data_race(READ_ONCE(selinux_avc.avc_cache.latest_notif));
>  }

My apologies, I'm not sure what happened, but it looks like my
comments on this patchset were never sent.  Regardless, as you likely
saw, patch 1/2 was merged and is now in Linus tree, thank you.
However, I did have a comment on this patch: could we also quiet KCSAN
with a RCU read lock?

  u32 avc_policy_seqno(void)
  {
    u32 seqno;

    rcu_read_lock();
    seqno =3D selinux_avc.avc_cache.latest_notif;
    rcu_read_unlock();

    return seqno;
  }

--=20
paul-moore.com
