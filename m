Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204409;
	b=WVJwo+leklJ/C269NhPqfOadAr/rSpV2qXoppj9OyR15As6384X5I2F5sHVKU7WfMLKw
	 VXSHQnuiZh8r1C1Wk2fnf3JtbB5IIYif0KLZpg/6bHcCbLRwWcFDQN9YP0nFwYW+j3qW2
	 1F/GJg6Q3S0RN5Xlctwm/wp/XkobXYDHt3uxeKNTKQoDV1p7HIneAeog4s8CosGLNZSe1
	 R5NvQtC8MUlZaHLM9cVUms4ZlWdUfIcsWw5YpLVYHlaFD1aespcyoBoHxrwxiSHOfCoR5
	 a23KH8+x01TfNbd+zqWGFindT+1K52amHuv2Ni9sHpY5RjsxcXudxQ7nq/3bxfMcqPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ix7+SixJwdmG4m95aVl2eQDkTR7pmMwrmGx/pcWoz+4=;
	b=gBxvtcy/qHfmIR0eN8rEoL93q1d4C4a3HEkcZ9wcaM32EzkyfOnws8vrfAQ7dCWRfK/Z
	 1dBr9O5EaveFTLywyTUYDNknEqTKGF4g5lw9O1Z8dfZ2pgilFrW/KvQRxA5LmEsg22+d3
	 ZatmmcYG7CvpD1ni1GRUv4/V13j2fAyeo6qbMF7hwe3Sy/4o4VPMBa5LXw3f6vnqsrmSn
	 i8d9II+EucIwDhBV9fiGdkJQLX4FVGqT8nwXjjNAilnZtY/PCcPO96Xjs7Kckqp3RcDM8
	 7sMTIGvfxY5ja6C/9Z6jenOPr4fHV8r1eOJxmQCy0xcPSBHYl/X0VjqrQoB5dbfzb+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKSxzjea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0601606A6CC
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 19:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0601606A6CC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FKSxzjea
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67da62357acso2036780d50.0
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 11:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204405; cv=none;
        d=google.com; s=arc-20260327;
        b=FP0DrinlfaC1A4eXrdaaz4LG46QFabZs9VjStm5o3Ikn6Vk228lWyOAFTeg+4c0GrU
         Wp6EVPNo/MosRMwHJ5d3IO4vu3S3O2Fq5G/PobYHrpqIfw1mMtzdOZ6Dmi6ee2CyrvVe
         PnM1b/X3HtPtaglvSHY976aAJ8FA74g7TV3a8XLQ+m7cpYrTXmF03K6BL+XCRn8CHrUM
         mGhf3id3KP+J4MhblK3nQDf8UD12cqMoX6BYbV5a7OelZCxt9X09D7LWjrPHa/XVtMQX
         +oyWbTl2D0q8HufQXguTgTqEWMaDIUIQ0i5b00iCYmKKRg54+5zET9hlc4zCU2Gvi2fb
         giWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ix7+SixJwdmG4m95aVl2eQDkTR7pmMwrmGx/pcWoz+4=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=g3QmbmJ+4wOMLboWcGYTl2jTMCtH+MlvtXKaQa9+V+O9NTSPE2afowmuG9Qapw8AOS
         vug4EpLriGjWMDXaw4ge8W3R/uXPg1zoGeUnc65E27phwpoWLyKPf+1O/nXbR/RJHmEw
         9QfI+rBqyFtA3sCLiARR+UvRLi+Hu5a63RPvi0boNCwnHXsAY3GaM03sl+MJK71zAZD+
         OE7DcR7Kj/UEAiqe8YD19APebngx2UnwGsYI9aiGh3ZmK30AYcEEvD0COmZa1kL0dJ5W
         Nbt0pEmdsrzMjNt2GaCltkl7epKti90jXVO4o2us1GrI5P4nxk/R8ke7r7NYS7DUHeT1
         XPiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795204405; x=1795809205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ix7+SixJwdmG4m95aVl2eQDkTR7pmMwrmGx/pcWoz+4=;
        b=FKSxzjeak5Ffvr2JdTqO8O4XvT4ViJ9tSe84kN8zTJqQXo6TOhD+vHCalP3RkctHeP
         MUa5MUIkp51UUXr7jnorjTRMPkKb8hI8zfjhPVjoCKltUV+a4RtUMo5o+TZ7E3wl9ons
         nH7kUbzbvWoESrp6XiFYIh1UD6xvYjA0fvjCflMkAiZRZBEETn0v3R0sYtMKSX217qnJ
         oXfvGc3EPUhTNRQ1j3sEvOXQ42z1ZnqexromeFE38sjsSvFzY7FmdlfRYeKy0DtbXsJ6
         p4qQMQzct0JClGgx6j1KuBpRUf8IHWRDlrlt6GFw5nmMyx5XE4jMWrgCA9YpictPuiuJ
         3nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204405; x=1795809205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ix7+SixJwdmG4m95aVl2eQDkTR7pmMwrmGx/pcWoz+4=;
        b=x0/roHGJb57GORSET5yP3E6ZZoIUiVKQPydMO7YwZzGkubLf1SAoj/ZQhCjIr8rOgS
         yT7KP4SyQp4u3ZMMTmMaTf+EQrbtkxuGHO5/daZnvUZAsFrLsGxUhJFRJdAlZjMpwCsW
         7O9TODWKULDJ5aclflV35vgo6XD4eTfJ+/El9Nsiljp6Xf3HHzhh0SfJYAwgzmHSKYkZ
         Z2V5AW0tAq33O77noSh9gyty3vTWSlv6YcGW4EdiDhmrLy2+/xge1bCFwikawAlyYdMU
         hei3Rm2+ywu2bVe+yEnLdwznJ8r+7rval6FO0UUvCLdgO6aE8tmdZswPOimWQnsLJp1j
         t7fA==
X-Gm-Message-State: APuU4Z+cfb0EkBlqfLgU73cpH8aiO3h5ncGWKQYNNV8VMU1r6yZhsznP
	kOoMxmaLR6Ke526Hkxi8LMM5517zTLOz2sdjOST3QdAkupFz7sdlox+/Q3zRMaLw3RakjwCAC4K
	Ra82zsS5kqQEbxAc4B6PvOlSLXXqNEUOop99N
X-Gm-Gg: AZFdTZca4/uB571Y5lRSlIPHoQLPjl01toOcnTHI7jvMNdCroeRd2K2aZhmNTyVmbo8
	92kTGJrIWjZUBH0Jt1CcfYMrtNPQ0uc33JWHUb27AGmLZCRl1aJN6TNUAHfifjo3mkFmxHC/L1v
	5hGz9agaGoKr78QnmFpDUVNw4Lpnft+TS0uGG81/XCOxoqKshP/pecQ9XYMCWyqFZdvvnC12Y30
	ccN98Bp98pqv26kyC++yZJUbBKiNmDwVeLxGMIWTJeSn8B18mfM8EifatsMSO3wx3pOtEMamDfZ
	xyKzAjNU/0X1gKOaiUgLM96uBxFMj0QJntxkT9EqWi2jZrmkpYuK0wZBWQsPGrdLaYlmQj1BaqM
	GOn3S6aZyLZ3ewhA8MkJre+uT7mfgYnOfGqHBs7NC3cUT1s9TMMRkm7QnQsCGRjwqqg5Qqxtrdk
	v6+fwXuXzuyifm656hl8YbFcEx4rbFbofgKr1zqLO0vwadthxeYDiEJpc4f480OprOnslVM7wlj
	RPv4m0=
X-Received: by 2002:a05:690e:4891:10b0:67d:be3c:9582 with SMTP id
 956f58d0204a3-67df449824cmr1516648d50.74.1795204404835; Fri, 20 Nov 2026
 11:53:24 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 20 Nov 2026 14:53:14 -0500
X-Gm-Features: AclHuK_06S2Ms3VkV4lKXM3z7ZA1zjvjpc8Olw9ueWub5ScC6PNsp0ECNkODIR4
Message-ID: <CAEjxPJ6kyeL_rafta7MmF6x4Zt-h1GWznWrhfm61JvHRa6Md2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] .github/workflows: update python and ruby versions
 for ubuntu-26.04
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:28=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The CI fails on ubuntu-latest because it has moved to 26.04 and the
> matrix referenced python and ruby versions that are no longer
> available in 26.04. Update to the latest version and drop old ones.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged and restores the run tests on
ubuntu-latest (now 26.04) while passing all tests.
If someone wants to restore some of the older python/ruby version
testing and/or add lld and/or mold linker testing, let me know.
