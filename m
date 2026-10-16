Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC56487CD2
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178013; cv=pass; b=pa6UWWznTL774VN9hmkRkp1MC2z79V3l+qhMzcsJk6kQaPyw7Blx26O0mSSUsoMrGNvbwzX8VnaCFLA43taoSolKhbdHK7MFOvF7DktagMJBb/uYcR3TGsIyjbko+FuDqoM9RUzhJP0ku+s+DISeAOExGbf48K4lOG9eZ69dbOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178013; c=relaxed/simple;
	bh=6ktSvGIwbdz8Ai1JNZDpjSbfOwvuiBoXWuWA91ZMggI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZvLLbjqr+UImzp6YMe8fxvW/iQ9YMwox1J0KX0UOMJnAZ7gG9z3NVPVs7q+preZmp7p80zuj1wwdAdwxNED02mDFgoCyEpLbzpM3SVdQ84T+zsZuzLe8NSS9JzbEaB3K0Mt/Y9awOTjopCgJcEin/2f0jR+ku5GUdlllocvA2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9iVB3jW; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9iVB3jW"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6711f05fb14so300570d50.2
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 12:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792178010; cv=none;
        d=google.com; s=arc-20260327;
        b=BW/pIx4qvhRhAQHVpb0fi+KyUbDo0uWsGDi09/xCmHIzkwtVfw/TiVF/DfpkRXvv8d
         sbFeJYyFl7tYNhH5lBNyZnU9e+EV4QQJBt0fm4UIzRq7aCKR5pUFTsl5jJyleN05cirV
         Wi4sIA4apxaUHND9RyfTWm61vzlbhJOXPkR51dr7HkUruste70VndeVjGlnBkiFYkS7l
         JQnvjLNBiQ/aoLMjTKceEHmRnoJQpLYnmyFBjl9k+aBH7KtXOMX2TMWDktQgQW/KzRYl
         Vu/QZmed8hH4z6k33y4RZ8WHzP3hQ/pcrnxM0SSG4DIGRQZlIMXUm5oTPu24tohuh3Dq
         mOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hpcJ2shC51nTcuuSPEvKzG5kdGJKAufNaVaxdolIBn4=;
        fh=g69bfMTktTCXTxlZPNSulZ5mbEffnTZ5V4LJ4Ze5+98=;
        b=jbpRuOVNI/cyrchp/hb1PAxmW4id+a6YfZO0sur2HUMYwkwNfkOrjrQKjQVx3AW88s
         J3Xu7LCbOxeTmzu2vvP2xxqnOlp/bJfI9P24t16z8INWNHzrwYVSGRZRDwMFJiIZQujV
         RxqjxUaycRt+KGrkeRlMkFUl5GsbbmHHNnn9yWpjXHS7b48m9ntO3nQcO+envWUK5//8
         0HStJ6nFxQcHRXRGDiQvttTapl0I+j/B9INIKoBt9lOVlHi81r7zqIlncGynMyboXGOc
         CaLPW3tb31LQUP8pXBQHw/RPUaZXm4zcr5Yw32tRaPdp8o9FeWSfaS/oFtQis96vEz6Y
         08LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178010; x=1792782810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hpcJ2shC51nTcuuSPEvKzG5kdGJKAufNaVaxdolIBn4=;
        b=P9iVB3jWVOVr9c/KPZYnND7xJ/jlAIG9JuoncSK/Le9SJ9nSYy9vCOyuiEmqGck+iY
         98pATnxg4u6LNl/zswXejEahjVwKjPStWTI07pxTnnqUikVJ43MOTG54X4e8IouseJW8
         Aba0mVgwNpIbCRab+3AMLR1By1LBgRjPq+e7qjt8/Q+bEKPN54SZt6cM3agTY3LbtTCA
         fj+b0Rd17h8SlBaYo6qQYrk25sGLE8OXzUo6210QgKDtdMW1NehojXNiNprsIvZ0cZyD
         Svkf6Z+WnCUkcm31l8I9ANmIMR79KZy7GfgaOMsONDb2Nt9+EKULpf/llNnfu8a0ymLZ
         25Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178010; x=1792782810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpcJ2shC51nTcuuSPEvKzG5kdGJKAufNaVaxdolIBn4=;
        b=f48PyEPKHYdX5yAxrlwNJW0mR/2+zvNhXsYgWoColvHlfsLHSlb0uz35W01aO6Ihxa
         hiwvxOU0XEfJvWksk4umOHjLH/ktIoYHW2FSZglopcDV3rrcNXiK8uK2sDX1IoWC3XId
         5YZJxZx6CLO7v9WXQ7r+2d3F/mNkWiF7BAn/Nlsr0Ez7PJe9f+OYVFkP4ffERVsazYTA
         aB9Kz5ycHZzkNiqGcz3AcvRsPjg7Qy9ZbtJ9Qrh+LemgFNCpBg8ThIUyjdCwxsI4cUMV
         6BOoPJnCZBthivn4qXBnT0QWr/c+brcBNMainsmyzNNnslKMrDGBZ/cAzDbe2TE3K/O5
         zjYg==
X-Gm-Message-State: AFq9FYIB3Xo3uOG7+7WF771QXj14zL2BbwvqLcsDGi5w6dSxg1BcZm02
	wlWba1twVhF6IiR3w93HW3jm4DxDIC9ViG//Bxu+OwwMuxmw+LjEXR5RlefwQ0LU2wuq+nD5Y7w
	DL8kokzbMQqYmd9ZFF2Cdp3AxBek5zX8=
X-Gm-Gg: AYBFou3CWHYNJdxPQihntcd0LmyIaAZvjq+uE5FWsHSrtuKfqOTwbFM3YRN9vsjZBYa
	iW3aL0d6E4TMaI/wFSyuKEbIN68XBQNDF3oyn/iM7Cu2UohGoJhD3TH0amKvU4kmgVU8RkGjKMi
	7Z42nSeSOjO1xlUDIx/DS1pCwpTkn1c4WvyNT8ufD4C9H1r6ihCkHUYaktPBN9BdlyVWI+FiY84
	FjPNBSfc8eX1wQJJuHMesYVdCNbXS5qF4G5Ku33Q1Azmcqje6InXEDVI0HPfgLLqtwHHusNPZ6u
	JVRIktVMxt86VTnmSCVrhN/uFIadtIGnwYEZN9YGgalsqJ2wpLs5lMU=
X-Received: by 2002:a05:690e:4813:b0:679:c12b:ec24 with SMTP id
 956f58d0204a3-679ca7bfc2cmr89768d50.51.1792178010595; Fri, 16 Oct 2026
 12:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179216341681.27711.14564271122957760636@gmail.com>
In-Reply-To: <179216341681.27711.14564271122957760636@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 15:13:18 -0400
X-Gm-Features: AclHuK-esjaifBzyGlF46wGCtDfFZbbGSj-YSFW0n7q2GqwIWuz-GE2CtaIiGZY
Message-ID: <CAEjxPJ4A=3_Wx74deVjVNjt3NLK291BqR8v6X_DUXNJnVVkN0Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: test CALIPSO over the IPv6
 forwarding path
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:10=E2=80=AFAM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> The existing CALIPSO tests only run over loopback, so the code that
> rewrites the IPv6 header of forwarded packets (calipso_skbuff_delattr()
> and calipso_skbuff_setattr(), called from selinux_ip_forward()) is not
> covered.
>
> Add two subtests that build a client -- router -- server topology out
> of network namespaces and send traffic through the router:
>
> - the client labels its packets with CALIPSO and the router, mapped to
>   unlabeled, removes the option;
> - the client sends unlabeled packets and the router adds a CALIPSO
>   option.
>
> The first one catches the payload_len bug fixed by "calipso: update
> payload_len when removing the CALIPSO option": without the fix the
> server drops the forwarded packet as truncated (Ip6InTruncatedPkts).
>
> Commands inside the namespaces use nsenter(1) as "ip netns exec" and
> "ip -n" remount /sys, which is denied when running as sysadm_t.  The
> policy now allows unlabeled_t traffic on the generic interface and
> node, needed for the unlabeled packets the router forwards.
>
> Tested on Fedora 44 (aarch64), as unconfined_t and sysadm_t:
> - 6.19.10-300.fc44: the new removal subtest fails (udp, tcp, mptcp),
>   the new addition subtest passes;
> - 7.3-rc6 with the fix: all inet_socket and sctp tests pass.
>
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Agree that we may want this to be bracketed with a kvercmp guard to
avoid breaking testing older kernels but otherwise:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
