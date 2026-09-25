Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657B470EB4
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364034; cv=pass; b=vFSCjt4KpP1UZj5cUUOYp3Law7uEWHs8+fwTbO2I9dmtB+L82eq9zIDRqhmlZx4c6rRXOLfbbjjMSh+MSloVTWeVgGIXtaum36qRrIuE5xsN1HjNSDcSbdgJegK2nmi0GHdjfxOsJKLsRCZWuvPg/F6o1/1CaPycy4BignuSI2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364034; c=relaxed/simple;
	bh=nvc65nDnSp+VlCsYxsYR0vwvvo4RXcqAQhHB+lFDQZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfgemOxSNdg9S5B9uvhAPuXwBxzQlkigrDFjmc2puCjEeuxlo1LDVZWGLEADCrhQCuXbQeZy4guWqTBpAKLKghpVZ8r1YymN8OS+fQsFx/qHUpP2n/CnPL7pWrMlePpFE+fQo+iIQLVfX1hkve7aUKMKiFDxguRwNKoYFrUSJnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwLKLj0b; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwLKLj0b"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so13248637b3.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790364031; cv=none;
        d=google.com; s=arc-20260327;
        b=p+SF8VkeFg1uyCZtGCqrd0I67cjyE3FLokvfhKAD1EB+SZl0c2927qMxPTJ20a+joG
         wOtPUD4TD+tq9HgFYW3N/XhtQGKPNvKys8PF63lSbpWHl5MFas6p5SrWqtpjDkM4MVCA
         S68Vrr1bB+txPDtc1HcvOvKqLuMB2FCsHTV0YCIFop8HADXmKJs70yNu/vd13phsndtM
         uQtoR022yfrD3KIdus31MZ2vqyKzWQReUpAS5xdzz5iz8mWkBxxnersVnkd/CdaqyxgX
         5Ee7tAr+Ycbhrcbw1awWzXyG3t8rRFwZXcaWz+AG0V2PbcdgNKDajSX56Lph9O5idPxI
         a0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nJlc3zYzvDKAJkgFLtjnOSUm38UJVvjALwKEMv/aqKI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Q1Q6HncFxt3AGgRXXRq3imf/+zAF9y4aZ0KQv7Hd3p+66q5toX1XDAqKL4itgJ8smO
         ULMXhxFlz5HZJLaDKhuC22TjVUpSbzBxbUFCpqY/yiizJHSOsPK3S+q6z8X1mET/TXW/
         Zk3q+apObeOqeEcpvbW9KpPmFJDmCrSZHBukNKhIljX1wxxOGvdKbZgGF4FMoUxhvNgq
         YGL4Vwy7wbXJBtNVHNiWqOIYWvSWVNDjPdObmm6zqQgKws/qMsO1x+VArZN1ZpGePLj7
         MMU27P90jNFeQBeULI3STV0oFyvQ+5gjpQcYg0o4BzSPkQbQav5IdnOad2+Iu70CX1t1
         FJIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364031; x=1790968831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nJlc3zYzvDKAJkgFLtjnOSUm38UJVvjALwKEMv/aqKI=;
        b=AwLKLj0bWsxH2jbvhDSbbvcZn2BA/5R13+3GWsbtJB6x6aiIPKoJKQCKyglzOAQ1nR
         KQez4Sb3g054Wz9CGo2XZJ4M3flw+QziaIYnuzjSGmpPmphh+gXshKJve6wawBq4VWc7
         JdhnhAVs8/6GWKTk/JMVEK6DbrMlZAoPp0n23y1758FvtCnQQGLhJgGEiiiB6L6eSCZw
         Nsxtlamez7c5lkU8qkydymdFyw9DWrgctK0J79qHSi0hoUPKe2sIeV/CSJbWXVu/gG+2
         3duEiStrJCPfIxnrarMkPYT60a5bToIkiquCNRydYG4sB4F/SMWGb6nz1+X1zubMNHYe
         qVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364031; x=1790968831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJlc3zYzvDKAJkgFLtjnOSUm38UJVvjALwKEMv/aqKI=;
        b=RBNAfvSH6SqgBBNXB75Z+lFqMbzAjSoRXqLHPNrYQPmIsjSchc3OrUCBBbFh84SX4J
         jM73rNuygSKdp8nfiNgUFcsAlz4YZ+XYMN1BDuKFDBbg3gp2chwOVkVyXTteGgi2EgaE
         AchKFCsz9CfYEEtVR3L24zs3dloYYnhSDYw8dBnCy0K6gVWKVOrcEqVuQBFz/QmX7b1x
         YvnOeZA0vNSyAznNkwHGRbZ98FQY5Iladq/s0nye7gKFnfWGodnNBz5su/cBw4HesR9M
         b7+D+b+Ba0i9ucUCX9gqQFbkot5TTT2Gn/yx22OIjCAYSxX2oVkpLg6JXH9VB8cCGx3O
         wTAw==
X-Gm-Message-State: AFuF++nRFV4dmaoFpQpyw0dPBq6iL/YbBuykGxEo2PPj4bGJLhtgJVYf
	hWzLTazuvKIDlE37vhww8E4rmqHerpiaNCw9Eb9MF371FtsVSzGCzKAlLuRtqw/Jg6u8l+RO9UQ
	tyKWp/41t0h+4LG1yAlCo7KSJZzYk5Rc=
X-Gm-Gg: AYBFou0Ouy3FPMqxFqBZrKR/eTgRqX/u8Bjh1L5QJaNMYfr1qJzDHAF8gc4cAzwMLns
	Ei7z/pXeI5kSEtqAfuHuInAVsSXVId15jwac5N5TttPaJUJQu9qT8uuoH/7+qZ8g2/BMUKRzLQQ
	3MlnppeSYTD4/MnyrMcrcrVrWZs0leGCUONfZAweMqN3fFGieuitjacMHoEn9X6obFqHUEOcqaF
	F3cCbgS0qRQVqE0f51SNQhtCrH6qTU5bgv7VVR4Kp7zWmnGQ4spGarpGmMkbu590l+AiHmBrboX
	GKkZ0B5PCogoKwP9P1+x1Crb8ZiiOdAdSxxwZsGGHQG0XNfNAJM3XzU=
X-Received: by 2002:a05:690c:4341:b0:873:5bd1:98c3 with SMTP id
 00721157ae682-8a64e7ea366mr22219187b3.53.1790364031384; Fri, 25 Sep 2026
 12:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-16-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-16-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:20:20 -0400
X-Gm-Features: AclHuK9nDPBylthPuw50r6PfFQYpktPajBeNyVeaomTsd0l1MdalA1VpTGPCTwo
Message-ID: <CAEjxPJ52i52sM9bDRWpfVcwxM4oKUOP3rNT6FSDE5ohMg7U-+A@mail.gmail.com>
Subject: Re: [PATCH 17/21] tests/inet_socket: skip mptcp if not supported
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> tests/Makefile only checks the kernel version before running the MPTCP
> tests.  On a kernel built without CONFIG_MPTCP, the server fails to creat=
e
> its socket and exits before opening the flag FIFO, while server_start()
> blocks forever in open(2) on the FIFO, hanging the whole testsuite:
>
>   perl inet_socket/mptcp/test
>     wait_for_partner
>     fifo_open
>     do_dentry_open
>     ...
>
> Skip the tests if the running kernel does not support MPTCP.  MPTCP
> cannot be built as a module, so check for its sysctl directory instead of
> trying to load it.
>
> Also fix a typo in the unknown protocol case.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
