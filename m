Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793625015;
	b=d5WD1BbDrRylvl7XstQGoEndlGgYQpfxMaYIgr2MFsw9FYNHpf51nwXiC1LZV9LWSDAU
	 3hWYtbbzbknvPvBNM+xL/SIfNZWmgUYQvkKoN6mUrO1JTunPJ2X4j/BLccvrz7NSRk2/M
	 dj1K2utUlkeiqogWvPlTwbQck1AvB5XEH/lLsmWCTLsZTHrAhA7mnrDXqVoq62BKlRDMK
	 QOmNeCO2h8dR7REGQPq23ZA5TQVA+G6WoX8uDQ4eqZm9Fxku1f5qLoQRCRTpmND0A6jyv
	 lEKTZZ5rhrgzD07tYsh3L+m27eQbbsxnAZP1+woigCiEx0Mdo6vuS4tRl+TUTdQJ3Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=j5HqCDBNUZL8Cs7sS9UodAnwZhB66gZy3GUsaWCMqR0=;
	b=l58fV/c7Tv14eoehdw3tuVGCtLQUFBrmNfaNNOZJm5ylrl5fI3imL58m3LhqQ9j6efrc
	 +Ch7J8GxfmwcvQ0CMCresSDbXcsI2LotFSxl/Behd3mkK4AiAbrYT09s5+rr0TA9poVS1
	 91WfSxJibR/hV5aSdcL3XL2AfL6SMl8utc766pCAu00NzbhvmRtQp6xJKGztb3zkFmLuO
	 3m2u9UQkZl2peejot1rHkD0rd/L2vmr7fzysSOAEP4Fv6eq1hD5XGBA8bHKRF3Ot/zhJx
	 Zpl/7jbZ6Wv6iwMFmNXVVNUcM4S3iR1jzoCv6YaHuSCJQQgBqQQSI+8KGU4N1kaEK9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6HE+Z7S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFE606A327
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03FFE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6HE+Z7S
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1781048c88.1
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793625014; cv=none;
        d=google.com; s=arc-20260327;
        b=bZHoUhXLIpUbsKny+fk1kwZFr8tcXfl6rx4gOvQ/MzrrudBJg/OEH6GC8BbsmzKMMO
         MJkvq8k5r3UIyoBu4Un5ijZqTIspflJjKXNIkk/4u/YAII5j7P7aIER+oeelk5oV2Myz
         kJe51YixNT/5M+7sW5/Bm3h7dCZY3/KWaDrLjeAxq39dB81I5T0nWLdkkBh4L1iXm3eB
         p9lB1aThyc7e5x/pMNU1ykNRRppm0ql9FjMeMnPd4MUHl1kpLeWfUuMRhxYzSaZJ9FYD
         ktN4+sUHfaIAD7XYFfuDXkD2kBI8cEViB0oWEM19uotUsxxK6Kl2HsFaX9McdwuWUIOW
         uDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5HqCDBNUZL8Cs7sS9UodAnwZhB66gZy3GUsaWCMqR0=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=U5luhgntfAd9oPuBCQvapLxrgC1ECgl2P6rA70s4FZSr1Ie8+eMpi2nZxVzLMPAahF
         F/45P6NkckdY1KMhvtmtiQUqnSF0vuYHQ8WI7wwHUGX5XTjSpqxbRVxOwwKvCYh+19k9
         oiDASeRyrHhXl7BNuWwhHaTVBkX42ex9qS5m0Nso1Dy9T3ckXJ/ox1xExyJ9mdD47eKo
         RcrtLy1izeSG6/+D+Zy4m2LI+BipUrFq8yUfxbwzzvawjmI5/I94V8R3ciz3xTxUrCsd
         WjaitbsphyWHhPD1xX989WwqC80YgKfujSnUo+yI20AVfRfkPX1Rtyg73pn6OLMngyv6
         AAMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793625014; x=1794229814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5HqCDBNUZL8Cs7sS9UodAnwZhB66gZy3GUsaWCMqR0=;
        b=V6HE+Z7SNTzpoRBVO8bGrfxfuTM4ELAzhuNcJvPQYf3hnCnXmWHgXO5cnfnnkP3Aku
         L7mot2qVphZsslv2uNBXfEv0kSXFYvpD6M6wSXGN9ZdC3bHUhDlFeHTxHA6lpD/dS+hb
         xvfGbIbrtdC5weLevvG9JupxgSi7EwK33A+WBlUNbkobdkG7YZJz+9frQMqNMs09QCV7
         U61tXJ6pY+YewAuIjj8I0VRmRbNpnmL6Pu4FKk9E5c1rpdQjDUc0OJ7jxZhrgSlBgPbK
         FNgAlNOcxEGjINYlCZhH9gufF4IuvnVSNvrg+D/G5BoFubq+g8FR1lxoBY6oQEp/c22N
         TvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793625014; x=1794229814;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5HqCDBNUZL8Cs7sS9UodAnwZhB66gZy3GUsaWCMqR0=;
        b=CdOwjyWMyMaqyIFr6zn53ZWUzDdpMccR/mZBC/QLbTtlpC+tcXNvhQjMwBvzeeoHw3
         QFjsZ4wcSPmJjJJSU9Vkrj1Ct0Wwj8G3YTbKxZY74Y/xmXce5WZiZ4aSWiMnR+Uj8JN8
         RyDv/6xS9IfQStEqWSrXqYxcsxoWjFvFa8UsK9Ut8IEeTTlKOBCEFUs0+CtQI1H64JJF
         jlASHwlvCSMksxO3YnsUydohI2420id0F5MpK1ZxAXI/nOr5Zbl9+dUsASWXq4jfxEdS
         O4QP5o8E3t2GpxLEYmB1SHKV6GRWlHNoRzqaoRO79we7PE4L/hs4o/fAZhaE919URKaS
         C7rg==
X-Gm-Message-State: AFq9FYKsRShzLUZs3w8FNai0U/yJb9vxwm3xY/WZQj7rHR26+4aIeTS2
	tlU3ZAu7fKmRtMfr9O1LIHuIrKVRQ9EAY6pM0lhfRMG8xDEmn5JN2Enjn2yb18vDtZYQH6pu/b7
	aICjVke+IOtJ1yJa5Re21c4A+ZC80Gi7sH4EP
X-Gm-Gg: AYBFou2xWVpSyw8F0r8b5q/JVMnk18V2dFTEWZhPvBVSK6qcwsseS0R1zBykTSB+qYT
	k064icYZ3VFNrjoEmLOH15r0cFoJ06Jffgdi6q5ABXAFvvDO41Lup1IM/MrJgpL8fxvv2TBGv+I
	CBnmSc0vEcRs79ctAIsNOXrfUhpO3vWA/ovvc7sVYpRD+9waeUnHCWMvU3DplfpQRh7DhWXO2uj
	XFjMplcoXpoy1xHYYwRCAqQtvX33dLCp5FEsoR7+jBUCKDN0rHwF+akdw54Igka0XFjOEbfM1fj
	hUiHASfym9fuX8KfPa3YQJgVlm+SJNQJlzcuwwBKUWNYKCrBRt4EoTleDlo/1w/zX4ftiQFKL+/
	/nuFyPzq3Lm/+yVhgsfyIg6rQVb2zmeKXNyP9STFy//sg+Ju0uxUHBQC33wnFH4rZDTw0kt1Bw3
	f/l2/J0I1dm2SJwFQ=
X-Received: by 2002:a05:7022:ed01:b0:143:808b:b178 with SMTP id
 a92af1059eb24-1a94b0a801fmr15992977c88.26.1793625013978; Mon, 02 Nov 2026
 05:10:13 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130549.252935-1-omosnacek@gmail.com>
In-Reply-To: <20261102130549.252935-1-omosnacek@gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Mon, 2 Nov 2026 14:10:01 +0100
X-Gm-Features: AclHuK-3fb1X0wyvTjvyNhzvfE-4HjXRyX0JG7QgSa61FTevVq6SQCuslGvGwr8
Message-ID: <CAAUqJDtY0rjABOJyAs9_ZHvY+v3P6a8PxLVCH-tVGaui_E+-Sg@mail.gmail.com>
Subject: Re: [RFC PATCH testsuite 1/2] DEBUG
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Nov 2026 at 14:05, Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com=
> wrote:
>
> ---
>  tests/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 4c8e82b..8108b40 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -202,6 +202,8 @@ ifeq ($(DISTRO),RHEL7)
>      SUBDIRS:=3D$(filter-out netlink_socket, $(SUBDIRS))
>  endif
>
> +SUBDIRS:=3Dunix_socket
> +
>  .PHONY: all test clean
>
>  all:
> --
> 2.54.0
>

Eh, I didn't intend to send this patch, sorry... resent a v2 without it.
