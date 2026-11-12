Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794495386;
	b=k8GL7OA95Rfx62+qoEdB/wv0CASpnxhjiK3v6BmWpf0ZtnesvakigrMdJEpRA37U02Oz
	 46OtYUqx7uL5OfK7LFtnOh9lwKKB875KVD9zjxmCR5X1KQ4vEIu/+iAbu376ZHVazIaQn
	 FMsAb9Jh9E2tZjMpRzOGnLcDPp5W59ZDD/FnX6P+hPV7uw7zEpTzFLsiTKEZlo3rEYk4p
	 yQjhdi4Del1mHq5K14PYqER/+IkFPzdUN7RDu7m10Ytvgt6kwG3XhztvzuOUCWMt9HUX9
	 lODY4EfmLUZStUvIQM3cWvCHmmQbZF602yoWN4DwgpPmcDf6C4szy7mjP5P2YAYLWIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ixb33/LKnuSALkH/U5ZCJ/bUsIywNlYnb3waKwPYgNU=;
	b=HcPOgUTqJ5yefZlhlShZKrYj4iX3I7W8YY30qqjUyCVzUdusqEdRPGMmwkhcPbM5QBhY
	 trX8XKAhV090a33TxIdlTEnqqO0nLuWxyx4ePlmHJJQHwCRAbsu5FV+YaK6EP0rkvxGB8
	 rE9b8KHeCvuXujNrJbdw/TeYrWurtcUcGKUJXkFjQevyh3MPa48/cOl5dr3SA11gHODJ4
	 r34wiDkoymnbSK3uJj38ltGr9C7/h9egsUe4EKWY0ZJNpArD+E8rxwHGYqGirHu7TZDwD
	 grxaKdrZFt8yECDenPBe+xYsfsQaVHIqUFJDa6SUt/eW5lhXDErvoIb61WZG3Dc177A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqIwHcHq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FA606A327
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675FA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqIwHcHq
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679334baa1fso5944105d50.2
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 06:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794495385; cv=none;
        d=google.com; s=arc-20260327;
        b=kCP6wGeJDIpj70EC+//xIwWA44Lql88k4WapAZULQgSbdWw4+SDYFKDp/WKWqhDqdW
         cLvcnk+H8x6t3MmpvbaFL97KJzeeNWVflffZ61sYd8sKBvzNpy91RwnJBNNhooAHZ0W/
         fKr/IAsfiDigGB2vXWd+/CmXNNbPFpC681E5+O6ssBg6DbFcdnUz09fZXJl8fxRSllF9
         bWtYnuRWoZqgSmP75nZu2NOQVqoDI5zjESy+cUsFRuSmovnHY2a2GmqyuDOVpkS3uWYs
         pDK9BqhVnPMxCgIaNdUzT+zJCJZRUUeJSo2AVk6Of/HCUWPztxNlWlVW4Blb60aSKLqj
         sIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ixb33/LKnuSALkH/U5ZCJ/bUsIywNlYnb3waKwPYgNU=;
        fh=JHL+dlBtetZKWAunLGWKbt14h50PoOUW6V+T78x38Ms=;
        b=ZtaBIdyrV6cteVaoEU8aB0vuk7e9X8q2JSxJVERfCldxGn9NWVIxYsm0bK6Fp7y1cJ
         t/5U6VUIRb6BORwuJNn1QrZotpj3sT7F43f2wKOTNyF7l5LNVX9OnQdqL7VL2wRNVP9x
         9AR8qf1QaOoeSV37csmmVWm3fp4ZGcnjIWM3kY4gbeIItEkgVARzYqx2Yct+j3Jy1cgR
         bKidQexccT4iumj83/C8Ad1tyGeFRnPTNI0mB9JIZQwGTlsDu9GNddgU1tSYJfxS3P7A
         aCCCkMiz4q1/OA3WGT7ySqW3ABe1OFWj4uGS3o1mObGTRk2LI5n5mNHEc0c28hkiM3Bm
         K5OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794495385; x=1795100185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixb33/LKnuSALkH/U5ZCJ/bUsIywNlYnb3waKwPYgNU=;
        b=rqIwHcHqtwQvvmiI15WL6Tg1aDMFOLktRuKwlxzBLGMW53LMO2uOss2iR71ypNiLh/
         6HxKY7jJnKdpaZ95A6/nrHM/0qA0F3C8/FFj8rtcirzvbzpTb0RFz1ZOp6sdq/BSbp3g
         2/VG1IENj6tdli0JjVNQx5boxDayj02XthIVUBbRuYo/yyr8343HkXumsbvdsL5rwyyQ
         w2nscVqzMuvDguPTHjO2WlbfpwqtulB7fxp+m+4l0DEGly3zCKfLEj9GHmGypS7srBO9
         BGJ7Uw/nk83OjIJQYE3IgNtx51rdpWaBzXTTj7t8dNlJtJ2Nx9IoH4PUbxOs/FKZb91o
         OuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495385; x=1795100185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixb33/LKnuSALkH/U5ZCJ/bUsIywNlYnb3waKwPYgNU=;
        b=n3z5MvvkTQOnq7+5E+BSmuaW4YGYnOjOqEOAj72dW8wis0ThDySknx87bT82M4gLWt
         vKw6VZb90Iuj6N5OcFL9tjv1gN5YXf/3hxBC8RiR+L30qwEFkKYz9OkAOJnaB/dFv6gX
         Mx38jd5OFbJ+2cEVVTZWAs3lJOljvhx7d1LiFSgs/plMJLIy4xcvKLmbbAOS4r03MvLI
         NrOVxS56oNtDnHZR19lkI4+ligGqfN/mpNQP7uOtwkny5eWWAgSMQ/McZIw5R2n+m5R3
         TC5U2KssKd5Rvi8E3RFIYuwwMV1eLSwq473NozKqIr7wMZX3CZ9sWrnm/wzJSoOq3XBA
         8G4Q==
X-Gm-Message-State: APuU4Z8IP9F+4vyyvGbbUx3YKNZ8iPZR3au2PbHVvxel546v24DQmcT2
	fZhygHqu4DTuUC020QJI2QAQ4r+PDtM77mCC8u4PLehiLAHM2IRad7G4qYwJvNvO81b4FGYfOeT
	PMPXZJPB5SYtROf5b1AkwqY1Gw7HygxtohIx4
X-Gm-Gg: AYBFou3cPieuyjPHCrexzhq6JJdPa2UVs+cisWA68v7mdtWNkMdT0KsIF5N27GGKhOM
	UVSpmhWBDW83eONXBezvzLKG7/M2zpLZAhX5dmNcwUAkabVR704hlHaeE8FeI52DHAhnvCpk+Ml
	QKELoPvaCms/h2VdMeY81N6KCaj818bt1yqiwSAWX8nvLr0HdYcYKe53Mw4XHv15+IzIgS8l/UF
	u91/bGSK45D+AppqTzg+6gItqMtZjz3ImDvWzU5i0/XgFSEzqLREscO/ZdFQndEnfPHqX2UbpEd
	8CShBl73MssxaH1RBItvmOToaTI9EI8BkEL5JsujSWAVPbOSEUqJ/QBsVCt0wMTXuiYQSR2kjSX
	pfnKoKystWwsanUpLr4STPqsmrcNZuq739XMzL8RqJQp7fzbBEG79kK3wj+fyPQGdBKvH1Yp78L
	tkn6UgQnQnRCvkY+d8RQsZbk6rIz6I+DHdDUvfk/vNMu+J8gnzGaHfWWcKEw==
X-Received: by 2002:a05:690e:440d:b0:679:c17e:407f with SMTP id
 956f58d0204a3-67c67db7647mr2331180d50.10.1794495385364; Thu, 12 Nov 2026
 06:56:25 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110171715.3597-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261110171715.3597-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Nov 2026 09:56:14 -0500
X-Gm-Features: AclHuK8hYwOQgCavsP74M7BrdZ0iVQ-fwJsKteBFqjJ_ST3VfkrZ2dRJI7CTx8o
Message-ID: <CAEjxPJ6DPKihg7YL_mA09KOfnNaJU9tKOqv-5Tgn3JNLYYsG+w@mail.gmail.com>
Subject: Re: [PATCH] tests/bpf: reformat to match CI astyle defaults
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 12:17=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The testsuite CI is failing on check-syntax due to using a newer
> astyle. This appears to match what Fedora 45 shipped so applying
> it to resolve CI failures.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged and fixed the style-check although the runs are
still failing due to the restored NFSv4 tests.
