Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993144;
	b=DkMDO2S3Ik//gfuMlxB6K8L0KJo6PTL+3qvw+CGpKhX5tx8tGOtQFfSTHH6KkvTu6e9P
	 rUzCW9PFuihOvQsOb0PhTdRX/Ro/o3QL1uiO6SOAQIKIDkiP0AHUqf/KfuZzgjb6xo6I1
	 GCy9V9BZTY2DBj0mr2Py0FyYnwKNF8iJaf27PANFejTnGYU3XhRSFYjUV8Nepmt2jIrU2
	 C29Ns96zCr81VE3FSuU7uB1YLLNe/c76lJH7x5XPQ2Bw9ITmNe8/44vdGvqJcw4MVGUOA
	 D6vFysOk1JVZWeCp4HJsFa3kNVK76Ch4kEkmW5ciiSo5KhKro0lbe5MEd338jfg/EhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dDoQCBiYuREGUV1yZeAWNAXKg9O7424lhd23XrC61I0=;
	b=vizg0JMKPcvBO6HB24DNLyu22vYLGPqk90LIMYAyPas307mB8PJMbSohnw1+JNmVu8fL
	 +Q26hiMAFMHKjPbcgJJiFaulc15Sw3w8JD9d7UUbJvwVwPUGZ5r8M57VqUjPhFHW8x0TQ
	 HdBvdDWI9XNQlnra49ZO48q1gOItn/3yCcwkOs8/r29zCG92QLUCs4DWUtpJpUH3KOldP
	 MMrL88iObRrqUhJ0fulysCP5j60Ac5b6WRuzBAHnLad3msee2T/nW6L4FQta5Nw06VtPg
	 WKWr/m0pCe5BpRbuX33fnuKhT5FLoL3CBR1fzCWmN9+5hGvEqhc8bZ2Dwipq16phUkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APZc6EWl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D2606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350D2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APZc6EWl
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b30477a320so7276587b3.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993143; cv=none;
        d=google.com; s=arc-20260327;
        b=iSPRdRAw1sSue1eBwLkX+UtbHVa1kOHNy97+r3qzM2XSB+9nxARwT9GXFJD39bT8mr
         7mTxoyTi5pYxJDvM0Ay3ELW1ifH9GKoejAvjkhQVaZzC0/KtmsdMvXubVax9s+/fE1Zw
         06DcBhEpaJx2xRSKjkoemrtSedJoePQ5IW50YkyLeF99pnyfnNLMLtmM8UT6XmEyNTBp
         EWeo4NMB3inON3kgX2HMtfZ0+6V6+uwU0+7jnP/Z6oujkre8ud0ngRi5tMLdoqRy5dIY
         YzAAQi2qpMqfm9poToIHlKMFCE12ot+tQfxGwEHD8Cb0mx5jCXfGUuFLqnNWdBEyC44i
         FBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDoQCBiYuREGUV1yZeAWNAXKg9O7424lhd23XrC61I0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Gi+zsOcNyvMkIoOFPB/k0IscuABraZ3OuAGLNfu9Pb0n5VTVRK++9vc6Gpcls+kgy/
         +YBllRw1A9mWmd6HPt+AcxyxZN8wry+LIf4iVny3dHvhr0kkgM0hLzvdFN81qFrVEyCD
         /WSKLs9L1sO/zEDyBxYjTputYCCx44Tvc7c0XXPNcJIUcemYSmwJSkW/ETxywgyTniyx
         TpDCzUqKUf8WZSiv1JG5LnIq86k7nYfE2fXDmIBSedQJqI1ouswC9qd9M4yYmWkjoMBg
         LXtaiv00PgUq3Jclk/6AKJHB8z9GP4g34tOIT53sSrpIdlXgEH8rtGi/C0kLNPvV7k78
         QYpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993143; x=1794597943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDoQCBiYuREGUV1yZeAWNAXKg9O7424lhd23XrC61I0=;
        b=APZc6EWlSDYlcCyJQlBExKnA8fahTaLN3vhYtnRSEroYyMIHVHwjehHgXZeCeG1Nuv
         zDbCd0wngkte4E3Dd+AHAFc/JGwYg1fHMNPFtoCkCw9A6Jl9YC+6fJKVKn6wswN7jPVL
         8/2vO4Oa0ciuiANjbVB7LriyaUfVkczcBArf+lz06EqNTZqTiLB0Z0LJhN6WOFs0YMYs
         hrt8cFV0lQfSjETeeZ1kh6nNa930isAB5t1msn1XtUZSnYuibLKS08/wxn8At3mLQ+js
         qzYkQz2iPgJeLiO8hJCaTiC/OqrbxcCpCRaDkyZJ761JwSFetR0YvDMI7aKPpkWc4sTL
         XiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993143; x=1794597943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDoQCBiYuREGUV1yZeAWNAXKg9O7424lhd23XrC61I0=;
        b=xZS7v9jNKUOdwaeINFpTgAZSxJDCcSU1u+jap6LZ9w9+J0sHcqvfaYWslI1Z2N58wC
         gtk1by+9ThRVIOkLnfXwh918SWDxcHL7oLCMsTxHitSlLsSFOPBxWtDfkTADMSOXRClb
         IQ+k1OgBVlovGuEGFql1ZrbtDVFSC+iNS4MgpgEI1xaCmOGlarLimVn1m4ChAH/NRM9X
         WwF0rO6wU+nrPtE5x3dnKOkdaFfY02PMH3/1VqTsmsYuQAIq35gjPGPdo7g2MBdA/82d
         R7u2hyAl3NsNhehFJmBIZX4CY1piS4G+atrnO6Oya5OyH84//xORS7SS0XlB2mKBXqXT
         tgeA==
X-Gm-Message-State: APuU4Z/nMHy2XH1c6X5a+VMBD6VllyNe4HtanoJ8Z8USGX0Y84XZ4U0C
	9WWKRPHhtcFEd/BfpbJTTku51dZIfl7NilveOnhukuc5QF06jcLmxOyCPzO9XhWGDMoj3m/KjiU
	4dBr2NfqWeyB+e5a5dtaeMXE26vQBeOoOMMJS0Z0=
X-Gm-Gg: AYBFou0WZcLiKaVhLzojiBBb4ESRl5V8fGUnHf0GwHMSEKyb0vzwIrGAGRPuhIgYVpm
	Zeg71QQah8wCWLokpPGyAd8r9Aq33nHuLf7oftSnBO+7Bah5U/xv75xJm7QSIh2X3hnHzheuiiP
	9GoxMrfr2VljyhjIse132JZRy94S5nQP3Kwz92sbhF/cfxpQksHAd7TEbxN19/yUIYB+rg/r5Ro
	C5zfzomz3Zx7S57+5977OcaYUuv0j+ZL8T+Fb7hVqbEtLJgDYiQq0lfTD/lW7uXDEeh4Ij+SabJ
	4vfyvveIlka8PBdG81KxtV+e4Pt45n2Bd9HgPDbCwMkFxeVy7lGTeVKhaa7CNfc3Gof/jJYT+tA
	gWuIAsNfyqH0PoK/eSRASaNu1BBxRVeu53jsNtXkpA4tAJXDXoJC8n1WU1hVK9GqNN9WVsxsBn/
	PxCnff33QyeZNNFaVF0k/iBiYt/rroQAKJ3PqzeQv6sM9chHZf4CSBQPqv6A==
X-Received: by 2002:a53:c4c6:0:b0:677:c671:56f2 with SMTP id
 956f58d0204a3-67c143f16a5mr1236410d50.65.1793993143255; Fri, 06 Nov 2026
 11:25:43 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106121725.48778-1-cgoettsche@seltendoof.de> <20261106121725.48778-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261106121725.48778-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:25:32 -0500
X-Gm-Features: AclHuK-uJ8lzuixl_5Swcrqu2UQ6nro9EdJKy1OgZP62tMzitaXmsUacVlXJ0l8
Message-ID: <CAEjxPJ7S30b+6zKVw3pXSthuw4g+DNZ=9ca+VkYJndUG-VW6qA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] libselinux/audit2why: use public PyUnicode_AsUTF8
 and Py_ssize_t list size
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> _PyUnicode_AsString() is a deprecated private CPython alias for the publi=
c
> PyUnicode_AsUTF8(); switch to the latter.  Also store PyList_Size() in a
> Py_ssize_t (and index the list with one) instead of truncating to int.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
