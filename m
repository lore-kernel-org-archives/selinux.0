Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE2223DEA
	for <selinux@vger.kernel.org>; Thu,  2 Jul 2026 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954640; cv=none; b=sYFWbXxGNecWo/Zk24DkJ28FqFSISArrjt3Bt1N5TF+G6Xq9tX3KAe5NqwKo6h+cz/H/B12c4uxrJO50M/7OJ8wOxWRiH2WxtmNvAL6XwhY5k1aSdh4oFZj8/1lyMELM4UcLaEq//L+2VOi5yimD3PN1I5886Tk6hqRAsI/copA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954640; c=relaxed/simple;
	bh=mOGFYf2NVq2+X+4ukULrmQkJlrQ1JeQwuSMJOslFPvs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=QMvZqVcu+TzpbYuUAxcJAwkzdqi+GoLPpDI16wk/riIj6CoJS9kcl+gZxAC8tKjYCJa/DZiktN7bAIX9VJCgTWDxBWdAAmfKNsCBTwEhZdDqP72akLG/u5vsz6F0YN2W5FzCvnTh9ptsF9OTLlEZu6phm6htuSdZU1GVVK9K3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5J0FbJF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5J0FbJF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so5245255e9.3
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782954638; x=1783559438; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOGFYf2NVq2+X+4ukULrmQkJlrQ1JeQwuSMJOslFPvs=;
        b=S5J0FbJFdM/AMSygSEGVa4WennqDRQKg0YoC7xGpGOwJKByVbvkI3ClVl8edntzYk6
         U6HLqhyutcburVNaM2SFYlx9nul+yuiiiNjsldQFiF+J37KGrZ346g/GFqhSa8AuwIKq
         u8l1JDowIcte0Vj/Gz5KfIU8zaWZNIfmR/SHvohvXAWKBrOti+CGgXqcNv2V6ZZVaLZD
         DxReCMTMEux3mFmGcyictwIsHKnOsPBx2VnJXJdm3l/WVV0GJ5kjOQZBhso7J2hOCMq4
         a3kng/9bi0Zmy2LBhtJ2HgZV20H5TLwrpbpeWo4zwp7EU9QRpNgQi5ULEjOrhrp5NBTN
         kdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782954638; x=1783559438;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOGFYf2NVq2+X+4ukULrmQkJlrQ1JeQwuSMJOslFPvs=;
        b=qoIqOK16Vso0MVBAqO1/NeM+zCfq2bH7/eWPDQmVIDu5xxWe/rtz5SP5SPtI9IJGSD
         rlv4POy1efoyDm5407MtsiM/SoqgQKrZGZDV0FBYmxpydLGHHIuk0XKQgCZQniP8yKaF
         HY/ho5QFJUMc4pJ7K5yMfqeEZCZZD/lsT7ceV7X95v6p/9xFEOgfTURhgL1lVU/+aqJD
         7hAB7LTPsuyX+CG2ojJTGuO6PoeGfmjKyHbuRDagTw63Vp1fpRWpuErsNDN04eQjCwLV
         kTBB1vaU+B+8n5pjYuM46G6BA4CX2x1E4DoPcakerbvUn9KBOHq1VeTT5iR+aCTN+voV
         J+DA==
X-Forwarded-Encrypted: i=1; AFNElJ9bWHy5F6AmiRhGoREIdyso6PpAZnTq813glT10XJ4/i6xo7A50FN0px/zSAr+7JsUPeThIqp5Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+uS2A6z8lnNidgrfJaPWbqFu39Rz8t2FqlbPfUyW0Pe+jJgOF
	axuc+UV+e+ufqzgje5KRuJk1aRZ/XZ41jv+FB3yOdmsuOco0Nwc4Dt0=
X-Gm-Gg: AfdE7cnJ64ANIwrjuBKKQy8x5JNhi/4I/l1f5RHuGvOiR+QH2Jytw9D0qYV8WzYTR4u
	0ZDqAjy5Kqk5FkZz2kkXs15ySKgqAQZ6ynIjJxjI+kGjfxfOSzW2HjhJwOPYLfD+Aiqh2oV2h5j
	fdQhjWH50GLQlB4CA24+OPpGAEI6PzsXt2lj382h9nfEJa1fhB24DzMBCnWOE+aYW1lSoEmCsC6
	D6nQx1D/kfEW+xX/fuKbr3WuZs5gcwoCPkmSLD8BHqOuJJVr3l5cfM5zQwY6mzdGAug6JKbEfyU
	H1B1SCM57baegizAC0s6Af2J1G015OWruhh0m/kQzdbyz62Nl9HCXQnJye0o+7ihf70ztsiHRho
	EGbwybraaJjMKoISdveuZ1nol2NVOUhnvTM390Wh8+AIbtYEt/aTjvVc/hVxUkQ==
X-Received: by 2002:a05:600c:34d4:b0:493:b8cf:cc8a with SMTP id 5b1f17b1804b1-493c2b3ccd2mr50214495e9.4.1782954637980;
        Wed, 01 Jul 2026 18:10:37 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef248b7sm62043285e9.2.2026.07.01.18.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 18:10:35 -0700 (PDT)
Message-ID: <6a45ba8b.940a5a52.377c47.efec@mx.google.com>
Date: Wed, 01 Jul 2026 18:10:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
In-Reply-To: <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>
References: <20260625235336.3641828-1-tristmd@gmail.com> <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>

T24gV2VkLCAwMSBKdWwgMjAyNiwgUGF1bCBNb29yZSB3cm90ZToKPiBIb3dldmVyLCB0aGVyZSBp
cyBhbm90aGVyIGlzc3VlIHJlbGF0aW5nIHRvIHRoZSBTQ1RQIHNvZnRpcnEgY29kZSBwYXRoczoK
PiB0aGUgZmFjdCB0aGF0IHdlIGNhbGwgaW50byBzb2NrX2hhc19wZXJtKCkgaW4gYm90aAo+IF9f
c2VsaW51eF9zb2NrZXRfYmluZCgpIGFuZCBzZWxpbnV4X3NvY2tldF9jb25uZWN0X2hlbHBlcigp
LiAgVGhlCj4gc29ja19oYXNfcGVybSgpIGZ1bmN0aW9uIHVzZXMgY3VycmVudF9zaWQoKSBhcyB0
aGUgc3ViamVjdCBpbiB0aGUKPiBhdmNfaGFzX3Blcm0oKSBjYWxsLCBhbmQgaW4gdGhlIHNvZnRp
cnEgY2FzZSB0aGF0IGlzIG5vdCB3aGF0IHdlIHdhbnQuCgpIYWQgYSBsb29rIGF0IHRoaXMuIFRo
ZSBBU0NPTkYgc29mdGlycSBwYXRoIGlzOgoKICBzY3RwX3JjdigpICBbTkVUX1JYIHNvZnRpcnFd
CiAgICAtPiBzY3RwX3Byb2Nlc3NfYXNjb25mKCkKICAgICAgLT4gc2N0cF9wcm9jZXNzX2FzY29u
Zl9wYXJhbSgpCiAgICAgICAgLT4gc2VjdXJpdHlfc2N0cF9iaW5kX2Nvbm5lY3Qoc2ssIFNDVFBf
UEFSQU1fQUREX0lQL1NFVF9QUklNQVJZKQogICAgICAgICAgLT4gc2VsaW51eF9zY3RwX2JpbmRf
Y29ubmVjdCgpCiAgICAgICAgICAgIC0+IHNvY2tfaGFzX3Blcm0oKQogICAgICAgICAgICAgIC0+
IGF2Y19oYXNfcGVybShjdXJyZW50X3NpZCgpLCBza3NlYy0+c2lkLCAuLi4pCgpJbiBzb2Z0aXJx
LCBjdXJyZW50IGlzIHdoYXRldmVyIHByb2Nlc3Mgd2FzIGludGVycnVwdGVkLCBzbyB0aGUgc3Vi
amVjdApTSUQgaXMgZWZmZWN0aXZlbHkgcmFuZG9tLiBNZWFud2hpbGUgdGhlIHBvcnQvbm9kZSBi
aW5kIGNoZWNrcyBmdXJ0aGVyCmRvd24gaW4gX19zZWxpbnV4X3NvY2tldF9iaW5kKCkgYW5kIHRo
ZSBwb3J0IGNvbm5lY3QgY2hlY2sgaW4Kc2VsaW51eF9zb2NrZXRfY29ubmVjdF9oZWxwZXIoKSBh
bHJlYWR5IHVzZSBza3NlYy0+c2lkIGFzIHRoZSBzdWJqZWN0LAp3aGljaCBpcyB0aGUgZXN0YWJs
aXNoZWQgcGF0dGVybiBmb3Igc29mdGlycSBjb250ZXh0CihzZWxpbnV4X3NvY2tldF9zb2NrX3Jj
dl9za2IsIHNlbGludXhfc2N0cF9hc3NvY19yZXF1ZXN0LCBldGMuKS4KClRoZSBhcHByb2FjaCBJ
IHdvdWxkIHN1Z2dlc3Q6IHRocmVhZCBhbiBleHBsaWNpdCBzdWJqZWN0IFNJRCBpbnRvIHRoZSBp
bm5lcgpoZWxwZXJzLiBzZWxpbnV4X3NjdHBfYmluZF9jb25uZWN0KCkgd291bGQgcGFzcyBza3Nl
Yy0+c2lkLCBhbmQgdGhlCnByb2Nlc3MtY29udGV4dCB3cmFwcGVycyAoc2VsaW51eF9zb2NrZXRf
YmluZCwgc2VsaW51eF9zb2NrZXRfY29ubmVjdCkKd291bGQgcGFzcyBjdXJyZW50X3NpZCgpLiBU
aGF0IGtlZXBzIHNvY2tfaGFzX3Blcm0oKSBzZW1hbnRpY3MKdW5jaGFuZ2VkIGZvciB0aGUgbm9y
bWFsIHBhdGggYW5kIG1ha2VzIHRoZSBTSUQgY2hvaWNlIHZpc2libGUgYXQgZWFjaApjYWxsIHNp
dGUuCgpJIGNhbiBzZW5kIGEgcGF0Y2ggZm9yIHRoaXMgaWYgdGhpcyBhcHByb2FjaCB3b3JrcyBm
b3IgeW91LgoKLS0KVHJpc3Rhbgo=
