Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993736;
	b=GvMYc9PiMSfAhMxYdOy/XwNB8n5aGsYRKtOIlioy6OEJQe1GCEJli+EUHIbPzZboylEf
	 99Ed1Q7C0AiqM8ikSBtUDtg2sIYZW0mz9nS78Kk8LU90IUKOYlQRDicyqkD6mulYW/77d
	 kH6lIUbHwIEx3ctkvd+3ZkbfkZZFTk73EIL0ThYy2DxFC9gzwv+yTRjRVNSu7p1c9pJUf
	 GhKqtfpp41JOBJWTkNNZC0/lc8x/3gL4Ddajo/qemoztaik6UA9r6bG26NIXF4V/vOHlZ
	 5Yn8c2lFNGRNj1LfIuAlzb+4gta+Zylmi258oCQ5Q14ETQaKJz2ZW8VGb3RKfSHJNOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mDBUDa0RL/mMj+jPTx7UvrOWGXDj3uWlKqfkKuAQqnw=;
	b=sV84CRxbi3rtQjJL7upt8Y82zX/+eXH9u7D038K4nXn/127Ioinr+SBbqaewKvsy1HDt
	 fU1RcYCCjQ7ttALU5Qx03ViJVRIU4CtzE5FcZTdMSszTJYUjVeAHCqoejcFDxIWjjj//l
	 YT3xhDenXQHFYX6gPhKHPzbg4NORLii78rhqQU2onEjBha8326icf4QeynmRcTHbFiv7N
	 Wh5YXackOxl4gQnDSZ5cRkwoIQAJ5h6gOr69KNe4vSXN3hNdWqZB0bQt74JL4xa1N3koc
	 FTaCfrKjU4kvr5et6dvwJSjQd9dYB0E1F25/8wopZRbc5fP4v5SKFGma0G6perzQLKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fnXqTwra;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BC606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C6BC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fnXqTwra
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6798eb0d190so806962d50.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993735; cv=none;
        d=google.com; s=arc-20260327;
        b=Oa5tJDti+xExvLrNypWD6x5UINlp9lNDBwu7uQJhk1xXxkYiON8RCal5DLihcxY4Qu
         ugUQteJ8uyRMp+dYCJPz80vOIWBxWruE83ZWdTt2y6xTZsvd4B/gPjcYvKPos0Sjio+2
         a67HHCf9+Jg8vi5Y/nHE8C6FkVjH9sSWWEz+Rtqq9ZkFu7CRR88WOnY37ncidtqX32Ws
         vpIi/2tM4TU6mf71adoYrEX6zhaM4nTlN5cqzqijdVAP1HnCFHBvJG+9kvq+1fHeY+26
         tlsZvnycpHf9bxDepuUwCf28FpsaySKwez2GM3mBjlFP835BRTfrqyfz96RFQmYcVXcy
         0WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDBUDa0RL/mMj+jPTx7UvrOWGXDj3uWlKqfkKuAQqnw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Fp4kCS1y2yYFgrNDKBYEsQ7hcEn7oO0ElyuoGsBiSjnix6uwCbwMzGM5c/cE39H69y
         qEJarh5qM+co3usulsVlwRadctowrFtZ/qxzTCXXFMoYv/EpDpf/gE8RSVXcdqbwHGrR
         z1WZCIlCnePeKDBleI9xxMQMRDZcQ8islmVIZyUUE36VPBhVNzodwjP/9+hs3ZNh4ze1
         LbAHPNIgqcfCjM2A9oY4PWJDlCxBgxDYORuFhrx81weUnhU2IiHRlPCfMWnGoR5FBq5/
         fagQf+nc5b69nkXckao+k0g7BCZ1FAkc30TS3AgP58djgll1Cz7yRhYUL9ZWOkO1mdir
         2hMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993735; x=1794598535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mDBUDa0RL/mMj+jPTx7UvrOWGXDj3uWlKqfkKuAQqnw=;
        b=fnXqTwraJQNXhL2s3HuW+yHDFB7Vzz/0xu+bXHCRKdlf1iljww82ruhOD0BnQx/T4x
         6EbwHKpqbOK670mIgJyDoKJ6CrkwEgssOALdPDeKywTPfIoyo6Kh2PaJlDDK46iB/RBk
         FxO/0Ia3KPHUjj5YS4IOS74CEH9gWpzdQ/30spmajkcx5X9nBEsW9GYuT20x1NU0BKVx
         XPsk1TnW/Umg3/t+YhrIQjUGhV4zwsdOrBzRCVfSlR+EqxMDu6pNxIOErhfSCxHTVOd3
         r23s7ZMOMtk7rD1C26NBkfW1pZ8YOgaDvFUeaA66NNYOxp4V52Gu9VW+THNUMznU9Doy
         fEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993735; x=1794598535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDBUDa0RL/mMj+jPTx7UvrOWGXDj3uWlKqfkKuAQqnw=;
        b=AsG/zPlto5IFMEQ3/yFzewdQVZzi+MGyRMf99/4NqEwYCHuV1LTH8VrNz9o20Y4RoK
         G6HeRvf/k7iTplMfCTIvsuMN68PcPuZLr68QGj2ZA1iAHbRknaP5LCXU1gmmFoZP58ha
         Pa2f0CLm7uoZUSugDSFc+jksxZBIZPpfseefJo1/zAYBzmbnP4p5HVYhR+iJPeIFghzV
         WUljDrmxjm3yy2wjTETiBuDstIJP/lNCa1icebdonZk0/VYpNTw4rykE1PM/ZhVOep19
         WDrqQdiLGWvaA/8j4TQGMezc3PxT4uOeZt/yXtMKqzFLsiGrJhnoR1goReJp4Lg0wxyB
         /3dA==
X-Gm-Message-State: APuU4Z9gKbw+19JFal5Nudli1Tkzad1BuxttIe3iIMqhQef7Zp9PKM97
	QXQxA5AS7Mrg3vzK8CJOdzbBosFOdO33MBvOP4MZ/yaOsnoR6qK7bo8pKvuaaouwfgac4/Ob9D5
	j8OAYtFlfe3ul05STPpM1ktXecR4Gz+0=
X-Gm-Gg: AYBFou1ju6HMVSwUnN9eYw5FhJZXxOjzNZrr0bMH0P/8xu4sUZZmsXsMJ1uEoVUMZAm
	AgowB+a+xCRvwb0kLBS+ELhr947mT98D1uL6ndu0kPIoGKvpPgIb6DYM5lw5AYSkuMSIOjaBc/1
	E97vG/z9LbfpbXL5Q3M7NCLe4fFVSbjz5YMqtinnQA8Ed60X/uZzMYt67DkOE8TJbuwKIIeSf2b
	eiUuOy9HfhMDFSd+jW1cYyCHyoVABpvcnFoFlVP6RaB53h8zXAnHw+t4Ac9Aa3j8dipu7N0Ghmm
	Oo2gVdux8fz/Tigt/nc4Egm/26TgSJ6AaYHyHhsankBuMLu6ZOqbOaG744p7Iy2ebvTVM6TVVvi
	O4upmUtfffAEseGybZ9jJk9idga9+YqhqyY+ZOXe5xxeR7Un+c8jH7vZsHdv5NLfWcneOg+Ki3t
	mbZq1xV2Rw1wpNiUevSGpuzis4wIJjPzlgjTkHF4C81oTasQc06P8bIP61/w==
X-Received: by 2002:a05:690e:118f:b0:67c:1fc:2a4a with SMTP id
 956f58d0204a3-67c145e8b3fmr2065688d50.79.1793993735233; Fri, 06 Nov 2026
 11:35:35 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:35:24 -0500
X-Gm-Features: AclHuK80MGpt3i7qDI1RVuBxPIxG3JOvWRZq28OEzJ77ldRvgjGyoSwylvR0dwc
Message-ID: <CAEjxPJ5Jja7XVsn=Mo-hTnsc8tSzu4ZGG5q0KXX3BWjx-vU6Bg@mail.gmail.com>
Subject: Re: [PATCH 02/16] libsepol: expand every class of a type rule after a duplicate
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> expand_terule_helper() walks the classes of a type_transition,
> type_member or type_change rule and returns success as soon as one class
> maps to an identical rule already present in the same scope. The
> remaining classes of the rule are never expanded and are lost without a
> diagnostic.
>
> For example, with dup_src_t carrying the attribute dup_src_a,
>
>     type_transition dup_src_t dup_tgt_t:dir dup_new_t;
>     type_transition dup_src_a dup_tgt_t:{ dir file } dup_new_t;
>
> expands only the dir transition; the file transition is dropped, so a
> file created by dup_src_t in dup_tgt_t is labeled dup_tgt_t instead of
> dup_new_t. Reversing the two statements keeps both. Refpolicy hits this
> with kubelet_t and kubectl_domain, losing
> type_transition kubelet_t tmp_t:file kubernetes_tmp_t.
>
> Skip only the duplicated class and continue with the next one, and add
> a regression test expanding the example above.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
