Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022159;
	b=JZJj3pQYuGEp6H6nM4rvlxn7A1P0EyXRHy/O9JOM9qQib5Pk9aAoC0nafGOdpmrW3EyL
	 zJcQlExM+znY7wgagxW6B9i+2zNHH6au7xGSoFeVUKiEGo5eQL8Sbi3a638wto/i7yrGW
	 eWNfrh+3E1zIAOz4q4eed1E6DCoI8hkh+Qyfb2zURMtq0fr4prkBPsfo0GMfxciHEbqxX
	 Jhw04fNIHweRQsD+TX6+p94i/4KnK9XdU2sa3n5lWJlK5CpNK1JrqNSrQpN1va1NwVtW9
	 ZNL7kbNxpJRaLoI1JHfk+bREh2XSrENX8BdE1jdQzcprm4Le1iXdO0vabmKp6ydpzWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dm3tkachggV0SiOpjxtKcV30hXTkZLTTYqaP+2dIJ7c=;
	b=mF9HFrVhVkdPK0wYoZf/Y1cpCV72z+dV36g25Q/ZdcFzFs+7eDqagH6NGw6D/9CKSa0a
	 7WNvrvhPNl4Pk5K8TI6cGG2/R7DejK66Xh9v/tHwRqrMkk9ReZ2+qjS7zfZQlzU9pRYTc
	 nQ1kDPpU6885+iGy9d/lGpyP6CDM2NSjUELxHboJJzy5PM0zXgtn4XuXA2GZG40nCxC2v
	 xPwrN22uHDrwtf0DGPKq7ME5XOjz4ESw73hivNKfIKpWG5Vur4EBJHZaQYXqiYNArD+2/
	 k6XPyWx/cNBZgctSVsKILv36ZyCK9UGhckyQcK3azBnjfR0/iMt4cEXhoP9xnKCRK+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DMz+8WTK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6A606A31A
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DMz+8WTK
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677bc4704cbso2814888d50.0
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022157; cv=none;
        d=google.com; s=arc-20260327;
        b=Aj2DcFlUul5bwNPC5y2wG4HJH9s63uYWurhtiPEVbbK14NG7Xf9Duvm3zY7PxvPVel
         bh+AV293Q9F5qJSLCGPJk0Qfro2UkZN+auPV0GO72lTa7bScXG7Zj/axDU976Wt+AVA3
         fbGRhVLXTsomDPHWAiI0gvTPd7acgtI3v88s1Cbr24ABXYJH7WSMphaDL1RpF+soEP3w
         6kebrx6s5ZOqNQskRlNM2j69FxO1cWzffJHtGXKgFSNdg8KX04M0nnONAkhPEb0cjtyq
         68ANiaBopi6l+5fKZlz0Q1lgKsGtQutVxVtttpV75yUGbMqYmsVXfXBDzBmZ5hTySIoB
         cedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dm3tkachggV0SiOpjxtKcV30hXTkZLTTYqaP+2dIJ7c=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=aD67SmuvIZ+J7hPg6OHwoO2hMxULu4ryD8/+LGJhPZ6Ir+t0mUqo7WToQESrsu+Yyd
         lnE4MQn4groaUtuEixiPXaGaIJ49QthgEhU1O/6iC2W31tPXzjIvqMWEz6nLrvoPpbQo
         K0OeMXf1XVuvG6nJHLIKJikaHhZh2cDN9EI/mu1ifA/Ep6jY9gq82+NEWkW5WO+sP3pe
         d3THpebYWYi/Wo1HJtFo0sHBd+d1fKk394JMa/AW7rShDCw+ShJaF8ZArBCKF0677xNy
         MoPnfzYgdLz/eXWdcs2P/wX2w/0NEDgAsjIWcTsk/mYgqhVWvk8Nkni3zj28EZZwkUHc
         DjkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022157; x=1793626957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dm3tkachggV0SiOpjxtKcV30hXTkZLTTYqaP+2dIJ7c=;
        b=DMz+8WTK7pdxS7XhTdGlgUHhS6v7X0eWuSuxE9nsmODvObMquVEozMJh0Kf0T4yWiB
         P5QDxSCZl5us1AL8ePrTqtXmP21H43S68ltunNVbHpeCm2grJfv80arQkH4jYOZEGUfl
         E+NP6tQoHjpmN7OjGHexz+NavpMBRdSGx18LylPpkq9SePieq8Qwat8IEvEVfjYTCtS2
         92IrK2SayM0H1M8jEtyivqpFs4EmVR0ef7xC2lLy5HD8ELgBXfAutt9qEjBTv6Oj50iR
         hMsXKAqhXUkg0Od7fEmjJD7DDmwA4esPkhpi0SCekQihzN+Bq6Dj72K5wX2YYqS1sCJB
         nMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022157; x=1793626957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dm3tkachggV0SiOpjxtKcV30hXTkZLTTYqaP+2dIJ7c=;
        b=Y+lPGr/qZZYB/UrPJCePnYhwawOxUlpTgeTiIwQ7e6WxcAjgNzKRPcFQO2FeFamwy1
         cVE7VfiL0pWeNch2Nis2Q/QeW+VGFNstZ9+jqAyjzz1RbC8viGAzP4nkg6dQ/J4+6ES+
         QWKbJdFBDZUrVnXv+EO2tYxjv6Dvmg4l3TAc6fdLZekBk8ZcWuzLYMHRIAUOnOkh33p3
         BMkI7yON+VHNDjoE8opgtK1ApG2MLKh0hxwo0Le5RBrs5NdSBL0v+4lt4Ql5dju75GWh
         RjWsnjCTQX0Gugc+uxX1hgWLT8vpx4AXiGIl/cMuWqyWTJBcFf7qHC+S4NPsT0eAql88
         DnhQ==
X-Gm-Message-State: AFq9FYIteSiNsi6n5Wi3nBP2XEe51Faps1xXpbZ3Y1sHpEa0impDJ4Wg
	DCh02DDUZ6MoGWm7DUIDgFzdfS/v3Hnak26tBofjawoRQSQlNygJ8EGJmrqT1qL44A+z4LaERXT
	LqgvzO5nUKlpSJDlFQuf4KlRB0xqjshpUjWoF890=
X-Gm-Gg: AYBFou14R0ahyKjqzE8w56SzKopJQFBCNdW5kAc6u0E6m61HK3iyLXxNE5igA/CeI3M
	go9XeBLdIhqEcj9sR43w2B2+AlnhIXHECUsGkYeLw5qoD9Ti43U3Pj1bVdaRRZKCNIZUvIoo8YH
	oOu8WFbGc0/4WBoPFzmE/3cfhhBzs2AoNl20QPRfPG8c9StgIrLjL1e0B/x9KIfgwGax4VEp0Ep
	ZhbTpstsAmhpS88wh3eUZGFXuv2UW6IGJN6yV/lNFGg0GbCBDt7UkhTqGMPkP8cApDq81nQH0ih
	KcXLtgoZ4TkXNCOc/o4XE7+IhM97Lhy0i2yjNy+uaDk2rq6o0kpDjpb0LDbXNMOyEr866+tT1OF
	DSXf5fjI4m2BMfzQ2O6TM3JC3NTiegouND9WBghoB14eN7cM3uEF9yXTsHTJ41oqlnsl3PuLbji
	DTUeglSdanzxI4onUlG2xv5A==
X-Received: by 2002:a05:690e:806:20b0:672:a233:62cb with SMTP id
 956f58d0204a3-67a4549362amr2245117d50.37.1793022157446; Mon, 26 Oct 2026
 06:42:37 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023184046.61448-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023184046.61448-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:42:26 -0400
X-Gm-Features: AclHuK-dkRfdZ1wX026VOLfArDJYknfFBEbRv6nOsx68ORSkF4YF4HeS3zcpXuM
Message-ID: <CAEjxPJ4ChUHdKAtH8KywtAyBGim19sm4H0H-Som=D+jgPFodPw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: release the transaction lock when setup fails
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:41=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> After acquiring the transaction lock, direct_begintrans() can fail
> while creating the sandbox or final output directory. The public begin
> function sets is_in_transaction only on success, so disconnect does
> not release the lock after such a failure. Destroying the handle then
> loses the descriptor without closing it. Other writers can remain
> blocked until the process exits.
>
> Release the transaction lock on both post-acquisition setup failures.
> The existing release helper preserves errno and resets the descriptor.
> Leave the lock-acquisition failure path and successful transactions
> unchanged, so a failed contender cannot release another owner's lock.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
