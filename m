Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793997521;
	b=vW37fJMneWTnb4u7UbhChKSKcFe2M6iT6U0rukBfXugMdUo3grX2ntMoLjTo1JcDrr81
	 XaX20APdpYYcVzBJ+cw7RhRCrW+99aQcqld22Lh796R0m96fhkwaShaKLc7Kd56Iy6ot7
	 1ZwQtoHDb+LO4spsuhPan+i7hIbZQN1CsrP7N02/htixuWdIXaeWebDFqJo6AagSL9LuZ
	 yWwvNvTVoSk6RVtPN+WSQKQ3TElusTB08G3TYr2X7Iuy8mGQL1tj31F0cyysQjT46tmuC
	 dbcONgoKm6eBWMODk3sdgxVnQtYeWKGpf3IBED1z0NZWWWRRSuV3fyDGVbrxx45bXxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=hzU/MJNyWqJYaLo94+2rasKEAitaIbgXjvqZDKlw7R4=;
	b=WSZGpmfRhtPFeNLTtjFZONqEFVj/UcD4hm/cXV+3kT0a93DGzsFmt9u9HGeIwo8o0mIA
	 VAF3l+O2AMgU6b7J3s4mBRz2gGNY6PGXtw4D5IVWxo34Ti/1nASFx+ejSu1HchRwGe2jA
	 jpx5yeMUnuBRJguBwnS1mlE8WyJE5i+lgKJTtgmnCSufopWnJvLA8gf1bQgf0xFvIv6R8
	 abhVMgt3VkGogzbEj4MsezNayx9ctCn/LxM6ibhp/sdXbdSEfMhWnsjokVg1SYB5VWvNa
	 IO/2Lj+cp1+vQRYQVGUxYFZaeu6p8zFkLcMkmIuNFqp8KceSUlmPwkGjsUzhzvrVtsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URL32tPU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2983606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2983606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URL32tPU
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679a2297c55so1306114d50.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:38:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793997519; cv=none;
        d=google.com; s=arc-20260327;
        b=HVGpOZuiQXzRcBGvaZgWfdRg8Xjcc0DkfEM9n8ujo2DqzOcGNgBDLBauc4yrkusIWg
         hnH0ZhEuay2FSgpCI4u82U5GQc6sStjG3Afcd8UMDen5NzllRZsjdVef+OEYwNV+6dOy
         Y9fQcUfsLkyQ6251/P1SfJR/qVOYTeP1NZcU590pAoM5fIMaMDf92eG5P6nc+ilzvAzS
         ENh7l2i/RXcfgVLzF43/Q0eRIOun4kdpjt9L+zL0cmeimbHVhH4BJMHtsxv8NExyN8Wo
         U/s22sCpTkvMEGyrU5QCiQQz6Hpt7uKk6d0l6SBXkbTAhVVCAAZYRac+ZpiyHEvxupw1
         CjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hzU/MJNyWqJYaLo94+2rasKEAitaIbgXjvqZDKlw7R4=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=n8FKv935hOkLC8DR4fUJFCqxSA6DYR32DSXDyHoxNOYDQ2Mgp4/2A0OLx9FaSZDfBP
         SLigyKUHoq1rXDzvx+08rCf6FA489hD5VLhPQlBfLzWVCRZrsQfaBIPf8p3w1k6xQYhD
         AALlvllPZ1PH97Iv4GNyOldtlsZmL92Pc4BTAf2oS8h4Ap9AxXnCoM6CVvlgiJYZI/kO
         cZZA+TFH1S3p8zN677BnGYmZG9uGCViZDuvtlsD/VDGxgClD/OaKqleQb7slQbyNPqrt
         B/25L9sKt6D2I4BH5MPmYSLWd3tBjgysEoMu7ymFgoJuNDjhXdr6Ili3DC6oyFYXSZaf
         A9TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793997519; x=1794602319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hzU/MJNyWqJYaLo94+2rasKEAitaIbgXjvqZDKlw7R4=;
        b=URL32tPUTm02ch4kKO9/dJ5VAGX+KntU47y5QIviksoQc4FpGdk71Yu85nZWa+PD03
         JnPW8o1X7kc9gorxUMAiLIemkATNcgjXFtzbdzB53NzpZIh15PHYjWWaYRnqEVYD130w
         ooYwtmyGernyuSZWTqUZpIhEgVh1WYOhvpk/NBwTz59YSEEoJUNOKtnkGAghosqlSEOs
         3nW2o394yvpC5wVuK55Ula1m/3vGF7ynoh9ot+00wxZt4f644+8XJ2qhiHOXylQ3oTMp
         AalMwky3NQRK30Pyl379oL5C3dwbsuq+xadgzcP7z1AoVbajiAT6c6YeTigFgXIaqXiu
         NpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997519; x=1794602319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hzU/MJNyWqJYaLo94+2rasKEAitaIbgXjvqZDKlw7R4=;
        b=EZhmT5ysAEF/LpVlIUZNunKoVSdHWsYA0OrozHXiYIOi+WkGbwKSBroNE8iEo4+Qf6
         Gc+TLHpCq274RwT5HAnTniD+wh9SLhFeu+WbZHsPLPoQmq1NjJdeCHRoIkOC1pkp5+yf
         6bMBbf5w/nbxdvG8NMBfQ0w//zsRh3uwNZkXA+n4zbAp8WlwQZ3+ys2R7ChvtO7LqOQi
         Xru95CMVb96E2nLUUwobFkiwb9gnnqXyXeOELQZQqg0MvXTkI1ebzLhTeQ0Abjc7Rv3t
         pxe3BFw9QG3tvjSyOssqkCevSFWzmVkog3xfYPdB6dGkxVpjnsYXOTkWuUmxmkMornNF
         tEfg==
X-Gm-Message-State: APuU4Z9dSloNzm4RUp2L8Vlrje2ODi8Bguy7laeVfqlkHEe9a+RzL6bF
	lYmav33ZfGZvNSM28kLRbZIyyyxSi3g0+xzSywLeEaEBkuFnh+ooaNKh7vA+fayRDNi4IqO3QCY
	o55HOPwWSUPDMxDh8ZFzm9oYMqiGBrrM=
X-Gm-Gg: AYBFou1o01xz+iymF+8bwyXGKZ6+jtVoJngIMesyXQFUYSXpMsZxSOuIr84A61QNBwp
	7GTJJObOmLL+teiBkmeSm3zfX5YFjizhmg2c0PdHAlIqcj0z3bm6wryZnQ3KfrYehyTScRC2R16
	/4ypf0eHYtW8LYJOnOxqlB/UOBLVnlHXtCtdoRkD9BO0UnmnFLat1UvUlqVs0qAf5rwNdPwOPk1
	yb1MuTm9Z/9wNjdm/xeimgYsuQtjmpUYksYlAI8qhqKFTWmthgoJsv8CACtGQyfl+hdXwqGd8Fj
	FBixLi+xccJWo3aE3/JNr90NVamDbu8hrcM7/FJFxdJLnMB4OfSh3jhC7pjh0e75wBcBKvlalG4
	EBwXDrIndLK9D+wB/KIbd6MI7vynGi7rIMkTabZBhUuvFagCz8FBSvg1eJhP8hQ36EPJcEG6ZYp
	H/6IIKjr2K4eGtVtcD/RNnJodBq4GKWG0Qp8FtPJ9qIJMunoTAhpYR8/XXig==
X-Received: by 2002:a05:690e:803:10b0:67c:1336:e173 with SMTP id
 956f58d0204a3-67c145b4ceamr1493019d50.68.1793997519683; Fri, 06 Nov 2026
 12:38:39 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106142302.512540-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261106142302.512540-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:38:28 -0500
X-Gm-Features: AclHuK8tsmg9SZ9PM8Mo44iQF9ljMW9ssrcQNgX7HidwMnjLkgin9I3MELDKn2Y
Message-ID: <CAEjxPJ4C=e89ta+1FwErVnc9aFjSTULDG5r_-3b2wYk38USDrA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid quadratic removal of redundant
 conditional rules
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:23=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> optimize_cond_avtab() collects the redundant conditional rules in a list
> and then, for every entry of the conditional avtab, scans that list
> linearly to check whether the entry is to be deleted. The cost is the
> product of both sizes; on a modular Reference Policy build this single
> loop accounted for about 12% of the runtime of `semodule -B`.
>
> Sort the addresses of the nodes to delete once and look up each avtab
> entry with bsearch(3). Addresses are stored as uintptr_t, so no pointer
> to a freed node is read after its deletion. Should the allocation fail,
> fall back to the previous linear scan, so the function stays infallible
> and policydb_optimize() keeps its behavior.
>
> Also free the list entries left over after the scan, which were leaked
> before if a collected node was not found in the table.
>
> The resulting policy is unchanged.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
