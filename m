Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88546501F49
	for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982336; cv=pass; b=shQRrRtvg+YNfGrXqBCxn3KNAjj7QBpqgbQRMaTYEPv4eEUYcMB5S5pU2t7f+/5jEiLWjbega2kOCrhB9bqigjYcLfzfYZ4Pq/elwx0+7hJgMeETjAvyxhB7orbKM9Wc1WY7nMJypy2NIR0uEaIudaIdvTYLwYDL8xe3WLxpUZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982336; c=relaxed/simple;
	bh=CMHQ9sHNrSPoHtKhqT1JWoto98t9CAzU6IFT3QrD0d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDCyvArAkEliYMPK5bIMa1oxTMmDRuuskx9bPfNebMwgK2PeeO5E60s3MZ6K3e/jRNiZyfTcoyzdYAhYoYzZzaqdY2wkpBlawDbdnbMTQmW+/0Ss79GeSx73WagijuAmyhXZayLQZbHBFcRJ9jiWi33AVYw5QV7UDK8YlA4CJrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMMeinXc; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMMeinXc"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6768403e9bbso3479357d50.1
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 05:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982270; cv=none;
        d=google.com; s=arc-20260327;
        b=lUpSq5eGwHpwVKL51uMg65W2GDyjqC3ttECIY540IOkBuzUlzrGC7HlmW/ntTg/doz
         BpwMFomgQgzkxxbNw8YFJ1HUPUJixVSMLtvOCX60g0snYEa3wkTFqmcyVvCTPioWcno8
         sYXfe/GpgCdX3rjK467SND8EPPG0S1HpXXzcx7R2iangYYfsIsd0Boi7tdqllns284In
         +HJCsyza+qeID1rHiJp57WdJUFYrJwVo4eAX/4hn0rir1ZfNu1sLHuKSSfsNkr7TiyCL
         Ofkr/bBAxx0dqz9zDTpK4VsBSK8eGWUryEH7YzlKFDOrb474JHFt4pyD0sRcqWizhdwz
         PPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMHQ9sHNrSPoHtKhqT1JWoto98t9CAzU6IFT3QrD0d4=;
        fh=9CvfyTln6mlGi4sBe9JH0kMBicdx1bffQat4jneQZt8=;
        b=hZxbozcTB+u7g2bh5YNuDQcfV05YZh7lx2tSWrMr2oxY9a+Ta6Okr1mRD/NR1ZvmYp
         aZODQSTgkpTpab1k3HaVYvpXRh98UlkiKpUr3oy6KX8EiYwqKTsaps7IvGo4SI0ALVvR
         nrwOZY9RRFqYXLrugrwSzeY9FkyT6dFZy4IrPUmOzfPeklLGsJVUVfu2qkJJ6EKks+6z
         136f49AlLSaWJwXP/VEQpt+ItR93JiroQ/veFMZnodGZ+2M2q9WmXsSKfeuu2K9z5t3e
         5jGlFwSl14sIvW8fvZvMIIXend2uuPSIQ8bUHJYFVWfimIIeTrfYTNkCLrIGPJGp0UhD
         gsoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982270; x=1792587070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMHQ9sHNrSPoHtKhqT1JWoto98t9CAzU6IFT3QrD0d4=;
        b=YMMeinXcqdj8VXjvX/D4+dIsYPAgAFtdv7Fh07kVhYRz0HhE94mlyAU+pZwTbeWQOl
         UrYUxVPxKWw89rL5waGUC2VMi8CI2DEtXVtbWAXH6zQeF0SNxX7CKSGJAfNBrlSTi0Xb
         v7sILXdYRioD3WOpQyQK9fOJAYcTWxrw0Mh6uaLy/gt2Dq25Q5ouVMAcEIr5CiJv3jRL
         kRsuIgIbAavfX9gFUSla0KdLnlrsSCen8r7KgixYxT655Xepa9YP6S2JGcQllB8+9+pR
         QXgiiMJQjYlAMdtQEPKuzE0ySofo2iOoqrPzAM1W4TuHCv6f5yFumqvKxn+os4OBMA78
         SSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982270; x=1792587070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMHQ9sHNrSPoHtKhqT1JWoto98t9CAzU6IFT3QrD0d4=;
        b=ZTzGPpxP86J8OvkH3acsKqTqWdklLFobhl7X4WhPNAZx9TsHKR7T3Eig+yY6k2LAeU
         +ko+itkpQZ+5JHVwDlEmtSCgw3yDOY1FcUYkOEFvvvTDgO64RCxJz0CDfTgHu4+8q5o3
         DGoWss/QKSY9rv21tYoU/gMnrC7ZwEBE3hEY5VRpIyFiqtLfYpi/kDmnqBztbbwUHtlP
         zcgiRz6FClWwTJK8dSd3u+TwVwN1VZT0ow4uqIsjgITdElyOmLXSfjhySAr/FHApCLKn
         dojGklOAwYPb6pZPU2TQK52WPorX7upX1rnJLC48UX7gmDVbtLu/R1BaPqbYuXy1wPm7
         H/ZA==
X-Gm-Message-State: AFq9FYI/ID9HO3zILlIy0hn6gzTiiKd3JCA479En+eRg3kzTq4tb1zIF
	g8EttImI16VIXpbM3yGJjhlfxxRGaPM+x3GjGo2Olg4fmpkRMN5WC1Q6iYUUQIlp7E6wSOuX+kY
	SQ555Z1RqFOEY5mJOngahawc9MCYFOgckr/cW
X-Gm-Gg: AYBFou3rzRcK+s/PT86H3rUfsknl5Q2XW3Uclglt6lIciE7lOIoIr1aQqDdxCr3/8gU
	d2fJFzUtA5HQM6Ke2RnMi8ZkVc3FistRZ88VFHKjdigywOz44Jnsek8prcnjvOei927g3gZ2sg0
	QM8FxIb/uJ0eD7CAKKNpCqzCM27xE0BgZCC3BYStreWRIcFpmerEbnh5Lks4Z00obD4s6Fwiem5
	OcHY5l5CEd0Pfg3xHCbFvs0sGmXFuYK/4MHzkFUfevlfm1UEQSobHcjjFTIayQpjlx/M5Cd9jA2
	pThiI5EAQSLZf1K9GpR1mEfz3tL4q3dhlNmAxxl2ccvDu1hppOi7Yzo=
X-Received: by 2002:a05:690e:dcc:b0:677:c075:a57a with SMTP id
 956f58d0204a3-67936b17d30mr5711961d50.108.1791982269857; Wed, 14 Oct 2026
 05:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013135042.217207-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261013135042.217207-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 Oct 2026 08:50:58 -0400
X-Gm-Features: AclHuK-nYGUkqWgjbr49MSC2VeY1amnxe74P03q6W7dEeVkguoJnEjoJ1kQlGBs
Message-ID: <CAEjxPJ5TneMP7GwEWa7upXouktb8+NawhCMxdhKFtvc2MgJfAQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: clear attribute member set after building type_attr_map
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> expand_module() populates each attribute's type_datum.type via
> attr_convert_callback() and then uses that set to build the kernel
> policydb's attr_type_map/type_attr_map in type_attr_map(). The ebitmap
> is left in place on the datum afterward.
>
> type_write() does not emit type_datum.types for a kernel policy, so a
> policydb produced by policydb_read() always has it empty, and
> policydb_validate() rejects a kernel-policy attribute whose types set
> is non-empty. This makes a freshly expanded policydb fail validation
> while the same policy round-tripped through a policy file passes.
> Both in-tree fuzzers call policydb_validate() on the output of
> expand_module(): the binpolicy fuzzer bails out before exercising the
> write and decompile paths on the expanded policy, and the checkpolicy
> fuzzer would abort() on any source policy that associates a type with
> an attribute.
>
> Destroy the ebitmap once the maps are built so the in-memory kernel
> policydb has the same shape as one read back from a binary. This
> covers both the kept and the expand-away (TYPE_FLAGS_EXPAND_ATTR_TRUE)
> cases.
>
> Adjust the expander CUnit test helper to read attribute membership
> from attr_type_map on a kernel policydb, which is where it now lives
> (and what is actually written out).
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This patch has been merged.
