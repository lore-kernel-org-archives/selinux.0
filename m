Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793995465;
	b=DEpbQV1QYlzHcxRQWWNJZ9vEbQGPe0+6uV88EppNC6CbSgnff+YUxvlpTN5Q/OTHNXJ8
	 H/NId4i6WkWO+S9Xsxm5YC0qMpBFkAK8cxQ+HgGlu+UcuotDIWS6WVB+yLzpiDXPI0dCv
	 okQTUT45XJxFM1iw/eS5uclBCN64IAi/6IysA2sLyUPAJIEdpts7kAUNx4n148p43GLbU
	 HXEzeGtKB34I/isU3a7KkMGepuzLfFEncNitaygt/P5XPA1NMlP3YjFdUJURObUPl5pV5
	 buJQS1DSCWAM3GhVqLDo/H178yj/j33J1kkx1LUdLhuX8ddRhU2/rPXfns7JLr3EDuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SXfZWFf0rxI0voOIfsmAGUql6REXItzSVZAF5YmaiJI=;
	b=3ozPQOu8BgE0mGc8CMQ7erCt1CD+r+qmvT1H41rHrR4ZEKfWa95u2wb2oFlf7dmxSkBS
	 a/fot6T8q7etQ8Rr3ksuSQ+GZ1W7J68n7u+3FKtv/ITDAHO6xS5C7i1Uyq7dA3Vbm5OOE
	 f3N8LebGsk5oPHll1M0UtRdMI/3hnAqdOWDET5ZJ+Vy3xe2mh8cxTRHdPbDQzxLvDK3QB
	 ogpRnefvxVU1sLkzqWDXDX6g2uxryIPKB84SU7ErE6W3d9YE83CQD06aCmkU/QVRXsEor
	 P/B4wntTSgX/eo7M91v3SGhAvZmtQ7ScB7k4uW36i5XLPgQlr6xh3x9ULKfAxpTt9SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMpL6XMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67A606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D67A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMpL6XMf
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67be6030c9fso822707d50.3
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793995464; cv=none;
        d=google.com; s=arc-20260327;
        b=aUithLfwA+ooVyifL+zLe2DHeFPx9iT9cSLQCcTb6N9GrPkaVNlbQIlUX+KXy1hM07
         MH5GXXq+fYEu34Ow34V9Pxd+7kaAksfKmh6OTYu6w4KigbmKIZFZ2DwlahgpUatAOJd6
         YKuurQ24Vn0TMEMtCLR9wBcMVMSKl6vqWpC95yL8bR53ToW5MQ1tLSlVNV7o7U4rcZNz
         ohu5pU1O0APIJz7tl1rLZOR4GO1LJTCWfy4uaTwFZLcCzm9fRmcTnJui5JYuNfkbumQV
         +QiemVuOCdb/XlKagsfn1JMIPNgRUlnkxP/BbdYICsAl1U2sFylS+Ood19Oqlc3oMKe4
         d4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SXfZWFf0rxI0voOIfsmAGUql6REXItzSVZAF5YmaiJI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=OqqaFSwp+ohafM+g8mgdU+McnlvMe34RbEZzwv32XJTFzMQMvRUq0KRmtM4cIC9b9F
         0jZt9F5BEYzx09P1M+3sSweI8in1kFc9CQnFt6WT1H6KrORrjOR0OcnDjQSHa3XjBVAu
         1TLYybvKNx1L7E0O8y+7jCa3sJ/+D0NnvtQO0Rb7toqFbQFRJtWJxdB5wC/JLUP80yMt
         rSvqCYtBtEK4MAaagGXQHNOCcLpl5J+sNY8IyofAU+dpJqI0y5JVbGRg95mrFuX8SSti
         aam6CHFHnf5VpESMWbqTOgZ6exCCB4xA/0HLzFy3oYpjmaGvAp9eMhLmvMgcM6oGGfSz
         hRKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995464; x=1794600264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SXfZWFf0rxI0voOIfsmAGUql6REXItzSVZAF5YmaiJI=;
        b=wMpL6XMf5SDhgBlr5b6HNk27BidABiLU92bFv2isHAqCJpfZeS2MSv2e9ciVqOLIMQ
         wUYxBvdwIVH1gMyb6g9NMCGpTd2S8SWCHf6AydGG+kRerCUElyPGpeUvyNdNUFFi9mPz
         t55q2VPpmfXu24vrD9HyptJHs0Qp5ew+tasVJfb3VPyUqcaCL2CrlpY3SMk0VFzhw+r8
         jo/aDV4IiWq3BZt9yGwo2MNQmchlSTgd43G4fNp2+QndcdBwoer5jS6gNAHNCPqzT/Xs
         LTkv1Yrg9B+tLZh7+mxL1IBx3iXxmE13cH5lk34jWOPqWro4/wfDRg2Ni3Ykf8EtG3bn
         82JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995464; x=1794600264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXfZWFf0rxI0voOIfsmAGUql6REXItzSVZAF5YmaiJI=;
        b=Dvo5OqrbfzDrlA+LYkbAGCdZdj0y7ep5NiJZBR/1iiOK+jdbGzsfFC7GRn7N2RDYny
         QpKkCsvOMwASs8kLHULsmYDm3YFt2rw3aVzTur+gGx76uglH7nKsFC9624Zllfa+HFZO
         R/avJfrhKzXxQSjmDe6skThiKaWoVyerjtUjczbJ8O+vgpsHaouWoVZUdXNi8kVKJm/e
         YJ63Cdxax1E8t768rzlmgWpkvwZEU6KrxyuUu/Qwx/aPoOw3cvscgXWGmCmx6nwA2JaU
         WYY42QFFlMwqhZ8c70YawN0nr2H6aepsAFcd+H9ljSYktJyj3Qh4QKpP1CsnMQhcfZA9
         lGMw==
X-Gm-Message-State: APuU4Z+7V/JET9ycPZC/T86JA0FW3Ky46vhY7P6xg//C4xzmKZk8JA6G
	VEmTpK67zGdDh/3/eczjtGcvRov7/sSF4utFhvUZ2QgrigeJgfVwuTO0J6fjWArns3JhGuu4iFs
	cwMWZufBakI/vmR4aNBv00dcUZBv0w1FWrVueMTA=
X-Gm-Gg: AYBFou108n5tKKNKIVXMYK1QY5dyeCbQhcfQEzp3UUYd0OA7HOCvGmnunG64cTnweO5
	rNOAqjNHrVT5idMvMpHg6l50oegvsqpeR1dliPsnXNZLyj6ZBqjdZJlBadB9q7kxeoyJEIIPXtZ
	e5gNsCnFPvIw8vtN/MHptExzHZ9CH0LoVI4bnrmSVTGPLLG0ecGyakfeN0P/xMTyxUVgi7ibPEz
	bdKWngwdyzbnflOP+mYaF8Pz0dt+WZ1je9dkmObGtHlZS5fg+8WeGA9bJi2baJqC6EXIxbeJ7Mb
	iXKFHhfAw5zDkzALUtot6Ew5Aq1pyQUFjMEjLnv3PI68E4RJYwzd9gHGA1nHcJFuQAYcaDa0o92
	8Nd9vOl3nse65SVAgQqCFCwpSA61icmfXRedDurqgsKBukCzKOLEpvlU1qHRlGkoqx1lDeQXPQk
	z4iW0AV1nUp2LI6pzRPuyv8Aph461lTd270vg2evDUYcCCfKu8jsuoE0B4EA==
X-Received: by 2002:a53:e00a:0:b0:67c:1f7:ac6a with SMTP id
 956f58d0204a3-67c1468eebemr1520549d50.103.1793995464487; Fri, 06 Nov 2026
 12:04:24 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-13-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-13-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:04:13 -0500
X-Gm-Features: AclHuK8s_z1HmmuwpSMchKPbVgFRXQh34jrq3XH9VBPporcgOYZihk3ORY16Css
Message-ID: <CAEjxPJ4bHYQ3UZXWAfj_aEYHeC5N-xAKt4G18gstx_YLTk-meQ@mail.gmail.com>
Subject: Re: [PATCH 14/16] policycoreutils/hll/pp: open the output after
 reading the input
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> pp opens, and thereby truncates, the output file before it reads the
> input package. An input that fails to parse leaves an empty output
> file behind, replacing any previous content, and naming the input as
> the output destroys the module before it is read:
>
>     pp m.pp m.pp    # "module package header truncated", m.pp is empty
>
> Check the argument count first and open the output only once the
> package has been read.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
