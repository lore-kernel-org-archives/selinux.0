Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86E3DE429
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699538; cv=pass; b=PxivmtjrEUgSWF9HcR42BSlQY6FRO27Ql4Qu3P5lEMzYD5T0Ht5FxRXQuE3dYNMzFb3UgKg/5Z8Jjjyzjp3k588FT8InmcoXpsS7i9CANLro3SODFyy5zZpIta9V+34+oYfXIBsHdxnJcSnv/2HBWDYL5PPjPZHh21tm5ErEYu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699538; c=relaxed/simple;
	bh=zGkv3wwhPJVqvoQ2WJx0z9Yp4AlzWLkDR8DxWrYwqvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W49PJaJ0Aj7GvXajMcc+mo4uXNNZz1gon/Ol2l8hjiO173wb4jqpJ3e/k2oPuPwnWZzGD31Pcy4sUz9tsrKyK6ESJboUT7qg+lT1y7lnAhPRmzKOb0Je5T4bhjDS8xNypFHfbtGOzhWGB7v/FJy9BOUXHeQMW+JSyrQaW0Yu1tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU+i3ctU; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU+i3ctU"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8aa75b338d6so21915927b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699536; cv=none;
        d=google.com; s=arc-20260327;
        b=jQ+XwFLlMu7/aUSZerOBwRHKuB6uZuqk+QsE4GJv3x5nybxOvWePhNCDuZTcX2jmk7
         TCfM0AVHyolAM31Vw/zv/o//eapX2REWz10saZSATwmOHTjOHVIBlf26/DeyhND+NoB7
         7oGEhKmQo0nnv7rc8KA7ZlmoGDk3KzkAL6X4RxBebvnoOkdR+iUtOXn/zxhyEGqo3OM+
         HXaEAz6tu4Kzdrm6pAbfqhnaDI/KttKm8r23IjTwf1IGuhuQGtKN+hdOvZUvVkl1+xGz
         zwTHQYeEv8+QhRmhEC8q8WCYJpOXTkHiOKSWH1K2EBkclpyCywyVyW7X07dOeKnODggQ
         qUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wr3aEq7wDQ1RFl/gVo7+LB9wcaGDu5Bvy7MpNEKiwPU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=NS7yuD+4QPrlDYh/yTqRsp2wWqfSMbNPWPqoclBxj04UKlkiHrKNUYKMoMokH3EOxU
         y0g87GnkuJ3KyBTMea1liFamGLxUpwcFmxq5i+RYLhvTXlhdhx/QDX+NAu8UdpIJqJUI
         iLtR6ykVBDY/ZRFySNMBfEhwEzOP2mapouZ16XY9uN5mYDdANoZqfEVLI0uzMuzUQuPE
         RLql3/Ca7nJJE0XKJc9SzuwMrA44oE6lZTMVeq9PAFOd92Ds2JTwXIlYMtO2PS023b1n
         bs0ee0Wmp5fBGW7kxpJRUvvQmanRSzIYk6IAWqDW67klN9c75OsOVtkBgAhHICNCZmN5
         MrTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699536; x=1791304336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wr3aEq7wDQ1RFl/gVo7+LB9wcaGDu5Bvy7MpNEKiwPU=;
        b=FU+i3ctUpOdageC2H5r1VJ+Z8OtqLlTcXakrU3a96+JPmBxSxUbYcBNHETQ9H/YdxP
         YkSUsHww3KhJ5zEb4Iwt0bXPDyCaz32vtY2f0ED5b+xtjwI63EV0SZvAngOE7vijYB1M
         5V4ABS6LtZx/6VJv+jIwijIpaPFzr1yuMf+yNxxm9O13ZysFoJn7bDH33HdrO0Pqb71n
         v1tdrAQ3HU7FBSWflhTYyYxqp3mzIV19L+iLd63u7pZjg4XQZCBTGPVOM1l81HhW+P0I
         aNVCvZtG4tpYWMvFMWywEtsF06vpzXigmga4h1H2QTXIFMJtec+gVVaniIc+Z8g1VZgQ
         KLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699536; x=1791304336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wr3aEq7wDQ1RFl/gVo7+LB9wcaGDu5Bvy7MpNEKiwPU=;
        b=2EWyOoykZJSLHGCPg/TVGLOGC/gryZw7hUX7MwEmIxi76t0mmyYlO8z3m5U/WK87iV
         Gh98wFh/8cjugfN0YQONn9waf5cbbqGo7SVOT/CtExB+gE5lkqx5mEbOH3I8MUqxazUB
         AR54qnJz34RxoOEy8CGGsiQvNRKswdLbbh8poA5aPdJi+VuLIesNOnQWfCv3ENJHtGXP
         o2It9D6BgOOXtDiZgQgKnUMuFQ2WDtDNHw/pkVnR4EnIGIK2ORB1metJu7TUgcQqcrl5
         ZqB1FEE4LgUelPHyI1hZMkYbK3iPu5EWX9MqOSnlkSPFSA16Q/gly9A3ieaysWulZNTC
         aQ3g==
X-Gm-Message-State: AFq9FYLafmwowXngE5VIGlHJZnuAJnFeX9YV0U/I6NmBvCjqk04mC/df
	7x4bLSRBGt5vsXahVqUkgyQHfLub4p28Im4qQuEC+5iFd4C52Akh8O1mQ1eomMXfX4Fo9Uh9Z0U
	50H8AVMO7bhIMemW3/SrYJ8oPp27zPrl/mkf3
X-Gm-Gg: AYBFou2AivUBcLqOfnhjbUKHmpZJxJgfPtzL8Yrdjk7r6sASOYSyXhfpDKPFoxDOZSx
	AF1S/Xq98bNKymf/7uca6THjfkm5jCPDwz1EFz2WM1ZHcqxnyChU7LVoIcrhhgReEIa/wBrLcVr
	2pKrC83/OL0tUiweG1bVYBpdT4b220PoQ/kFKYO8bbcLwuuWseWa4pJ/aFGfqhdYSScy1tfABpe
	EvNRoJxMlpew9y/q34IGeczODlddw6vcBCsPwdLu2XMcuhnQLIzmdb1IrTazgEH3Y8H5ODTNfZi
	WnmUkIuIHdjZ006uU2rHtObjdcNWGW0BFxkE7c1hLYjcJIldP4r5augmYpOOz9xMHg==
X-Received: by 2002:a05:690c:6605:b0:888:7a02:2800 with SMTP id
 00721157ae682-8a646d8fc6amr81379757b3.16.1790699536234; Tue, 29 Sep 2026
 09:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-20-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-20-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:32:05 -0400
X-Gm-Features: AclHuK-jmSVdl2xYfDjnta-stoYT5xZAkNKKtrOJEUYFJUaoxlOAUBHvpaRzXQ8
Message-ID: <CAEjxPJ7VyyK2EvjtE_vQSAMDLs5+V8aTPGrHW=w9rov9BjdErg@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] tests: drop headers from Makefile dependencies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:10=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Clang does not support header files included in the compile command:
>
>     clang -g -O2 -Werror -Wall -Wextra -Wno-error=3Dunused-parameter -D_G=
NU_SOURCE -DHAVE_BPF -DHAVE_FS_WATCH_PERM -DHAVE_BPF    bpf_test.c bpf_comm=
on.c bpf_common.h  -lselinux -lbpf -o bpf_test
>     clang: error: cannot specify -o when generating multiple output files
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
