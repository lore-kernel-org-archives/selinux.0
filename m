Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE651B0412
	for <selinux@vger.kernel.org>; Sat,  8 Mar 2025 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741476277; cv=none; b=t4bkcTjvclEa1ee3KcM40RHOGrMN8gRlGTLDKjxM5c8YnCR7RQzhkp6h2hQXGqwuDNPrAgVgu3oj/KQU01QtpXzxxkBmEuN4Pfz9Rm7EC1raTnTruRCiocO6c+P4JPXd+Yr5+5VjnaUdlwvTYKTtCeFnp7HJQ3mZa4iUIpu8JOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741476277; c=relaxed/simple;
	bh=RSwGMlcGMqOhexbVr1FoLk27dtV1eeXcdg1yu7cNKUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GaKCKH4r88cdUvhuvJdAZfGeKH6urG26pY27Q7JdQ8eggSxx4ZA503m8dh1FtUv2NmFykT5qMm8bA353z7Mqow2kjRWQ7rU3dH/xcn0hnXLusOj+FFSm7FrqZ2bA6K8WhCO26PII+1jaH4mTDq4AIEK6XT4VBaNCWM9g26xgrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/SLwZOK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/SLwZOK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf57138cfaso582682666b.1
        for <selinux@vger.kernel.org>; Sat, 08 Mar 2025 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741476274; x=1742081074; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSwGMlcGMqOhexbVr1FoLk27dtV1eeXcdg1yu7cNKUM=;
        b=X/SLwZOKaKztDuzULBwv1kFn2foIpF/qlKMnP08PeP4LFXwbpUQuz69rhU3r2yXQh7
         /30UXBaoO59H/V9orF23Z920E+Ebv6GEQGnduIBaI8U1kfIJS1au/0Amd4UX1pFYmWJ8
         R9z/7k3LsxnHjveIcWfOKEvW2Uf4Wzvyt2FL5M8yP8PJ9ncwgeXs/IhKJhX6o1i9tlbY
         nFIj4GPQ4Mcyp9Cxz+eE0rwHgQHjhNrvVm3lH+FBcsffzPvvvZ1gk55/hZFIqM6E9HxC
         oic0NbKZpj62FT6vNKm3b8po8W2iAdyI7quaqwyjZG0F1GhT5MF8eZrM2LnOQ3AUAW0C
         gm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741476274; x=1742081074;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSwGMlcGMqOhexbVr1FoLk27dtV1eeXcdg1yu7cNKUM=;
        b=NRWaGZk5PNOGGx8zf6Re30K0DO10JptTpyDXc0jixzg0lqS8qUgbur6oMqpkU7bVYx
         u4ftUvtlwRqs8zqLgZ9iIThsgcOxUF0XPr2gQqPHk1Xsv2PUCdWnVa2/5efS7OWXZsIo
         y6i1pGOLc+HRDIAhJo0YLwJmkMBwGZrJCc/svKEtZbRmQEpKUOJzsY34i46cxmLbuwNw
         T4Y7V0jO5Mm4coOGL7eH0GPScXG1s1W5+bnV3KmPHAQccZ+kKLWCDy4GRLTKFtVfgyDt
         UO67jPitMCdjaGU9jkpuA7B7v6VvWz8gs+AX5j6LER/xSimqWxX3qyePYuwDq0xSm6X3
         JmYA==
X-Forwarded-Encrypted: i=1; AJvYcCWLVFPXpmdiH7oRoyewT1+1tb1KGkFzRO+x+VJ7LbJOg0fMqEBe3zy6u5vFXRd7hgSyz0Ei9/xO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ciiiYJ7OYw1oZK4FTlaYirG/pE6ICaX5fO34sR/meoVfY/nL
	wjHfFiTx2kxp8nrxGhMG6UuaoRiVlIj96yCXQLjgUCxvmEf5kTYO
X-Gm-Gg: ASbGncsVBVEgeEg0/3GK8vL0S76iwL0gicAiyFD5IqMDcfJWwUnoWi9r4TybCmxA9dO
	EmJz2Rj06xGfAh6PRTLodbAfTnwu2cJLewaS9F+x4cyLJxx9iRhW+MCe4JW842IgUdzcReOLMSa
	fDg4Yp+0wiKmpPzaeMbqtQF374DpWm2UlMScztFn4eduFAXL9JXkyBpwht53X49AtuXXEvRGzfJ
	7UC5j2OGr5AANKDR08D9SbYOgWX5JrzZYRooVfQHJwe+CEg+pvvNol438Ywe9U4Fyqt+dzFB25J
	QcCsswKwjLfPKaZo6fRQqYr+1xcSYzbZG9pPWreerPPP/A==
X-Google-Smtp-Source: AGHT+IGEMhUBcu5bfyX0qq0wwJjzBVyWQNPhCcflKUzLhIAASOZhL1uqbYU0ObxtAf7aUzL5WLFKDg==
X-Received: by 2002:a17:906:f5a1:b0:ac1:e889:c2a with SMTP id a640c23a62f3a-ac252737c5amr1073456566b.11.1741476274004;
        Sat, 08 Mar 2025 15:24:34 -0800 (PST)
Received: from localhost ([81.79.13.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27f0c3814sm121787966b.135.2025.03.08.15.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Mar 2025 15:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Mar 2025 23:24:33 +0000
Message-Id: <D8B9TFHB7VSL.3MMG9DH2HLGDE@gmail.com>
Cc: <bill.c.roberts@gmail.com>
Subject: Re: [PATCH v2] libsemanage: create semanage_basename to ensure
 posix compliance
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: "Rahul Sandhu" <nvraxn@gmail.com>, <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <D7Y03RIRQTEH.1SUBF6LGYYEM6@gmail.com>
 <20250221093910.657484-1-nvraxn@gmail.com>
In-Reply-To: <20250221093910.657484-1-nvraxn@gmail.com>

Ping

Thanks,
Rahul
